/* global describe it before ethers */

import {
    getSelectors,
    FacetCutAction,
    removeSelectors,
    findAddressPositionInFacets,
    } from "../scripts/libraries/diamond";
import {
    Diamond,
    DiamondCutFacet,
    DiamondLoupeFacet,
    GroupManagerFacet,
    OwnershipFacet,
    RegistryFacet,
    } from "../typechain-types";
import { deployDiamond, maxClusterSize, maxGroupsPerIngester, maxIngestersPerGroup } from "../scripts/deploy";
import { IDiamondLoupe } from "../typechain-types/contracts/IngesterOrchestratorDiamond/facets/DiamondLoupeFacet";

import { ethers } from "hardhat";

import { BigNumber } from "ethers";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

interface IngesterControllerMapping {
    [ingesterAddress: string]: SignerWithAddress;
}

async function addFacetsToDiamond(addresses: string[], diamondCutFacet: DiamondCutFacet, diamondAddress: string, FacetNames: string[]) {
    let accessControlFacet = await ethers.getContractFactory("AccessControlFacet");
    let accessControlFacetSelectors = getSelectors(accessControlFacet);

    let commonFunctionsFacet = await ethers.getContractFactory("CommonFunctionsFacet");
    let commonFunctionSelectors = getSelectors(commonFunctionsFacet);
    FacetNames = [...FacetNames, "AccessControlFacet", "CommonFunctionsFacet"];
    const facetCuts = [];
    let selectorsAdded: any= [];
    for (const FacetName of FacetNames) {
        const Facet = await ethers.getContractFactory(FacetName);
        const facet = await Facet.deploy();
        await facet.deployed();
        addresses.push(facet.address);
        console.log(`${FacetName} deployed: ${facet.address}`);
        
        let selectorsToAdd = getSelectors(facet);
        if (FacetName != 'AccessControlFacet') {
            let accessControlFacetSelectors = getSelectors(accessControlFacet);
            console.log("🚀 ~ file: groupManagerFacetTest.ts:48 ~ addFacetsToDiamond ~ accessControlFacetSelectors:", accessControlFacetSelectors)

            //filter out AccessControlFacet since all other facets extend this
            selectorsToAdd = selectorsToAdd.filter(
                (selector: any) => !accessControlFacetSelectors.includes(selector)
                );
        }
        if (FacetName != 'CommonFunctionsFacet') {
            let commonFunctionSelectors = getSelectors(commonFunctionsFacet);
            console.log("🚀 ~ file: groupManagerFacetTest.ts:57 ~ addFacetsToDiamond ~ commonFunctionSelectors:", commonFunctionSelectors)

            // filter out Common Functions Facet since all other facets extend this
            selectorsToAdd = selectorsToAdd.filter(
                (selector: any) => !commonFunctionSelectors.includes(selector)
                );
        }
        console.log("Facet address:", facet.address);
        console.log("FacetCutAction.Add:", FacetCutAction.Add);
        console.log("Selectors to add:", selectorsToAdd);
        selectorsAdded = [...selectorsAdded, selectorsToAdd];
        facetCuts.push({
            facetAddress: facet.address,
            action: FacetCutAction.Add,
            functionSelectors: selectorsToAdd,
        });
    }
    // '0xc9926a9e'
    console.log('length of sleectors added', selectorsAdded.length);
    console.log("🚀 ~ file: groupManagerFacetTest.ts:69 ~ addFacetsToDiamond ~ selectorsAdded:", selectorsAdded)

    let txDiamond = await diamondCutFacet.diamondCut(
        facetCuts,
        ethers.constants.AddressZero,
        "0x",
        { gasLimit: 800000 }
    );
    let receiptTx = await txDiamond.wait();
    if (!receiptTx.status) {
        throw Error(`Diamond upgrade failed: ${txDiamond.hash}`);
    }

    return addresses;
}


describe("Testing Group Manager", async function () {
    let diamondCutFacet: DiamondCutFacet;
    let diamondLoupeFacet: DiamondLoupeFacet;
    let ownershipFacet: OwnershipFacet;
    let addresses: string[] = [];
    let diamondAddress: string;
    let registryFacet: RegistryFacet;
    let groupManagerFacet: GroupManagerFacet;

    let contractOwner: SignerWithAddress;
    let accounts: SignerWithAddress[];
    let controller: SignerWithAddress;
    let controller2: SignerWithAddress;
    let ingester: SignerWithAddress;
    let ingester2: SignerWithAddress;
    let ingester3: SignerWithAddress;

    let ingesters: SignerWithAddress[];
    let ingesterToController: IngesterControllerMapping = {}
    let removedIngesterAssignedGroups: string[];
    const message = "Test message";
    const nonce = 1;
    let registrationTx: any;
    const maxAllocatableGroups: number = maxClusterSize * maxGroupsPerIngester;
    let numIngesters: number = 3;

    before(async function () {
        accounts = await ethers.getSigners();

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
        
        for (const address of await diamondLoupeFacet.facetAddresses()) {
          addresses.push(address);
        }

        let facetNames = ['RegistryFacet', 'GroupManagerFacet'];
        addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames);

        registryFacet = await ethers.getContractAt('RegistryFacet', diamondAddress);
        groupManagerFacet = await ethers.getContractAt('GroupManagerFacet', diamondAddress);

        ingesters = [];

        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }

        // console.log("🚀 ~ file: registryFacetTest.ts:326 ~ maxAllocatableGroups:", maxAllocatableGroups)
        // for (let i = 0; i < maxAllocatableGroups; i++ ) {
        //     await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
        //     const group = await groupManagerFacet.getGroup(`group${i}`);
        //     expect(group.isAdded).to.be.true;
        //     expect(group.ingesterAddresses.length <= maxGroupsPerIngester)
        // }
    });
        
    it("should set maxNumberIngesterPerGroup correctly with deployment", async () => {
        const maxIngesterPerGroupRes = await groupManagerFacet.getMaxIngestersPerGroup();
        expect(maxIngesterPerGroupRes).to.equal(maxIngestersPerGroup);
    });
    
    // it("should set maxNumberIngesterPerGroup", async () => {
    //     expect(await groupManagerFacet.connect(contractOwner).setMaxIngestersPerGroup(10)).to.emit(groupManagerFacet, "SetNewMaxIngesterPerGroup");
    //     let newMaxNumberIngesterPerGroup = BigNumber.from(await groupManagerFacet.getMaxIngestersPerGroup()).toNumber();
    //     expect(newMaxNumberIngesterPerGroup).to.equal(10);
    // });
});

