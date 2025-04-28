// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { console } from "forge-std/console.sol";
import { PunchSwapV3Factory } from "../src/core/PunchSwapV3Factory.sol";
import { Constants } from "./Constants.sol";


contract PunchSwapV3FactoryEnableFeeAmountScript is Constants {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address deployer = vm.addr(deployerPrivateKey);
        PunchSwapV3Factory factory = PunchSwapV3Factory(address(0x0));
        uint24 fee = 100;
        int24 tickSpacing = 1;

        console.log("Factory: ", address(factory));
        console.log("Fee: ", uint256(fee));
        console.log("TickSpacing: ", uint256(tickSpacing));
        console.log("Owner:     ", factory.owner());
        console.log("Deployer:  ", deployer);
        console.log("Current Fee Amount: ", factory.feeAmountTickSpacing(fee));

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        factory.enableFeeAmount(fee, tickSpacing);

        vm.stopBroadcast();
        console.log("PunchSwapV3Factory: ", address(factory));
    }
}