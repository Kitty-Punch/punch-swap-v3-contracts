// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import '../core/interfaces/IPunchSwapV3Pool.sol';
import '@uniswap/lib/contracts/libraries/SafeERC20Namer.sol';

import './libraries/ChainId.sol';
import './interfaces/INonfungiblePositionManager.sol';
import './interfaces/INonfungibleTokenPositionDescriptor.sol';
import './interfaces/IERC20Metadata.sol';
import './libraries/PoolAddress.sol';
import './libraries/NFTDescriptor.sol';
import './libraries/TokenRatioSortOrder.sol';
import './NonfungibleTokenPositionDescriptorBase.sol';

/// @title Describes NFT token positions
/// @notice Produces a string containing the data URI for a JSON metadata string
contract NonfungibleTokenPositionDescriptor is NonfungibleTokenPositionDescriptorBase {

    uint256 private constant CHAIN_ID = 747;

    address private constant WFLOW_ADDRESS = address(0xd3bF53DAC106A0290B0483EcBC89d40FcC961f3e);

    address private constant USDF = address(0x2aaBea2058b5aC2D339b163C6Ab6f2b6d53aabED);
    address private constant STG_USDC = address(0xF1815bd50389c46847f0Bda824eC8da914045D14);
    address private constant USDC_E = address(0x7f27352D5F83Db87a5A3E00f4B07Cc2138D8ee52);
    address private constant CBTC = address(0xA0197b2044D28b08Be34d98b23c9312158Ea9A18);

    constructor(bytes32 _nativeCurrencyLabelBytes) NonfungibleTokenPositionDescriptorBase(WFLOW_ADDRESS, _nativeCurrencyLabelBytes) {}

    function _initializePriorities() override internal {
        priorities[CHAIN_ID][USDF] = TokenRatioSortOrder.NUMERATOR_MOST;
        priorities[CHAIN_ID][STG_USDC] = TokenRatioSortOrder.NUMERATOR_MORE;
        priorities[CHAIN_ID][USDC_E] = TokenRatioSortOrder.NUMERATOR;
        priorities[CHAIN_ID][CBTC] = TokenRatioSortOrder.DENOMINATOR_MORE;
    }
}
