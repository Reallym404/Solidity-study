// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Maptest {

    mapping(address => uint) public map;

    struct Car{
        string model;
        uint year;
        address owner;
    }

    enum State {
        white,
        black,
        red
    }

    State public state;

    mapping(address => Car[]) public mapCars;
    Car[] public cars;

    function setCars() external {
        Car memory tesla =  Car("tesla",2007,msg.sender);
        Car memory lamob = Car({model:"lamob",year: 1999, owner : msg.sender});
    
        cars.push(tesla);
        cars.push(lamob);

        mapCars[msg.sender] = cars;
    }

    function setMap(uint _i) external {
        map[msg.sender] = _i;
    }

    function setState(State _state) external {
        state = _state;
    }

    function delState() external {
        delete state;
    }
}
