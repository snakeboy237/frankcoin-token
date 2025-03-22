# FrankCoin 🪙

FrankCoin is a custom ERC-20 token written in Solidity using OpenZeppelin libraries. It includes advanced features such as:

- 🔥 Burnable: Token holders can burn (destroy) their own tokens.
- ⏸️ Pausable: The contract owner can pause and unpause all transfers.
- 🛡️ Ownable: Admin functions are protected and restricted to the owner.

## 🔧 Features

- `burn(uint256 amount)`: Destroy tokens from your own balance
- `pause()` / `unpause()`: Freeze or resume transfers (owner only)
- `onlyOwner`: Restricts admin functions to the deployer

## 🧪 Built With

- [Solidity ^0.8.0](https://docs.soliditylang.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/5.x/)
- [Remix IDE](https://remix.ethereum.org/)

## 📦 Contract

To be deployed on [Goerli](https://goerli.etherscan.io/) or [Sepolia](https://sepolia.etherscan.io/)

## 💡 Next Steps

- Add transfer tax & whitelist logic
- Deploy to a testnet
- Build a Web3 frontend using React + Ethers.js

## 🧑‍💻 Author

Frank — Web3 Developer in training 💪
