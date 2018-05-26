pragma solidity ^0.4.18;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  function Token(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}

contract OverflowUnderFlow {
    uint public zero = 0;
    uint public max = 2**256-1;

    // zero will end up at 2**256-1
    function underflow() public {
        zero -= 1;
    }
    // max will end up at 0
    function overflow() public {
        max += 1;
    }
}

// bonus, from the Consensys smart contract best practices

contract UnderflowManipulation {
    address public owner;
    uint256 public manipulateMe = 10;
    function UnderflowManipulation() {
        owner = msg.sender;
    }

    uint[] public bonusCodes;

    function pushBonusCode(uint code) {
        bonusCodes.push(code);
    }

    event position (uint i);
    function pwn() public {
        popBonusCode();
        for (uint i = 1000; i < 5000; i++) {
            if (bonusCodes[i] != 0)
                emit position(i);
        }

    }

    function popBonusCode()  {
        require(bonusCodes.length >=0);  // this is a tautology
        bonusCodes.length--; // an underflow can be caused here
    }

    function modifyBonusCode(uint index, uint update)  {
        require(index < bonusCodes.length);
        bonusCodes[index] = update; // write to any index less than bonusCodes.length
    }

}
