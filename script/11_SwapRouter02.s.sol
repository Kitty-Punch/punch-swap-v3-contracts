// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { SwapRouter02 } from "../src/swap-router/SwapRouter02.sol";
import { Constants } from "./Constants.sol";
import { console } from "forge-std/console.sol";

contract SwapRouter02Script is Constants {

    function run() external returns (SwapRouter02 swapRouter02){
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address factoryV3 = vm.envAddress(PARAM_V3_FACTORY);
        address WETH9 = vm.envAddress(PARAM_WETH9);
        address factoryV2 = vm.envAddress(PARAM_V2_FACTORY);
        address positionManager = vm.envAddress(PARAM_POSITION_MANAGER);

        console.log("Owner:             ", ownerAddress);
        console.log("Factory V3:        ", factoryV3);
        console.log("WETH9:             ", WETH9);
        console.log("Factory V2:        ", factoryV2);
        console.log("Position manager:  ", positionManager);
        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);


        swapRouter02 = new SwapRouter02{salt: salt}(factoryV2, factoryV3, positionManager, WETH9);

        vm.stopBroadcast();
        console.log("SwapRouter02: ", address(swapRouter02));
        return swapRouter02;
    }
}