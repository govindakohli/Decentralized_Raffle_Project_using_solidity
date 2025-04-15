// Layout of the contract file:
// version
// imports
// errors
// interfaces, libraries, contract

// Inside Contract:
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private

// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

/**
 * @title A Raffle contract
 * @author Govinda
 * @notice This contract is for creating raffle contract
 * @dev Implementing Chainlink VRFv2.5
 */
contract Raffle {
    // Errors //
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_enteranceFee;
    address payable[] private s_players;

    // Events //

    event RaffleEntered(address indexed player);

    // Constructor //
    constructor(uint256 entranceFee) {
        i_enteranceFee = entranceFee;
    }

    function enterRuffle() public payable {
        // require(msg.value >= i_enteranceFee, "Not Enough Amount sent!")
        require(msg.value >= i_enteranceFee, Raffle__SendMoreToEnterRaffle());
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() public {}

    // getter functions

    function getEntranceFee() external view returns (uint256) {
        return i_enteranceFee;
    }
}
