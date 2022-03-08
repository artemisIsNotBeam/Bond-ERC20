// reward in ETH.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import ERC20 functionality
import "../token/ERC20/ERC20.sol";
import "../token/ERC20/IERC20.sol";
//feel free to change any of the constructor code


interface IBEP20 {
    // mind the `view` modifier
    function balanceOf(address _owner) external view returns (uint256);
}

contract RewardToken is ERC20{
    //arrays for adding owe
    mapping (address => uint) owe; 
    address[] WalletList;
    // all these variable you can change
    //pay day logic
    uint256 PayDayDelay = 30 seconds;
    uint256 LastPayday = 0 seconds;
    uint256 amountForPayDay = 30; 
    // thingy /more variables
    uint256 NativePerCoin = 1;              
    uint256 miniumAmount = 0;
    uint256 miniumWithdraw = 0;   
    address BondTokenAdress = 0xa94E3320973399eF276a73471974535AD1F4DC3D;
    //thats my ETh wallet send me eTH :))))

    event Withdraw(address reciever, uint amount);              
    event Deposit(address sender, uint amount);

    constructor() ERC20("RewardToken", "REW") {
        // we don't mint anything initally
    }

    function amountTheyOwen(address guy) public view returns(uint256){
        // first, initialize ERC20 interface instance with a token address
        // creating a pointer to the WBNB contract
        IBEP20 WBNBContract = IBEP20(BondTokenAdress);

        // getting balance of `bankAddress` on the WBNB contract
        return WBNBContract.balanceOf(guy);
    }


    function registerWallet() public{
        uint TheyOwn = amountTheyOwen(msg.sender);
        if (TheyOwn > miniumAmount){
            WalletList.push(msg.sender);
        }
    }
    //now - PayDayDelay < LastPayday;
    function addOwe(bool payNow) external{
        // make sure we can add
        require(block.timestamp-PayDayDelay < LastPayday);
        //update the last pay day time
        LastPayday +=PayDayDelay;
        //loop through all in WalletList
        for (uint i=0;i<WalletList.length;i++){
            //declare vars
            address daWallet = WalletList[i];
            uint amount = amountTheyOwen(daWallet);
            //if they own more than minium
            if (amount > miniumAmount){
                //add money to their owe
                //gives 1/10
                owe[daWallet] += amount * NativePerCoin/ 10 *10^18;
            }
        }
        if (payNow == true){
            withdrawAll();
        }
        
    }


    // from  https://ethereum.stackexchange.com/questions/77750/sending-money-through-a-smart-contract
    function withdrawAll() public{
        //make sure I have enough to pay out
        //set how much we owe them 
        uint amount = owe[msg.sender];
        //make sure their withdraw is valid
        require(amount > miniumWithdraw);
        //withdraw to them
        _mint(msg.sender,amount);
        // take away the debt to them
        owe[msg.sender] -= amount;
    }

    function deposositIncontract(uint256 depositAmount) public payable{
        // just put money in
        require(msg.value >= depositAmount);
        emit Deposit(msg.sender, depositAmount);
    }
}
