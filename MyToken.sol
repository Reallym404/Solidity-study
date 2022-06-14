// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC721, ERC721Enumerable, ERC721URIStorage, Pausable, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;
    Counters.Counter private _tokenIdCounter;
    string public baseURI;
    uint256 public maxSupply = 10;
    //uint256 public maxMintAmount = 5;
    bool public isReveal;
    string public baseExtension = ".json";
    string private metaDataURI;
    uint public cost = 0.1 ether;

    function 

    constructor(string memory _initMetaDataURI) ERC721("Plent1", "MPT1") {
        metaDataURI = _initMetaDataURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _uri) public onlyOwner{
        baseURI = _uri;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function setReveal() public onlyOwner {
        isReveal = true;
    }

    function getIdCounter() public view returns(uint){
        return _tokenIdCounter.current();
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function mint() external payable{
        require(totalSupply() < maxSupply,"more than maxSupply");
        require(msg.value == cost,"Need to send 0.1 ether");
        _tokenIdCounter.increment();
        _safeMint(msg.sender, _tokenIdCounter.current());
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        require(_exists(tokenId),"ERC721Metadata: URI query for nonexistent token");
        if(isReveal){
            string memory currentBaseURI = _baseURI();
            return bytes(currentBaseURI).length > 0?string(abi.encodePacked(currentBaseURI,tokenId.toString(),baseExtension)):"";
        }else{
            return metaDataURI;
        }
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
