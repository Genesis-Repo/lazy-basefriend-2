// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract FriendTech is ERC721, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;
    EnumerableSet.AddressSet private daoMembers;

    mapping(address => uint256) private sharesPrice;
    mapping(address => uint256) private sharesTotalSupply;
    mapping(address => mapping(address => uint256)) private userShares;

    event SharesPriceSet(address indexed user, uint256 price);
    event SharesSupplySet(address indexed user, uint256 totalSupply);
    event SharesBought(address indexed buyer, address indexed seller, uint256 sharesBought);
    event SharesSold(address indexed buyer, address indexed seller, uint256 sharesSold);
    event SharesTransferred(address indexed from, address indexed to, uint256 sharesTransferred);
    event AddedToDAO(address indexed member);
    event RemovedFromDAO(address indexed member);

    constructor() ERC721("FriendTechShares", "FTS") {}

    // Function to add a user to the DAO
    function addToDAO(address _member) external onlyOwner {
        daoMembers.add(_member);
        emit AddedToDAO(_member);
    }

    // Function to remove a user from the DAO
    function removeFromDAO(address _member) external onlyOwner {
        daoMembers.remove(_member);
        emit RemovedFromDAO(_member);
    }

    // Function to check if an address is a member of the DAO
    function isInDAO(address _member) external view returns (bool) {
        return daoMembers.contains(_member);
    }
}