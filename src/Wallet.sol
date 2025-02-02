// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

error Wallet_NotOwner();
error Wallet_NotEnoughFunds();
error Wallet_AddressNotFound();

contract Wallet {
    address payable public immutable i_owner;
    mapping(address => uint) private s_ethSent;
    mapping(address => uint) private s_ethReceived;

    constructor() {
        i_owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert Wallet_NotOwner();
        }
        _;
    }

    function getBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

    function getSent(address _receiver) public view onlyOwner returns (uint) {
        return s_ethSent[_receiver];
    }

    function getReceived(address _sender) public view onlyOwner returns (uint) {
        return s_ethSent[_sender];
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

        s_ethSent[_receiver] += _amount;
    }

    receive() external payable {
        s_ethReceived[msg.sender] += msg.value;
    }
}
