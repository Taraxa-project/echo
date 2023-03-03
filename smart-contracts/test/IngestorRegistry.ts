import { ethers } from "hardhat";
import { Signer } from "ethers";
import { expect } from "chai";

import { IngesterRegistry } from "../typechain-types/contracts/IngesterRegistry";
// import ECDSA from '@openzeppelin/contracts/utils/cryptography';

describe("IngesterRegistry", function () {
  let owner: Signer;
  let admin: Signer;
  let user1: Signer;
  let user2: Signer;
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
        const walletAddress = await user1.getAddress();
        const nodeIngestor = user2;
        const nodeIngestorAddress = await user2.getAddress();

        const amount = 999;
        const message = 'hello';
        const nonce = 123;

        let hash: any = await contract._hash(walletAddress, amount, nonce);
        console.log("🚀 ~ file: IngestorRegistry.ts:104 ~ hash:", hash)

        const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));
        const signer = await contract.recover(hash, sig);

        console.log("🚀 ~ file: IngestorRegistry.ts:107 ~ signer:", signer)
        console.log('wallet address', walletAddress);
        console.log('node ingestor address', nodeIngestorAddress);

        expect(signer == nodeIngestorAddress).to.equal(true);


    });

   
    });

    
});