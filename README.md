# Nft-Market-Contractsv2

NFT Marketplace

NFTMarket.sol: list ERC721/1155 items for sale

MarketBids.sol: Enter bids for NFTs listed for sale, or "blind" bids for items not listed for sale (specific tokens or collection wide).

MarketTrades.sol: Enter trades with ERC721/1155 NFTs for NFTs listed for sale, or "blind" trades for items not listed for sale (specific tokens or collection wide).

MarketOffers.sol: Enter ERC20 offers for NFTs listed for sale, or "blind" offers for items not listed for sale (specific tokens or collection wide).

MarketCollections.sol: restricts the trading of certain collections

MarketMint.sol: mints new marketplace NFTs for a configurable amount of configurable tokens. Deploys new ERC721 or ERC1155 for a deployment fee. Fees go to controlling DAO.

ERC721Factory.sol: creates new ERC721 contract with access control

ERC1155Factory.sol: creates new ERC1155 contracts with access control

RewardsController.sol: splits rewards between users, devs and controlling DAO

MktRoleProvider.sol: Access control role provider to restrict access across all contracts

OwnerProxy.sol: controlling contract to operate all other contracts, operated by the DAO

PHAM1155.sol: ERC1155 standard with access control

PHAMNFTs.sol: ERC721 standard with access control
