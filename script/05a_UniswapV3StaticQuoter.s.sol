// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { UniswapV3StaticQuoter } from "../src/periphery/lens/UniswapV3StaticQuoter.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract UniswapV3StaticQuoterScript is Constants {

    function run() external returns (UniswapV3StaticQuoter quoter) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address V3FACTORY = vm.envAddress(PARAM_V3_FACTORY);

        console.log("Starting script: broadcasting");
        console.log("Owner:     ", ownerAddress);
        console.log("V3FACTORY: ", V3FACTORY);
        console.log("Salt:      ");
        console.logBytes32(salt);

        vm.startBroadcast(deployerPrivateKey);

        // constructor(address _factory)
        quoter = new UniswapV3StaticQuoter{salt: salt}(V3FACTORY);

        vm.stopBroadcast();
        console.log("UniswapV3StaticQuoter:    ", address(quoter));
        return quoter;
    }
}