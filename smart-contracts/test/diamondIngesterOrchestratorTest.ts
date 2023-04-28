/* global describe it before ethers */

import {
    getSelectors,
    FacetCutAction,
    removeSelectors,
    findAddressPositionInFacets,
    } from "../scripts/libraries/diamond";
import {
    DiamondCutFacet,
    DiamondLoupeFacet,
    GroupManagerFacet,
    OwnershipFacet,
    RegistryFacet,
    Test1Facet,
    NotContractOwner
    } from "../typechain-types";
import { deployDiamond, maxClusterSize, maxGroupsPerIngester, maxIngestersPerGroup } from "../scripts/deploy";

import { ethers } from "hardhat";

import { BigNumber, ContractReceipt } from "ethers";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { addFacetsToDiamond, removeFacetsFromDiamond } from "./testUtils/testUtils";
  
describe("Ingester Orchestrator Diamond Tests", async function () {
    let diamondCutFacet: DiamondCutFacet;
    let diamondLoupeFacet: DiamondLoupeFacet;
    let ownershipFacet: OwnershipFacet;
    let tx;
    let receipt: ContractReceipt;
    let result;
    let addresses: string[] = [];
    let diamondAddress: string;
    let accounts: SignerWithAddress[];
    let controller: SignerWithAddress;
    let ingester: SignerWithAddress;
    let contractOwner: SignerWithAddress;
  
    before(async function () {
        accounts = await ethers.getSigners();
        controller = accounts[0];
        ingester = accounts[1];

        const diamonDeployed = await deployDiamond();
        diamondAddress = diamonDeployed.diamondAddress;
        contractOwner = diamonDeployed.contractOwner;
        
        diamondCutFacet = await ethers.getContractAt(
            "DiamondCutFacet",
            diamondAddress
        );
        diamondLoupeFacet = await ethers.getContractAt(
            "DiamondLoupeFacet",
            diamondAddress
        );
        ownershipFacet = await ethers.getContractAt(
            "OwnershipFacet",
            diamondAddress
        );
    });
  
    it("should have three facets -- call to facetAddresses function", async () => {
      for (const address of await diamondLoupeFacet.facetAddresses()) {
        addresses.push(address);
      }
  
      assert.equal(addresses.length, 3);
    });
  
    it("facets should have the right function selectors -- call to facetFunctionSelectors function", async () => {
      let selectors = getSelectors(diamondCutFacet);
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[0]);
      assert.sameMembers(result, selectors);
      selectors = getSelectors(diamondLoupeFacet);
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[1]);
      assert.sameMembers(result, selectors);
      selectors = getSelectors(ownershipFacet);
      result = await diamondLoupeFacet.facetFunctionSelectors(addresses[2]);
      assert.sameMembers(result, selectors);
    });
  
    it("selectors should be associated to facets correctly -- multiple calls to facetAddress function", async () => {
      assert.equal(
        addresses[0],
        await diamondLoupeFacet.facetAddress("0x1f931c1c")
      );
      assert.equal(
        addresses[1],
        await diamondLoupeFacet.facetAddress("0xcdffacc6")
      );
      assert.equal(
        addresses[1],
        await diamondLoupeFacet.facetAddress("0x01ffc9a7")
      );
      assert.equal(
        addresses[2],
        await diamondLoupeFacet.facetAddress("0xf2fde38b")
      );
    });

    describe("RegistryFacet Diamond Tests", async function () {
        let registrationFacet: RegistryFacet;
        let removedIngesterAssignedGroups: string[];

        it("should add registry functions", async () => {
          const RegisteryFacet = await ethers.getContractFactory("RegistryFacet");
          const registryFacet = await RegisteryFacet.deploy();
          await registryFacet.deployed();
          addresses.push(registryFacet.address);
          const selectors = getSelectors(registryFacet);
      
          tx = await diamondCutFacet.diamondCut(
            [
              {
                facetAddress: registryFacet.address,
                action: FacetCutAction.Add,
                functionSelectors: selectors,
              },
            ],
            ethers.constants.AddressZero,
            "0x",
            { gasLimit: 800000 }
          );
          receipt = await tx.wait();
          if (!receipt.status) {
            throw Error(`Diamond upgrade failed: ${tx.hash}`);
          }
          result = await diamondLoupeFacet.facetFunctionSelectors(registryFacet.address);
          assert.sameMembers(result, selectors);
        });

        it("should replace getIngester function", async () => {
            const RegistryFacet = await ethers.getContractFactory("RegistryFacet");
            const RegistryFacetTest = await ethers.getContractFactory("RegistryFacetTest");
            const registryFacetTest = await RegistryFacetTest.deploy();
            await registryFacetTest.deployed();
          
            const selectorsToReplace = getSelectors(registryFacetTest).get(["getIngester(address)"]);
          
            tx = await diamondCutFacet.diamondCut(
              [
                {
                  facetAddress: registryFacetTest.address,
                  action: FacetCutAction.Replace,
                  functionSelectors: selectorsToReplace,
                },
              ],
              ethers.constants.AddressZero,
              "0x",
              { gasLimit: 800000 }
            );
            receipt = await tx.wait();
            if (!receipt.status) {
              throw Error(`Diamond upgrade failed: ${tx.hash}`);
            }
          
            // Check if the old facet no longer has the replaced function
            const oldFacetAddress = addresses[3];
            result = await diamondLoupeFacet.facetFunctionSelectors(oldFacetAddress);
            assert.notIncludeMembers(result, selectorsToReplace);
          });

        it("should call replaced function", async () => {
            registrationFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
            let ingesterTestRes = await registrationFacet.getIngester(ingester.address);
            let testClusterId = BigNumber.from(ingesterTestRes.clusterId).toNumber();
            expect(testClusterId == 999);
        });

        it("should replace original getIngester function by removing and adding back in", async () => {
            const RegistryFacet = await ethers.getContractFactory("RegistryFacet");
            const RegistryFacetTest = await ethers.getContractFactory("RegistryFacetTest");
            const registryFacetTest = await RegistryFacetTest.deploy();
            await registryFacetTest.deployed();
          
            const selectorToRemove = getSelectors(registryFacetTest).get(["getIngester(address)"]);
            const selectorToAdd = getSelectors(RegistryFacet).get(["getIngester(address)"]);
          
            const oldFacetAddress = addresses[3]; // assuming the old RegistryFacet address is stored at index 3
          
            tx = await diamondCutFacet.diamondCut(
              [
                {
                  facetAddress: ethers.constants.AddressZero,
                  action: FacetCutAction.Remove,
                  functionSelectors: selectorToRemove,
                },
                {
                  facetAddress: oldFacetAddress,
                  action: FacetCutAction.Add,
                  functionSelectors: selectorToAdd,
                },
              ],
              ethers.constants.AddressZero,
              "0x",
              { gasLimit: 800000 }
            );
            receipt = await tx.wait();
            if (!receipt.status) {
              throw Error(`Diamond upgrade failed: ${tx.hash}`);
            }
          
            // Check if the new facet has the replaced function
            result = await diamondLoupeFacet.facetFunctionSelectors(registryFacetTest.address);
            assert.notIncludeMembers(result, selectorToRemove);
          
            // Check if the old facet no longer has the replaced function
            result = await diamondLoupeFacet.facetFunctionSelectors(oldFacetAddress);
            assert.includeMembers(result, selectorToAdd);
        });
    });

    describe("ownership", function () {
      let registryFacet: RegistryFacet;
      let newOwner: SignerWithAddress;

      before(async function () {
        accounts = await ethers.getSigners();
        newOwner = accounts[1];

        // const diamonDeployed = await deployDiamond();
        // diamondAddress = diamonDeployed.diamondAddress;
        // contractOwner = diamonDeployed.contractOwner;

        let facetNames = ['GroupManagerFacet', 'DataGatheringFacet'];
        let sharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
        await removeFacetsFromDiamond(addresses, diamondCutFacet, diamondAddress, ["RegistryFacet"], sharedFacets)
        addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets);
        registryFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
    });


      it("should transfer ownership", async function () {
          let diamond = (await ethers.getContractAt(
            "OwnershipFacet",
            diamondAddress,
            contractOwner
          )) as OwnershipFacet;

          let currentOwner = await diamond.owner();

          let tx = await diamond.transferOwnership(newOwner.address);
          await tx.wait();
          await expect(tx).to.emit(diamond, "OwnershipTransferred");
          let modOwner = await diamond.owner();
          expect(await diamond.owner()).to.equal(newOwner.address);
      });
  
      it("should not allow non-admin to transfer ownership", async function () {

        console.log('starting the failing test');
        let diamond = (await ethers.getContractAt(
          "OwnershipFacet",
          diamondAddress
        )) as OwnershipFacet;

        let currentOwner = await diamond.owner();
        console.log("🚀 ~ file: diamondIngesterOrchestratorTest.ts:243 ~ currentOwner:", currentOwner)
        const expectedError = "NotContractOwner";

        await expect(diamond.transferOwnership(newOwner.address)).to.be.revertedWithCustomError(diamond, 'NotContractOwner');
      });
    });
});
  