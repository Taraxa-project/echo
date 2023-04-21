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
    OwnershipFacet,
    RegistryFacet,
    Test1Facet,
    } from "../typechain-types";
import { deployDiamond } from "../scripts/deploy";
import { IDiamondLoupe } from "../typechain-types/contracts/IngesterOrchestratorDiamond/facets/DiamondLoupeFacet";

import { ethers } from "hardhat";

import { ContractReceipt } from "ethers";
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
    });
});
  