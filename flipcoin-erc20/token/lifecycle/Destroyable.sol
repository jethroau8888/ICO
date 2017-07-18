/****************************************************************
 * Destroyable.sol - mortality can be necessary
 * Created: July 18, 2017 04:04
 *
 * Jack Kasbeer (@jcksber)
 *
 * Modified Last: July 18, 2017 04:45
 *****************************************************************/

import "../lib/Ownable.sol";

pragma solidity ^0.4.11;

// Mortal
// Reserving the right to retreat from the blockchain
contract Mortal is Ownable {
    function close() onlyOwner {
        selfdestruct(owner);
    }
}