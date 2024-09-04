// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IAvatarArtAuction.sol";
import "./AvatarArtBase.sol";

/**
* @dev Contract is used so that user can join an auction
* Business steps:
*   1. Artists submit auction information to system
*   2. Admin approve these informations and create an auction.
*   Note that: The submiting and approving will be processed outside blockchain
*   3. User joins the auction and winner will be the one who pay the highest price
*   4. At the end of auction, anyone can call `distribute` function to distribute NFT to the winner
*      If there is not winner, NFT will be payback to artist
*/
contract AvatarArtAuction is AvatarArtBase, IAvatarArtAuction{
    enum EAuctionStatus{
        Open,
        Completed,
        Canceled
    }
    
    //Store information of specific auction
    struct Auction{
        uint256 startTime;
        uint256 endTime;
        uint256 tokenId;
        address tokenOwner;
        uint256 price;
        address winner;
        EAuctionStatus status;       //0:Open, 1: Closed, 2: Canceled
    }
    
    //Store auction history when a user places
    struct AuctionHistory{
        uint256 time;
        uint256 price;
        address creator;
    }
    
    //AUCTION 
    Auction[] public _auctions;       //List of auction
    
    //Mapping between specific auction and its histories
    mapping(uint256 => AuctionHistory[]) public _auctionHistories;
    
    constructor(address bnuTokenAddress, address avatarArtNFTAddress) 
        AvatarArtBase(bnuTokenAddress, avatarArtNFTAddress){}

    function getAuctionCount() public view returns(uint256)
    {
        return _auctions.length;
    }
        
     /**
     * @dev {See - IAvatarArtAuction.createAuction}
     * 
     * IMPLEMENTATION
     *  1. Validate requirement
     *  2. Add new auction
     *  3. Transfer NFT to contract
     */ 
    
    
    /**
     * @dev {See - IAvatarArtAuction.deactivateAuction}
     * 
     */ 
    
    
    /**
     * @dev {See - IAvatarArtAuction.distribute}
     * 
     *  IMPLEMENTATION
     *  1. Validate requirements
     *  2. Distribute NFT for winner
     *  3. Keep fee for dev and pay cost for token owner
     *  4. Update auction
     */ 
    
    
    /**
     * @dev Get active auction by `tokenId`
     */ 
    function getActiveAuctionByTokenId(uint256 tokenId) public view returns(bool, Auction memory, uint256){
        for(uint256 index = _auctions.length; index > 0; index--){
            Auction memory auction = _auctions[index - 1];
            if(auction.tokenId == tokenId && auction.status == EAuctionStatus.Open && auction.startTime <= _now() && auction.endTime >= _now())
                return (true, auction, index - 1);
        }
        
        return (false, Auction(0,0,0, address(0), 0, address(0), EAuctionStatus.Open), 0);
    }
    
     /**
     * @dev Get auction infor by `auctionIndex` 
     */
    function getAuction(uint256 auctionIndex) external view returns(Auction memory){
        require(auctionIndex < getAuctionCount());
        return _auctions[auctionIndex];
    }
    
    /**
     * @dev Get all completed auctions for specific `tokenId` with auction winner
     */ 
    function getAuctionWinnersByTokenId(uint256 tokenId) public view returns(Auction[] memory){
        uint256 resultCount = 0;
        for(uint256 index = 0; index < _auctions.length; index++){
            Auction memory auction = _auctions[index];
            if(auction.tokenId == tokenId && auction.status == EAuctionStatus.Completed)
                resultCount++;
        }
        
        if(resultCount == 0)
            return new Auction[](0);
            
        Auction[] memory result = new Auction[](resultCount);
        resultCount = 0;
        for(uint256 index = 0; index < _auctions.length; index++){
            Auction memory auction = _auctions[index];
            if(auction.tokenId == tokenId && auction.status == EAuctionStatus.Completed){
                result[resultCount] = auction;
                resultCount++;
            }
        }
        
        return result;
    }
    
    /**
     * @dev {See - IAvatarArtAuction.place}
     * 
     *  IMPLEMENTATION
     *  1. Validate requirements
     *  2. Add auction histories
     *  3. Update auction
     */ 
    
    
     /**
     * @dev {See - IAvatarArtAuction.updateActionPrice}
     * 
     */ 
    function updateActionPrice(uint256 auctionIndex, uint256 price) external override onlyOwner returns(bool){
        require(auctionIndex < getAuctionCount());
        Auction storage auction = _auctions[auctionIndex];
        require(auction.startTime > _now());
        auction.price = price;
        
        emit AuctionPriceUpdated(auctionIndex, price);
        return true;
    }
    
    /**
     * @dev {See - IAvatarArtAuction.updateActionTime}
     * 
     */ 
    function updateActionTime(uint256 auctionIndex, uint256 startTime, uint256 endTime) external override onlyOwner returns(bool){
        require(auctionIndex < getAuctionCount());
        Auction storage auction = _auctions[auctionIndex];
        require(auction.startTime > _now());
        auction.startTime = startTime;
        auction.endTime = endTime;
        
        emit AuctionTimeUpdated(auctionIndex, startTime, endTime);
        return true;
    }

    /**
     * @dev Owner withdraws ERC20 token from contract by `tokenAddress`
     */
    function withdrawToken(address tokenAddress) public onlyOwner{
        IERC20 token = IERC20(tokenAddress);
        token.transfer(_owner, token.balanceOf(address(this)));
    }
    
    event NewAuctionCreated(uint256 tokenId, uint256 startTime, uint256 endTime, uint256 price);
    event AuctionPriceUpdated(uint256 auctionIndex, uint256 price);
    event AuctionTimeUpdated(uint256 auctionIndex, uint256 startTime, uint256 endTime);
    event NewPlaceSetted(uint256 tokenId, uint256 auctionIndex, address account, uint256 price);
    event Distributed(uint256 tokenId, address winner, uint256 time);
}