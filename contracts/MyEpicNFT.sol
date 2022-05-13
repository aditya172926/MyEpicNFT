// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFT is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // The NFT standard is known as ERC721 which you can read a bit about here. 
    // OpenZeppelin essentially implements the NFT standard for us and then lets us 
    // write our own logic on top of it to customize it. 
    // That means we don't need to write boiler plate code.

    //ERC721 contract link - https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol


    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Whoa!");
    }

    // A function our user will hit to get their NFT.
    function makeAnEpicNFT() public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        // When we do _safeMint(msg.sender, newItemId) it's pretty much saying: 
        // "mint the NFT with id newItemId to the user with address msg.sender
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.

        // We then do, _setTokenURI(newItemId, "blah") which will set the NFTs unique 
        // identifier along with the data associated w/ that unique identifier. 
        // It's literally us setting the actual data that makes the NFT valuable. 
        // In this case, we're setting it as "blah" which....isn't that valuable ;).
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/LEC1");
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        // The tokenURI is where the actual NFT data lives. 
        // And it usually links to a JSON file called the metadata

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}