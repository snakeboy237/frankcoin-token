// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Metadata {
    function contractName() public pure returns (string memory) {
        return "FrankCoin";
    }

    function contractVersion() public pure returns (string memory) {
        return "1.0.0";
    }

    function contractDescription() public pure returns (string memory) {
        return "Production-grade real estate custody token";
    }
}
