// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "token/ERC20/ERC20.sol";

//feel free to change any of the constructor code

contract BondToken is ERC20 {
    mapping (address => uint) owe;
    uint256 Supply = 20;
    uint256 PayDayDelay = 30 seconds;
    uint256 LastPayday = 0 seconds;
    uint256 amountForPayDay = 30; 

    event Withdraw(address reciever, uint amount);
    event Deposit(address sender, uint amount);

    constructor(Supply) public ERC20("BOND", "BND") {
        _mint(msg.sender, Supply);
    }    
    //now - PayDayDelay < LastPayday;
    function addOwe() external{
        uint256 give2 = msg.sender;
        require(now-PayDayDealy < LastPayDay);

        //write more
        //add owe to everyone who owns right
        //do it in the owe array
    }

    function putmoney(uint amountOfMoney) external{
        require(msg.value >= amountOfMoney);

        
    }

    // from  https://ethereum.stackexchange.com/questions/77750/sending-money-through-a-smart-contract
    function withdrawAll() public {
        uint amount = owe[msg.sender];
        require(owe[msg.sender] >= amount, "Insufficient funds");
        emit Withdrawal(msg.sender, amount);
        balances[msg.sender] -= amount;
    }

    function deposositIncontract(uint256 depositAmount) public payable{
        Deposit(msg.sender, depositAmount);
    }
}
