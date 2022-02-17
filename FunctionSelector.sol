// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract FunctionSelector {

    // params : transfer(address,uint256)
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));// 0xa9059cbb
    }
}


contract Receiver{

    event Log(bytes data);

    function transfer(address _to,uint _amount) external {
        emit Log(msg.data);
        // msg.data=
        //0xa9059cbb
        //0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
        //000000000000000000000000000000000000000000000000000000000000000b
    }
}
