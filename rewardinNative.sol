// reward in ETH.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import ERC20 functionality
import "token/ERC20/ERC20.sol";
import "token/ERC20/IERC20.sol";
//feel free to change any of the constructor code

contract BondToken is ERC20 {
    uint256 SupplyLeft = 300;
    //if using this contract feel free to change any a name or ammount
    constructor() public ERC20("BOND token", "BND") {
        //this dosen't mint all only the initial amount
        _mint(msg.sender, SupplyLeft);
    }    
}


