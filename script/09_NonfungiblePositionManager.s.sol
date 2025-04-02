// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { NonfungiblePositionManager } from "../src/periphery/NonfungiblePositionManager.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract NonfungiblePositionManagerScript is Constants {

    function run() external returns (NonfungiblePositionManager manager) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address WETH9 = vm.envAddress(PARAM_WETH9);
        address V3FACTORY = vm.envAddress(PARAM_V3_FACTORY);
        address TOKEN_DESCRIPTOR = vm.envAddress(PARAM_TOKEN_DESCRIPTOR);

        console.log("Starting script: broadcasting");
        console.log("Owner:     ", ownerAddress);
        console.log("WETH9:     ", WETH9);
        console.log("Factory:   ", V3FACTORY);
        console.log("Token Descriptor:     ", TOKEN_DESCRIPTOR);
        console.log("Salt:      ");
        console.logBytes32(salt);

        vm.startBroadcast(deployerPrivateKey);

        // constructor(address _factory, address _WETH9, address _tokenDescriptor_ )
        manager = new NonfungiblePositionManager{salt: salt}(V3FACTORY, WETH9, TOKEN_DESCRIPTOR);

        vm.stopBroadcast();
        console.log("NonfungiblePositionManager:     ", address(manager));
        return manager;
    }
}