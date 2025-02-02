// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// get balance
// send amount to

error Wallet_NotOwner();

contract Wallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not owner");
        _;
    }

    function getBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

    function sendValue(
        uint _amount,
        address _receiver
    ) external payable onlyOwner {
        require(address(this).balance > _amount, "not enough money in wallet");
        payable(_receiver).transfer(_amount);
    }

    receive() external payable {}
}
