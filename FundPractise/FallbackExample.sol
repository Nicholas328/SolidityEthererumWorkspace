// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FallbackExample{
    uint public result;

    /*
        Low level interactions
        calldata为空会被认为是交易行为，会调用receive()函数；
        如果不为空，会调用制定函数；
        如果没有该指定函数，则会调用callback()兜底
    */

    receive() external payable { 
        result = 1;
    }

    function method() public {
        result = 6;
    }

    fallback() external payable { 
        result = 66;
    }

}