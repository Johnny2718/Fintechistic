We would like to use smart contract to demonstrate the loan borrowing and lending process. The smart contract file is called "Fintestic.sol"
In the file, there are there contract, namely "Borrower", "Escrow" and "Loan"



Contract "Borrower":
Called by the borrower, once deployed, NFT will be minted to the address of the borrower and the NFT can be viewed of Opensea testnet
![IVZjGXR](https://user-images.githubusercontent.com/91397409/201110516-6aa387df-b095-433c-ba1b-555e0e7b9497.png)



Contract "Escrow":
Called by the escrow, once deployed, token will be minted to the escrow's account. The transaction record can be viewed on Etherscan.
![Etherscan](https://user-images.githubusercontent.com/91397409/201112190-7f30b764-c644-48e1-bd6c-a09024bcb95a.png)


Contract "Loan":
Called by the third pirty. There are three function inside the contract. The function "setLoan" is used to set the loan information for the borrowing and repaying. The second function is "borrowLoan". Before calling this function. It is important to to call "setApprovedForAll" in both the borrower's contract and the escrow's contract.
It is essential for other party to transact their NFT or token on their behalf. After approved. "borrowLoan" can be called. The token will transafer from the escrow to the borrower and the NFT will be transferred from the borrower to the escrow. Similarly, for repay the loan, function "repayLoan" will be called. If the borrower have enough token to repay. He/She will give back the token. Else the NFT will be sent to the lender.

![Approved](https://user-images.githubusercontent.com/91397409/201116713-3edcc624-fac7-4e5f-adf3-bac8bbf78250.png)



