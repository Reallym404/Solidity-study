// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract TestEncode{


    function hash(string memory text1,string memory text2,address addr) external pure returns(bytes32){
        return keccak256(abi.encodePacked(text1,text2,addr));
    }

    function encode(string memory text1,string memory text2) external pure returns (bytes memory) {
        return abi.encode(text1,text2);
    }

    function encodePacked(string memory text1,string memory text2) external pure returns (bytes memory) {
        return abi.encodePacked(text1,text2);
    }

    function hashEncodePacked(string memory text1,uint _x,string memory text2) external pure returns (bytes32){
        return keccak256(abi.encodePacked(text1,_x,text2));
    }

}
