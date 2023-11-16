// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Degen is ERC20, ERC20Burnable, Ownable {
    constructor(address initialOwner)
        ERC20("Degen", "DGN")
        Ownable(initialOwner)
    {}

    function mintdegen(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferdegen(address to, uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough Degen");
        approve(msg.sender, amount);
        transferFrom(msg.sender, to, amount);
    }

    function redeemitem(int itemno) public payable returns(string memory){
        uint256 amount = 0;
        require(itemno > 0 && itemno <= 4, "No item selected");

        if(itemno == 1){
            amount = 10;
        }else if(itemno == 2){
            amount = 100;
        }else if(itemno == 3){
            amount = 200;
        }else if(itemno == 4){
            amount = 1000;
        }
        string memory errmsg = "You do not have ";
        errmsg = string.concat(string.concat(errmsg, Strings.toString(amount)), " Degen for this item");

        require(balanceOf(msg.sender) > amount, errmsg);
        burn(amount);
        return "Item bought successfully";
    }

    function checkbalance () public view returns(uint256){return balanceOf(msg.sender);}

    function burndegen (uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough Degen");
        burn(amount);
    }

    function checkitems () public pure returns(string memory){
        string memory items = "1. Potion 10 DGN | 2. Sword 100 DGN | 3. Shield 200 DGN | 4. Armor 1000 DGN";
        return items;
    }

}