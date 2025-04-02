// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import {console} from "forge-std/console.sol";
import {UniswapV3Staker} from "../src/staker/UniswapV3Staker.sol";
import {IUniswapV3Factory} from "../src/core/interfaces/IUniswapV3Factory.sol";
import {INonfungiblePositionManager} from "../src/periphery/interfaces/INonfungiblePositionManager.sol";
import {Constants} from "./Constants.sol";

contract UniswapV3StakerScript is Constants {
    function run() public returns (UniswapV3Staker uniswapV3Staker) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address factoryV3 = vm.envAddress(PARAM_V3_FACTORY);
        address positionManager = vm.envAddress(PARAM_POSITION_MANAGER);
        uint256 maxIncentiveStartLeadTime = vm.envUint(PARAM_MAX_INCENTIVE_START_LEAD_TIME);
        uint256 maxIncentiveDuration = vm.envUint(PARAM_MAX_INCENTIVE_DURATION);

        console.log("Salt:");
        console.logBytes32(salt);
        console.log("Owner:                         ", ownerAddress);
        console.log("Factory:                       ", factoryV3);
        console.log("Position Manager:              ", positionManager);
        console.log("Max incentive start lead time: ", maxIncentiveStartLeadTime);
        console.log("Max incentive duration:        ", maxIncentiveDuration);
        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        uniswapV3Staker = new UniswapV3Staker{salt: salt}(
            IUniswapV3Factory(factoryV3),
            INonfungiblePositionManager(positionManager),
            maxIncentiveStartLeadTime,
            maxIncentiveDuration
        );
        vm.stopBroadcast();

        console.log("UniswapV3Staker:   ", address(uniswapV3Staker));
        return uniswapV3Staker;
    }
}
