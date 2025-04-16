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
import {VRFConsumerBaseV2Plus} from "./lib\chainlink-brownie-contracts\contracts\src\v0.8\vrf\dev\VRFConsumerBaseV2Plus.sol";

// import {VRFConsumerBaseV2Plus} from "@chainlink/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";

/**
 * @title A Raffle contract
 * @author Govinda
 * @notice This contract is for creating raffle contract
 * @dev Implementing Chainlink VRFv2.5
 */
contract Raffle is VRFConsumerBaseV2Plus {
    // Errors //
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_enteranceFee;
    // @dev The duration of the lottery in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    // Events //

    event RaffleEntered(address indexed player);

    // Constructor //
    constructor(uint256 entranceFee, uint256 interval) {
        i_enteranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRuffle() external payable {
        // require(msg.value >= i_enteranceFee, "Not Enough Amount sent!")
        require(msg.value >= i_enteranceFee, Raffle__SendMoreToEnterRaffle());
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    //1. Get a random number
    //2. Use random number to pick a player
    //3. be automatically called

    function pickWinner() external {
        // Check to see if enough time has passed
        // block.timestamp - s_lastTimeStamp > i_interval;
        require(
            block.timestamp - s_lastTimeStamp > i_interval,
            "Unable to decide the Winner due to time issue"
        );

        requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: s_keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );
    }

    // getter functions //

    function getEntranceFee() external view returns (uint256) {
        return i_enteranceFee;
    }
}
