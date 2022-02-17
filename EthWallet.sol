// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract EthWallet{

    address payable public owner;

    constructor() payable{
        owner = payable(msg.sender);
    }

    receive() external payable{}

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdraw(uint amount) external {
        require(msg.sender == owner,"must be owner call");
        require(getBalance() >= amount,"must be >= balance");
        payable(msg.sender).transfer(amount);
    }
}
