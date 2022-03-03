// reward in ETH.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import ERC20 functionality
import "token/ERC20/ERC20.sol";
import "token/ERC20/IERC20.sol";
//feel free to change any of the constructor code

contract RewardToken is ERC20{
    //Important put the RewardInNative first
    address BondContract = // IMPORTANT YOU WILL NEED TO FILL THIS OUT
    ///////////////////////




    //arrays for adding owe
    mapping (address => uint) owe; 
    uint walletList = [];
    uint256 secondSupply = 10;
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
    
    constructor() public ERC20("RewardToken", "REW") {
        // we don't mint anything initally
    }

    function amountTheyOwen(address user) public returns(uint){
        // first, initialize ERC20 interface instance with a token address
        ERC20 token = ERC20(tokenAddress);
        uint256 balance = token.balanceOf[user];
        return balance;
    }


    function registerWallet() public{
        uint TheyOwn = amountTheyOwen(msg.sender);
        if (TheyOwn > miniumAmount){
            walletList.push(msg.sender);
        }
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

        for (let i=0;i<walletList.length;i++){
            address wallet = walletList[i];
        }
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
}