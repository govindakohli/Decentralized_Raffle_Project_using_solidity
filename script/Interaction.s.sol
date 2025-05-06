// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import {Script, console} from "forge-std/Script.sol";
import {VRFCoordinatorV2_5Mock} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

// C:\Users\goluk\OneDrive\Desktop\Blockchain\MyContracts\LotteryProject\lib\chainlink-brownie-contracts\contracts\src\v0.8\vrf\
import {HelperConfig} from ".././script/HelperConfig.s.sol";

contract CreateSubsciption is Script {
    function CreateSubsciptionUsingConfig() public returns (uint256, address) {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        (uint256 subId, ) = createSubsciption(vrfCoordinator);
        return (subId, vrfCoordinator);
    }

    function createSubsciption(
        address vrfCoodinator
    ) public returns (uint256, address) {
        console.log("Creating Subscription on chainId:", block.chainid);
        vm.startBroadcast();
        uint256 subId = VRFCoordinatorV2_5Mock(vrfCoodinator)
            .createSubscription();
        vm.stopBroadcast();
        console.log("Your subscription Id  is:", subId);
        console.log(
            "Please update the subscription id in your helperConfig.s.sol"
        );
        return (subId, vrfCoodinator);
    }

    function run() public {
        CreateSubsciptionUsingConfig();
    }
}
