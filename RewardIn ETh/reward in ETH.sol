// reward in ETH.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import ERC20 functionality
import "../token/ERC20/ERC20.sol";
import "../token/ERC20/IERC20.sol";
//feel free to change any of the constructor code

contract BondToken is ERC20 {
    // all these variable you can change
    uint256 SupplyLeft = 300 * 10^18;
    //one onehundredeth
    uint256 ICOprice=1;
    uint256 initialMintAMount = 20*10^18;         

    event Withdraw(address reciever, uint amount);              
    event Deposit(address sender, uint amount);
    //if using this contract feel free to change any a name or ammount
    constructor() ERC20("BOND token", "BND") {
        //this dosen't mint all only the initial amount
        _mint(msg.sender, initialMintAMount);
        SupplyLeft-= initialMintAMount;
    }    

    

    function buyBondWithEth(uint256 Howmany) public payable{
        uint price = Howmany * ICOprice/100;
        //find  price
        require(msg.value >= price);
        require(Howmany <= SupplyLeft);
        //make sure the persron has enough in their wallet and we have enough left
        _mint(msg.sender, Howmany*10^18);
        emit Deposit(msg.sender, price);
        //give us the MULA and mint them coins
        SupplyLeft -= Howmany;
    }

    
}
