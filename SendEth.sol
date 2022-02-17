// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract SendEth {

    constructor() payable{}

    receive() external payable{}

    function vSend(address payable _to) external payable{
        bool sent = _to.send(1);
        require(sent,"send failed");
    }

    function vTransfer(address payable _to) external payable{
        _to.transfer(1);
    } 

    function vCall(address payable _to) external payable{
        (bool success,) = _to.call{value:1}("");
        require(success,"call failed");
    }
}

contract receiveEth {
    
    event Log(uint value,uint gasvalue);
    
    receive() external payable{
        emit Log(msg.value,gasleft());
    }
}
