// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { NonfungibleTokenPositionDescriptor } from "../src/periphery/NonfungibleTokenPositionDescriptor.sol";
import { Constants } from "./Constants.sol";
import "forge-std/console.sol";

contract NonfungibleTokenPositionDescriptorScript is Constants   {

    function run() external returns (NonfungibleTokenPositionDescriptor descriptor) {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address WETH9 = vm.envAddress(PARAM_WETH9);
        bytes32 ETH_NATIVE_CURRENCY_LABEL_BYTES = vm.envBytes32(PARAM_ETH_NATIVE_CURRENCY_LABEL_BYTES);

        console.log("Starting script: broadcasting");
        console.log("Owner:     ", ownerAddress);
        console.log("WETH9:     ", WETH9);
        console.log("ETH_NATIVE_CURRENCY_LABEL_BYTES:     ");
        console.logBytes32(ETH_NATIVE_CURRENCY_LABEL_BYTES);
        console.log("Salt:      ");
        console.logBytes32(salt);

        vm.startBroadcast(deployerPrivateKey);

        // constructor(address _WETH9, bytes32 _nativeCurrencyLabelBytes) 
        descriptor = new NonfungibleTokenPositionDescriptor{salt: salt}(WETH9, ETH_NATIVE_CURRENCY_LABEL_BYTES);

        vm.stopBroadcast();
        console.log("NonfungibleTokenPositionDescriptor:     ", address(descriptor));
        return descriptor;
    }
}