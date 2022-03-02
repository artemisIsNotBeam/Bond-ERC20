// reward in ETH.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import ERC20 functionality
import "token/ERC20/ERC20.sol";
import "token/ERC20/IERC20.sol";
//feel free to change any of the constructor code

contract BondToken is ERC20 {
    mapping (address => uint) owe; 
    mapping (address => address) walletList;
    // all these variable you can change
    uint256 SupplyLeft = 300;
    uint256 ICOprice=.01;
    uint256 initialMintAMount = 20;
    //pay day logic
    uint256 PayDayDelay = 30 seconds;
    uint256 LastPayday = 0 seconds;
    uint256 amountForPayDay = 30; 
    // thingy /more variables
    uint256 ethPerCoin = .1;              
    uint256 miniumAmount = 0;
    uint256 miniumWithdraw = 0;          

    event Withdraw(address reciever, uint amount);              
    event Deposit(address sender, uint amount);
    //if using this contract feel free to change any a name or ammount
    constructor() public ERC20("BOND token", "BND") {
        //this dosen't mint all only the initial amount
        _mint(msg.sender, initialMintAMount);
        SupplyLeft-= initialMintAMount;
    }    


    function amountTheyOwen(address person) public returns(uint){
        IERC20(person).balanceOf(account);
    }

    //now - PayDayDelay < LastPayday;
    function addOwe(uint payNow) external{
        require(now-PayDayDealy < LastPayDay);
        require(msg.sender);
        
        /*
        logic for thing

        require(amount > miniumAmount);
        owe[theirWallet] += amount * ethPerCoin;
        */

        
        //if they want to get money now call Withdraw all
        if (payNow == true){
            withdrawAll();
        }
        
    }


    // from  https://ethereum.stackexchange.com/questions/77750/sending-money-through-a-smart-contract
    function withdrawAll() external{
        //set how much we owe them 
        uint amount = owe[msg.sender];
        //make sure their withdraw is valid
        require(amount > miniumWithdraw);
        //withdraw to them
        emit Withdrawal(msg.sender, amount);
        // take away the debt to them
        owe[msg.sender] -= amount;
    }

    function deposositIncontract(uint256 depositAmount) public payable{
        // just put money in
        require(msg.value >= depositAmount);
        Deposit(msg.sender, depositAmount);
    }

    function buyBondWithEth(uint256 Howmany) public payable{
        uint price = Howmany * ICOprice;
        //find  price
        require(msg.value >= price);
        require(Howmany <= SupplyLeft);
        //make sure the persron has enough in their wallet and we have enough left
        _mint(msg.sender, Howmany);
        Deposit(msg.sender, price);
        //give us the MULA and mint them coins
        SupplyLeft -= Howmany;
    }

    
}
