// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}


/**
 * @dev Interface of the ERC-165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[ERC].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


/**
 * @title IERC1363
 * @dev Interface of the ERC-1363 standard as defined in the https://eips.ethereum.org/EIPS/eip-1363[ERC-1363].
 *
 * Defines an extension interface for ERC-20 tokens that supports executing code on a recipient contract
 * after `transfer` or `transferFrom`, or code on a spender contract after `approve`, in a single transaction.
 */
interface IERC1363 is IERC20, IERC165 {
    /*
     * Note: the ERC-165 identifier for this interface is 0xb0202a11.
     * 0xb0202a11 ===
     *   bytes4(keccak256('transferAndCall(address,uint256)')) ^
     *   bytes4(keccak256('transferAndCall(address,uint256,bytes)')) ^
     *   bytes4(keccak256('transferFromAndCall(address,address,uint256)')) ^
     *   bytes4(keccak256('transferFromAndCall(address,address,uint256,bytes)')) ^
     *   bytes4(keccak256('approveAndCall(address,uint256)')) ^
     *   bytes4(keccak256('approveAndCall(address,uint256,bytes)'))
     */

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`
     * and then calls {IERC1363Receiver-onTransferReceived} on `to`.
     * @param to The address which you want to transfer to.
     * @param value The amount of tokens to be transferred.
     * @return A boolean value indicating whether the operation succeeded unless throwing.
     */
    function transferAndCall(address to, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`
     * and then calls {IERC1363Receiver-onTransferReceived} on `to`.
     * @param to The address which you want to transfer to.
     * @param value The amount of tokens to be transferred.
     * @param data Additional data with no specified format, sent in call to `to`.
     * @return A boolean value indicating whether the operation succeeded unless throwing.
     */
    function transferAndCall(address to, uint256 value, bytes calldata data) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the allowance mechanism
     * and then calls {IERC1363Receiver-onTransferReceived} on `to`.
     * @param from The address which you want to send tokens from.
     * @param to The address which you want to transfer to.
     * @param value The amount of tokens to be transferred.
     * @return A boolean value indicating whether the operation succeeded unless throwing.
     */
    function transferFromAndCall(address from, address to, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the allowance mechanism
     * and then calls {IERC1363Receiver-onTransferReceived} on `to`.
     * @param from The address which you want to send tokens from.
     * @param to The address which you want to transfer to.
     * @param value The amount of tokens to be transferred.
     * @param data Additional data with no specified format, sent in call to `to`.
     * @return A boolean value indicating whether the operation succeeded unless throwing.
     */
    function transferFromAndCall(address from, address to, uint256 value, bytes calldata data) external returns (bool);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens and then calls {IERC1363Spender-onApprovalReceived} on `spender`.
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to be spent.
     * @return A boolean value indicating whether the operation succeeded unless throwing.
     */
    function approveAndCall(address spender, uint256 value) external returns (bool);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens and then calls {IERC1363Spender-onApprovalReceived} on `spender`.
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to be spent.
     * @param data Additional data with no specified format, sent in call to `spender`.
     * @return A boolean value indicating whether the operation succeeded unless throwing.
     */
    function approveAndCall(address spender, uint256 value, bytes calldata data) external returns (bool);
}


/**
 * @title SafeERC20
 * @dev Wrappers around ERC-20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    /**
     * @dev An operation with an ERC-20 token failed.
     */
    error SafeERC20FailedOperation(address token);

    /**
     * @dev Indicates a failed `decreaseAllowance` request.
     */
    error SafeERC20FailedDecreaseAllowance(address spender, uint256 currentAllowance, uint256 requestedDecrease);

    /**
     * @dev Transfer `value` amount of `token` from the calling contract to `to`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeCall(token.transfer, (to, value)));
    }

    /**
     * @dev Transfer `value` amount of `token` from `from` to `to`, spending the approval given by `from` to the
     * calling contract. If `token` returns no value, non-reverting calls are assumed to be successful.
     */
    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeCall(token.transferFrom, (from, to, value)));
    }

    /**
     * @dev Variant of {safeTransfer} that returns a bool instead of reverting if the operation is not successful.
     */
    function trySafeTransfer(IERC20 token, address to, uint256 value) internal returns (bool) {
        return _callOptionalReturnBool(token, abi.encodeCall(token.transfer, (to, value)));
    }

    /**
     * @dev Variant of {safeTransferFrom} that returns a bool instead of reverting if the operation is not successful.
     */
    function trySafeTransferFrom(IERC20 token, address from, address to, uint256 value) internal returns (bool) {
        return _callOptionalReturnBool(token, abi.encodeCall(token.transferFrom, (from, to, value)));
    }

    /**
     * @dev Increase the calling contract's allowance toward `spender` by `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     *
     * IMPORTANT: If the token implements ERC-7674 (ERC-20 with temporary allowance), and if the "client"
     * smart contract uses ERC-7674 to set temporary allowances, then the "client" smart contract should avoid using
     * this function. Performing a {safeIncreaseAllowance} or {safeDecreaseAllowance} operation on a token contract
     * that has a non-zero temporary allowance (for that particular owner-spender) will result in unexpected behavior.
     */
    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 oldAllowance = token.allowance(address(this), spender);
        forceApprove(token, spender, oldAllowance + value);
    }

    /**
     * @dev Decrease the calling contract's allowance toward `spender` by `requestedDecrease`. If `token` returns no
     * value, non-reverting calls are assumed to be successful.
     *
     * IMPORTANT: If the token implements ERC-7674 (ERC-20 with temporary allowance), and if the "client"
     * smart contract uses ERC-7674 to set temporary allowances, then the "client" smart contract should avoid using
     * this function. Performing a {safeIncreaseAllowance} or {safeDecreaseAllowance} operation on a token contract
     * that has a non-zero temporary allowance (for that particular owner-spender) will result in unexpected behavior.
     */
    function safeDecreaseAllowance(IERC20 token, address spender, uint256 requestedDecrease) internal {
        unchecked {
            uint256 currentAllowance = token.allowance(address(this), spender);
            if (currentAllowance < requestedDecrease) {
                revert SafeERC20FailedDecreaseAllowance(spender, currentAllowance, requestedDecrease);
            }
            forceApprove(token, spender, currentAllowance - requestedDecrease);
        }
    }

    /**
     * @dev Set the calling contract's allowance toward `spender` to `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful. Meant to be used with tokens that require the approval
     * to be set to zero before setting it to a non-zero value, such as USDT.
     *
     * NOTE: If the token implements ERC-7674, this function will not modify any temporary allowance. This function
     * only sets the "standard" allowance. Any temporary allowance will remain active, in addition to the value being
     * set here.
     */
    function forceApprove(IERC20 token, address spender, uint256 value) internal {
        bytes memory approvalCall = abi.encodeCall(token.approve, (spender, value));

        if (!_callOptionalReturnBool(token, approvalCall)) {
            _callOptionalReturn(token, abi.encodeCall(token.approve, (spender, 0)));
            _callOptionalReturn(token, approvalCall);
        }
    }

    /**
     * @dev Performs an {ERC1363} transferAndCall, with a fallback to the simple {ERC20} transfer if the target has no
     * code. This can be used to implement an {ERC721}-like safe transfer that rely on {ERC1363} checks when
     * targeting contracts.
     *
     * Reverts if the returned value is other than `true`.
     */
    function transferAndCallRelaxed(IERC1363 token, address to, uint256 value, bytes memory data) internal {
        if (to.code.length == 0) {
            safeTransfer(token, to, value);
        } else if (!token.transferAndCall(to, value, data)) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    /**
     * @dev Performs an {ERC1363} transferFromAndCall, with a fallback to the simple {ERC20} transferFrom if the target
     * has no code. This can be used to implement an {ERC721}-like safe transfer that rely on {ERC1363} checks when
     * targeting contracts.
     *
     * Reverts if the returned value is other than `true`.
     */
    function transferFromAndCallRelaxed(
        IERC1363 token,
        address from,
        address to,
        uint256 value,
        bytes memory data
    ) internal {
        if (to.code.length == 0) {
            safeTransferFrom(token, from, to, value);
        } else if (!token.transferFromAndCall(from, to, value, data)) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    /**
     * @dev Performs an {ERC1363} approveAndCall, with a fallback to the simple {ERC20} approve if the target has no
     * code. This can be used to implement an {ERC721}-like safe transfer that rely on {ERC1363} checks when
     * targeting contracts.
     *
     * NOTE: When the recipient address (`to`) has no code (i.e. is an EOA), this function behaves as {forceApprove}.
     * Opposedly, when the recipient address (`to`) has code, this function only attempts to call {ERC1363-approveAndCall}
     * once without retrying, and relies on the returned value to be true.
     *
     * Reverts if the returned value is other than `true`.
     */
    function approveAndCallRelaxed(IERC1363 token, address to, uint256 value, bytes memory data) internal {
        if (to.code.length == 0) {
            forceApprove(token, to, value);
        } else if (!token.approveAndCall(to, value, data)) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     *
     * This is a variant of {_callOptionalReturnBool} that reverts if call fails to meet the requirements.
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        uint256 returnSize;
        uint256 returnValue;
        assembly ("memory-safe") {
            let success := call(gas(), token, 0, add(data, 0x20), mload(data), 0, 0x20)
            // bubble errors
            if iszero(success) {
                let ptr := mload(0x40)
                returndatacopy(ptr, 0, returndatasize())
                revert(ptr, returndatasize())
            }
            returnSize := returndatasize()
            returnValue := mload(0)
        }

        if (returnSize == 0 ? address(token).code.length == 0 : returnValue != 1) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     *
     * This is a variant of {_callOptionalReturn} that silently catches all reverts and returns a bool instead.
     */
    function _callOptionalReturnBool(IERC20 token, bytes memory data) private returns (bool) {
        bool success;
        uint256 returnSize;
        uint256 returnValue;
        assembly ("memory-safe") {
            success := call(gas(), token, 0, add(data, 0x20), mload(data), 0, 0x20)
            returnSize := returndatasize()
            returnValue := mload(0)
        }
        return success && (returnSize == 0 ? address(token).code.length > 0 : returnValue == 1);
    }
}

/**
 * @title SimpleSwap
 * @dev Basic DEX mimicking Uniswap core: add/remove liquidity, swap tokens, query prices.
 * This contract manages token reserves.
 */
contract SimpleSwap {
    using SafeERC20 for IERC20; // Enables safer ERC20 token interactions.

    address public owner; // Contract deployer.

    /**
     * @dev Stores current reserves for a token pair (token0 < token1).
     */
    struct Reserve {
        uint256 reserve0; // Amount of token0 in pool.
        uint256 reserve1; // Amount of token1 in pool.
    }

    // Pool state storage
    mapping(address => mapping(address => Reserve)) public reserves;
    mapping(address => mapping(address => uint256)) public totalLiquidity;
    mapping(address => mapping(address => mapping(address => uint256))) public userLiquidity;

    // --- Events ---

    /**
     * @dev Emitted when liquidity is added.
     * @param provider The address of the user who added liquidity.
     * @param tokenA The address of the first token in the pair.
     * @param tokenB The address of the second token in the pair.
     * @param amountA The actual amount of tokenA added to the pool.
     * @param amountB The actual amount of tokenB added to the pool.
     * @param liquidityMinted The amount of liquidity shares minted to the provider.
     */
    event LiquidityAdded(
        address indexed provider,
        address indexed tokenA,
        address indexed tokenB,
        uint amountA,
        uint amountB,
        uint liquidityMinted
    );

    /**
     * @dev Emitted when liquidity is removed.
     * @param provider The address of the user who removed liquidity.
     * @param tokenA The address of the first token in the pair.
     * @param tokenB The address of the second token in the pair.
     * @param amountA The amount of tokenA returned to the provider.
     * @param amountB The amount of tokenB returned to the provider.
     * @param liquidityBurned The amount of liquidity shares burned by the provider.
     */
    event LiquidityRemoved(
        address indexed provider,
        address indexed tokenA,
        address indexed tokenB,
        uint amountA,
        uint amountB,
        uint liquidityBurned
    );

    /**
     * @dev Emitted when a swap occurs.
     * @param sender The address of the user who initiated the swap.
     * @param tokenIn The address of the token sent into the swap.
     * @param tokenOut The address of the token received from the swap.
     * @param amountIn The actual amount of tokenIn transferred from the sender.
     * @param amountOut The actual amount of tokenOut transferred to the recipient.
     */
    event Swapped(
        address indexed sender,
        address indexed tokenIn,
        address indexed tokenOut,
        uint amountIn,
        uint amountOut
    );

    // --- Modifiers ---

    /**
     * @dev Ensures transaction is executed before `deadline`.
     * @param deadline The timestamp after which the transaction should revert.
     */
    modifier ensure(uint deadline) {
        require(block.timestamp <= deadline, "Transaction expired");
        _;
    }

    // --- Constructor ---

    /**
     * @dev Sets `msg.sender` as `owner` on deployment.
     */
    constructor() {
        owner = msg.sender;
    }

    // --- Internal Utility Functions ---

    /**
     * @dev Sorts two token addresses canonically (token0 < token1).
     * Reverts if tokens are identical.
     * @param tokenA The address of the first token.
     * @param tokenB The address of the second token.
     * @return token0 The numerically smaller token address.
     * @return token1 The numerically larger token address.
     */
    function _sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, "Identical tokens");
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
    }

    // --- Structs for stack management ---

    /**
     * @dev Helper struct to bundle data for addLiquidity to optimize stack depth.
     */
    struct AddLiquidityData {
        address token0;   // Numerically smaller token address.
        address token1;   // Numerically larger token address.
        uint reserve0;    // Current reserve of token0.
        uint reserve1;    // Current reserve of token1.
        uint totalLiq;    // Current total liquidity for the pair.
    }

    /**
     * @dev Helper struct to bundle data for removeLiquidity to optimize stack depth.
     */
    struct RemovalData {
        address token0;   // Numerically smaller token address.
        address token1;   // Numerically larger token address.
        uint reserve0;    // Current reserve of token0.
        uint reserve1;    // Current reserve of token1.
        uint totalLiq;    // Current total liquidity for the pair.
        uint userLiq;     // User's current liquidity for the pair.
    }

    /**
     * @dev Helper struct to bundle data for swap functions to optimize stack depth.
     */
    struct SwapData {
        address token0;   // The numerically smaller token address of the pair.
        address token1;   // The numerically larger token address of the pair.
        bool reversed;    // True if path[0] (tokenIn) is token1.
    }

    /**
     * @dev New helper struct to bundle all data needed for swap execution (transfers and reserve updates).
     */
    struct SwapExecutionData {
        address sender;
        address tokenIn;
        address tokenOut;
        uint amountIn;
        uint amountOut;
        address recipient; // Renamed 'to' to 'recipient' to avoid conflict with 'to' in outer function
        address token0;
        address token1;
        bool reversed;
    }

        /**
     * @dev Helper struct to bundle data for finalizing removeLiquidity to optimize stack depth.
     */

        struct RemoveLiquidityOperationData {
        // Input parameters to the function
        address tokenA;
        address tokenB;
        uint liquidityAmount;
        uint amountAMin;
        uint amountBMin;
        address recipient; // Renamed 'to' for clarity, matches _safeTransfer parameter

        // Derived/calculated data
        address token0;
        address token1;
        uint currentReserve0;
        uint currentReserve1;
        uint currentTotalLiq;
        uint currentUserLiq;
        uint calculatedAmount0;
        uint calculatedAmount1;
        uint finalAmountA; // amountA to return
        uint finalAmountB; // amountB to return
    }

        /**
     * @dev Helper struct to bundle *all* data related to an add liquidity operation.
     * This aims to pass a single entity around to various internal helpers.
     */
    struct AddLiquidityOperationData {
        // Input parameters to the function
        address tokenA;
        address tokenB;
        uint amountADesired;
        uint amountBDesired;
        uint amountAMin;
        uint amountBMin;
        address recipient; // The 'to' address

        // Derived/calculated data
        address token0;
        address token1;
        uint currentReserve0;
        uint currentReserve1;
        uint currentTotalLiq;
        uint finalAmountA; // The actual amount of tokenA added
        uint finalAmountB; // The actual amount of tokenB added
        uint liquidityMinted; // The amount of liquidity shares minted
    }

    /**
     * @dev Internal helper function to calculate the amounts of tokens to add and liquidity to mint.
     * This function reads current reserves and calculates optimal amounts based on pool ratio or desired amounts.
     * It updates the `AddLiquidityOperationData` struct with `finalAmountA`, `finalAmountB`, and `liquidityMinted`.
     * @param _opData The `AddLiquidityOperationData` struct to populate with calculated values.
     */
    function _calculateAddLiquidityAmounts(
        AddLiquidityOperationData memory _opData
    ) private view { // Marked as view because it only reads state and updates a memory struct
        (_opData.token0, _opData.token1) = _sortTokens(_opData.tokenA, _opData.tokenB);

        Reserve storage r = reserves[_opData.token0][_opData.token1];
        _opData.currentReserve0 = r.reserve0;
        _opData.currentReserve1 = r.reserve1;
        _opData.currentTotalLiq = totalLiquidity[_opData.token0][_opData.token1];

        if (_opData.currentTotalLiq == 0) {
            // First liquidity provision: all desired amounts are accepted.
            _opData.finalAmountA = _opData.amountADesired;
            _opData.finalAmountB = _opData.amountBDesired;
            _opData.liquidityMinted = _opData.amountADesired + _opData.amountBDesired; // Simplified liquidity calculation
        } else {
            // Subsequent liquidity: calculate optimal amounts to maintain the existing pool ratio.
            uint actualReserveA = _opData.tokenA == _opData.token0 ? _opData.currentReserve0 : _opData.currentReserve1;
            uint actualReserveB = _opData.tokenA == _opData.token0 ? _opData.currentReserve1 : _opData.currentReserve0;

            uint amountBOptimal = (_opData.amountADesired * actualReserveB) / actualReserveA;

            if (amountBOptimal <= _opData.amountBDesired) {
                require(amountBOptimal >= _opData.amountBMin, "Insufficient B amount for desired A");
                _opData.finalAmountA = _opData.amountADesired;
                _opData.finalAmountB = amountBOptimal;
            } else {
                uint amountAOptimal = (_opData.amountBDesired * actualReserveA) / actualReserveB;
                require(amountAOptimal >= _opData.amountAMin, "Insufficient A amount for desired B");
                _opData.finalAmountA = amountAOptimal;
                _opData.finalAmountB = _opData.amountBDesired;
            }

            // Calculate liquidity shares proportional to added amounts.
            uint liq0 = (_opData.finalAmountA * _opData.currentTotalLiq) / actualReserveA;
            uint liq1 = (_opData.finalAmountB * _opData.currentTotalLiq) / actualReserveB;
            _opData.liquidityMinted = liq0 < liq1 ? liq0 : liq1;
        }
        require(_opData.liquidityMinted > 0, "No liquidity minted (amounts too small)");
    }

    /**
     * @dev Internal helper function to update pool reserves, total liquidity, user liquidity, and emit the event.
     * Takes a single struct containing all necessary data to minimize stack depth.
     * @param _opData The fully populated `AddLiquidityOperationData` struct.
     */
    function _finalizeAddLiquidity(AddLiquidityOperationData memory _opData) private {
        Reserve storage r = reserves[_opData.token0][_opData.token1];

        // Update the contract's reserves
        if (_opData.tokenA == _opData.token0) {
            r.reserve0 += _opData.finalAmountA;
            r.reserve1 += _opData.finalAmountB;
        } else {
            r.reserve0 += _opData.finalAmountB;
            r.reserve1 += _opData.finalAmountA;
        }

        // Update total and user liquidity shares
        totalLiquidity[_opData.token0][_opData.token1] += _opData.liquidityMinted;
        userLiquidity[_opData.recipient][_opData.token0][_opData.token1] += _opData.liquidityMinted;

        // Emit the event
        emit LiquidityAdded(
            msg.sender,
            _opData.tokenA,
            _opData.tokenB,
            _opData.finalAmountA,
            _opData.finalAmountB,
            _opData.liquidityMinted
        );
    }

    /**
     * @notice Allows users to remove liquidity from a token pair.
     * @dev Burns a specified amount of liquidity shares and transfers the proportional share
     * of underlying tokens (tokenA and tokenB) back to the user.
     * Aggressively uses structs and helper functions to minimize local variables and stack depth.
     * @param tokenA The address of the first token in the pair.
     * @param tokenB The address of the second token in the pair.
     * @param liquidityAmount The amount of liquidity shares to burn/redeem.
     * @param amountAMin The minimum acceptable amount of tokenA to receive (slippage control).
     * @param amountBMin The minimum acceptable amount of tokenB to receive (slippage control).
     * @param to The address to send the retrieved tokens to.
     * @param deadline The timestamp after which the transaction will revert if not mined.
     * @return amountA The amount of tokenA received after removing liquidity.
     * @return amountB The amount of tokenB received after removing liquidity.
     */
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidityAmount,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external ensure(deadline) returns (uint amountA, uint amountB) {
        // Prepare a single struct to pass all input and derived data
        RemoveLiquidityOperationData memory opData;
        opData.tokenA = tokenA;
        opData.tokenB = tokenB;
        opData.liquidityAmount = liquidityAmount;
        opData.amountAMin = amountAMin;
        opData.amountBMin = amountBMin;
        opData.recipient = to; // Assign 'to' to recipient in the struct

        // Delegate all initial calculations, checks, and data population to a helper
        _calculateAndPrepareRemoveLiquidity(opData); // This function will fill in the 'derived' fields of opData

        // Perform the updates and transfers using the fully populated opData
        _updateAndFinalizeRemoveLiquidity(opData);

        // Return the final amounts from the struct
        return (opData.finalAmountA, opData.finalAmountB);
    }

// --- New Helper Function (Add this with your other internal helpers) ---

    /**
     * @dev Internal helper function to perform initial calculations and checks for removeLiquidity.
     * Populates the `RemoveLiquidityOperationData` struct with derived values.
     * @param _opData The `RemoveLiquidityOperationData` struct to populate.
     */
    function _calculateAndPrepareRemoveLiquidity(
        RemoveLiquidityOperationData memory _opData
    ) private view { // Changed to view as it only reads state and updates memory struct
        (_opData.token0, _opData.token1) = _sortTokens(_opData.tokenA, _opData.tokenB);

        Reserve storage r = reserves[_opData.token0][_opData.token1];
        _opData.currentReserve0 = r.reserve0;
        _opData.currentReserve1 = r.reserve1;
        _opData.currentTotalLiq = totalLiquidity[_opData.token0][_opData.token1];
        _opData.currentUserLiq = userLiquidity[msg.sender][_opData.token0][_opData.token1];

        require(_opData.currentUserLiq >= _opData.liquidityAmount, "Insufficient liquidity to remove");
        require(_opData.currentTotalLiq > 0, "No liquidity in pool");
        require(_opData.liquidityAmount > 0, "Liquidity amount must be > 0");

        // Calculate proportional amounts of token0 and token1 to return.
        _opData.calculatedAmount0 = (_opData.liquidityAmount * _opData.currentReserve0) / _opData.currentTotalLiq;
        _opData.calculatedAmount1 = (_opData.liquidityAmount * _opData.currentReserve1) / _opData.currentTotalLiq;

        // Map calculated amounts back to tokenA and tokenB for checks and transfers.
        _opData.finalAmountA = _opData.tokenA == _opData.token0 ? _opData.calculatedAmount0 : _opData.calculatedAmount1;
        _opData.finalAmountB = _opData.tokenA == _opData.token0 ? _opData.calculatedAmount1 : _opData.calculatedAmount0;

        // Apply slippage control.
        require(_opData.finalAmountA >= _opData.amountAMin && _opData.finalAmountB >= _opData.amountBMin, "Slippage exceeded");
    }

    /**
     * @dev Internal helper function to update reserves, perform transfers, and emit the event.
     * Takes a single struct containing all necessary data to minimize stack depth.
     * @param _opData The fully populated `RemoveLiquidityOperationData` struct.
     */
    function _updateAndFinalizeRemoveLiquidity(
        RemoveLiquidityOperationData memory _opData
    ) private {
        // Access the storage pointer for reserves again within this function's stack frame.
        Reserve storage r = reserves[_opData.token0][_opData.token1];

        // Update the contract's reserves, total liquidity, and the user's liquidity share.
        r.reserve0 = _opData.currentReserve0 - _opData.calculatedAmount0;
        r.reserve1 = _opData.currentReserve1 - _opData.calculatedAmount1;
        totalLiquidity[_opData.token0][_opData.token1] = _opData.currentTotalLiq - _opData.liquidityAmount;
        userLiquidity[msg.sender][_opData.token0][_opData.token1] = _opData.currentUserLiq - _opData.liquidityAmount;

        // Perform transfers
        _safeTransfer(_opData.tokenA, _opData.recipient, _opData.finalAmountA);
        _safeTransfer(_opData.tokenB, _opData.recipient, _opData.finalAmountB);

        // Emit event
        emit LiquidityRemoved(
            msg.sender,
            _opData.tokenA,
            _opData.tokenB,
            _opData.finalAmountA,
            _opData.finalAmountB,
            _opData.liquidityAmount // liquidityBurned
        );
    }

    /**
     * @notice Allows a user to exchange an exact amount of one token for another.
     * @dev Transfers `amountIn` of `path[0]` from `msg.sender` to the contract.
     * Calculates the output amount of `path[1]` based on current reserves and a swap fee.
     * Transfers the calculated output amount to the `to` address and updates the reserves.
     * Only direct swaps (path.length == 2) are supported.
     * Uses `SwapData` struct and a new `SwapExecutionData` struct with a helper function
     * to further optimize stack depth for transfers and reserve updates.
     * @param amountIn The exact amount of the input token (`path[0]`) to swap.
     * @param amountOutMin The minimum acceptable amount of the output token (`path[1]`) to receive (slippage control).
     * @param path An array of token addresses representing the swap route.
     * @param to The address to which the output tokens will be sent.
     * @param deadline The timestamp after which the transaction will revert if not mined.
     * @return amounts An array containing the actual input amount (`amounts[0]`) and the actual output amount (`amounts[1]`).
     */
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external ensure(deadline) returns (uint[] memory amounts) {
        require(path.length == 2, "Only direct swaps supported");
        require(amountIn > 0, "Amount in must be > 0");

        SwapData memory swapMeta;
        (swapMeta.token0, swapMeta.token1) = _sortTokens(path[0], path[1]);
        swapMeta.reversed = path[0] == swapMeta.token1;

        Reserve storage r = reserves[swapMeta.token0][swapMeta.token1];
        require(r.reserve0 > 0 && r.reserve1 > 0, "Empty reserves: pool uninitialized");

        uint reserveIn = swapMeta.reversed ? r.reserve1 : r.reserve0;
        uint reserveOut = swapMeta.reversed ? r.reserve0 : r.reserve1;

        uint amountOut = getAmountOut(amountIn, reserveIn, reserveOut);
        require(amountOut >= amountOutMin, "Slippage exceeded");

        // Populate the new struct with all data needed for execution
        SwapExecutionData memory execData = SwapExecutionData({
            sender: msg.sender,
            tokenIn: path[0],
            tokenOut: path[1],
            amountIn: amountIn,
            amountOut: amountOut,
            recipient: to,
            token0: swapMeta.token0,
            token1: swapMeta.token1,
            reversed: swapMeta.reversed
        });

        // Delegate the actual transfers and reserve updates to a new helper function
        // This moves more variables off the stack of swapExactTokensForTokens
        _executeSwapOperations(execData);

        amounts = new uint[](2);
        amounts[0] = amountIn;
        amounts[1] = amountOut;

        // Event emitted within _executeSwapOperations
    }

    // --- Internal Helper Functions (Moved below public functions for organization) ---

    /**
     * @dev Internal function to execute the token transfers, update reserves, and emit the swap event.
     * This function takes a single struct containing all necessary data to minimize stack depth
     * in the calling function (`swapExactTokensForTokens`).
     * @param data A `SwapExecutionData` struct containing all parameters for the swap execution.
     */
    function _executeSwapOperations(SwapExecutionData memory data) private {
        // Transfer the input token from the sender to this contract.
        _safeTransferFrom(data.tokenIn, data.sender, address(this), data.amountIn);

        // Access the storage pointer for reserves again within this function's stack frame.
        Reserve storage r = reserves[data.token0][data.token1];

        // Update the contract's reserves based on the swap.
        if (data.reversed) {
            r.reserve1 += data.amountIn;
            r.reserve0 -= data.amountOut;
        } else {
            r.reserve0 += data.amountIn;
            r.reserve1 -= data.amountOut;
        }

        // Transfer the calculated output tokens from the contract to the recipient.
        _safeTransfer(data.tokenOut, data.recipient, data.amountOut);

        // Emit an event to notify about the swap transaction.
        emit Swapped(data.sender, data.tokenIn, data.tokenOut, data.amountIn, data.amountOut);
    }

    /**
     * @dev Calculates the optimal amounts of tokens to add and liquidity to mint
     * for subsequent liquidity provisions, maintaining the current pool ratio.
     * @param tokenA The address of the first token (could be token0 or token1).
     * @param token0 The numerically smaller token address.
     * @param reserve0 The current reserve of token0.
     * @param reserve1 The current reserve of token1.
     * @param totalLiq The current total liquidity for the pair.
     * @param amountADesired The user's desired amount of tokenA.
     * @param amountBDesired The user's desired amount of tokenB.
     * @param amountAMin The minimum acceptable amount of tokenA.
     * @param amountBMin The minimum acceptable amount of tokenB.
     * @return amountA The actual amount of tokenA added.
     * @return amountB The actual amount of tokenB added.
     * @return liquidity The amount of liquidity shares minted.
     */
    function _calculateOptimalLiquidity(
        address tokenA,
        address token0,
        uint reserve0,
        uint reserve1,
        uint totalLiq,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin
    ) private pure returns (uint amountA, uint amountB, uint liquidity) {
        uint actualReserveA = tokenA == token0 ? reserve0 : reserve1;
        uint actualReserveB = tokenA == token0 ? reserve1 : reserve0;

        uint amountBOptimal = (amountADesired * actualReserveB) / actualReserveA;

        if (amountBOptimal <= amountBDesired) {
            require(amountBOptimal >= amountBMin, "Insufficient B amount");
            (amountA, amountB) = (amountADesired, amountBOptimal);
        } else {
            uint amountAOptimal = (amountBDesired * actualReserveA) / actualReserveB;
            require(amountAOptimal >= amountAMin, "Insufficient A amount");
            (amountA, amountB) = (amountAOptimal, amountBDesired);
        }

        // Calculate liquidity shares proportional to added amounts.
        uint liq0 = (amountA * totalLiq) / actualReserveA;
        uint liq1 = (amountB * totalLiq) / actualReserveB;
        liquidity = liq0 < liq1 ? liq0 : liq1;
    }

    /**
     * @dev Internal function to update pool reserves, total liquidity, and user liquidity.
     * Used by `addLiquidity` to consolidate state updates.
     * @param tokenA The address of the first token (could be token0 or token1).
     * @param token0 The numerically smaller token address.
     * @param token1 The numerically larger token address.
     * @param amountA The actual amount of tokenA added/removed.
     * @param amountB The actual amount of tokenB added/removed.
     * @param liquidity The amount of liquidity shares minted/burned.
     * @param to The address receiving liquidity shares.
     */
    function _updatePool(
        address tokenA,
        address token0,
        address token1,
        uint amountA,
        uint amountB,
        uint liquidity,
        address to
    ) private {
        Reserve storage r = reserves[token0][token1];
        if (tokenA == token0) {
            r.reserve0 += amountA;
            r.reserve1 += amountB;
        } else {
            r.reserve0 += amountB;
            r.reserve1 += amountA;
        }
        totalLiquidity[token0][token1] += liquidity;
        userLiquidity[to][token0][token1] += liquidity;
    }

    /**
     * @dev Internal helper for `SafeERC20.safeTransfer` to reduce stack depth.
     * @param token The address of the ERC20 token.
     * @param to The recipient address.
     * @param amount The amount of tokens to transfer.
     */
    function _safeTransfer(address token, address to, uint amount) private {
        IERC20(token).safeTransfer(to, amount);
    }

    /**
     * @dev Internal helper for `SafeERC20.safeTransferFrom` to reduce stack depth.
     * @param token The address of the ERC20 token.
     * @param from The sender address (who approved the transfer).
     * @param to The recipient address.
     * @param amount The amount of tokens to transfer.
     */
    function _safeTransferFrom(address token, address from, address to, uint amount) private {
        IERC20(token).safeTransferFrom(from, to, amount);
    }

    // --- Price Calculations (Public view functions) ---

    /**
     * @notice Calculates the amount of output tokens a user will receive for a given input amount.
     * @dev Implements the constant product market maker formula with a 0.3% trading fee.
     * Formula: `amountOut = (amountIn * 997 * reserveOut) / (reserveIn * 1000 + amountIn * 997)`.
     * @param amountIn The amount of tokens the user intends to swap into the pool.
     * @param reserveIn The current reserve balance of the input token in the pool.
     * @param reserveOut The current reserve balance of the output token in the pool.
     * @return The calculated amount of tokens the user will receive.
     */
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint) {
        require(amountIn > 0 && reserveIn > 0 && reserveOut > 0, "Invalid input: amounts or reserves must be > 0");
        uint amountInWithFee = amountIn * 997; // Apply 0.3% fee
        return (amountInWithFee * reserveOut) / (reserveIn * 1000 + amountInWithFee);
    }

    /**
     * @notice Calculates the minimum amount of input tokens required to receive a desired output amount.
     * @dev This is the inverse of `getAmountOut`. Accounts for a 0.3% trading fee.
     * Formula: `amountIn = (reserveIn * amountOut * 1000) / ((reserveOut - amountOut) * 997) + 1`.
     * `+ 1` is added to compensate for potential precision loss from integer division.
     * @param amountOut The desired amount of tokens the user wants to receive.
     * @param reserveIn The current reserve balance of the input token in the pool.
     * @param reserveOut The current reserve balance of the output token in the pool.
     * @return The calculated minimum amount of tokens the user needs to send.
     */
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) public pure returns (uint) {
        require(amountOut > 0, "Invalid output: amountOut must be > 0");
        require(reserveIn > 0 && reserveOut > 0, "Empty reserves: pool uninitialized");
        require(reserveOut > amountOut, "Output amount exceeds available reserve.");

        uint numerator = reserveIn * amountOut * 1000;
        uint denominator = (reserveOut - amountOut) * 997;
        return (numerator / denominator) + 1;
    }

    /**
     * @notice Retrieves the current price of one token in terms of another based on their reserves.
     * @dev The price is calculated as the ratio of `reserve of quote token / reserve of base token`.
     * The result is scaled by 1e18 to provide a fixed-point decimal representation.
     * @param tokenA The address of the "base" token.
     * @param tokenB The address of the "quote" token.
     * @return price The price of tokenA expressed in units of tokenB, scaled by 1e18.
     */
    function getPrice(address tokenA, address tokenB) external view returns (uint) {
        (address token0, address token1) = _sortTokens(tokenA, tokenB);
        Reserve storage r = reserves[token0][token1];
        require(r.reserve0 > 0 && r.reserve1 > 0, "Empty reserves: Cannot calculate price for an uninitialized pool.");

        return tokenA == token0
            ? (r.reserve1 * 1e18) / r.reserve0 // Price of token0 in terms of token1 (e.g., how many token1 per token0)
            : (r.reserve0 * 1e18) / r.reserve1; // Price of token1 in terms of token0 (e.g., how many token0 per token1)
    }

    /**
     * @notice Queries the liquidity shares held by a specific user for a given token pair.
     * @param user The address of the user whose liquidity balance is being queried.
     * @param tokenA The address of the first token in the pair.
     * @param tokenB The address of the second token in the pair.
     * @return The amount of liquidity shares `user` holds for the `tokenA`/`tokenB` pair.
     */
    function balanceOfLiquidity(address user, address tokenA, address tokenB) external view returns (uint) {
        (address token0, address token1) = _sortTokens(tokenA, tokenB);
        return userLiquidity[user][token0][token1];
    }
}
