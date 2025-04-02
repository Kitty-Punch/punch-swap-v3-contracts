// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6;

import "forge-std/Script.sol";

abstract contract Constants is Script {
    string public constant PARAM_OWNER = "OWNER";
    string public constant PARAM_PK_ACCOUNT = "PK_ACCOUNT";
    string public constant PARAM_SALT = "SALT";
    string public constant PARAM_WETH9 = "WETH9";
    string public constant PARAM_V3_FACTORY = "V3_FACTORY";
    string public constant PARAM_V2_FACTORY = "V2_FACTORY";
    string public constant PARAM_TOKEN_DESCRIPTOR = "TOKEN_DESCRIPTOR";
    string public constant PARAM_POSITION_MANAGER = "POSITION_MANAGER";
    string public constant PARAM_ETH_NATIVE_CURRENCY_LABEL_BYTES = "ETH_NATIVE_CURRENCY_LABEL_BYTES";
    string public constant PARAM_MAX_INCENTIVE_START_LEAD_TIME = "MAX_INCENTIVE_START_LEAD_TIME";
    string public constant PARAM_MAX_INCENTIVE_DURATION = "MAX_INCENTIVE_DURATION";
    string public constant PARAM_FEE_OWNER = "FEE_OWNER";
    string public constant PARAM_UNIVERSAL_ROUTER = "UNIVERSAL_ROUTER";
    string public constant PARAM_PERMIT2 = "PERMIT2";
    string public constant PARAM_FEE_TOKEN = "FEE_TOKEN";
}
