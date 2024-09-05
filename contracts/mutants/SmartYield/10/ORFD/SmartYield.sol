// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.7.6;
pragma abicoder v2;

import "hardhat/console.sol";

// TODO:
// investigate comp value + spot price + rate = min(MAX, oracle, spot)
// more tests

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./lib/math/MathUtils.sol";

import "./Governed.sol";
import "./IController.sol";
import "./oracle/IYieldOraclelizable.sol";
import "./ISmartYield.sol";

import "./IProvider.sol";

import "./model/IBondModel.sol";
import "./oracle/IYieldOracle.sol";
import "./IBond.sol";
import "./JuniorToken.sol";

contract SmartYield is
    JuniorToken,
    ISmartYield
{
    using SafeMath for uint256;

    // controller address
    address public controller;

    // address of IProviderPool
    address public pool;

    // senior BOND (NFT)
    address public seniorBond; // IBond

    // junior BOND (NFT)
    address public juniorBond; // IBond

    // underlying amount in matured and liquidated juniorBonds
    uint256 public underlyingLiquidatedJuniors;

    // tokens amount in unmatured juniorBonds or matured and unliquidated
    uint256 public tokensInJuniorBonds;

    // latest SeniorBond Id
    uint256 public seniorBondId;

    // latest JuniorBond Id
    uint256 public juniorBondId;

    // last index of juniorBondsMaturities that was liquidated
    uint256 public juniorBondsMaturitiesPrev;
    // list of junior bond maturities (timestamps)
    uint256[] public juniorBondsMaturities;

    // checkpoints for all JuniorBonds matureing at (timestamp) -> (JuniorBondsAt)
    // timestamp -> JuniorBondsAt
    mapping(uint256 => JuniorBondsAt) public juniorBondsMaturingAt;

    // metadata for senior bonds
    // bond id => bond (SeniorBond)
    mapping(uint256 => SeniorBond) public seniorBonds;

    // metadata for junior bonds
    // bond id => bond (JuniorBond)
    mapping(uint256 => JuniorBond) public juniorBonds;

    // pool state / average bond
    // holds rate of payment by juniors to seniors
    SeniorBond public abond;

    bool public _setup;

    constructor(
      string memory name_,
      string memory symbol_
    )
      JuniorToken(name_, symbol_)
    {}

    function setup(
      address controller_,
      address pool_,
      address seniorBond_,
      address juniorBond_
    )
      external
    {
        require(
          false == _setup,
          "SY: already setup"
        );

        controller = controller_;
        pool = pool_;
        seniorBond = seniorBond_;
        juniorBond = juniorBond_;

        _setup = true;
    }

    // externals

    // buy at least _minTokens with _underlyingAmount, before _deadline passes
    

    // sell _tokens for at least _minUnderlying, before _deadline and forfeit potential future gains
    

    // Purchase a senior bond with principalAmount_ underlying for forDays_, buyer gets a bond with gain >= minGain_ or revert. deadline_ is timestamp before which tx is not rejected.
    

    // buy an nft with tokenAmount_ jTokens, that matures at abond maturesAt
    

    // Redeem a senior bond by it's id. Anyone can redeem but owner gets principal + gain
    

    // once matured, redeem a jBond for underlying
    


    

    // given a principal amount and a number of days, compute the guaranteed bond gain, excluding principal
    

  // /externals

  // publics

    

    // jToken price * 1e18
    

    function underlyingTotal()
      public view virtual override
    returns(uint256)
    {
      return IProvider(pool).underlyingBalance() - IProvider(pool).underlyingFees() - underlyingLiquidatedJuniors;
    }

    function underlyingJuniors()
      public view virtual override
    returns (uint256)
    {
        return this.underlyingTotal() - abond.principal - this.abondPaid();
    }

    function underlyingLoanable()
      public view virtual override
    returns (uint256)
    {
        // underlyingTotal - abond.principal - abond.gain - queued withdrawls
        return this.underlyingTotal() - abond.principal - abond.gain - (tokensInJuniorBonds * this.price() / 1e18);
    }

    function abondGain()
      public view override
    returns (uint256)
    {
        return abond.gain;
    }

    function abondPaid()
      public view override
    returns (uint256)
    {
        uint256 ts = this.currentTime() * 1e18;
        if (ts <= abond.issuedAt || (abond.maturesAt <= abond.issuedAt)) {
          return 0;
        }

        uint256 d = abond.maturesAt - abond.issuedAt;
        return (this.abondGain() * MathUtils.min(ts - abond.issuedAt, d)) / d;
    }

    function abondDebt()
      public view override
    returns (uint256)
    {
        return this.abondGain() - this.abondPaid();
    }

  // /publics

  // internals
//SWC-126-Insufficient Gas Griefing:L439-451
    function _beforeProviderOp() internal {
      // this modifier will be added to the begginging of all (write) functions.
      // The first tx after a queued liquidation's timestamp will trigger the liquidation
      // reducing the jToken supply, and setting aside owed_dai for withdrawals
      for (uint256 i = juniorBondsMaturitiesPrev; i < juniorBondsMaturities.length; i++) {
          if (this.currentTime() >= juniorBondsMaturities[i]) {
              _liquidateJuniorsAt(juniorBondsMaturities[i]);
              juniorBondsMaturitiesPrev = i + 1;
          } else {
              break;
          }
      }
    }

    function _liquidateJuniorsAt(uint256 timestamp_)
      internal
    {
        JuniorBondsAt storage jBondsAt = juniorBondsMaturingAt[timestamp_];

        require(
          jBondsAt.tokens > 0,
          "SY: nothing to liquidate"
        );

        require(
          jBondsAt.price == 0,
          "SY: already liquidated"
        );

        jBondsAt.price = this.price();

        // ---

        underlyingLiquidatedJuniors += jBondsAt.tokens * jBondsAt.price / 1e18;
        _burn(address(this), jBondsAt.tokens); // burns Junior locked tokens reducing the jToken supply
        tokensInJuniorBonds -= jBondsAt.tokens;
    }

    // removes matured seniorBonds from being accounted in abond
    function unaccountBonds(uint256[] memory bondIds_) public override {
      for (uint256 f = 0; f < bondIds_.length; f++) {
        if (
            this.currentTime() > seniorBonds[bondIds_[f]].maturesAt &&
            seniorBonds[bondIds_[f]].liquidated == false
        ) {
            seniorBonds[bondIds_[f]].liquidated = true;
            _unaccountBond(seniorBonds[bondIds_[f]]);
        }
      }
    }

    function _mintBond(address to_, SeniorBond memory bond_)
      internal
    {
        require(
          seniorBondId < uint256(-1),
          "SY: _mintBond"
        );

        seniorBondId++;
        seniorBonds[seniorBondId] = bond_;
        _accountBond(bond_);
        IBond(seniorBond).mint(to_, seniorBondId);
    }

    // when a new bond is added to the pool, we want:
    // - to average abond.maturesAt (the earliest date at which juniors can fully exit), this shortens the junior exit date compared to the date of the last active bond
    // - to keep the price for jTokens before a bond is bought ~equal with the price for jTokens after a bond is bought
    function _accountBond(SeniorBond memory b_)
      internal
    {
        uint256 _now = this.currentTime() * 1e18;

        uint256 newDebt = this.abondDebt() + b_.gain;
        // for the very first bond or the first bond after abond maturity: this.abondDebt() = 0 => newMaturesAt = b.maturesAt
        uint256 newMaturesAt = (abond.maturesAt * this.abondDebt() + b_.maturesAt * 1e18 * b_.gain) / newDebt;

        // timestamp = timestamp - tokens * d / tokens
        uint256 newIssuedAt = newMaturesAt.sub(uint256(1) + ((abond.gain + b_.gain) * (newMaturesAt - _now)) / newDebt, "SY: liquidate some seniorBonds");

        abond = SeniorBond(
          abond.principal + b_.principal,
          abond.gain + b_.gain,
          newIssuedAt,
          newMaturesAt,
          false
        );
    }

    // when a bond is redeemed from the pool, we want:
    // - for abond.maturesAt (the earliest date at which juniors can fully exit) to remain the same as before the redeem
    // - to keep the price for jTokens before a bond is bought ~equal with the price for jTokens after a bond is bought
    function _unaccountBond(SeniorBond memory b_)
      internal
    {
        uint256 now_ = this.currentTime() * 1e18;

        if ((now_ >= abond.maturesAt)) {
          // abond matured
          // this.abondDebt() == 0
          abond = SeniorBond(
            abond.principal - b_.principal,
            abond.gain - b_.gain,
            now_ - (abond.maturesAt - abond.issuedAt),
            now_,
            false
          );

          return;
        }

        // timestamp = timestamp - tokens * d / tokens
        uint256 newIssuedAt = abond.maturesAt.sub(uint256(1) + (abond.gain - b_.gain) * (abond.maturesAt - now_) / this.abondDebt(), "SY: liquidate some seniorBonds");

        abond = SeniorBond(
          abond.principal - b_.principal,
          abond.gain - b_.gain,
          newIssuedAt,
          abond.maturesAt,
          false
        );
    }

    function _mintJuniorBond(address to_, JuniorBond memory jb_)
      internal
    {
        require(
          juniorBondId < uint256(-1),
          "SY: _mintJuniorBond"
        );

        juniorBondId++;
        juniorBonds[juniorBondId] = jb_;

        _accountJuniorBond(jb_);
        IBond(juniorBond).mint(to_, juniorBondId);
    }

    function _accountJuniorBond(JuniorBond memory jb_)
      internal
    {
        tokensInJuniorBonds += jb_.tokens;

        JuniorBondsAt storage jBondsAt = juniorBondsMaturingAt[jb_.maturesAt];
        uint256 tmp;

        if (jBondsAt.tokens == 0 && this.currentTime() < jb_.maturesAt) {
          juniorBondsMaturities.push(jb_.maturesAt);
          for (uint256 i = juniorBondsMaturities.length - 1; i >= MathUtils.max(1, juniorBondsMaturitiesPrev); i--) {
            if (juniorBondsMaturities[i] > juniorBondsMaturities[i - 1]) {
              break;
            }
            tmp = juniorBondsMaturities[i - 1];
            juniorBondsMaturities[i - 1] = juniorBondsMaturities[i];
            juniorBondsMaturities[i] = tmp;
          }
        }

        jBondsAt.tokens += jb_.tokens;
    }

    function _burnJuniorBond(uint256 bondId_) internal {
        //JuniorBond memory jb = juniorBonds[bondId_];

        //_unaccountJuniorBond(jb);
        // blows up if already burned
        IBond(juniorBond).burn(bondId_);
    }

    function _unaccountJuniorBond(JuniorBond memory jb_) internal {
        tokensInJuniorBonds -= jb_.tokens;
        JuniorBondsAt storage jBondsAt = juniorBondsMaturingAt[jb_.maturesAt];
        jBondsAt.tokens -= jb_.tokens;
    }

    function _takeTokens(address _from, uint256 _amount) internal {
        // TODO: optimization, use _transfer() gas + no approve
        require(
            transferFrom(_from, address(this), _amount),
            "SY: _takeTokens transferFrom"
        );
    }

  // /internals

}
