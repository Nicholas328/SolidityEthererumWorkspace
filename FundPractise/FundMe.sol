// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Get funds from users
    Withdraw funds
    Set a minimum funding value in USD
*/

import "./PriceConverter.sol";

error notOwner();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public tempNum;
    uint256 public constant MINIMUM_USD = 50 * 10 ** 18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    /*
        immutable修饰符 一次赋值不可再更改
        在编译阶段就完成了固化，在链上的执行阶段不是变量，不占用执行内存
    */
    address public immutable i_owner;
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        /*
            Transactions - Fields
            Nonce: tx count for the account
            Gas Price: price per unit of gas(in wei)
            Gas Limit:mas gas that this tx can use
            To：address that the txt is sent to
            Value: amount of wei to send
            Data:what to send to the To address
            v,r,s:components of tx signature
            -----------------------------------------
        */
        /*
            Reverting: undo any action before, and send remaining gas back
            拒绝后，剩余的gas会回退，但消耗掉的gas不会回退。上面执行的代码也会回滚
        */
        tempNum = 66;
        // Set a minimum fund amount in USD
        // How to receive ETH to this contract
        /*
            1. 直接调用
                PriceConverter.getConversionRate(msg.value) 
            2. 将对应方法赋与特定数据类型上，使整个合约都能调用
                using PriceConverter for uint256;
                msg.value.getConversionRate()
        */
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didnt send enough!");// 1e18 == 1*10*18 == 1000000000000000000
        funders.push(msg.sender);//Put address into array
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner{
        //重置mapping
        for (uint256 index=0; index < funders.length; index++) {
            address funder = funders[index];
            addressToAmountFunded[funder] = 0;
        }
        //Reset the array
        funders = new address[](0);
        /*  Actually withdraw the funds
            3 ways: transfer, send,call
            msg.sender is address
            payable(msg.sender) is payable address
        */
        //Transfer(max 2300 gas, throws error) (no longer recommended)
        // payable(msg.sender).transfer(address(this).balance); 

        //Send(max 2300 gas, bool) (not recommended)
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send failed");

        // //Call(all/set gas, bool) (recommended)
        (bool callSuccess, ) = payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess,"Call failed");
    }

    modifier onlyOwner{
        // require(msg.sender == i_owner);//只允许owner调用此方法
        if(msg.sender != i_owner){ 
            revert notOwner();
        }
        _;
    }
}