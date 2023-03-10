import { ethers } from 'hardhat';
import { Contract } from '@ethersproject/contracts';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from 'chai';
import { BigNumber } from 'ethers';

describe('IngesterRegistry', function () {
  let contract: Contract;
  let owner: SignerWithAddress;
  let ingester1: SignerWithAddress;
  let ingester2: SignerWithAddress;
  let ingester3: SignerWithAddress;
  let ingester4: SignerWithAddress;
  let ingester5: SignerWithAddress;
  let controller: SignerWithAddress;
  let controller2: SignerWithAddress;
  const message: string = 'hello';
  const nonce: number = 123;

  beforeEach(async function () {
    const maxGroupsPerIngester = 3;
    [owner, ingester1, ingester2, ingester3, ingester4, ingester5, controller, controller2] = await ethers.getSigners();
    const contractFactory = await ethers.getContractFactory('IngesterOrchestrator', owner);
    contract = await contractFactory.deploy(maxGroupsPerIngester);
    await contract.deployed();
  });

  describe("ownership", function () {
    it("should transfer ownership", async function () {
        const newOwner = ingester1.address;
        await expect(contract.transferOwnership(newOwner)).to.emit(contract, "OwnershipTransferred");

        expect(await contract.owner()).to.equal(newOwner);
    });

    it("should not allow non-admin to transfer ownership", async function () {
        const newOwner = ingester1.address;

        let currentOwner = await contract.owner();
        console.log("🚀 ~ file: IngesterRegistry.ts:40 ~ currentOwner:", currentOwner)
    
        await expect(contract.connect(ingester1).transferOwnership(newOwner)).to.be.revertedWith("Only admin can perform this action.");
    
        expect(await contract.owner()).to.equal(await owner.getAddress());
    });

    it("should allocate admin role to contract creater", async function () {
        const DEFAULT_ADMIN_ROLE = await contract.DEFAULT_ADMIN_ROLE();

        const adminCount = await contract.getRoleMemberCount(DEFAULT_ADMIN_ROLE);
        const adminCountNum =  BigNumber.from(adminCount).toNumber()
        const adminMember = await contract.getRoleMember(DEFAULT_ADMIN_ROLE, 0);
       
        expect(adminMember == owner.address);
    });
  });

  describe('addGroup', function () {
    it('should allow the admin to add a new group', async function () {
      const groupId = 1;
      const tx = await contract.addGroup(groupId);
      await tx.wait();

      const group = await contract.getGroup(groupId);
      expect(group.isAdded).to.be.true;
      expect(group.ingesterAddresses).to.be.an('array').that.is.empty;
    });

    it('should not allow a non-admin to add a new group', async function () {
      const groupId = 2;
      expect(contract.connect(ingester1).addGroup(groupId)).to.be.revertedWith('Only admin can perform this action.');

      const group = await contract.getGroup(groupId);
      console.log("🚀 ~ file: IngesterRegistry.ts:40 ~ group:", group)
      expect(group.isAdded).to.be.false;
      expect(group.ingesterAddresses).to.be.empty;
    });

    it('should not allow adding a group that already exists', async function () {
      const groupId = 1;
      await contract.addGroup(groupId);
      await expect(contract.addGroup(groupId)).to.be.revertedWith('Group already exists.');

      const group = await contract.getGroup(groupId);
      expect(group.isAdded).to.be.true;
      expect(group.ingesterAddresses).to.be.an('array').that.is.empty;
    });
  });

  describe("removeGroup", function () {
    const numGroups = 10;
    beforeEach(async function () {
        for (let i = 1; i < numGroups; i++) {
            const group = await contract.getGroup(i);
            await contract.connect(owner).addGroup(i);
        }
    });

    it("should remove an existing group", async function () {
      await contract.removeGroup(1);

      const group = await contract.getGroup(1);

      expect(group.isAdded).to.be.false;
      expect(group.ingesterAddresses.length).to.equal(0);
    });

    it("should not allow a group to be removed more than once", async function () {
      await contract.removeGroup(1);

      await expect(contract.removeGroup(1)).to.be.revertedWith(
        "Group does not exist."
      );
    });

    it("should emit a GroupRemoved event", async function () {
      expect(contract.removeGroup(1)).to.emit(contract, "GroupRemoved").withArgs(1);
    });

    it("should return the correct group when querying getGroup", async function () {
        const group = await contract.getGroup(1);
  
        expect(group.isAdded).to.be.true;
        expect(group.ingesterAddresses.length).to.equal(0);
      });
  });   
  
  describe("registerIngester", function () {

    

    it("should register a new ingester", async function () {
        const controller = ingester2;

        let hash = await contract._hash(ingester1.address, message, nonce);

        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);

        const signer = await contract.recover(ethHash, sig);

        expect(contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig))
        .to.emit(contract, "IngesterRegistered")
        .withArgs(ingester1.address, controller.address);

        expect(signer == ingester1.address).to.equal(true);

    });

    it("should fail registering a new ingester when sig is incorrect", async function () {
        const controller = ingester2;

        const incorrectMessage = 'bye';

        let hash = await contract._hash(ingester1.address, message, nonce);

        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);

        expect(contract.connect(controller).registerIngester(ingester1.address, incorrectMessage, nonce, sig)).to.be.revertedWith("Invalid signature.");
    });

    it("should create an ingester role when registering", async function () {
        //Register an ingester
        const controller = ingester2;
        console.log('starting test');
        
        let hash = await contract._hash(ingester1.address, message, nonce);
        
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        
        await contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig);
        //Fetch Ingester Role addresses
        const INGESTER_ROLE = await contract.INGESTER_ROLE();
        const ingesterCount = await contract.getRoleMemberCount(INGESTER_ROLE);
        const ingesterCountNum =  BigNumber.from(ingesterCount).toNumber()
        console.log("🚀 ~ file: IngesterRegistry.ts:177 ~ ingesterCountNum:", ingesterCountNum)
        const memberIngesters = [];
        for (let i = 0; i < ingesterCountNum; ++i) {
            memberIngesters.push(await contract.getRoleMember(INGESTER_ROLE, i));
        }
        expect(controller.address == memberIngesters[0]);
    });

    it("should fail when attempting to re-register the same ingester", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await contract._hash(ingester1.address, message, nonce);
        
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        
        await contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig);
        
        expect(contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig)).to.be.revertedWith("Ingestor already registered.");
    });

    it("should fail when attempting to re-register the same ingester with a different controller account", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await contract._hash(ingester1.address, message, nonce);
        
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        
        await contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig);
        
        expect(contract.connect(ingester3).registerIngester(ingester1.address, message, nonce, sig)).to.be.revertedWith("Ingestor already registered.");
    });

    it("should be able to register multiple ingester accounts under the same controller account", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await contract._hash(ingester1.address, message, nonce);
        
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        
        expect(contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig)).to.emit(contract, "IngesterRegistered")
        .withArgs(ingester1.address, controller.address);

        //register other ingester accounts under the same controller address
        expect(contract.connect(controller).registerIngester(ingester3.address, message, nonce, sig)).to.emit(contract, "IngesterRegistered")
        .withArgs(ingester3.address, controller.address);
        expect(contract.connect(controller).registerIngester(ingester4.address, message, nonce, sig)).to.emit(contract, "IngesterRegistered")
        .withArgs(ingester4.address, controller.address);
    });

    it("should be able to unregister ingester accounts after registering and renounce role", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await contract._hash(ingester1.address, message, nonce);
        
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        
        expect(contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig)).to.emit(contract, "IngesterRegistered")
        .withArgs(ingester1.address, controller.address);

        //register other ingester accounts under the same controller address
        expect(contract.connect(controller).unRegisterIngester(ingester1.address)).to.emit(contract, "IngesterUnRegistered")
            .withArgs(controller.address, ingester1.address);
        
        //Fetch Ingester Role addresses
        const INGESTER_ROLE = await contract.INGESTER_ROLE();
        const ingesterCount = await contract.getRoleMemberCount(INGESTER_ROLE);
        const ingesterCountNum =  BigNumber.from(ingesterCount).toNumber();
        expect(ingesterCountNum == 0);
    });
   
  });

  describe("get_ingester_groups", function () {
    const numGroups = 10;
    beforeEach(async function () {
        
        for (let i = 1; i < numGroups; i++) {
            await contract.connect(owner).addGroup(i);
        }
        //add some Groups to smart contract

        //Verify ingester1
        let hash = await contract._hash(ingester1.address, message, nonce);
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        const ethHash = await contract.getEthSignedMessageHash(hash);
        const signer = await contract.recover(ethHash, sig);
        await contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig);

        //Verify ingester2
        let hash2 = await contract._hash(ingester2.address, message, nonce);
        const sig2 = await ingester2.signMessage(ethers.utils.arrayify(hash2));
        const ethHash2 = await contract.getEthSignedMessageHash(hash2);
        const signer2 = await contract.recover(ethHash2, sig2);
        await contract.connect(controller).registerIngester(ingester2.address, message, nonce, sig2);

        //Verify ingester3
        let hash3 = await contract._hash(ingester3.address, message, nonce);
        const sig3 = await ingester3.signMessage(ethers.utils.arrayify(hash3));
        await contract.connect(controller2).registerIngester(ingester3.address, message, nonce, sig3);

        //Verify ingester4
        let hash4 = await contract._hash(ingester4.address, message, nonce);
        const sig4 = await ingester4.signMessage(ethers.utils.arrayify(hash4));
        await contract.connect(controller2).registerIngester(ingester4.address, message, nonce, sig4);

      });

    it("should assign a group(s) to a registered ingester and emit an event", async function () {
        expect(await contract.connect(controller).getIngesterGroups(ingester1.address, [1,2])).to.emit(contract, "IngesterRegisteredGroups").withArgs(ingester1.address, [1,2]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester = ingesterResponse['assignedGroups'];

        expect(assignedGroupsIngester.length == 2);
    });
  
    it("should assign different groups to different ingesters when assigning it different groups", async function () {
        // get groups for ingester1
        await contract.connect(controller).getIngesterGroups(ingester1.address, [1,2]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(controller).getIngesterGroups(ingester2.address, [3,4]);
        let ingesterResponse2 = await contract.getIngester(ingester2.address);
        let assignedGroupsIngester2 = ingesterResponse2['assignedGroups'];
        
        //check if there is no duplicates between the two responses
        const uniqueGroups = assignedGroupsIngester1.filter(item => assignedGroupsIngester2.includes(item));
        expect(assignedGroupsIngester1.length == 2);
        expect(assignedGroupsIngester2.length == 2);
        expect(uniqueGroups.length == 0);
    });

    it("should assign different groups to different ingesters when assigning the same groups", async function () {
        // get groups for ingester1
        await contract.connect(controller).getIngesterGroups(ingester1.address, [1,2]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(controller).getIngesterGroups(ingester2.address, [1,2]);
        let ingesterResponse2 = await contract.getIngester(ingester2.address);
        let assignedGroupsIngester2 = ingesterResponse2['assignedGroups'];
        assignedGroupsIngester1 = assignedGroupsIngester1.map((bn) => bn.toNumber());
        assignedGroupsIngester2 = assignedGroupsIngester2.map((bn) => {return bn.toNumber()})
        //check if there is no duplicates between the two responses
        const uniqueGroups = assignedGroupsIngester1.filter(item => assignedGroupsIngester2.includes(item));
        expect(assignedGroupsIngester1).include.members([1,2]);
        expect(assignedGroupsIngester2).include.members([1,2]);
    });

    it("should not exceed maxGroupPerIngester parameter when assigning the same groups to ingesters", async function () {
        // get groups for ingester1
        await contract.connect(controller).getIngesterGroups(ingester1.address, [1,2]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(controller).getIngesterGroups(ingester2.address, [1,2]);
        let ingesterResponse2 = await contract.getIngester(ingester2.address);
        let assignedGroupsIngester2 = ingesterResponse2['assignedGroups'];

        // get groups for ingester3
        await contract.connect(controller2).getIngesterGroups(ingester3.address, [1,2]);
        let ingesterResponse3 = await contract.getIngester(ingester3.address);
        let assignedGroupsIngester3 = ingesterResponse3['assignedGroups'];

        // get groups for ingester2
        expect(contract.connect(controller2).getIngesterGroups(ingester4.address, [1,2])).to.revertedWith("Could not assign group as it exceeded the max number of ingester per group: [1,2]");
        // let ingesterResponse4 = await contract.getIngester(ingester4.address);
        // let assignedGroupsIngester4 = ingesterResponse4['assignedGroups'];

        // assignedGroupsIngester1 = assignedGroupsIngester1.map((bn) => bn.toNumber());
        // assignedGroupsIngester2 = assignedGroupsIngester2.map((bn) => {return bn.toNumber()})
        // assignedGroupsIngester3 = assignedGroupsIngester3.map((bn) => {return bn.toNumber()})
        // assignedGroupsIngester4 = assignedGroupsIngester4.map((bn) => {return bn.toNumber()})

        // //check if there is no duplicates between the two responses
        // const uniqueGroups = assignedGroupsIngester1.filter(item => assignedGroupsIngester2.includes(item));
        // expect(assignedGroupsIngester1).include.members([1,2]);
        // expect(assignedGroupsIngester2).include.members([1,2]);
    });
  
    it("should not assign a group to an unregistered ingester", async function () {
      expect(contract.connect(ingester4).getIngesterGroups()).to.be.revertedWith("Ingester is not registered");
    });
  
    it("should not assign a group to an ingester not owned by the caller", async function () {
      expect(contract.connect(ingester4).getIngesterGroups()).to.be.revertedWith("Only registered ingester controller can perform this action.");
    });
  
 
  });

  describe('Add IPFS Hashes', function () {
    const usersHash = 'QmXx6gTFHa6mudUhKjFkNVak1q8exg68oMsCmzePJX9fKu';
    const chatsHash = 'QmS7V1ASYYkKj7V4d4QF4JZ9XKj5L5PY5pCVS5GPy7fQQn';
    const messagesHash = 'QmQe4R6UjQ6TDMDVbBopabKK46PGjKMYpHJ3qf8WdYY6gC';
  
    beforeEach(async function () {

        //Verify ingester1
        let hash = await contract._hash(ingester1.address, message, nonce);
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        await contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig);

        //Verify ingester2
        let hash2 = await contract._hash(ingester2.address, message, nonce);
        const sig2 = await ingester2.signMessage(ethers.utils.arrayify(hash2));
        await contract.connect(controller).registerIngester(ingester2.address, message, nonce, sig2);

        
    });
  
    it('should revert if called by an unregistered controller', async function () {
        
        expect(
            contract.connect(ingester1).addIpfsHash(
                ingester1.address,
                usersHash,
                chatsHash,
                messagesHash
            )
        ).to.be.revertedWith('Only registered ingester controller can perform this action.');
    });

    it('should add the IPFS hashes to the registry and emit events', async function () {
        const txAddIpfsHash = await contract.connect(controller).addIpfsHash(
            ingester1.address,
            usersHash,
            chatsHash,
            messagesHash
        );
        
        const ipfsHashes = await contract.getIpfsHashes(ingester1.address);
        //Check storage values through ipfsHash getter
        expect(ipfsHashes['usersIpfsHash']).to.equal(usersHash);
        expect(ipfsHashes['chatsIpfsHash']).to.equal(chatsHash);
        expect(ipfsHashes['messagesIpfsHash']).to.equal(messagesHash);
    });

    it('should emit events when add the IPFS hashes to the registry ', async function () {
        const txAddIpfsHash = await contract.connect(controller).addIpfsHash(
            ingester1.address,
            usersHash,
            chatsHash,
            messagesHash
        );
        
        //Check for emitted events
        expect(txAddIpfsHash).to.emit(contract, "IpfsHashAdded").withArgs(ingester1.address, usersHash, chatsHash, messagesHash);
    });
  });
  // Add more test cases for other functions as needed
});
