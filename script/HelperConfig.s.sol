// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.29;

// import {Script} from "forge-std/Script.sol";

// abstract contract codeConstants {
//     uint256 public constant ETH_SEPOLIA_CHAIN_ID = 1115511;
//     uint256 public constant LOCAL_CHAIN_ID = 31337;
// }

// contract HelperConfig is codeConstants, Script {
//     error HelperConfig__InvalidChainId();
//     struct networkConfig {
//         uint256 entranceFee;
//         uint256 interval;
//         address vrfCoordinator;
//         byte32 gadLane;
//         uint32 callbackGasLimit;
//         uint256 subsciptionId;
//     }

//     networkConfig public localnetworkCofig;
//     mapping(uint256 chainId => networkConfig) public networkConfig;

//     constructor() {
//         networkConfig[ETH_SEPOLIA_CHAIN_ID] = getSepoliaEthConfig();
//     }

//     function getConfigByChainId(
//         uint256 chainId
//     ) public returns (networkConfig memory) {
//         if (networkConfigs[chainId].vrfCoordinator != address(0)) {
//             return networkConfig[chainId];
//         } else if (chainId = LOCAL_CHAIN_ID) {
//             //getOrCreateAnvilEthConfig()
//         } else {
//             revert HelperConfig__InvalidChainId();
//         }
//     }

//     function getSopoliaEthConfig() public pure returns (networkConfig memory) {
//         return
//             NetworkConfig({
//                 entranceFee: 0.01 ether, //1e16
//                 interval: 30, // 30 seconds
//                 vrfCoordinator: 0x3C0Ca683b403E37668AE3DC4FB62F4B29B6f7a3e,
//                 gasLane: 0xe9f223d7d83ec85c4f78042a4845af3a1c8df7757b4997b815ce4b8d07aca68c,
//                 callbackGasLimit: 500000,
//                 subscriptionId: 0
//             });
//     }

//     function getOrCreateAnvilEthConfig() public returns (networkConfig memory) {
//         // check to see if we sent an active network config
//         if (localnetworkCofig.vrfCoordinator != address(0)) {
//             return localnetworkCofig;
//         }
//     }
// }

import {Script} from "forge-std/Script.sol";
import {}

abstract contract codeConstants {
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 1115511;
    uint256 public constant LOCAL_CHAIN_ID = 31337;
}

contract HelperConfig is codeConstants, Script {
    error HelperConfig__InvalidChainId();

    struct NetworkConfig {
        uint256 entranceFee;
        uint256 interval;
        address vrfCoordinator;
        bytes32 gasLane;
        uint32 callbackGasLimit;
        uint256 subscriptionId;
    }

    NetworkConfig public localNetworkConfig;
    mapping(uint256 => NetworkConfig) public networkConfigs;

    constructor() {
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getSepoliaEthConfig();
    }

    function getConfigByChainId(
        uint256 chainId
    ) public view returns (NetworkConfig memory) {
        if (networkConfigs[chainId].vrfCoordinator != address(0)) {
            return networkConfigs[chainId];
        } else if (chainId == LOCAL_CHAIN_ID) {
            return getOrCreateAnvilEthConfig();
        } else {
            revert HelperConfig__InvalidChainId();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                entranceFee: 0.01 ether,
                interval: 30,
                vrfCoordinator: 0x3C0Ca683b403E37668AE3DC4FB62F4B29B6f7a3e,
                gasLane: 0xe9f223d7d83ec85c4f78042a4845af3a1c8df7757b4997b815ce4b8d07aca68c,
                callbackGasLimit: 500000,
                subscriptionId: 0
            });
    }

    function getOrCreateAnvilEthConfig()
        public
        view
        returns (NetworkConfig memory)
    {
        if (localNetworkConfig.vrfCoordinator != address(0)) {
            return localNetworkConfig;
        }
        revert HelperConfig__InvalidChainId(); // fallback case
    }
}
