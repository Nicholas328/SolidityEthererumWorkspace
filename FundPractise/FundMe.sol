// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Get funds from users
    Withdraw funds
    Set a minimum funding value in USD
*/
contract FundMe{

    uint256 public tempNum;
    uint256 public minimumUSD = 50;

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
        // Set a minimum fund amount in USD
        // How to receive ETH to this contract
        tempNum = 66;
        require(msg.value >= 1e18, "Didnt send enough!");// 1e18 == 1*10*18 == 1000000000000000000
        /*
            Reverting: undo any action before, and send remaining gas back
            拒绝后，剩余的gas会回退，但消耗掉的gas不会回退。上面执行的代码也会回滚
        */



    }

    function withdraw() public{}
}