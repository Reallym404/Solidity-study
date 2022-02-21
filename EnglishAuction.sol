// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

interface IERC721 {

    function transferFrom(address from,address to,uint nftId) external;
}

contract EnglishAuction {

    event Start();
    event Bid(address indexed sender,uint amount);
    event Withdraw(address indexed bider,uint amount);
    event End(address indexed highesBidder,uint amount);

    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller;
    uint32 public endAt;
    bool public started;
    bool public ended;

    address public highesBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller,"not seller");
        require(!started,"started");

        started = true;
        endAt = uint32(block.timestamp + 60);
        nft.transferFrom(seller,address(this),nftId);

        emit Start();
    }

    function bid() external payable {
        require(started,"not started");
        require(block.timestamp < endAt,"ended");
        require(msg.value > highestBid,"value < highestBid");

        if(highesBidder != address(0)){
            bids[highesBidder] += highestBid;
        }

        highestBid = msg.value;
        highesBidder = msg.sender;

        emit Bid(msg.sender,msg.value);
    }

    function withDraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender,bal);
    }

    function end() external {
        require(started,"not started");
        require(!ended,"ended");
        require(block.timestamp >= endAt,"not ended");

        ended = true;
        if(highesBidder != address(0)){
            nft.transferFrom(address(this),highesBidder,nftId);
            seller.transfer(highestBid);
        }else{
            nft.transferFrom(address(this),seller,nftId);
        }

        emit End(highesBidder,highestBid);
    }
}
