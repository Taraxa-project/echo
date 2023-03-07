import { ethers } from "hardhat";
import { expect } from "chai";
import { BigNumber } from "ethers";

import { IngesterRegistry } from "../typechain-types/contracts/IngesterRegistry";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

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

    it("should allocate admin role to contract creater", async function () {
        const DEFAULT_ADMIN_ROLE = await contract.DEFAULT_ADMIN_ROLE();

        const adminCount = await contract.getRoleMemberCount(DEFAULT_ADMIN_ROLE);
        const adminCountNum =  BigNumber.from(adminCount).toNumber()
        const adminMember = [];
        for (let i = 0; i < adminCountNum; ++i) {
            adminMember.push(await contract.getRoleMember(DEFAULT_ADMIN_ROLE, i));
        }
       
        expect(adminMember[0] == owner.address);
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

    it("should create an ingester role when registering", async function () {
        //Register an ingester
        const walletController = user1;
        const walletAddress = user1.address;
        const nodeIngestor = user2;
        const nodeIngestorAddress = user2.address;

        let hash = await contract._hash(walletAddress, message, nonce);

        const sig = await nodeIngestor.signMessage(ethers.utils.arrayify(hash));

        await contract.connect(walletController).registerIngestor(nodeIngestorAddress, message, nonce, sig);
        
        //Fetch Ingester Role addresses
        const INGESTER_ROLE = await contract.INGESTER_ROLE();
        const ingesterCount = await contract.getRoleMemberCount(INGESTER_ROLE);
        const ingesterCountNum =  BigNumber.from(ingesterCount).toNumber()
        const memberIngesters = [];
        for (let i = 0; i < ingesterCountNum; ++i) {
            memberIngesters.push(await contract.getRoleMember(INGESTER_ROLE, i));
        }
        expect(walletAddress == memberIngesters[0]);
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
 
        expect(await contract.connect(walletAddress1).getIngesterGroups()).to.emit(contract, "IngestorRegisteredGroups");
        let ingesterResponse = await contract.getIngester(nodeIngestor1.address);
        let assignedGroupsIngester = ingesterResponse['assignedGroups'];

        expect(assignedGroupsIngester.length == 2);
    });
  
    it("should assign different groups to different ingesters", async function () {
        // get groups for ingester1
        await contract.connect(walletAddress1).getIngesterGroups();
        let ingesterResponse = await contract.getIngester(nodeIngestor1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(walletAddress2).getIngesterGroups();
        let ingesterResponse2 = await contract.getIngester(nodeIngestor2.address);
        let assignedGroupsIngester2 = ingesterResponse2['assignedGroups'];
        
        //check if there is no duplicates between the two responses
        const uniqueGroups = assignedGroupsIngester1.filter(item => assignedGroupsIngester2.includes(item));
        expect(assignedGroupsIngester1.length == 2);
        expect(assignedGroupsIngester2.length == 2);
        expect(uniqueGroups.length == 0);
    });
  
    it("should not assign a group to an unregistered ingester", async function () {
      expect(contract.connect(user1).getIngesterGroups()).to.be.revertedWith("Ingester is not registered");
    });
  
    it("should not assign a group to an ingester not owned by the caller", async function () {
      expect(contract.connect(nodeIngestor1).getIngesterGroups()).to.be.revertedWith("Only registered ingester controller can perform this action.");
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
                expect(contract.connect(walletAddress).getIngesterGroups()).to.be.revertedWith('All groups have been assigned.');
                break;
            } else {
                expect(contract.connect(walletAddress).getIngesterGroups()).to.emit(contract, "IngestorRegisteredGroups");
            }
        }
    });
  });

  describe('Add IPFS Hashes', function () {
    let ingesterRegistry;
    let walletAddress1: SignerWithAddress;
    let nodeIngestor1: SignerWithAddress;
    let walletAddress2: SignerWithAddress;
    let nodeIngestor2: SignerWithAddress;
    let usersHash: string;
    let chatsHash: string;
    let messagesHash: string;
  
    beforeEach(async function () {
        
        [owner, admin, walletAddress1, nodeIngestor1, walletAddress2, nodeIngestor2] = await ethers.getSigners();
        
        //Verify ingester1
        let hash = await contract._hash(walletAddress1.address, message, nonce);
        const sig = await nodeIngestor1.signMessage(ethers.utils.arrayify(hash));
        await contract.connect(walletAddress1).registerIngestor(nodeIngestor1.address, message, nonce, sig);

        //Verify ingester2
        let hash2 = await contract._hash(walletAddress2.address, message, nonce);
        const sig2 = await nodeIngestor2.signMessage(ethers.utils.arrayify(hash2));
        await contract.connect(walletAddress2).registerIngestor(nodeIngestor2.address, message, nonce, sig2);

        usersHash = 'QmXx6gTFHa6mudUhKjFkNVak1q8exg68oMsCmzePJX9fKu';
        chatsHash = 'QmS7V1ASYYkKj7V4d4QF4JZ9XKj5L5PY5pCVS5GPy7fQQn';
        messagesHash = 'QmQe4R6UjQ6TDMDVbBopabKK46PGjKMYpHJ3qf8WdYY6gC';
    });
  
    it('should revert if called by an unregistered controller', async function () {
        
        expect(
            contract.connect(nodeIngestor1).addIpfsHash(
                usersHash,
                chatsHash,
                messagesHash
            )
        ).to.be.revertedWith('Only registered ingester controller can perform this action.');
    });

    it('should add the IPFS hashes to the registry and emit events', async function () {
        const txAddIpfsHash = await contract.connect(walletAddress1).addIpfsHash(
            usersHash,
            chatsHash,
            messagesHash
        );
        
        const ipfsHashes = await contract.getIpfsHashes(nodeIngestor1.address);
        //Check storage values through ipfsHash getter
        expect(ipfsHashes.length).to.equal(3);
        expect(ipfsHashes[0].ipfsHash).to.equal(usersHash);
        expect(ipfsHashes[0].typeOfHash).to.equal(0); // TYPE.USERS
        expect(ipfsHashes[1].ipfsHash).to.equal(chatsHash);
        expect(ipfsHashes[1].typeOfHash).to.equal(1); // TYPE.CHATS
        expect(ipfsHashes[2].ipfsHash).to.equal(messagesHash);
        expect(ipfsHashes[2].typeOfHash).to.equal(2); // TYPE.MESSAGES
    });

    it('should emit events when add the IPFS hashes to the registry ', async function () {
        const txAddIpfsHash = await contract.connect(walletAddress1).addIpfsHash(
            usersHash,
            chatsHash,
            messagesHash
        );
        
        //Check for emitted events
        expect(txAddIpfsHash).to.emit(contract, "IpfsHashAdded").withArgs(nodeIngestor1.address, usersHash, 0);
        expect(txAddIpfsHash).to.emit(contract, "IpfsHashAdded").withArgs(nodeIngestor1.address, chatsHash, 1);
        expect(txAddIpfsHash).to.emit(contract, "IpfsHashAdded").withArgs(nodeIngestor1.address, messagesHash, 2);
    });
  });

});