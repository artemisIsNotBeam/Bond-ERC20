// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "token/ERC20/ERC20.sol";

//feel free to change any of the constructor code

contract BondToken is ERC20 {
    mapping (address => uint) owe; 
    uint256 Supply = 20;
    //pay day logic
    uint256 PayDayDelay = 30 seconds;
    uint256 LastPayday = 0 seconds;
    uint256 amountForPayDay = 30; 
    uint256 ethPerCoin = .1;
    //minium
    uint256 miniumAmount = 0;
    uint256 miniumWithdraw = 0;

    event Withdraw(address reciever, uint amount);
    event Deposit(address sender, uint amount);

    constructor(Supply) public ERC20("BOND", "BND") {
        _mint(msg.sender, Supply);
    }    
    //now - PayDayDelay < LastPayday;
    function addOwe(uint amount, address theirWallet) external{
        require(now-PayDayDealy < LastPayDay);
        require(msg.sender == theirWallet);
        /*
        https://docs.bscscan.com/api-endpoints/tokens#get-token-holder-list-by-contract-address
        gonna use this one: Get BEP-20 Token Account Balance by ContractAddress
        will be having that entered
        at position of the adreess

        the thing added will be 
        amount*ethPerCoin

        can also set a minmium amount to claim
        */

        // this is gonna best test script so I know I have the function working
        //owe[msg.sender] = apiResults["result"]
        //that will result in a string will need to convert into number

        //Just for context we pretend we have these amounts already given to us
        require(amount > miniumAmount);
        owe[theirWallet] += amount * ethPerCoin;
        // also need to move date
        
    }

    // from  https://ethereum.stackexchange.com/questions/77750/sending-money-through-a-smart-contract
    function withdrawAll() public {
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
