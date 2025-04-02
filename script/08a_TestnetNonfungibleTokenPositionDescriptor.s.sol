// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { TestnetNonfungibleTokenPositionDescriptor } from "../src/periphery/TestnetNonfungibleTokenPositionDescriptor.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract TestnetNonfungibleTokenPositionDescriptorScript is Constants   {

    function run() external returns (TestnetNonfungibleTokenPositionDescriptor descriptor) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        bytes32 ETH_NATIVE_CURRENCY_LABEL_BYTES = vm.envBytes32(PARAM_ETH_NATIVE_CURRENCY_LABEL_BYTES);

        console.log("Starting script: broadcasting");
        console.log("Owner:     ", ownerAddress);
        console.log("ETH_NATIVE_CURRENCY_LABEL_BYTES:     ");
        console.logBytes32(ETH_NATIVE_CURRENCY_LABEL_BYTES);
        console.log("Salt:      ");
        console.logBytes32(salt);

        vm.startBroadcast(deployerPrivateKey);

        // constructor(bytes32 _nativeCurrencyLabelBytes) 
        descriptor = new TestnetNonfungibleTokenPositionDescriptor{salt: salt}(ETH_NATIVE_CURRENCY_LABEL_BYTES);

        vm.stopBroadcast();
        console.log("TestnetNonfungibleTokenPositionDescriptor:     ", address(descriptor));
        return descriptor;
    }
}