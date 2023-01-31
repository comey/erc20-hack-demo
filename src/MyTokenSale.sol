// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./MyToken.sol";

contract MyTokenSale {

    address payable public admin;              //When you want to have Ether receiver in a SC, please define the receiver as payable
    MyERC20Token public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address indexed buyer, uint256 amount);

    constructor(MyERC20Token _tokenContract, uint256 _tokenPrice) {
        admin = payable (msg.sender);
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == _numberOfTokens*tokenPrice);
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));

        tokensSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    function refundUnsoldTokens () public {
        require(msg.sender == admin);
        tokenContract.transfer(admin, tokenContract.balanceOf(address(this)));
    }
    function endSale() public {
        require(msg.sender == admin);
        admin.transfer(address(this).balance);
    }
}