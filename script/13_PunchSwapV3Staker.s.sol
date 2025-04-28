// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import {console} from "forge-std/console.sol";
import {PunchSwapV3Staker} from "../src/staker/PunchSwapV3Staker.sol";
import {IPunchSwapV3Factory} from "../src/core/interfaces/IPunchSwapV3Factory.sol";
import {INonfungiblePositionManager} from "../src/periphery/interfaces/INonfungiblePositionManager.sol";
import {Constants} from "./Constants.sol";

contract PunchSwapV3StakerScript is Constants {
    function run() public returns (PunchSwapV3Staker punchSwapV3Staker) {
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

        punchSwapV3Staker = new PunchSwapV3Staker{salt: salt}(
            IPunchSwapV3Factory(factoryV3),
            INonfungiblePositionManager(positionManager),
            maxIncentiveStartLeadTime,
            maxIncentiveDuration
        );
        vm.stopBroadcast();

        console.log("PunchSwapV3Staker:   ", address(punchSwapV3Staker));
        return punchSwapV3Staker;
    }
}
