/******************************************************************************
 * COINFLIP MEMBERSHIP TOKEN
 * FLIPCOIN [v1.0.0]
 * Created: July 17, 2017 04:18
 *
 * Jack Kasbeer (@jcksber)
 *
 * Modified Last: July 18, 2017 05:54
 ******************************************************************************/
import "./Flipcoin20_Standard.sol";
import "../../lib/Member.sol";
import "../../lib/Security.sol";


pragma solidity ^0.4.8;

// FlipcoinBundle
// Package inherited contracts, ensure order checks out
contract FlipcoinBundle is Flipcoin20_Standard(0), Member { 
// unsure if i can leave this contract empty....
}

// Flipcoin
// ERC20 implementation of a Flipcoin
contract Flipcoin is FlipcoinBundle, Stoppable {

    // Declare symbol
    bytes32 public symbol;    
    // Assign decimal #             
    uint256 public decimals = 18; // standard    

    // Flipcoin constructor !!!
    function Flipcoin(bytes32 symbol_) {                             
        symbol = symbol_;                  
    }

    // Receive ether != bueno
    function () { throw; }

    // ERC20 call forwards
    function transfer(address dst, uint pot) stoppable note returns (bool) {
        return super.transfer(dst, pot);
    }

    function transferFrom(
        address src, address dst, uint pot
    ) stoppable note returns (bool) {
        return super.transferFrom(src, dst, pot);
    }
    function approve(address addy, uint pot) stoppable note returns (bool) {
        return super.approve(addy, pot);
    }


    // Alias to transfer
    function push(address dst, uint128 pot) returns (bool) {
        return transfer(dst, pot);
    }

    // Alias to transferFrom
    function pull(address src, uint128 pot) returns (bool) {
        return transferFrom(src, msg.sender, pot);
    }


    // CREATE Flipcoins in msg.sender
    function mint(uint128 pot) auth stoppable note {
        _balances[msg.sender] = safeAdd(_balances[msg.sender], pot);
        _supply = safeAdd(_supply, pot);
    }

    // DESTROY msg.sender's Flipcoins 
    function burnPotReserve(uint128 pot) auth stoppable note {
        _balances[msg.sender] = safeSub(_balances[msg.sender], pot);
        _supply = safeSub(_supply, pot);
    } 


    // Name the token
    bytes32 public name = "";     

    function setName(bytes32 name_) auth {
        name = name_;
    }    
}