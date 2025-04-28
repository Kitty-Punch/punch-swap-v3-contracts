// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { PunchSwapV3PoolDeployer } from "../src/core/PunchSwapV3PoolDeployer.sol";
import { Constants } from "./Constants.sol";
import { console } from "forge-std/console.sol";

contract PunchSwapV3PoolDeployerScript is Constants {

    function run() external returns (PunchSwapV3PoolDeployer deployed) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);

        console.log("Owner:     ", ownerAddress);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);
        deployed = new PunchSwapV3PoolDeployer();
        vm.stopBroadcast();

        console.log("PunchSwapV3PoolDeployer: ", address(deployed));

        return deployed;
    }
}