// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/security/Pausable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/access/AccessControl.sol";


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

    //Event for change tracking 
    event TaxUpdate(uint256 oldTax, uint256 newTax);
    event TreasuryUpdate(address oldTreasury, address newTreasury);
    event whitelistUpdat(address updateUser, bool status);
    event adminUpdate(address oldAdmin, address newAdmin);


    constructor(address _admin, address _treasury) ERC20("FrankCoin", "FRNC")
    {
        
        require(_admin != address(0) && _treasury != address(0),"Invalid arguments");  // avoiding empty addresses error during initiation
        
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);  // Grants default role to admin
        _grantRole(ADMIN_ROLE, _admin);  //Granted admin role to admin
        _grantRole(MINER_ROLE, _admin);  // Granting miner role to admin

        treasury = _treasury; //Setting the treasury address

    }


    //Contract metadata functions  
    function contractName() public pure returns(string memory)
    {
        return "FrankCoin";
    }

    function contractVersion() public pure returns(string memory)
    {
        return "1.0.0";
    
    }

    function contractDescription() public pure returns (string memory) {
    return "A production-grade real estate custody token with role-based minting, tax logic, whitelist, and upgradeable ownership.";
    }

    //Mint restricted to mint users
    function mint(address to, uint256 amount) public onlyRole(MINER_ROLE)
     {
        _mint(to, amount);
    
     }

     //Applying taxes to transfer
     function _transfer(address from, address to, uint256 amount) internal override{

        if (whitelist[from] || whitelist[to]){
           super. _transfer(from, to, amount);
     } else {
        //Calculating tax 
            uint256 tax = ((taxPercentage * (amount)) /100) ;       
            uint256 afterTax = amount - tax;
            //Appling tax to transfer
           super._transfer(from,to, afterTax);
           //Applying tax to treasury wallet
         super._transfer(from, treasury, tax );
     }

}

//Add Whitelist Management Functions
function addToWhiteList(address user) external onlyRole(ADMIN_ROLE){
        whitelist[user] = true;
        emit whitelistUpdat(user,true);
    }
function removeWhiteList(address user) external onlyRole(ADMIN_ROLE) {
         whitelist[user]= false;
         emit whitelistUpdat(user,false);
    }

//Add Pause/Unpause Functions
function pause() public onlyRole(ADMIN_ROLE) 
{
        _pause();
        
    }
    function unpause() public onlyRole(ADMIN_ROLE){
       _unpause();
            
    }

   function _beforeTokenTransfer(address from, address to, uint256 amount)
    internal
    whenNotPaused
    override
{
    super._beforeTokenTransfer(from, to, amount);
}

   function updateTaxPercentage(uint256 newTaxPercentage) external onlyRole(ADMIN_ROLE) {
        require(newTaxPercentage <= 1000,"Invalid Tax percentage");
        //Saving old percentage value to return it in case if user wants to revert back 
        uint256 oldTax = taxPercentage;
        taxPercentage = newTaxPercentage;
        emit TaxUpdate(oldTax,newTaxPercentage);
    }

    function transferAdmin(address newAdmin) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(newAdmin != address(0),"Invalid Arguments"); // Checking if new admin is not empty
        address oldAdmin = msg.sender;

        _grantRole(DEFAULT_ADMIN_ROLE, newAdmin);
        _grantRole(ADMIN_ROLE,newAdmin);
        
        emit adminUpdate(oldAdmin,newAdmin);

        _revokeRole(ADMIN_ROLE, msg.sender);
        _revokeRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

}



