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

  beforeEach(async function () {
    [owner, admin, user1, user2] = await ethers.getSigners();

    const ingesterRegistryFactory = await ethers.getContractFactory("IngesterRegistry", owner);
    contract = await ingesterRegistryFactory.deploy();
    await contract.deployed();

  });

  describe("addGroup", function () {
    it("should add a new group", async function () {
      const groupName = "test-group";

      await expect(contract.addGroup(groupName))
        .to.emit(contract, "GroupAdded")
        .withArgs(groupName);

      const isAdded = await contract._groups(groupName);
      expect(isAdded).to.be.true;
    });

    it("should revert when adding an existing group", async function () {
      const groupName = "test-group";

      await contract.addGroup(groupName);

      await expect(contract.addGroup(groupName)).to.be.revertedWith("Group already exists.");

      const isAdded = await contract._groups(groupName);
      expect(isAdded).to.be.true;
    });
  });

  describe("removeGroup", function () {
    it("should remove an existing group", async function () {
      const groupName = "test-group";

      await contract.addGroup(groupName);

      await expect(contract.removeGroup(groupName))
        .to.emit(contract, "GroupRemoved")
        .withArgs(groupName);
    
      const isAdded = await contract._groups(groupName);
      expect(isAdded).to.be.false;
    });

    it("should revert when removing a non-existing group", async function () {
      const groupName = "test-group";

      await expect(contract.removeGroup(groupName)).to.be.revertedWith("Group does not exist.");

      const isAdded = await contract._groups(groupName);
      expect(isAdded).to.be.false;
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
        console.log("🚀 ~ file: IngestorRegistry.ts:129 ~ user1:", user1)
        const walletAddress = user1.address;
        const nodeIngestor = user2;
        const nodeIngestorAddress = user2.address;

        const message = 'hello';
        const nonce = 123;

        let hash = await contract._hash(nodeIngestorAddress, message, nonce);

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

        let hash = await contract._hash(nodeIngestorAddress, message, nonce);

        const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);

        expect(contract.registerIngestor(nodeIngestorAddress, incorrectMessage, nonce, sig)).to.be.revertedWith("Claim: Invalid signature.");
    });
   
  });

    
});