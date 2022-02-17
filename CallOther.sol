// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract CallOther{

    bytes public data;

    function callSetX(address _test,uint _x) external {
        TestContract(_test).setX(_x);
    }

    function callgetX(TestContract _test) external view returns (uint x){
        x = _test.getX();
    }

    function callSetValue(address _test,uint _x) external payable {
        TestContract(_test).sendX{value:msg.value}(_x);
    }

    function callSetX1(address _test) external {
        (bool success,bytes memory _data) = _test.call(abi.encodeWithSignature("setX(uint256)",256));
        require(success,"call failed");
        data = _data;
    }

}

contract TestContract{

    uint public x;
    uint public value;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns(uint){
        return x;
    }

    function sendX(uint _x) external payable{
        x = _x;
        value = msg.value;
    }


}
