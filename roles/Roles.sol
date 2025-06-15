// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../openzeppelin-contracts-master/contracts/access/AccessControl.sol";


abstract contract Roles is AccessControl {

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINER_ROLE = keccak256("MINER_ROLE");
    event updateAdmin(address oldAdmin, address newAdmin);

    constructor (address _admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
        _grantRole(ADMIN_ROLE, _admin);
        _grantRole(MINER_ROLE, _admin);
    }

    function transferAdmin(address newAdmin) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(newAdmin != address(0), "this is an invalid new admin");
        _grantRole(ADMIN_ROLE, newAdmin);
        _grantRole(MINER_ROLE, newAdmin);
        _grantRole(DEFAULT_ADMIN_ROLE, newAdmin);

        emit updateAdmin(msg.sender, newAdmin);

        _revokeRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _revokeRole(MINER_ROLE, msg.sender);
        _revokeRole(ADMIN_ROLE, msg.sender);



    }

}