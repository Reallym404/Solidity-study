// SPDX-License-Identifier: GPL-3.0
// 定义接口调用

pragma solidity ^0.8.7;

interface ITodolist{

    function create(string calldata _text) external;

    function get(uint _index) external view returns (string memory,bool);
}

contract TestITodoList{

    function callCreate(address _todolist) external returns(string memory text,bool b){
        ITodolist(_todolist).create("test todo list");
        (text,b) = ITodolist(_todolist).get(0);
    }
}
