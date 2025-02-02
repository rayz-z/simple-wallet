// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// get balance
// send amount to

error Wallet_NotOwner();
error Wallet_NotEnoughFunds();
error Wallet_AddressNotFound();

contract Wallet {
    address payable public owner;
    mapping(address => uint) private ethSent;
    mapping(address => uint) private ethReceived;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Wallet_NotOwner();
        }
        _;
    }

    function getBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

    function getSent(address _receiver) public view onlyOwner returns (uint) {
        return ethSent[_receiver];
    }

    function getReceived(address _sender) public view onlyOwner returns (uint) {
        return ethSent[_sender];
    }

    function sendValue(
        uint _amount,
        address _receiver
    ) external payable onlyOwner {
        if (address(this).balance < _amount) {
            revert Wallet_NotEnoughFunds();
        }

        (bool success, ) = payable(_receiver).call{value: _amount}("");
        require(success, "Transfer failed");

        ethSent[_receiver] += _amount;
    }

    receive() external payable {
        ethReceived[msg.sender] += msg.value;
    }
}
