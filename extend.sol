// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract A {
    function foo() public pure virtual returns(string memory){
        return "A foo";
    }
    function bar() public pure returns(string memory){
        return "A bar";
    }
}

contract B is A{
    function foo() public pure virtual override returns (string memory){
        return "B foo";
    }
    function baz() public pure virtual returns (string memory){
        return "B bar";
    }
}

contract C is B{
    function baz() public pure override returns(string memory){
        return "C bar";
    }
}



contract X {

    function foo() public pure virtual returns(string memory){
        return "X foo";
    }

    function Xs() public pure returns(string memory){
        return "Xs";
    }
}

contract Y is X {
    function foo() public pure virtual override returns(string memory){
        return "Y foo";
    }

    function Ys() public pure returns(string memory){
        return "Ys";
    }
}

contract Z is X,Y {
    function foo() public pure override(Y,X) returns(string memory){
        return "Z foo";
    }
}
