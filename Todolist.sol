// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract Todolist{

    event sendMessage(address indexed _from,address indexed _to,string _message);

    struct Todo{
        string text;
        bool status;
    }

    Todo[] public todos;


    function create(string calldata _text) external {
        todos.push(Todo({
            text:_text,
            status: false
        }));
    }

    function update(uint _index,string calldata _text) external {
        todos[_index].text = _text;
    }

    function get(uint _index) external view returns (string memory,bool){
        Todo memory todo = todos[_index];
        return (todo.text,todo.status);
    }

    function changeStatus(uint _index) external {
        todos[_index].status = !todos[_index].status;
    }

    function sendMsg(address _to,string calldata message) external {
        emit sendMessage(msg.sender,_to,message);
    }

}
