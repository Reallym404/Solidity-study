// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract PiggyBank {

    address public owner;

    receive() external payable{}

    constructor(){
        owner = msg.sender;
    }

    function withDraw() external {
        require(msg.sender == owner,"not owner");
        ///payable(msg.sender).transfer(address(this).balance);
        // 自毁，并且把余额发送到调用者
        selfdestruct(payable(msg.sender));
    }
}
