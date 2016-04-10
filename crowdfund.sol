contract CrowdFund {
  struct Funder {
    address addr;
    uint amount;
  }

  event FundsReceived(address sender);
  event GoalCrossed();

  mapping (uint => Funder) funders;
  uint public numberOfFunders = 0;
  address accountToSendTo;
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
    FundsReceived(msg.sender);
    if (amountReceived > goalAmount) {
      GoalCrossed();
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
        accountToSendTo.send(amountReceived);
      } else {
        for (uint i = 0; i < numberOfFunders; i++) {
          Funder funder = funders[i];
          funder.addr.send(funder.amount);
        }
      }
      isOpen = false;
    }
  }
}
