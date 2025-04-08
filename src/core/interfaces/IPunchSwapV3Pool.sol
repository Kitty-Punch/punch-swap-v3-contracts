// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import './pool/IPunchSwapV3PoolImmutables.sol';
import './pool/IPunchSwapV3PoolState.sol';
import './pool/IPunchSwapV3PoolDerivedState.sol';
import './pool/IPunchSwapV3PoolActions.sol';
import './pool/IPunchSwapV3PoolOwnerActions.sol';
import './pool/IPunchSwapV3PoolEvents.sol';

/// @title The interface for a PunchSwap V3 Pool
/// @notice A PunchSwap pool facilitates swapping and automated market making between any two assets that strictly conform
/// to the ERC20 specification
/// @dev The pool interface is broken up into many smaller pieces
interface IPunchSwapV3Pool is
    IPunchSwapV3PoolImmutables,
    IPunchSwapV3PoolState,
    IPunchSwapV3PoolDerivedState,
    IPunchSwapV3PoolActions,
    IPunchSwapV3PoolOwnerActions,
    IPunchSwapV3PoolEvents
{

}
