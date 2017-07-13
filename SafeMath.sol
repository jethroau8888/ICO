pragma solidity ^0.4.10;

/*
*@title overflow detection for uint math functinos
*@notice Inspired from Minime tokens
*/

contract SafeMath {

  function safeAdd(uint x, uint y) internal returns(uint) {
    uint z = x + y
    assert((z >= x) && (z >= y))
    return z
  }

  function safeSub(uint a, uint b) internal returns(uint){
    assert(b<=a);
    return a-b;
  }

  function safeMult(uint a, uint b) internal returns (uint){
    uint z = a*b;
    assert(z/a == b || a==0)
    return z
  }

  function safeDiv(uint a, uint b) internal returns (uint) {
    assert(b>0)
    uint z = a/b;
    assert(a== b*z + a % b)
    return z
  }
}
