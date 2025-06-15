// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Whitelist.sol";
import "../roles/Roles.sol";
import "../openzeppelin-contracts-master/contracts/token/ERC20/ERC20.sol";



abstract contract Taxablebl is ERC20, Whitelist, Roles  {
    
    address public treasury;
    uint256 public taxPercentage = 200;

    event updatTax(uint256 oldTax, uint256 newTax);
    event updateTreasury(address oldTreasury, address newTreasury);

    constructor(address _treasury) {
        require(_treasury != address(0), "The treasury cannot be");
        treasury = _treasury;
    }

    //Updating tax
    function changeTax(uint256 _taxPercentage) external{
        require(_taxPercentage <= 1000, "The tax cannot exceed 10%;");
        uint256 oldTax = taxPercentage;
        taxPercentage = _taxPercentage;
        
        emit updatTax(oldTax, _taxPercentage);
    }

    //Updating treasury
    function changeTreasury(address _treasury) external {
        require(_treasury != address(0), "The treasury cannot be");
        address oldTreasury = treasury;
        treasury = _treasury;

        emit updateTreasury(oldTreasury, _treasury);
    }

    //Applying tax during transfer 
    function _taxedTransfer(address from, address to, uint256 amount) internal {
        if (whitelist[from] || whitelist[to]) {
            // Exempt from tax
            super._transfer(from, to, amount);
        } else {
            // Apply tax
            uint256 tax = (amount * taxPercentage) / 10000; // Convert to percentage
            uint256 netAmount = amount - tax;

            super._transfer(from, to, netAmount);       // Send net amount
            super._transfer(from, treasury, tax);       // Send tax to treasury
        }
    }

}