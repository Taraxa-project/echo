
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@solidstate/contracts/access/access_control/AccessControl.sol";
import "../libraries/LibDiamond.sol";
import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";

contract AccessControlFacet is AccessControl {
    
    modifier onlyAdmin() {
        LibDiamond.enforceIsContractOwner();
        _;
    }

    modifier onlyRegisteredIngester() {
        require(_hasRole(LibAppStorage.INGESTER_ROLE, msg.sender), "LibAppStorage: Not a registered ingester");
        _;
    }

    modifier onlyRegisteredController() {
        require(_hasRole(LibAppStorage.CONTROLLER_ROLE, msg.sender), "LibAppStorage: Not a registered controller");
        _;
    }

    function isRegisteredIngester(address ingester) public view returns (bool) {
        return _hasRole(LibAppStorage.INGESTER_ROLE, ingester);
    }

    function isRegisteredController(address controller) public view returns (bool) {
        return _hasRole(LibAppStorage.INGESTER_ROLE, controller);
    }

    function isIngesterOwnedByController(address ingester, address controller) public view returns (bool) {
        AppStorage storage s = LibAppStorage.appStorage();
        return s.ingesterToController[ingester].controllerAddress == controller;
    }
}
