// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PracticeToken {
    uint public symbol;
    string public name;
    uint public supply;
    address public owner;
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(uint _symbol, string memory _name, uint _supply) {
        symbol = _symbol;
        name = _name;
        supply = _supply;
        owner = msg.sender;

        balances[owner] = _supply;

        emit Transfer(address(0), owner, _supply);
    }

    function sendMoney(address to, uint value) external {
        require(to != address(0), "Invalid address");
        require(value <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
    }
}
