// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

    import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library ethToUsd {

    function getPrice() internal view returns (uint256) {
        (,int256 price,,,) = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversion(uint256 amountInEth) internal view returns (uint256) {
        uint256 _getConversion = (getPrice() * amountInEth) / 1 ether;
        return _getConversion;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).version();
    }

}