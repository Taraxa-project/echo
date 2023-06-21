import {
    DiamondCutFacet,
    DiamondLoupeFacet,
    GroupManagerFacet,
    OwnershipFacet,
    RegistryFacet,
    } from "../typechain-types";
import { deployDiamondTest, maxClusterSize, maxIngestersPerGroup } from "../scripts/deployDiamondTest";

import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { assert, expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

import {IngesterControllerMapping,
    allUnique,
    addFacetsToDiamond,
 } from "./testUtils/testUtils";



describe("Stress Testing Contract", async function () {
    //Diamond related storage
    let diamondCutFacet: DiamondCutFacet;
    let diamondLoupeFacet: DiamondLoupeFacet;
    let ownershipFacet: OwnershipFacet;
    let addresses: string[] = [];
    let diamondAddress: string;
    let registryFacet: RegistryFacet;
    let groupManagerFacet: GroupManagerFacet;

    //accounts
    let contractOwner: SignerWithAddress;
    let accounts: SignerWithAddress[];
    let ingesters: SignerWithAddress[];
    
    //testing storage variables
    let ingesterToController: IngesterControllerMapping = {}
    
    //constants
    const message = "Test message";
    const nonce = 1;
    const maxClusterSize = 500;
    const maxIngestersPerGroup = 1;
    
    let numIngesters: number = 10;
    const maxAllocatableGroups: number = numIngesters * maxClusterSize;
    console.log("🚀 ~ file: groupManagerFacetTest.ts:59 ~ maxAllocatableGroups:", maxAllocatableGroups)
    const verbose = false;

    beforeEach(async function () {
        accounts = await ethers.getSigners();

        const diamonDeployed = await deployDiamondTest(false, maxClusterSize, maxIngestersPerGroup);
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
        let sharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
        addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets);

        registryFacet = await ethers.getContractAt('RegistryFacet', diamondAddress);
        groupManagerFacet = await ethers.getContractAt('GroupManagerFacet', diamondAddress);

        ingesters = [];
    });

    it("should add large amount of ingesters and groups without any gas tx failures - without replication", async () => {
        for (let i = 0; i < maxAllocatableGroups ; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }    
    
        ingesters = [];
        let ingestersAssignedGroups = []
        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
            let ingester = await registryFacet.getIngesterWithGroups(accounts[i].address);
            let cluster = await registryFacet.getCluster(BigNumber.from(ingester.clusterId).toNumber());
            expect(ingester.assignedGroups == cluster.groupUsernames);
            ingestersAssignedGroups.push(ingester.assignedGroups);
        }
    });


    it("should add large amount of ingesters and groups without any gas tx failures - with replication", async () => {
        await groupManagerFacet.setMaxIngestersPerGroup(3);
        
        for (let i = 0; i < maxAllocatableGroups / 3; i++) {
            await groupManagerFacet.connect(contractOwner).addGroup(`group${i}`);
            const group = await groupManagerFacet.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngestersPerGroup)
        }    
    
        ingesters = [];
        let ingestersAssignedGroups = []
        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await registryFacet.hash(accounts[i].address, message, nonce);
            const sig = await accounts[i-1].signMessage(ethers.utils.arrayify(hash));
            await registryFacet.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
            let ingester = await registryFacet.getIngesterWithGroups(accounts[i].address);
            let cluster = await registryFacet.getCluster(BigNumber.from(ingester.clusterId).toNumber());
            expect(ingester.assignedGroups == cluster.groupUsernames);
            ingestersAssignedGroups.push(ingester.assignedGroups);
        }
    });
});