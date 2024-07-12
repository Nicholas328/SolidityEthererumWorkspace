// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0; 

import "./SimpleStorage.sol";

//继承类
contract ExtraStorage is SimpleStorage{

    /*
        方法重写
        被重写的方法需要virtual修饰符
        新的方法需要override修饰符
    */
    function storeNum(uint256 _favouriteNumber) public override {
        favouriteNumber = _favouriteNumber + 5;
    }
}