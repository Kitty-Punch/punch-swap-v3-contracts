// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import { console } from "forge-std/console.sol";
import { PoolAddress } from "../src/periphery/libraries/PoolAddress.sol";
import { UniswapV3Pool } from "../src/core/UniswapV3Pool.sol";
import { Constants } from "./Constants.sol";

contract UniswapV3PoolInitBytecodeHashScript is Constants {

    function run() external pure returns (bytes32 initCodeHash) {
        // Get the init bytecode hash
        bytes memory initCode = type(UniswapV3Pool).creationCode;
        initCodeHash = keccak256(initCode);
        console.log("UniswapV3Pool init bytecode hash:");
        console.logBytes32(initCodeHash);
        console.log("Check/update constant POOL_INIT_CODE_HASH in src/periphery/libraries/PoolAddress.sol");
        console.log("POOL_INIT_CODE_HASH: ");
        console.logBytes32(PoolAddress.getPoolInitCodeHash());

        require(initCodeHash == PoolAddress.getPoolInitCodeHash(), "UniswapV3Pool init bytecode hash mismatch");
    }
}