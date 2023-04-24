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
    } from "../typechain-types";
import { deployDiamond, maxClusterSize, maxGroupsPerIngester, maxIngestersPerGroup } from "../scripts/deploy";
import { IDiamondLoupe } from "../typechain-types/contracts/IngesterOrchestratorDiamond/facets/DiamondLoupeFacet";

import { ethers } from "hardhat";

import { BigNumber, ContractReceipt } from "ethers";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Sign } from "crypto";
  
describe("DiamondTest", async function () {
    let diamondCutFacet: DiamondCutFacet;
    let diamondLoupeFacet: DiamondLoupeFacet;
    let ownershipFacet: OwnershipFacet;
    let tx;
    let receipt: ContractReceipt;
    let result;
    const addresses: string[] = [];
    let diamondAddress: string;
    let accounts: SignerWithAddress[];
    let controller: SignerWithAddress;
    let ingester: SignerWithAddress;
  
    before(async function () {
        accounts = await ethers.getSigners();
        controller = accounts[0];
        ingester = accounts[1];

        diamondAddress = await deployDiamond();
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

    describe("RegistryFacet", async function () {
        let registrationFacet: RegistryFacet;

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
          
            const oldFacetAddress = addresses[3]; // assuming the old RegistryFacet address is stored at index 0
          
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
          
        
        it("Should register an ingester", async function () {
            registrationFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
            const message = "Test message";
            const nonce = 1;
        
            // Generate the signature
            const hash = ethers.utils.solidityKeccak256(["address", "string", "uint256"], [ingester.address, message, nonce]);
            const signature = await controller.signMessage(ethers.utils.arrayify(hash));
        
            // Register ingester
            await registrationFacet.registerIngester(ingester.address, controller.address, message, nonce, signature);
        
            // Verify the registration
            const ingesterData = await registrationFacet.getIngester(ingester.address);
            expect(ingesterData.ingesterAddress).to.equal(ingester.address);
            expect(ingesterData.verified).to.equal(true);
        });

        it("Should allocate an ingester role", async function () {
            let isRegistered = await registrationFacet.isRegisteredIngester(ingester.address);
            expect(isRegistered).to.be.true;
        });

        it("Should unregister an ingester", async function () {
            registrationFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
            let ingesterToRemove = await registrationFacet.getIngesterWithGroups(ingester.address);

            let tx = await registrationFacet.unRegisterIngester(ingester.address);
            let txUnregister = await tx.wait();

            expect(txUnregister).to.emit(diamondAddress, "IngesterUnRegistered")
                .withArgs(controller.address, ingester.address)
                .and.to.emit(diamondAddress, "IngesterRemovedFromGroup")
                .withArgs(ingester.address, ingesterToRemove.assignedGroups);
        
            expect(registrationFacet.getIngester(ingester.address)).to.be.revertedWith("Ingester does not exist.");
        });

        it("Should revoke role of ingester when unregistered", async function () {
            registrationFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
            
            let isRegistered = await registrationFacet.isRegisteredIngester(ingester.address);
            expect(isRegistered).to.not.false;
        });
    });

    describe("GroupManagerFacet", async function () {
        let groupManagerFacet: GroupManagerFacet;
        let selectorsAccessControl: any;
        const message = "Test message";
        const nonce = 1;
        let registrationFacet: RegistryFacet;

        before(async function () {
            let accessControlFacet = await ethers.getContractAt("AccessControlFacet", diamondAddress);
            selectorsAccessControl = getSelectors(accessControlFacet);
        
            // Generate the signature
            registrationFacet = await ethers.getContractAt("RegistryFacet", diamondAddress);
            const hash = ethers.utils.solidityKeccak256(["address", "string", "uint256"], [ingester.address, message, nonce]);
            const signature = await controller.signMessage(ethers.utils.arrayify(hash));
        
            // Register ingester
            await registrationFacet.registerIngester(ingester.address, controller.address, message, nonce, signature);
        });

        it("should add group manager functions", async () => {
            const GroupManagerFacet = await ethers.getContractFactory("GroupManagerFacet");
            const groupManagerFacet = await GroupManagerFacet.deploy();
            await groupManagerFacet.deployed();
            addresses.push(groupManagerFacet.address);
            const selectorsGroupManager = getSelectors(groupManagerFacet);

            // Remove AccessControlFacet selectors from GroupManagerFacet selectors
            const selectorsGroupManagerAdd = selectorsGroupManager.filter(
                (selector: any) => !selectorsAccessControl.includes(selector)
            );
         
            tx = await diamondCutFacet.diamondCut(
            [
                {
                facetAddress: groupManagerFacet.address,
                action: FacetCutAction.Add,
                functionSelectors: selectorsGroupManagerAdd,
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
            result = await diamondLoupeFacet.facetFunctionSelectors(groupManagerFacet.address);
            assert.sameMembers(result, selectorsGroupManagerAdd);
        });

        it("should add have initialized group manager constants correctly", async () => {
            let groupManagerFacet = await ethers.getContractAt("GroupManagerFacet", diamondAddress);
            let maxClusterSizeRes = await groupManagerFacet.getMaxClusterSize();
            let maxGroupsPerIngesterRes = await groupManagerFacet.getMaxGroupsPerIngester();
            let maxIngestersPerGroupRes = await groupManagerFacet.getMaxIngestersPerGroup();

            expect(maxClusterSize == BigNumber.from(maxClusterSizeRes).toNumber());
            expect(maxGroupsPerIngester == BigNumber.from(maxGroupsPerIngesterRes).toNumber());
            expect(maxIngestersPerGroup == BigNumber.from(maxIngestersPerGroupRes).toNumber());
        });

        it("should add group to ingester and cluster", async () => {
            let groupToAdd = 'group1';
            let groupManagerFacet = await ethers.getContractAt("GroupManagerFacet", diamondAddress);
            let tx = await groupManagerFacet.addGroup(groupToAdd);
            let txGroup = await tx.wait();

            expect(txGroup).to.emit(diamondAddress, "AddGroup")
                .withArgs(groupToAdd)
                .and.to.emit(diamondAddress, "GroupDistributed")
                .withArgs(0, groupToAdd);

            let group = await groupManagerFacet.getGroup(groupToAdd);

            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses).to.include(ingester.address);
            expect(BigNumber.from(group.clusterId).toNumber() == 0);
        });

        it("should remove group from ingester", async () => {
            let groupToRemove = 'group1';
            let groupManagerFacet = await ethers.getContractAt("GroupManagerFacet", diamondAddress);
            let tx = await groupManagerFacet.removeGroup(groupToRemove);
            let txGroup = await tx.wait();

            expect(txGroup).to.emit(diamondAddress, "RemoveGroup").withArgs(groupToRemove);

            let group = await groupManagerFacet.getGroup(groupToRemove);

            expect(group.isAdded).to.be.false;
        });
    });
});
  