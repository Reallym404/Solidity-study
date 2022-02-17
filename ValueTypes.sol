// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract ValueTypes {

    bool public b = true;

    uint public u = 123;
    uint public minUint = type(uint).min ;
    uint public maxUint = type(uint).max;


    int public i = -1;


    int public minInt = type(int).min;
    int public maxInt = type(int).max;
    address public addr = 0x9857b416A7e84dEe915444e03F389203E9eC3c5B;
    //bytes32 public b32 = 0x9857b416A7e84dEe915444e03F389203E9eC3c5Bssss ;

    function testBool() external view returns(bool){
        if(b){
            return !b;
        }else{
            return b;
        }
    }

    function add(uint x,uint y) external pure returns(uint){
        return x + y;
    }

    function sub(int x,int y) external pure returns(int){
        return x - y;
    }

    function globalVars() external view returns(address,uint,uint){
        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint blockNum = block.number;
        return(sender,timestamp,blockNum);
    }

    error MyError(address addr,string str) ;

    function testError(uint _i) external view {
        if(_i > 2){
            revert MyError(msg.sender,"i > 2");
        }else{
            revert MyError(msg.sender,"i must be > 2");
        }
    }
}

