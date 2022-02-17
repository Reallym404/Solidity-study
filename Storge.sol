// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract Storge {

    struct MyStruct{
        string text;
        uint foo;
    }

    string public text;

    mapping(address => MyStruct) public map;

    function set() external {
        MyStruct memory ms = MyStruct({text:"text",foo :123});
        map[msg.sender] = ms;
    }

    function changeStorage() external {
        MyStruct storage ms = map[msg.sender];
        ms.text = "text123";
    }

    function changeMemory() external view{
        MyStruct memory ms = map[msg.sender] ;
        ms.text = "text000";
    }

    function example(uint[] calldata y,string calldata s) external returns (uint[] memory) {
        uint[] memory memArr = new uint[](3);

        _internal(y);

        memArr[0] = 234;
        return memArr;
    }

    function _internal(uint[] calldata y) private {
        uint x = y[0];
    }

    function setText(string calldata _text) external {
        text = _text;
    }

    


}
