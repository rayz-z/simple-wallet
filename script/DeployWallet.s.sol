// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "../lib/forge-std/src/Script.sol";
import {Wallet} from "../src/Wallet.sol";

contract DeployWallet is Script {
    function run() external returns (Wallet) {
        vm.startBroadcast();
        Wallet wallet = new Wallet();
        vm.stopBroadcast();
        return wallet;
    }
}
