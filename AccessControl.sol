// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract AccessControl {

    event GrantRole(bytes32 role,address account);
    event RevokRole(bytes32 role,address account);

    bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 public constant USER = keccak256(abi.encodePacked("USER"));

    mapping(bytes32 => mapping(address => bool)) public roles;

    constructor(){
        _grantRole(ADMIN,msg.sender);
    }

    modifier _onlyRole(bytes32 role){
        require(roles[role][msg.sender],"not auth");
        _;
    }
    
    function _grantRole(bytes32 role,address addr) internal {
        roles[role][addr] = true;
        emit GrantRole(role,addr);
    }

    function grantRole(bytes32 role,address addr) external _onlyRole(ADMIN) {
        _grantRole(role,addr);
    }

    function revokRole(bytes32 role,address addr) external _onlyRole(ADMIN) {
        roles[role][addr] = false;
        emit RevokRole(role,addr);
    }
}
