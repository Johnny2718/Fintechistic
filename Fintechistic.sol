// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// Library form Openzepplin
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

// Create NFT for the borrower, called by the borrower
contract Borrower is ERC1155, Ownable , ERC1155Burnable{
    constructor() ERC1155("") {
        // id = 0 (NFT), num of NFT =2
        _mint(msg.sender, 0, 1, "");
        _setURI("ipfs://Qmed2ZTaL8Nogiat3tsEesiE8WfU81GPeNJjXp9MoSH6jU");
    }
}
// Create Token for the escrow, called by the escrow
contract Escrow is ERC1155, Ownable , ERC1155Burnable{
    constructor() ERC1155("") {
        // id = 1 (token), num of token = 1000
        _mint(msg.sender,1,1000, "");
    }
}
// Contract for the loan
contract Loan{
    uint private principal;
    uint private interest;

    // number of NFT owned by the borrower
    uint public borrowerNFT;
    // number of Token owned by the borrower
    uint public borrowerToken;
    // number of NFT owned by the escrow
    uint public escrowNFT;
    // number of token owned by the escrow
    uint public escrowToken;

    address public borrower;
    address public escrow;

    // set the loan information
    // _NFTAdd == contract address of the borrower
    // _TokenAdd == contract address of the escrow
    function setLoan(uint _principal, uint _interest, address _borrower,address _escrow,address _NFTAdd, address _TokenAdd) public{
        ERC1155 NFT = ERC1155(_NFTAdd);
        ERC1155 Token = ERC1155(_TokenAdd);
        NFT=ERC1155(_NFTAdd);
        Token=ERC1155(_TokenAdd);
        principal=_principal;
        interest=_interest;
        borrower=_borrower;
        escrow=_escrow;

        // update the number of NFT and token
        borrowerNFT=NFT.balanceOf(_borrower,0);
        borrowerToken=Token.balanceOf(_borrower,1);
        escrowNFT=NFT.balanceOf(_escrow,0);
        escrowToken=Token.balanceOf(_escrow,1);
    }

    // We assume id = 0 is NFT, id=1 is token
    function borrowLoan(address _NFTAdd, address _TokenAdd) external{
        ERC1155 NFT = ERC1155(_NFTAdd);
        ERC1155 Token = ERC1155(_TokenAdd);
        require(borrowerNFT >0,"the borrower does not have enough NFT!");
        require(escrowToken >principal,"escrow does not have enough token");
        NFT.safeTransferFrom(borrower, escrow, 0,1 ,"");
        Token.safeTransferFrom(escrow,borrower,1,principal,"");

        borrowerNFT=NFT.balanceOf(borrower,0);
        borrowerToken=Token.balanceOf(borrower,1);
        escrowNFT=NFT.balanceOf(escrow,0);
        escrowToken=Token.balanceOf(escrow,1);
    }
    function repayLoan(address _NFTAdd, address _TokenAdd) external{
        ERC1155 NFT = ERC1155(_NFTAdd);
        ERC1155 Token = ERC1155(_TokenAdd);
        // the amount that the borrower need to repay
        uint repayAmount = principal * interest/100 + principal;
        require(Token.balanceOf(borrower,1)>repayAmount,"borrower does not have enough to repay"); 
        Token.safeTransferFrom(borrower,escrow,1,repayAmount,"");
        NFT.safeTransferFrom(escrow,borrower,0,1,"");

        borrowerNFT=NFT.balanceOf(borrower,0);
        borrowerToken=Token.balanceOf(borrower,1);
        escrowNFT=NFT.balanceOf(escrow,0);
        escrowToken=Token.balanceOf(escrow,1);
    }
}





