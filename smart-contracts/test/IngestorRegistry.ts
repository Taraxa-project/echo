import { ethers } from "hardhat";
import { Signer } from "ethers";
import { expect } from "chai";

import { IngesterRegistry } from "../typechain-types/contracts/IngesterRegistry";
// import { ECDSA } from '@openzeppelin/contracts/utils/cryptography';
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import * as abi from 'ethereumjs-abi';
import * as ethUtil from 'ethereumjs-util';

describe("IngesterRegistry", function () {
  let owner: SignerWithAddress;
  let admin: SignerWithAddress;
  let user1: SignerWithAddress;
  let user2: SignerWithAddress;
  let contract: IngesterRegistry;
  const groupName1 = "test-group-1";
  const groupName2 = "test-group-2";
  const groupName3 = "test-group-3";
  const groupName4 = "test-group-4";
  const groupName5 = "test-group-5";
  const message: string = 'hello';
  const nonce: number = 123;

  beforeEach(async function () {
    [owner, admin, user1, user2] = await ethers.getSigners();

    const ingesterRegistryFactory = await ethers.getContractFactory("IngesterRegistry", owner);
    contract = await ingesterRegistryFactory.deploy();
    await contract.deployed();

  });

  describe("addGroup", function () {
    it("should add a new group", async function () {
      await expect(contract.addGroup(groupName1))
        .to.emit(contract, "GroupAdded")
        .withArgs(groupName1);

      const isAdded = await contract._groups(groupName1);
      expect(isAdded).to.be.true;
    });

    it("should revert when adding an existing group", async function () {
      await contract.addGroup(groupName1);

      await expect(contract.addGroup(groupName1)).to.be.revertedWith("Group already exists.");

      const isAdded = await contract._groups(groupName1);
      expect(isAdded).to.be.true;
    });
  });

  describe("removeGroup", function () {
    it("should remove an existing group", async function () {
      await contract.addGroup(groupName1);
      const isAdded1 = await contract._groups(groupName1);

      await expect(contract.removeGroup(groupName1))
        .to.emit(contract, "GroupRemoved")
        .withArgs(groupName1);
    
      const isAdded = await contract._groups(groupName1);
      expect(isAdded).to.be.false;
    });

    it("should revert when removing a non-existing group", async function () {
      await expect(contract.removeGroup(groupName1)).to.be.revertedWith("Group does not exist.");

      const isAdded = await contract._groups(groupName1);
      expect(isAdded).to.be.false;
    });

    it("should remove group from list of groups when removing an existing group", async function () {
        await contract.addGroup(groupName1);
        await contract.addGroup(groupName2);

        
        await expect(contract.removeGroup(groupName1))
          .to.emit(contract, "GroupRemoved")
          .withArgs(groupName1);
      
        const groupList = await contract.getGroups();
        expect(groupList).to.be.an('array').that.includes(groupName2);
      });
  });

  describe("getGroups", function () {
    it("should return an array of group names", async function () {
        await contract.addGroup(groupName1);
        await contract.addGroup(groupName2);

        const groupList = await contract.getGroups();
        expect(groupList).to.be.an('array').that.includes(groupName1, groupName2);
    });

    it("should return an empty array if there are no groups", async function () {
        const groupList = await contract.getGroups();
        expect(groupList).to.be.an('array').that.is.empty;
    });
  });

  describe("ownership", function () {
    it("should transfer ownership", async function () {
        const newOwner = await user1.getAddress();
        await expect(contract.transferOwnership(newOwner)).to.emit(contract, "OwnershipTransferred");

        expect(await contract.owner()).to.equal(newOwner);
    });

    it("should not allow non-admin to transfer ownership", async function () {
        const newOwner = await user1.getAddress();
    
        await expect(contract.connect(user1).transferOwnership(newOwner)).to.be.revertedWith("Only admin can perform this action.");
    
        expect(await contract.owner()).to.equal(await owner.getAddress());
    });
  });

  describe("registerIngestor", function () {
    it("should register a new ingestor", async function () {
        const walletAddress = user1.address;
        const nodeIngestor = user2;
        const nodeIngestorAddress = user2.address;

        let hash = await contract._hash(walletAddress, message, nonce);

        const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);

        const signer = await contract.recover(ethHash, sig);

        expect(contract.connect(nodeIngestor).registerIngestor(nodeIngestorAddress, message, nonce, sig))
        .to.emit(contract, "IngestorRegistered")
        .withArgs(nodeIngestorAddress, walletAddress);

        expect(signer == nodeIngestorAddress).to.equal(true);

    });

    it("should fail registering a new ingestor when sig is incorrect", async function () {
        const walletAddress = user1.address;
        const nodeIngestor = user2;
        const nodeIngestorAddress = user2.address;

        const incorrectMessage = 'bye';

        let hash = await contract._hash(walletAddress, message, nonce);

        const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);

        expect(contract.connect(nodeIngestor).registerIngestor(nodeIngestorAddress, incorrectMessage, nonce, sig)).to.be.revertedWith("Claim: Invalid signature.");
    });
   
  });

  describe("get_ingester_groups", function () {
    let walletAddress1: SignerWithAddress;
    let nodeIngestor1: SignerWithAddress;
    let walletAddress2: SignerWithAddress;
    let nodeIngestor2: SignerWithAddress;


    beforeEach(async function () {
        
        [owner, admin, walletAddress1, nodeIngestor1, walletAddress2, nodeIngestor2] = await ethers.getSigners();
        
        //add some Groups to smart contract
        await contract.addGroup(groupName1);
        await contract.addGroup(groupName2);
        await contract.addGroup(groupName3);
        await contract.addGroup(groupName4);
        await contract.addGroup(groupName5);

        //Verify ingester1
        let hash = await contract._hash(walletAddress1.address, message, nonce);
        const sig = await nodeIngestor1.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);
        const signer = await contract.recover(ethHash, sig);
        await contract.connect(walletAddress1).registerIngestor(nodeIngestor1.address, message, nonce, sig);

        //Verify ingester2
        let hash2 = await contract._hash(walletAddress2.address, message, nonce);
        const sig2 = await nodeIngestor2.signMessage(ethers.utils.arrayify(hash2));
        const ethHash2 = await contract.getEthSignedMessageHash(hash2);
        const signer2 = await contract.recover(ethHash2, sig2);

        await contract.connect(walletAddress2).registerIngestor(nodeIngestor2.address, message, nonce, sig2);

      });

    it("should assign a group(s) to a registered ingester and emit an event", async function () {
 
        expect(await contract.connect(walletAddress1).getIngesterGroups(nodeIngestor1.address)).to.emit(contract, "IngestorRegisteredGroups");
        let ingesterResponse = await contract.getIngester(nodeIngestor1.address);
        let assignedGroupsIngester = ingesterResponse['assignedGroups'];

        expect(assignedGroupsIngester.length == 2);
    });
  
    it("should assign different groups to different ingesters", async function () {
        // get groups for ingester1
        await contract.connect(walletAddress1).getIngesterGroups(nodeIngestor1.address);
        let ingesterResponse = await contract.getIngester(nodeIngestor1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(walletAddress2).getIngesterGroups(nodeIngestor2.address);
        let ingesterResponse2 = await contract.getIngester(nodeIngestor2.address);
        let assignedGroupsIngester2 = ingesterResponse2['assignedGroups'];
        
        //check if there is no duplicates between the two responses
        const uniqueGroups = assignedGroupsIngester1.filter(item => assignedGroupsIngester2.includes(item));
        expect(assignedGroupsIngester1.length == 2);
        expect(assignedGroupsIngester2.length == 2);
        expect(uniqueGroups.length == 0);
    });
  
    it("should not assign a group to an unregistered ingester", async function () {
      expect(contract.connect(user1).getIngesterGroups(user2.address)).to.be.revertedWith("Ingester is not registered");
    });
  
    it("should not assign a group to an ingester not owned by the caller", async function () {
      expect(contract.connect(nodeIngestor1).getIngesterGroups(nodeIngestor2.address)).to.be.revertedWith("Only registered ingester controller can perform this action.");
    });
  
    it("should revert if all groups have been assigned", async function () {
        let accounts = await ethers.getSigners();

        for (let i = accounts.length - 1; i > 5; i--){
            let walletAddress = accounts[i];
            let nodeIngestor = accounts[i-1];
            let hash = await contract._hash(walletAddress.address, message, nonce);
            const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));
            await contract.connect(walletAddress).registerIngestor(nodeIngestor.address, message, nonce, sig);
            let unassignedGroups = await contract.getUnassignedGroups();
            
            // Check for when unassignedGroups is empty for revert
            if (unassignedGroups.length == 0) {
                expect(contract.connect(walletAddress).getIngesterGroups(nodeIngestor.address)).to.be.revertedWith('All groups have been assigned.');
                break;
            } else {
                expect(contract.connect(walletAddress).getIngesterGroups(nodeIngestor.address)).to.emit(contract, "IngestorRegisteredGroups");
            }
        }
    });
  });
});