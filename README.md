# erc1155-nft-recive-game

Network: polygon mumbai testnet

Follow below steps in remix:

1. Deploy reciver.sol .
2. Send LINK token to deployed contract address.
3. Send erc-1155 NFT to the deployed contract address.
4. After sending , user can call 'isWinner' function to check if he/she is the winner.
5. To claim NFT winner can call 'claim' function.


Winning Logic:
A number is hardcode in contract i.e '44' , when contract recieves NFT it fetches a random number between 1 to 100 , and if that number is '44' user wins. therefore, giving 1% wining chance to user. 
