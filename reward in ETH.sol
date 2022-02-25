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
    uint256 ethPerCoin = .1;

    event Withdraw(address reciever, uint amount);
    event Deposit(address sender, uint amount);

    constructor(Supply) public ERC20("BOND", "BND") {
        _mint(msg.sender, Supply);
    }    
    //now - PayDayDelay < LastPayday;
    function addOwe(apiReuslts{}) external{
        uint256 give2 = owe[msg.sender];
        require(now-PayDayDealy < LastPayDay);

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
    }

    // from  https://ethereum.stackexchange.com/questions/77750/sending-money-through-a-smart-contract
    function withdrawAll() public {
        uint amount = owe[msg.sender];
        require(owe[msg.sender] >= amount, "Insufficient funds");
        emit Withdrawal(msg.sender, amount);
        owe[msg.sender] -= amount;
    }

    function deposositIncontract(uint256 depositAmount) public payable{
        require(msg.value >= depositAmount);
        Deposit(msg.sender, depositAmount);
    }
}
