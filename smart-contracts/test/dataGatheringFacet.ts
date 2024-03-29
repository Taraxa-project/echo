
import { ethers } from "hardhat";

import { expect } from "chai";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

import {
    addFacetsToDiamond,
 } from "./testUtils/testUtils";

 import {
    DiamondCutFacet,
    DiamondLoupeFacet,
    OwnershipFacet,
    RegistryFacet,
    DataGatheringFacet
    } from "../typechain-types";
import { deployDiamondTest} from "../scripts/deployDiamondTest";

const maxClusterSize = 300;
const maxIngestersPerGroup = 1;

describe('Add IPFS Hashes', function () {
    //Diamond related storage
    let diamondCutFacet: DiamondCutFacet;
    let addresses: string[] = [];
    let diamondAddress: string;
    let registryFacet: RegistryFacet;
    let dataGatheringFacet: DataGatheringFacet;
    //accounts
    let contractOwner: SignerWithAddress;
    let accounts: SignerWithAddress[];
    let ingester: SignerWithAddress;
    let controller: SignerWithAddress;
    
    //constants
    const message = "Test message";
    const nonce = 1;
    let numIngesters: number = 3;
    const verbose = false;
    const usersHash = 'QmXx6gTFHa6mudUhKjFkNVak1q8exg68oMsCmzePJX9fKu';
    const chatsHash = 'QmS7V1ASYYkKj7V4d4QF4JZ9XKj5L5PY5pCVS5GPy7fQQn';
    const messagesHash = 'QmQe4R6UjQ6TDMDVbBopabKK46PGjKMYpHJ3qf8WdYY6gC';
    
    beforeEach(async function () {

        accounts = await ethers.getSigners();
        controller = accounts[0];
        ingester = accounts[1];

        const diamonDeployed = await deployDiamondTest(verbose, maxClusterSize, maxIngestersPerGroup);
        diamondAddress = diamonDeployed.diamondAddress;
        contractOwner = diamonDeployed.contractOwner;

        diamondCutFacet = await ethers.getContractAt(
            "DiamondCutFacet",
            diamondAddress
        );
        
        let facetNames = ['RegistryFacet', 'DataGatheringFacet'];
        let sharedFacets = ["AccessControlFacet", "CommonFunctionsFacet"];
        addresses = await addFacetsToDiamond(addresses, diamondCutFacet, diamondAddress, facetNames, sharedFacets);

        registryFacet = await ethers.getContractAt('RegistryFacet', diamondAddress);
        dataGatheringFacet = await ethers.getContractAt('DataGatheringFacet', diamondAddress);

        //Verify ingester1
        let hash = await registryFacet.hash(ingester.address, message, nonce);
        const sig = await controller.signMessage(ethers.utils.arrayify(hash));
        await registryFacet.connect(controller).registerIngester(ingester.address, message, nonce, sig);

    });
    
    it('should revert if called controller instead of ingester address', async function () {
        expect(
            dataGatheringFacet.connect(controller).addIpfsHash(
                usersHash,
                chatsHash,
                messagesHash
            )
        ).to.be.revertedWith("LibAppStorage: Not a registered ingester");
    });

    it('should revert if trying to add ipfs hashes with unregistered ingester', async function () {
        expect(
            dataGatheringFacet.connect(accounts[accounts.length - 1 ]).addIpfsHash(
                usersHash,
                chatsHash,
                messagesHash
            )
        ).to.be.revertedWith("LibAppStorage: Not a registered ingester");
    });

    it('should add the IPFS hashes to the registry and emit events', async function () {
        const txAddIpfsHash = await dataGatheringFacet.connect(ingester).addIpfsHash(
            usersHash,
            chatsHash,
            messagesHash
        );
        
        const ipfsHashes = await dataGatheringFacet.getIpfsHashes(ingester.address);
        //Check storage values through ipfsHash getter
        expect(ipfsHashes['usersIpfsHash']).to.equal(usersHash);
        expect(ipfsHashes['chatsIpfsHash']).to.equal(chatsHash);
        expect(ipfsHashes['messagesIpfsHash']).to.equal(messagesHash);
    });

    it('should emit events when add the IPFS hashes to the registry ', async function () {
        const txAddIpfsHash = await dataGatheringFacet.connect(ingester).addIpfsHash(
            usersHash,
            chatsHash,
            messagesHash
        );
        
        //Check for emitted events
        expect(txAddIpfsHash).to.emit(dataGatheringFacet, "IpfsHashAdded").withArgs(ingester.address, usersHash, chatsHash, messagesHash);
    });
});