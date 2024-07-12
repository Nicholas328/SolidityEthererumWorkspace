// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{

    SimpleStorage[] public storageArray;
    address[] public addressArray;

    function createSimpleStorageContract() public {
        SimpleStorage newStorage = new SimpleStorage();
        storageArray.push(newStorage);
        addressArray.push(address(newStorage));
    }

    //通过index获得SimpleStorage对象，调用方法赋值对象
    function storeNumByIndex(uint256 _index, uint _num) public {
        //ABI - Application Binary Interface
        SimpleStorage simpleStorage = storageArray[_index];
        simpleStorage.storeNum(_num);
    }

    function getNumByIndex(uint256 _index) public view returns(uint256) {
        // SimpleStorage simpleStorage = storageArray[_index];
        // return simpleStorage.getNum();
        return storageArray[_index].getNum();
    }

}