// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { TickLens } from "../src/periphery/lens/TickLens.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract TickLensScript is Constants {

    function run() external returns (TickLens ticks) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        
        console.log("Owner:     ", ownerAddress);
        console.log("Salt:      ");
        console.logBytes32(salt);

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        ticks = new TickLens{salt: salt}();

        vm.stopBroadcast();
        console.log("TickLens:  ", address(ticks));
        return ticks;
    }
}