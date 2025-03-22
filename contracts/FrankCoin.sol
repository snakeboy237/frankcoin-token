// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FrankCoin is ERC20Burnable, Pausable, Ownable {
    constructor(uint256 initialSupply) ERC20("FrankCoin", "FRC") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * (10 ** decimals()));
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // Hook that runs before any transfer (including mint and burn)
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal
        override
    {
        super._beforeTokenTransfer(from, to, amount);
        require(!paused(), "FrankCoin: Token transfers are paused");
    }
}

function _trand(address to, address from uint256 amount) internal {
    override 
    super._trand(from, to);
    

}
