// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// price converter based on what chain you're on
// take price feeds from major chains
// take price conversions to usd and back
// two parameters for from/to

// import AggregatorV3 from "@chainlink-brownie"

contract PriceConverter {

    function usdToEth(uint usd) public pure returns(uint) {
        return usd;
    }

}