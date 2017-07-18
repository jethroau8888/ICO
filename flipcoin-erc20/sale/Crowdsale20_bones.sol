/******************************************************************************
 * COINFLIP CROWDSALE [v2.0.0]
 * Created: July 17, 2017 04:42
 *
 * Jack Kasbeer (@jcksber)
 *
 * Modified Last: July 17, 2017 08:00
 *
 * Original source can be found here 
 * -> [https://github.com/OpenZeppelin/zeppelin-solidity/../Crowdsale.sol]
 ******************************************************************************/
 pragma solidity ^0.4.11;

import './Flipcoin20.sol';
/* Needed functionality from SafeMath library */
/* https://github.com/LykkeCity/EthereumApiDotNetCore/blob/master/src/ContractBuilder/contracts/token/SafeMath.sol */
contract SafeMath {
    uint256 constant public MAX_UINT256 =
    0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    function safeAdd(uint256 x, uint256 y) constant internal returns (uint256 z) {
        if (x > MAX_UINT256 - y) throw;
        return x + y;
    }

    function safeSub(uint256 x, uint256 y) constant internal returns (uint256 z) {
        if (x < y) throw;
        return x - y;
    }

    function safeMul(uint256 x, uint256 y) constant internal returns (uint256 z) {
        if (y == 0) return 0;
        if (x > MAX_UINT256 / y) throw;
        return x * y;
    }
}

/**
 * @title Crowdsale 
 * @dev Crowdsale is a base contract for managing a token crowdsale.
 * Crowdsales have a start and end block, where investors can make
 * token purchases and the crowdsale will assign them tokens based
 * on a token per ETH rate. Funds collected are forwarded to a wallet 
 * as they arrive.
 */
contract Crowdsale {
  using SafeMath for uint256;

  // The token being sold
  Flipcoin20 public token; // DOUBLE CHECK THIS

  // start and end block where investments are allowed (both inclusive)
  uint256 public startBlock;
  uint256 public endBlock;

  // address where funds are collected
  address public wallet;

  // how many token units a buyer gets per ETH
  uint256 public price;

  // amount of raised money in wei
  uint256 public amountRaised;

  /**
   * event for token purchase logging
   * @param purchaser who paid for the tokens
   * @param beneficiary who got the tokens
   * @param value weis paid for purchase
   * @param amount amount of tokens purchased
   */ 
  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);

  event GoalReached(address beneficiary, uint amountRaised); // unsure
  event FundTransfer(address backer, uint amount, bool isContribution); // unsure


  function Crowdsale(uint256 _startBlock, uint256 _endBlock, uint256 rateInEther, address _wallet) {
    require(_startBlock >= block.number);
    require(_endBlock >= _startBlock);
    require(_rate > 0);
    require(_wallet != 0x0);

    wallet = _wallet;               //formerly called 'beneficiary'
    startBlock = _startBlock;       //unsure
    endBlock = _endBlock;           //unsure
    price = rateInEther * 1 ethers; //evaluates to Wei 
  }

  // Allow investors to purchase Flipcoin 
  function () payable {
    if (crowdsaleClosed) throw;
    uint256 amount = msg.value;
    balanceOf[msg.sender] = amount;
    amountRaised += amount;
    token.transfer(msg.sender, amount / price); // DOUBLE CHECK THIS
    FundTransfer(msg.sender, amount, true);
  }

  // @return true if the transaction can buy tokens
  function validPurchase() internal constant returns (bool) {
    uint256 current = block.number;
    bool withinPeriod = current >= startBlock && current <= endBlock;
    bool nonZeroPurchase = msg.value != 0;
    return withinPeriod && nonZeroPurchase;
  }

  // @return true if crowdsale event has ended
  function hasEnded() public constant returns (bool) {
    return block.number > endBlock;
    // add more checks here
  } 


  modifier afterDeadline() { if (now >= deadline) _; }


  // DELETED CODE 

  // creates the token to be sold. 
  // function createTokenContract() internal returns (Flipcoin20) {
  //   return new Flipcoin20();
  // }

}
