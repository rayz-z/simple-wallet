// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {Wallet} from "src/Wallet.sol";

contract WalletTest is Test {
    address USER = makeAddr("user");
    address RECEIVER = makeAddr("receiver");
    uint constant STARTING_BALANCE = 10 ether;
    Wallet wallet;

    function setUp() external {
        vm.prank(USER);
        wallet = new Wallet();
        vm.deal(address(wallet), STARTING_BALANCE);
    }

    function testOwner() public view {
        console.log(msg.sender);
        console.log(address(this));
        console.log(wallet.owner());
        console.log(USER);
        assertEq(USER, wallet.owner());
    }

    function testSendValue() public {
        uint startBal = address(wallet).balance;
        uint receiverBal = RECEIVER.balance;
        assertEq(startBal, STARTING_BALANCE);
        
        vm.prank(USER);
        wallet.sendValue(0.1 ether, RECEIVER);
        console.log(receiverBal);
        console.log(RECEIVER.balance);
        assertNotEq(receiverBal, RECEIVER.balance);
    }

}
