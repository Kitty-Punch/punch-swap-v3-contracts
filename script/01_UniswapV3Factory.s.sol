// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { console } from "forge-std/console.sol";
import { UniswapV3Factory } from "../src/core/UniswapV3Factory.sol";
import { Constants } from "./Constants.sol";

contract UniswapV3FactoryScript is Constants {

    function run() external returns (UniswapV3Factory factory) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);

        console.log("Owner:     ", ownerAddress);
        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        factory = new UniswapV3Factory{salt: salt}();

        vm.stopBroadcast();
        console.log("UniswapV3Factory: ", address(factory));

        return factory;
    }
}