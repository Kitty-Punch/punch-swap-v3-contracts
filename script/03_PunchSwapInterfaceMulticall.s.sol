// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { PunchSwapInterfaceMulticall } from "../src/periphery/lens/PunchSwapInterfaceMulticall.sol";
import { Constants } from "./Constants.sol";
import { console } from "forge-std/console.sol";

contract PunchSwapInterfaceMulticallScript is Constants {

    function run() public returns (PunchSwapInterfaceMulticall multiCall) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        
        console.log("Owner:     ", ownerAddress);
        console.log("Salt:      ");
        console.logBytes32(salt);
        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        multiCall = new PunchSwapInterfaceMulticall{salt: salt}();

        vm.stopBroadcast();
        console.log("PunchSwapInterfaceMulticall: ", address(multiCall));
        return multiCall;
    }
}