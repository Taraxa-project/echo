import { ethers } from "hardhat";
import { Signer } from "ethers";
import { expect } from "chai";

import { IngesterRegistry } from "../typechain-types/contracts/IngesterRegistry";

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
      console.log('added group ', groupName);
      const isAdded = await contract._groups(groupName);
      console.log("🚀 ~ file: IngestorRegistry.ts:52 ~ isAdded:", isAdded)

      await expect(contract.removeGroup(groupName))
        .to.emit(contract, "GroupRemoved")
        .withArgs(groupName);
    
      let groups2 = await contract._groups;
      console.log("🚀 ~ file: IngestorRegistry.ts:58 ~ groups:", groups2)
    //   const isAdded = await contract._groups(groupName);
    //   expect(isAdded).to.be.false;
    });

    it("should revert when removing a non-existing group", async function () {
      const groupName = "test-group";

      await expect(contract.removeGroup(groupName)).to.be.revertedWith("Group does not exist.");

      const isAdded = await contract._groups(groupName);
      expect(isAdded).to.be.false;
    });
  });

//   describe("registerIngestor", function () {
//     it("should register a new ingestor", async function () {
//         const walletAddress = await user1.getAddress();
//         const nodeIngestorAddress = await user2.getAddress();
//         const message = ethers.utils.solidityKeccak256(["address"], [nodeIngestorAddress]);
//         const signature = await user1.signMessage(ethers.utils.arrayify(message));

//         await expect(contract.registerIngestor(walletAddress, nodeIngestorAddress, signature))
//         .to.emit(contract, "IngestorRegistered")
//         .withArgs(walletAddress, nodeIngestorAddress);

//         const isRegistered = await contract._ingestors(nodeIngestorAddress);
//         expect(isRegistered).to.be.true;
//     });

//     it("should revert when the proof is invalid", async function () {
//         const walletAddress = await user1.getAddress();
//         const nodeIngestorAddress = await user2.getAddress();
//         const message = ethers.utils.solidityKeccak256(["address"], [nodeIngestorAddress]);
//         const invalidSignature = await user1.signMessage(ethers.utils.arrayify(message)) + "00"; // Add one byte to make the signature invalid
        
//         await expect(contract.registerIngestor(walletAddress, nodeIngestorAddress, invalidSignature))
//             .to.be.revertedWith("Invalid proof.");
        
//         const isRegistered = await contract._ingestors(nodeIngestorAddress);
//         expect(isRegistered).to.be.false;
//     });
      
//     it("should revert when the ingestor is already registered", async function () {
//         const walletAddress = await user1.getAddress();
//         const nodeIngestorAddress = await user2.getAddress();
//         const message = ethers.utils.solidityKeccak256(["address"], [nodeIngestorAddress]);
//         const signature = await user1.signMessage(ethers.utils.arrayify(message));
        
//         await contract.registerIngestor(walletAddress, nodeIngestorAddress, signature);
        
//         await expect(contract.registerIngestor(walletAddress, nodeIngestorAddress, signature))
//             .to.be.revertedWith("Ingestor is already registered.");
        
//         const isRegistered = await contract._ingestors(nodeIngestorAddress);
//         expect(isRegistered).to.be.true;
//     });
    
//     it("should revert when the wallet address doesn't match the proof", async function () {
//         const walletAddress = await user1.getAddress();
//         const nodeIngestorAddress = await user2.getAddress();
//         const message = ethers.utils.solidityKeccak256(["address"], [nodeIngestorAddress]);
//         const signature = await user2.signMessage(ethers.utils.arrayify(message));
        
//         await expect(contract.registerIngestor(walletAddress, nodeIngestorAddress, signature))
//             .to.be.revertedWith("Invalid proof.");
        
//         const isRegistered = await contract._ingestors(nodeIngestorAddress);
//         expect(isRegistered).to.be.false;
//     });
// });

    // describe("ownership", function () {
    //     it("should transfer ownership", async function () {
    //         const newOwner = await user1.getAddress();
    //         await expect(contract.transferOwnership(newOwner)).to.emit(contract, "OwnershipTransferred");

    //         expect(await contract.owner()).to.equal(newOwner);
    //     });
    
    //     it("should not allow non-admin to transfer ownership", async function () {
    //         const newOwner = await user1.getAddress();
        
    //         await expect(contract.connect(user1).transferOwnership(newOwner)).to.be.revertedWith("Only admin can perform this action.");
        
    //         expect(await contract.owner()).to.equal(await owner.getAddress());
    //     });
    // });
});