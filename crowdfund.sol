contract CrowdFund {
  struct Funder {
    address addr;
    uint amount;
  }

  event Log(string message);

  mapping (uint => Funder) funders;
  uint public numberOfFunders = 0;
  address public accountToSendTo;
  uint public goalAmount;
  uint public deadline;
  bool public isOpen = true;
  uint public amountReceived = 0;

  function CrowdFund(address _accountToSendTo, uint _goalAmount, uint _duration) {
    accountToSendTo = _accountToSendTo;
    goalAmount = _goalAmount * 1 ether;
    deadline = now + _duration * 1 minutes;
  }

  // This function is called when someone sends money to the contract.
  function () {
    uint amount = msg.value;
    funders[numberOfFunders++] = (Funder({addr: msg.sender, amount: amount}));
    amountReceived += amount;
    Log("Funds Received");
    if (amountReceived >= goalAmount) {
      Log("Goal Crossed");
    }
  }

  // Return the status of the goal and received amount
  function checkStatus() constant returns (uint goal, uint received) {
    goal = goalAmount;
    received = amountReceived;
  }

  function transfer() {
    if (now >= deadline) {
      if (amountReceived >= goalAmount) {
        Log("Goal Crossed Transferring to Benificiary");
        accountToSendTo.send(amountReceived);
      } else {
        Log("Goal Not Reached. Refunding Amount");
        for (uint i = 0; i < numberOfFunders; i++) {
          Funder funder = funders[i];
          funder.addr.send(funder.amount);
        }
      }
      isOpen = false;
    } else {
      Log("Deadline not reached");
    }
  }
}
