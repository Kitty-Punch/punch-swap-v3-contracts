// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import '../core/interfaces/IUniswapV3Pool.sol';
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
contract TestnetNonfungibleTokenPositionDescriptor is NonfungibleTokenPositionDescriptorBase {

    uint256 private constant CHAIN_ID = 545;
    address private constant WFLOW_ADDRESS = address(0xd3bF53DAC106A0290B0483EcBC89d40FcC961f3e);
    address private constant USDF = address(0xd7d43ab7b365f0d0789aE83F4385fA710FfdC98F);
    address private constant USDC_E = address(0x309222b7833D3D0A59A8eBf9C64A5790bf43E2aA);
    address private constant CBTC = address(0x208d09d2a6Dd176e3e95b3F0DE172A7471C5B2d6);

    constructor(bytes32 _nativeCurrencyLabelBytes) NonfungibleTokenPositionDescriptorBase(WFLOW_ADDRESS, _nativeCurrencyLabelBytes) {}

    function _initializePriorities() override internal {
        priorities[CHAIN_ID][USDF] = TokenRatioSortOrder.NUMERATOR_MOST;
        priorities[CHAIN_ID][USDC_E] = TokenRatioSortOrder.NUMERATOR;
        priorities[CHAIN_ID][CBTC] = TokenRatioSortOrder.DENOMINATOR_MORE;
    }
}
