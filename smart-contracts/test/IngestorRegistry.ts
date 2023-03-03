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
      
        const groupList = await contract.listGroups();
        expect(groupList).to.be.an('array').that.includes(groupName2);
      });
  });

  describe("listGroups", function () {
    it("should return an array of group names", async function () {
        await contract.addGroup(groupName1);
        await contract.addGroup(groupName2);

        const groupList = await contract.listGroups();
        expect(groupList).to.be.an('array').that.includes(groupName1, groupName2);
    });

    it("should return an empty array if there are no groups", async function () {
        const groupList = await contract.listGroups();
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

        const message = 'hello';
        const nonce = 123;

        let hash = await contract._hash(walletAddress, message, nonce);

        const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);

        const signer = await contract.recover(ethHash, sig);

        expect(contract.registerIngestor(nodeIngestorAddress, message, nonce, sig))
        .to.emit(contract, "IngestorRegistered")
        .withArgs(walletAddress,nodeIngestorAddress);

        expect(signer == nodeIngestorAddress).to.equal(true);
    });

    it("should fail registering a new ingestor when sig is incorrect", async function () {
        const walletAddress = user1.address;
        const nodeIngestor = user2;
        const nodeIngestorAddress = user2.address;

        const message = 'hello';
        const incorrectMessage = 'bye';
        const nonce = 123;

        let hash = await contract._hash(walletAddress, message, nonce);

        const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);

        expect(contract.registerIngestor(nodeIngestorAddress, incorrectMessage, nonce, sig)).to.be.revertedWith("Claim: Invalid signature.");
    });
   
  });

  describe("get_ingester_groups", function () {
    let walletAddress1: SignerWithAddress;
    let nodeIngestor1: SignerWithAddress;
    let walletAddress2: SignerWithAddress;
    let nodeIngestor2: SignerWithAddress;

    before(async function () {
        
        [owner, admin, walletAddress1, nodeIngestor1, walletAddress2, nodeIngestor2] = await ethers.getSigners();
    
        const message = 'hello';
        const nonce = 123;
        
        //Verify ingester1
        let hash = await contract._hash(walletAddress1.address, message, nonce);
        const sig = await nodeIngestor1.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);
        await contract.registerIngestor(nodeIngestor1.address, message, nonce, sig);

        // //Verify ingester2
        // let hash2 = await contract._hash(walletAddress2.address, message, nonce);
        // const sig2 = await nodeIngestor2.signMessage(ethers.utils.arrayify(hash2));
        // const ethHash2 = await contract.getEthSignedMessageHash(sig2);
        // await contract.registerIngestor(nodeIngestor2.address, message, nonce, sig2);

    
      });

    it("should assign a group to a registered ingester", async function () {
      const groupsBefore = await contract.getIngesterGroups(nodeIngestor1.address);
  
      const groupsAfter = await contract.getIngesterGroups(nodeIngestor1.address);
      expect(groupsAfter.length).to.equal(groupsBefore.length + 1);
    });
  
    it("should assign different groups to different ingesters", async function () {
      const groups1 = await contract.getIngesterGroups(nodeIngestor1.address);
      const groups2 = await contract.getIngesterGroups(nodeIngestor2.address);
  
      expect(groups1.length).to.equal(1);
      expect(groups2.length).to.equal(1);
      expect(groups1[0]).to.not.equal(groups2[0]);
    });
  
    // it("should not assign a group to an unregistered ingester", async function () {
    //   const ingester = user1;
    //   const ingesterAddress = await ingester.getAddress();
  
    //   await expect(contract.getIngesterGroups(ingesterAddress)).to.be.revertedWith("Ingester is not registered");
    // });
  
    it("should not assign a group to an ingester not owned by the caller", async function () {
      await expect(contract.connect(nodeIngestor1).getIngesterGroups(nodeIngestor2.address)).to.be.revertedWith("Only ingester can perform this action.");
    });
  
    it("should not assign a group to an ingester that already has a group assigned", async function () {
      await contract.getIngesterGroups(nodeIngestor1.address);
  
      await expect(contract.getIngesterGroups(nodeIngestor1.address)).to.be.revertedWith("Ingester already has a group assigned");
    });
  });


    
});