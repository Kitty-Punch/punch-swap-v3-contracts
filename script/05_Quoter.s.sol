// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { Quoter } from "../src/periphery/lens/Quoter.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract QuoterScript is Constants {

    function run() external returns (Quoter quoter) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address WETH9 = vm.envAddress(PARAM_WETH9);
        address V3FACTORY = vm.envAddress(PARAM_V3_FACTORY);

        console.log("Starting script: broadcasting");
        console.log("Owner:     ", ownerAddress);
        console.log("WETH9:     ", WETH9);
        console.log("V3FACTORY: ", V3FACTORY);
        console.log("Salt:      ");
        console.logBytes32(salt);

        vm.startBroadcast(deployerPrivateKey);

        // constructor(address _factory, address _WETH9)
        quoter = new Quoter{salt: salt}(V3FACTORY, WETH9);

        vm.stopBroadcast();
        console.log("Quoter:    ", address(quoter));
        return quoter;
    }
}