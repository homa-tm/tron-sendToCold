// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HCFactory {
    address[] public deployedContracts;
    address payable depositeSCAddress = payable(0x40DADc4Ae6a8ecF9c071453B6C05C28a7D50E97f); // Address to transfer the entire balance
    address public owner;

constructor() {
        owner = msg.sender;
    }
    
    
    // Modifier to check if the sender is the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }
    
    function createContract() public {
        address newUserContract = address(new UserTrx(depositeSCAddress));
        deployedContracts.push(newUserContract);
    }

    function getDeployedContracts() public view returns (address[] memory) {
        return deployedContracts;
    }
}

contract UserTrx {
    address payable public owner;
    address payable public depositeSCAddress;

    constructor(address payable _depositeSCAddress) {  
    //    owner = payable(msg.sender);
        depositeSCAddress = _depositeSCAddress;
    }

    // Modifier to check if the sender is the contract owner
    //modifier onlyOwner() {
    //    require(msg.sender == owner, "Only contract owner can call this function");
    //    _;
   // }

    // Function to transfer the entire balance to the specified address
    function transferEntireBalance() external {
        uint256 balance = address(this).balance;
        depositeSCAddress.transfer(balance);
    }

    // Fallback function to receive Ether
    receive() external payable {}
}
