/******************************************************************************
 * COINFLIP CROWDSALE [v2.0.0]
 * Created: July 17, 2017 04:33
 *
 * Jack Kasbeer (@jcksber)
 *
 * Modified Last: July 17, 2017 04:41
 *
 * Original source can be found here 
 * -> [https://github.com/OpenZeppelin/zeppelin-solidity/../CappedCrowdsale.sol]
 ******************************************************************************/
pragma solidity ^0.4.11;

import './Crowdsale20_bones.sol';

/**
 * @title CappedCrowdsale
 * @dev Extension of Crowsdale with a max amount of funds raised
 */
contract CappedCrowdsale is Crowdsale {
  using SafeMath for uint256;

  uint256 public fundingCap;    // 50 million tokens
  uint256 public fundingGoal;   // 30 million tokens
  uint256 public deadline;      // launch + 90 days
  bool fundingCapReached = false;  // booleans for states
  bool fundingGoalReached = false;
  bool crowdsaleClosed = false;
  mapping(address => uint256) public balanceOf; // unsure
  //
  // NEEDS MODIFICATIONS FOR COINFLIP SPECIFICATIONS
  //
  /* CONSTRUCTOR */ // Do we need to initiate a Crowdsale(...)?
  function CappedCrowdsale(uint256 cap, uint256 fundingGoalInEthers, uint256 durationInMinutes) {
    fundingCap = cap;
    fundingGoal = fundingGoalInEthers * 1 ether;
    deadline = now + durationInMinutes * 1 minutes;
  }
  
  // UNFINISHED !
  // overriding Crowdsale20_bones#hasEnded to add cap logic
  // @return true if crowdsale event has ended
  function hasEnded() public constant returns (bool) {
    bool capReached = weiRaised >= cap;
    return super.hasEnded() || capReached;
  }
  /* checks if the goal or time limit has been reached 
   * and ends the campaign
   */ // INTEGRATE THIS INTO hasEnded() (above)
  // function checkGoalReached() afterDeadline {
  //     if (amountRaised >= fundingGoal){
  //         fundingGoalReached = true;
  //         GoalReached(beneficiary, amountRaised);
  //     }
  //     crowdsaleClosed = true;
  // }

  // UNFINISHED
  function safeWithdrawal() afterDeadline {
    if (!fundingGoalReached) {
        uint amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        if (amount > 0) {
            if (msg.sender.send(amount)) {
                FundTransfer(msg.sender, amount, false);
            } else {
                balanceOf[msg.sender] = amount;
            }
        }
    }

    if (fundingGoalReached && wallet == msg.sender) {
        if (wallet.send(amountRaised)) { 
            FundTransfer(wallet, amountRaised, false);
        } else {
            //If we fail to send the funds to beneficiary, unlock funders balance
            fundingGoalReached = false;
        }
    }
  }


  // DELETED CODE
  // overriding Crowdsale20_bones#validPurchase to add extra cap logic
  // @return true if investors can buy at the moment
  // function validPurchase() internal constant returns (bool) {
  //   bool withinCap = weiRaised.safeAdd(msg.value) <= cap;
  //   return super.validPurchase() && withinCap;
  // }


}
