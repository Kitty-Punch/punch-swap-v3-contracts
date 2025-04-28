// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.0;

import '../../core/interfaces/IPunchSwapV3Pool.sol';
import '../libraries/PoolTicksCounter.sol';

contract PoolTicksCounterTest {
    using PoolTicksCounter for IPunchSwapV3Pool;

    function countInitializedTicksCrossed(
        IPunchSwapV3Pool pool,
        int24 tickBefore,
        int24 tickAfter
    ) external view returns (uint32 initializedTicksCrossed) {
        return pool.countInitializedTicksCrossed(tickBefore, tickAfter);
    }
}
