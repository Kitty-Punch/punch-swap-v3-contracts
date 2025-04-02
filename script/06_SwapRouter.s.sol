// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { SwapRouter } from "../src/periphery/SwapRouter.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract SwapRouterScript is Constants {
    function run() external returns (SwapRouter swapRouter) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address factory = vm.envAddress(PARAM_V3_FACTORY);
        address WETH9 = vm.envAddress(PARAM_WETH9);

        console.log("Owner:     ", ownerAddress);
        console.log("Factory:   ", factory);
        console.log("WETH9:     ", WETH9);
        console.log("Salt:      ");
        console.logBytes32(salt);
        console.log("Starting script: broadcasting");

        vm.startBroadcast(deployerPrivateKey);

        swapRouter = new SwapRouter{salt: salt}(factory, WETH9);

        vm.stopBroadcast();
        console.log("SwapRouter:  ", address(swapRouter));
        return swapRouter;
    }
}