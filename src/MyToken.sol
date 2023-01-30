// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MyERC20Token is Ownable, ERC20, ERC20Burnable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 amount
    )
        ERC20Burnable()
        ERC20(name, symbol)
        Ownable()
    {
         _mint(msg.sender, amount * (10 ** decimals()));
    }
}