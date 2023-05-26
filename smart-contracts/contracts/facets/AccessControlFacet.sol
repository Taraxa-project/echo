
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@solidstate/contracts/access/access_control/AccessControl.sol";
import "../libraries/LibDiamond.sol";
import { LibAppStorage, AppStorage } from  "../libraries/LibAppStorage.sol";

contract AccessControlFacet is AccessControl {
    
    /**
    * @notice Modifier to enforce that the caller is a contract admin.
    */
    modifier onlyAdmin() {
        LibDiamond.enforceIsContractOwner();
        _;
    }

    /**
    * @notice Modifier to enforce that the caller is a registered ingester.
    */
    modifier onlyRegisteredIngester() {
        require(_hasRole(LibAppStorage._INGESTER_ROLE, msg.sender), "LibAppStorage: Not a registered ingester");
        _;
    }

    /**
    * @notice Modifier to enforce that the caller is a registered controller.
    */
    modifier onlyRegisteredController() {
        require(_hasRole(LibAppStorage._CONTROLLER_ROLE, msg.sender), "LibAppStorage: Not a registered controller");
        _;
    }

    /**
    * @notice Checks if an address is a registered ingester.
    * @param ingesterAddress The address to check for ingester registration.
    * @return A boolean indicating if the address is a registered ingester.
    */
    function isRegisteredIngester(address ingesterAddress) public view returns (bool) {
        return _hasRole(LibAppStorage._INGESTER_ROLE, ingesterAddress);
    }

    /**
    * @notice Checks if an address is a registered controller.
    * @param controller The address to check for controller registration.
    * @return A boolean indicating if the address is a registered controller.
    */
    function isRegisteredController(address controller) public view returns (bool) {
        return _hasRole(LibAppStorage._INGESTER_ROLE, controller);
    }

    /**
    * @notice Checks if an ingester is owned by a controller.
    * @param ingester The address of the ingester to check.
    * @param controller The address of the controller to check.
    * @return A boolean indicating if the ingester is owned by the controller.
    */
    function isIngesterOwnedByController(address ingester, address controller) public view returns (bool) {
        AppStorage storage s = LibAppStorage.appStorage();
        return s.ingesterToController[ingester].controllerAddress == controller;
    }
}
