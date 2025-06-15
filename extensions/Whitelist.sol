
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Whitelist {
    
    mapping(address => bool) public whitelist;
    event WhitelistUpdated(address user, bool status);

    function addToWhitelist(address user) external virtual {
        whitelist[user] = true;
        emit WhitelistUpdated(user, true);
    }

    function removeFromWhitelist(address user) external virtual {
        whitelist[user] = false;
        emit WhitelistUpdated(user, false);
    }

    function isWhitelisted(address user) public view virtual returns (bool) {
        return whitelist[user];
    }
}
