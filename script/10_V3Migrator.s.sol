// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { V3Migrator } from "../src/periphery/V3Migrator.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract V3MigratorScript is Constants {

    function setUp() public {}

    function run() external returns (V3Migrator migrator) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address WETH9 = vm.envAddress(PARAM_WETH9);
        address V3FACTORY = vm.envAddress(PARAM_V3_FACTORY);
        address POSITION_MANAGER = vm.envAddress(PARAM_POSITION_MANAGER);
        
        console.log("Starting script: broadcasting");
        console.log("Owner:     ", ownerAddress);
        console.log("WETH9:     ", WETH9);
        console.log("Factory:   ", V3FACTORY);
        console.log("Position Manager:     ", POSITION_MANAGER);
        console.log("Salt:      ");
        console.logBytes32(salt);

        vm.startBroadcast(deployerPrivateKey);

        // constructor(address _factory, address _WETH9, address _positionManager )
        migrator = new V3Migrator{salt: salt}(V3FACTORY, WETH9, POSITION_MANAGER );

        vm.stopBroadcast();
        console.log("V3Migrator:     ", address(migrator));
        return migrator;
    }
}