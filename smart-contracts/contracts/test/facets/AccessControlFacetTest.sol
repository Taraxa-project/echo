
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@solidstate/contracts/access/access_control/AccessControl.sol";
import "../../libraries/LibDiamond.sol";
import { LibAppStorageTest, AppStorageTest } from  "../libraries/LibAppStorageUpgradeTest.sol";

contract AccessControlFacetTest is AccessControl {
    
    modifier onlyAdmin() {
        LibDiamond.enforceIsContractOwner();
        _;
    }

    modifier onlyRegisteredIngester() {
        require(_hasRole(LibAppStorageTest.INGESTER_ROLE, msg.sender), "LibAppStorageTest: Not a registered ingester");
        _;
    }

    modifier onlyRegisteredController() {
        require(_hasRole(LibAppStorageTest.CONTROLLER_ROLE, msg.sender), "LibAppStorageTest: Not a registered controller");
        _;
    }

    function isRegisteredIngester(address ingester) public view returns (bool) {
        return _hasRole(LibAppStorageTest.INGESTER_ROLE, ingester);
    }

    function isRegisteredController(address controller) public view returns (bool) {
        return _hasRole(LibAppStorageTest.INGESTER_ROLE, controller);
    }

    function isIngesterOwnedByController(address ingester, address controller) public view returns (bool) {
        AppStorageTest storage s = LibAppStorageTest.appStorage();
        return s.ingesterToController[ingester].controllerAddress == controller;
    }
}
