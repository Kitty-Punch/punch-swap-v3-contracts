echo $(date) > local_verify.txt
source .env

NETWORK="testnet"
VERIFIER_URL="https://evm-testnet.flowscan.io/api/"
if [ "$RPC_URL" = "https://mainnet.evm.nodes.onflow.org/" ]; then
    VERIFIER_URL="https://evm.flowscan.io/api/"
    NETWORK="mainnet"
fi

echo 'NETWORK: '$NETWORK
echo 'RPC_URL: '$RPC_URL
echo 'VERIFIER_URL: '$VERIFIER_URL
echo 'OWNER: '$OWNER
echo 'WETH9: '$WETH9
echo 'V2_FACTORY: '$V2_FACTORY
echo 'ETH_NATIVE_CURRENCY_LABEL_BYTES: '$ETH_NATIVE_CURRENCY_LABEL_BYTES
echo 'V3_POOL_DEPLOYER: '$V3_POOL_DEPLOYER
echo 'PUNCH_SWAP_INTERFACE_MULTICALL: '$PUNCH_SWAP_INTERFACE_MULTICALL
echo 'TICK_LENS: '$TICK_LENS
echo 'QUOTER: '$QUOTER
echo 'PUNCH_SWAP_V3_STATIC_QUOTER: '$PUNCH_SWAP_V3_STATIC_QUOTER
echo 'SWAP_ROUTER: '$SWAP_ROUTER
echo 'QUOTER_V2: '$QUOTER_V2
echo 'TOKEN_DESCRIPTOR: '$TOKEN_DESCRIPTOR
echo 'POSITION_MANAGER: '$POSITION_MANAGER
echo 'V3_MIGRATOR: '$V3_MIGRATOR
echo 'SWAP_ROUTER_02: '$SWAP_ROUTER_02
echo 'V3_FACTORY: '$V3_FACTORY
echo 'MAX_INCENTIVE_START_LEAD_TIME: '$MAX_INCENTIVE_START_LEAD_TIME
echo 'MAX_INCENTIVE_DURATION: '$MAX_INCENTIVE_DURATION
echo 'FEE_OWNER: '$FEE_OWNER
echo 'UNIVERSAL_ROUTER: '$UNIVERSAL_ROUTER
echo 'PERMIT2: '$PERMIT2
echo 'UNSUPPORTED_PROTOCOL: '$UNSUPPORTED_PROTOCOL
echo 'FEE_TOKEN: '$FEE_TOKEN
echo 'UNIVERSAL_ROUTER_JSON_FILE: '$UNIVERSAL_ROUTER_JSON_FILE

export NETWORK=$NETWORK
export RPC_URL=$RPC_URL
export VERIFIER_URL=$VERIFIER_URL
export OWNER=$OWNER
export SALT=$SALT
export WETH9=$WETH9
export V2_FACTORY=$V2_FACTORY
export ETH_NATIVE_CURRENCY_LABEL_BYTES=$ETH_NATIVE_CURRENCY_LABEL_BYTES
export V3_POOL_DEPLOYER=$V3_POOL_DEPLOYER
export PUNCH_SWAP_INTERFACE_MULTICALL=$PUNCH_SWAP_INTERFACE_MULTICALL
export TICK_LENS=$TICK_LENS
export QUOTER=$QUOTER
export PUNCH_SWAP_V3_STATIC_QUOTER=$PUNCH_SWAP_V3_STATIC_QUOTER
export SWAP_ROUTER=$SWAP_ROUTER
export QUOTER_V2=$QUOTER_V2
export TOKEN_DESCRIPTOR=$TOKEN_DESCRIPTOR
export POSITION_MANAGER=$POSITION_MANAGER
export V3_MIGRATOR=$V3_MIGRATOR
export SWAP_ROUTER_02=$SWAP_ROUTER_02
export V3_FACTORY=$V3_FACTORY
export MAX_INCENTIVE_START_LEAD_TIME=$MAX_INCENTIVE_START_LEAD_TIME
export MAX_INCENTIVE_DURATION=$MAX_INCENTIVE_DURATION
export FEE_OWNER=$FEE_OWNER
export UNIVERSAL_ROUTER=$UNIVERSAL_ROUTER
export PERMIT2=$PERMIT2
export UNSUPPORTED_PROTOCOL=$UNSUPPORTED_PROTOCOL
export FEE_TOKEN=$FEE_TOKEN

#01
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $V3_FACTORY ./src/core/PunchSwapV3Factory.sol:PunchSwapV3Factory

#02
# NO forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $V3_POOL_DEPLOYER ./src/core/PunchSwapV3PoolDeployer.sol:PunchSwapV3PoolDeployer

#03
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $PUNCH_SWAP_INTERFACE_MULTICALL ./src/periphery/lens/PunchSwapInterfaceMulticall.sol:PunchSwapInterfaceMulticall

#04
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $TICK_LENS ./src/periphery/lens/TickLens.sol:TickLens

#05
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $QUOTER ./src/periphery/lens/Quoter.sol:Quoter --constructor-args $(cast abi-encode "constructor(address _factory, address _WETH9)" $V3_FACTORY $WETH9)

#05a
# NO forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $PUNCH_SWAP_V3_STATIC_QUOTER ./src/periphery/lens/PunchSwapV3StaticQuoter.sol:PunchSwapV3StaticQuoter --constructor-args $(cast abi-encode "constructor(address _factory)" $V3_FACTORY)

#06
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $SWAP_ROUTER ./src/periphery/SwapRouter.sol:SwapRouter --constructor-args $(cast abi-encode "constructor(address _factory, address _WETH9)" $V3_FACTORY $WETH9)

#07
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $QUOTER_V2 ./src/periphery/lens/QuoterV2.sol:QuoterV2 --constructor-args $(cast abi-encode "constructor(address _factory, address _WETH9)" $V3_FACTORY $WETH9)

#08
if [ "$NETWORK" = "mainnet" ]; then
    forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $TOKEN_DESCRIPTOR ./src/periphery/NonfungibleTokenPositionDescriptor.sol:NonfungibleTokenPositionDescriptor --constructor-args $(cast abi-encode "constructor(bytes32 _nativeCurrencyLabelBytes)" $ETH_NATIVE_CURRENCY_LABEL_BYTES)
else
    forge verify-contract --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $TOKEN_DESCRIPTOR ./src/periphery/TestnetNonfungibleTokenPositionDescriptor.sol:TestnetNonfungibleTokenPositionDescriptor --constructor-args $(cast abi-encode "constructor(bytes32 _nativeCurrencyLabelBytes)" $ETH_NATIVE_CURRENCY_LABEL_BYTES)
fi

#09
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $POSITION_MANAGER ./src/periphery/NonfungiblePositionManager.sol:NonfungiblePositionManager --constructor-args $(cast abi-encode "constructor(address _factory, address _WETH9, address _tokenDescriptor)" $V3_FACTORY $WETH9 $TOKEN_DESCRIPTOR)

#10
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $V3_MIGRATOR ./src/periphery/V3Migrator.sol:V3Migrator --constructor-args $(cast abi-encode "constructor(address _factory, address _WETH9, address _nonfungiblePositionManager)" $V3_FACTORY $WETH9 $POSITION_MANAGER)

#11
forge verify-contract --compiler-version 0.7.6 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $SWAP_ROUTER_02 ./src/swap-router/SwapRouter02.sol:SwapRouter02 --constructor-args $(cast abi-encode "constructor(address _factoryV2, address factoryV3, address _positionManager, address _WETH9)" $V2_FACTORY $V3_FACTORY $POSITION_MANAGER $WETH9)

#12
forge verify-contract --compiler-version 0.8.17 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $PERMIT2 ./src/permit2/Permit2.sol:Permit2

#13
forge verify-contract --compiler-version 0.8.17 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $UNSUPPORTED_PROTOCOL ./src/universal-router/deploy/UnsupportedProtocol.sol:UnsupportedProtocol

forge verify-contract --compiler-version 0.8.17 --rpc-url $RPC_URL --verifier blockscout --verifier-url "$VERIFIER_URL" $UNIVERSAL_ROUTER ./src/periphery/UniversalRouter.sol:UniversalRouter --constructor-args $(cast abi-encode "constructor(address _factory, address _WETH9)" $V3_FACTORY $WETH9)