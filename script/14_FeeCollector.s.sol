// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/console.sol";
import {FeeCollector} from "../src/fee-collector/FeeCollector.sol";
import {Constants} from "./Constants.sol";

contract FeeCollectorScript is Constants {
    function run() public returns (FeeCollector fee) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address feeOwner = vm.envAddress(PARAM_FEE_OWNER);
        address universalRouter = vm.envAddress(PARAM_UNIVERSAL_ROUTER);
        address permit2 = vm.envAddress(PARAM_PERMIT2);
        address feeToken = vm.envAddress(PARAM_FEE_TOKEN);

        console.log("Owner address:     ", ownerAddress);
        console.log("Fee owner:         ", feeOwner);
        console.log("Universal router:  ", universalRouter);
        console.log("Permit2:           ", permit2);
        console.log("Fee token:         ", feeToken);
        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);
        fee = new FeeCollector{salt: salt}(feeOwner, universalRouter, permit2, feeToken);

        vm.stopBroadcast();
        console.log("FeeCollector:  ", address(fee));
        return fee;
    }
}
