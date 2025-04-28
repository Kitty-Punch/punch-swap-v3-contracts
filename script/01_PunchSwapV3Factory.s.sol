// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { console } from "forge-std/console.sol";
import { PunchSwapV3Factory } from "../src/core/PunchSwapV3Factory.sol";
import { Constants } from "./Constants.sol";

contract PunchSwapV3FactoryScript is Constants {

    function run() external returns (PunchSwapV3Factory factory) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address newOwner = address(0x0);

        console.log("Owner:     ", ownerAddress);
        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        factory = new PunchSwapV3Factory{salt: salt}(ownerAddress);

        factory.enableFeeAmount(100, 1);

        factory.setOwner(newOwner);

        vm.stopBroadcast();
        console.log("PunchSwapV3Factory: ", address(factory));
        console.log("Final owner: ", factory.owner());

        return factory;
    }
}