# Flipcoin

## IMPORTANT NOTES
### Updated Last: July 17, 2017 06:22 CST
### Development
* ERC20 :: If you want your contract to receive Ether, you have to implement a fallback function. 
*       :: Please ensure you test your fallback function thoroughly to ensure the execution cost is less than 2300 gas before deploying a contract.

Main development occuring on `erc20` branch (this is finalized for launch)

`master` branch currently contains an ERC223 implementation.
## Flipcoin20.sol
### Description 
Implements ERC20 Token Standard at the most basic level, inherits from:
* `Member`: a token with a modifiable supply, pending ownership status, and holds the name & phone number of the Flipcoin owner, and
* `Stoppable`: a means for freezing and continuing function calls
	* `Note`: contains a modifier for logging calls as events, and
	* `Auth`: an access control pattern for Ethereum 
### Dependencies
Flipcoin20_Abstract 
	=> Flipcoin20_Standard, 
	   Member 
           Stoppable
		=> Flipcoin20 

## Crowdsale20.sol
### Description
Crowdsale implementation, based on [ https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/crowdsale/CappedCrowdsale.sol ], has fixed token supply, built-in timeout, a funding GOAL, but also CAP, and is PAYABLE.
### Dependencies
Crowdsale20_bones
	=> Crowdsale20
### To-do
* Remove MintableToken reference and replace with Flipcoin20

## Member.sol
### Description
Contains contracts for logic concerning: 
* Ownership
* New owner interaction
* Contact information

## Security.sol
### Description
All contracts regarding security of a contract, which currently includes:
* Re-entry attack guard
### To-do
Incorporate this. If not in any token functions, then definitely in the crowdsale file (now in `sale/`).

## doc/
### Description
@jcksber's notes condensing the Solidity documentation 
