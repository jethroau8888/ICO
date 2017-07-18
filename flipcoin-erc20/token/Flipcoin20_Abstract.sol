/******************************************************************************
 * COINFLIP MEMBERSHIP TOKEN - BASIC IMPLEMENTATION [v1.0.0]
 * Created: July 17, 2017 04:00
 *
 * Jack Kasbeer (@jcksber)
 *
 * Modified Last: July 18, 2017 03:21
 ******************************************************************************/
pragma solidity ^0.4.8;

// Token standard API
// https://github.com/ethereum/EIPs/issues/20

contract Flipcoin20_Abstract {
    function totalSupply() constant returns (uint supply);
    function balanceOf(address who) constant returns (uint256 balance);
    function allowance(address owner, address spender) constant returns (uint256 _allowance);

    function transfer(address to, uint256 value) returns (bool kk);
    function transferFrom(address from, address to, uint256 value) returns (bool kk);
    function approve(address spender, uint256 value) returns (bool kk);
    
    event Transfer(address indexed from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}