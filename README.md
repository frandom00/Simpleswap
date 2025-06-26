Overview
This document outlines the functionality and usage of the SimpleSwap smart contract. SimpleSwap is a decentralized exchange (DEX) that facilitates the creation of liquidity pools and the swapping of ERC-20 tokens.  It is a basic implementation inspired by the core mechanics of Uniswap, allowing users to add and remove liquidity and trade tokens directly on-chain.  The contract is designed to manage token reserves, calculate prices based on these reserves, and provide a secure trading environment. 


The contract is owned by the address that deploys it. 


Interfaces
The SimpleSwap contract is built to interact with tokens that adhere to the ERC-20 standard.  All token-related operations utilize the IERC20 interface.  To ensure secure and robust token transfers, the contract uses the SafeERC20 library, which provides wrappers for ERC-20 operations that handle potential failures and inconsistencies in token contract implementations. 



While the provided source file also includes definitions for IERC165 and IERC1363, the SimpleSwap contract's core logic exclusively uses standard IERC20 functions for its operations. 


How to Use the Contract
Interacting with the SimpleSwap contract typically involves two steps from the user's end:

Approve Token Transfers: Before calling a function that will transfer tokens from you (like addLiquidity or swapExactTokensForTokens), you must first grant the SimpleSwap contract an allowance to manage your tokens. This is done by calling the approve() function on the specific ERC-20 token contract, specifying the SimpleSwap contract's address as the spender and the amount you wish to allow.

Call the Contract Function: Once the allowance is set, you can call the desired SimpleSwap function. The contract will then use the allowance to pull the necessary tokens from your address using transferFrom.

All functions that execute a state change include a deadline parameter. This is a security feature that ensures the transaction will only be executed if it is mined before the specified timestamp, protecting against long-pending transactions being executed at a much later, unfavorable price. 

Core Functions
These are the main functions that alter the state of the contract and the liquidity pools.

addLiquidity()
Adds liquidity to a token pair's pool.  It takes the desired amounts of two tokens (A and B), calculates the optimal deposit ratio based on the current pool reserves, and transfers the tokens from the user.  In return, the user receives liquidity shares, which represent their portion of the pool. 





Parameters:
tokenA, tokenB: The addresses of the two tokens in the pair. 
amountADesired, amountBDesired: The amount of each token the user wishes to add. 
amountAMin, amountBMin: The minimum acceptable amount of each token to add, which controls slippage. 
to: The address that will receive the new liquidity shares. 
deadline: The transaction's expiration timestamp. 
Returns:
amountA, amountB: The actual amounts of each token added to the pool. 
liquidity: The number of liquidity shares minted to the to address. 
Emits: LiquidityAdded event. 
removeLiquidity()
Removes liquidity from a token pair's pool.  The user burns a specified number of their liquidity shares and, in exchange, receives a proportional amount of the underlying tokens from the pool. 



Parameters:
tokenA, tokenB: The addresses of the two tokens in the pair. 
liquidityAmount: The number of liquidity shares to burn. 
amountAMin, amountBMin: The minimum amount of each token the user must receive, protecting against slippage. 
to: The address that will receive the withdrawn tokens. 
deadline: The transaction's expiration timestamp. 
Returns:
amountA, amountB: The actual amounts of each token returned to the user. 
Emits: LiquidityRemoved event. 
swapExactTokensForTokens()
Exchanges an exact amount of an input token for another token.  The contract supports direct, two-token swaps.  The user specifies the exact input amount, and the contract calculates the corresponding output amount based on the pool's reserves. 



Parameters:
amountIn: The exact amount of the input token to be swapped. 
amountOutMin: The minimum acceptable amount of the output token to receive, controlling slippage. 
path: An array of two token addresses, where path[0] is the input token and path[1] is the output token. 
to: The address that will receive the output tokens. 
deadline: The transaction's expiration timestamp. 
Returns:
amounts: An array containing the input amount (amounts[0]) and the output amount (amounts[1]). 
Emits: Swapped event. 
View Functions (Price & Data Queries)
These functions are read-only and do not consume significant gas. They can be called to query the state of the contract and get price information.

getPrice(address tokenA, address tokenB)

Returns the current price of tokenA in terms of tokenB, based on the ratio of their reserves.  The price is scaled by 1e18 for fixed-point decimal representation. 

getAmountOut(uint amountIn, uint reserveIn, uint reserveOut)

Calculates how many output tokens will be received for a given amountIn of input tokens, based on the reserves. 

getAmountIn(uint amountOut, uint reserveIn, uint reserveOut)

Calculates the required amount of input tokens to receive a specific amountOut of output tokens. 

balanceOfLiquidity(address user, address tokenA, address tokenB)

Queries and returns the number of liquidity shares a specific user holds for a given token pair. 

Deployment Address
To interact with this contract, you need its address on the blockchain where it has been deployed.

Contract Address: https://sepolia.etherscan.io/address/0x82ed3596ebef740d1ce16ca534b3a0d8a59e4ebd#code
