// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { QuoterV2 } from "../src/periphery/lens/QuoterV2.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract QuoterV2Script is Constants {

    function run() external returns (QuoterV2 quoterV2) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address WETH9 = vm.envAddress(PARAM_WETH9);
        address V3FACTORY = vm.envAddress(PARAM_V3_FACTORY);

        console.log("Starting script: broadcasting");
        console.log("Owner:     ", ownerAddress);
        console.log("WETH9:     ", WETH9);
        console.log("Factory:   ", V3FACTORY);
        console.log("Salt:      ");
        console.logBytes32(salt);

        vm.startBroadcast(deployerPrivateKey);

        // constructor(address _factory, address _WETH9)
        quoterV2 = new QuoterV2{salt: salt}(V3FACTORY, WETH9);

        vm.stopBroadcast();
        console.log("QuoterV2:  ", address(quoterV2));
        return quoterV2;
    }
}