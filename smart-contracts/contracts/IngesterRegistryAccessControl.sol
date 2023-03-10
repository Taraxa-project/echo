// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

contract IngesterRegistryAccessControl is Ownable, AccessControlEnumerable {
    bytes32 public constant INGESTER_ROLE = keccak256("INGESTER_ROLE"); 

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    //modifiers
    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Only admin can perform this action.");
        _;
    }

    modifier onlyRegistered() {
        require(hasRole(INGESTER_ROLE, msg.sender), "Caller is not a registered ingester");
        _;
    }

    function transferOwnership(address newOwner) public onlyAdmin override {
        super.transferOwnership(newOwner);
    }
}