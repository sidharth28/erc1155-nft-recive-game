// contracts/MyContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "./vrf.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract WinnnerTakesAll is ERC1155Holder,RandomNumberConsumer {

    mapping(address => bytes32) public addressRequestMap;

  uint256 private constant WINNER_NUMBER = 44;

    struct NFTVault{
        address nft;
        uint id;
    }

    NFTVault[]  vaultArr;

     function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 ,
        bytes memory 
    ) public virtual override returns (bytes4) {

        addressRequestMap[operator] = getRandomNumber();

        vaultArr.push(NFTVault(msg.sender,id));

        return this.onERC1155Received.selector;
    }

    function isWinner() public view returns (bool ) {
        return randomMap[addressRequestMap[msg.sender]] == WINNER_NUMBER;
    }


   function claim() external {

        require(randomMap[addressRequestMap[msg.sender]] == WINNER_NUMBER,"You are not a winner, please try again !! Best of Luck");
        
        for(uint i = 0;i< vaultArr.length ; i++){
            IERC1155(vaultArr[i].nft).safeTransferFrom(
               address(this),
                msg.sender,
                vaultArr[i].id,
                1,
                '0x'
            );
        }

        delete vaultArr;
   }

    
}
