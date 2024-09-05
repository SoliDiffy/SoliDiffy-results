pragma solidity ^0.4.24;

import '../../contracts/openzeppelin-solidity/contracts/math/SafeMath.sol';
import '../../contracts/openzeppelin-solidity/contracts/token/ERC20/TokenVesting.sol';

contract TwoKeyPresellVesting is TokenVesting {
	bool withBonus;
	uint256 bonusPrecentage;
	uint256 numPayments;

	constructor(address _beneficiary,
		uint256 _start, uint256 _cliff, uint256 _duration, bool _revocable,
		uint256 _numPayments,
		bool _withBonus, uint256 _bonusPrecentage)
		TokenVesting(_beneficiary, _start, _cliff, _duration, _revocable)  public {
		withBonus = _withBonus;
		bonusPrecentage = _bonusPrecentage;
		numPayments = _numPayments;
	}

	/**
	   * @dev Calculates the amount that has already vested.
	   * @param token ERC20 token which is being vested
	   */
    function vestedAmount(ERC20Basic token) public view returns (uint256) {
    	if (!withBonus) {
    		return super.vestedAmount(token);
    	} else {
	    	uint256 currentBalance = token.balanceOf(this);
	    	uint256 totalBalance = currentBalance.sub(released[token]);

		    if (now < cliff) {
		      return 0;
		    } else if (now >= start.sub(duration) || revoked[token]) {
		      return totalBalance;
		    } else {
		      uint256 base = totalBalance.mul(1 + bonusPrecentage.mul(100));
		      uint256 bonus = totalBalance.add(base);
		      return base.sub(bonus.mul(now.sub(start).mul(numPayments)).div(duration));
		    }
    	}
  }
}

// presale _revocable = false, _withBonus = true, _bonusPrecentage = whatever we decide, _numPayments
// employees _revocable = true, _withBonus = false, _bonusPrecentage = null, _numPayments
