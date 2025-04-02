// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { UniswapV3PoolDeployer } from "../src/core/UniswapV3PoolDeployer.sol";
import { Constants } from "./Constants.sol";
import { console } from "forge-std/console.sol";

contract UniswapV3PoolDeployerScript is Constants {

    function run() external returns (UniswapV3PoolDeployer deployed) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);

        console.log("Owner:     ", ownerAddress);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);
        deployed = new UniswapV3PoolDeployer();
        vm.stopBroadcast();

        console.log("UniswapV3PoolDeployer: ", address(deployed));

        return deployed;
    }
}