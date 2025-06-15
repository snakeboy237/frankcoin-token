// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./openzeppelin-contracts-master/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "./openzeppelin-contracts-master/contracts/token/ERC20/ERC20.sol";
import "./openzeppelin-contracts-master/contracts/access/AccessControl.sol";
import "./openzeppelin-contracts-master/contracts/Pausable.sol";
import "./extensions/Taxablebl.sol";
import "./metadata/Metadata.sol";
import "./roles/Roles.sol";





contract FrankCoin is Taxablebl, ERC20Burnable, Pausable, Metadata {
    constructor(address _admin, address _treasury)
        Taxablebl(_treasury)
        Roles(_admin) // or Roles(_admin), depending on the file name
        ERC20("FrankCoin", "FRNC") // don't forget ERC20 constructor if not already called
    {
        // Any other setup logic here
    }
}
