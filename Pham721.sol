
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract PhamNFTs is ERC721, AccessControl {

    bytes32 public constant USER_OWNER_ROLE = keccak256("USER_OWNER");

    uint256 tokenId;
    uint256 price;
    uint256 supply;
    string baseUri;

    constructor(address userOwnerAddress, address controllerAddress, uint256 _price, uint256 _supply, string memory tokenName, string memory _tokenSymbol, string memory _baseUri) ERC721(tokenName, _tokenSymbol) {
      _grantRole(DEFAULT_ADMIN_ROLE, controllerAddress);
      _grantRole(USER_OWNER_ROLE, userOwnerAddress);
      supply = _supply;
      setPrice(_price);
      setBaseUri(_baseUri);
      baseUri = _baseUri;
    }

    function safeMint(address to, uint256 count) public payable {
        require (msg.value >= (price * count), "Insufficient ETH sent");
        require(supply >= tokenId + count, "Not enough left");
        tokenId += count;
        _safeMint(to, count);
    }
    function setPrice(uint256 _price) public onlyRole(USER_OWNER_ROLE) {
        price = _price; 
    }
    function setBaseUri(string memory _baseUri) public onlyRole(USER_OWNER_ROLE) {
        baseUri = _baseUri;
    }
    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");
        return string(abi.encodePacked(baseUri, Strings.toString(_tokenId), ".json"));
    }

    function withdraw() public onlyRole(USER_OWNER_ROLE) {
        payable(msg.sender).transfer(address(this).balance);
    }
    function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, AccessControl)
    returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
