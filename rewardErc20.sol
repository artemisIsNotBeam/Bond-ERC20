// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts-master/openzeppelin-contracts-master2/contracts/token/ERC20/ERC20.sol";

//feel free to change any of the constructor code

contract BondToken is ERC20 {
    mapping (address => uint) owe;
    uint256 Supply = 20;
    uint256 TimefromLastPayDay = 0 seconds;
    uint256 LastPayday = 0 seconds;

    constructor(Supply) public ERC20("BOND", "BND") {
        _mint(msg.sender, Supply);
    }
}

contract RewardToken is ERC20{
    uint256 secondSupply = 10;

    
    constructor(secondSupply) public ERC20("RewardToken", "REW") {
        _mint(msg.sender, secondSupply);
    }
}