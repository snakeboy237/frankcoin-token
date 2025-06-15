
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


// Creating Token
contract FrankCoin is ERC20, ERC20Burnable, Pausable, AccessControl {

    //Access control roles 
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MINER_ROLE = keccak256("MINER_ROLE");

    //Wallet to collect taxes
    address public treasury ;
    //Tax percentage 
    uint256 public taxPercentage = 200;
    //Tax whitelist map
    mapping(address =>bool) public whitelist;

    constructor(address _admin, address _treasury) ERC20("FrankCoin", "FRNC"){
        
        require(_admin != address(0) && _treasury != address(0),"Invalid arguments");  // avoiding empty addresses error during initiation
        
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);  // Grants default role to admin
        _grantRole(ADMIN_ROLE, _admin);  //Granted admin role to admin
        _grantRole(MINER_ROLE, _admin);  // Granting miner role to admin

        treasury = _treasury; //Setting the treasury address

    }
}