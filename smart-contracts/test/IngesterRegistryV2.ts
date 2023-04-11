import { ethers } from "hardhat";
import { Signer, Contract } from "ethers";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from "chai";
import { BigNumber } from 'ethers';


interface IngesterControllerMapping {
    [ingesterAddress: string]: SignerWithAddress;
  }

type GroupComparisonResult = {
matchingGroups: string[];
nonMatchingGroups: string[];
};
  
function compareGroups(
ingesterRemovedAssignedGroups: string[],
totalAssignedGroups: string[]
): GroupComparisonResult {
const matchingGroups: string[] = [];
const nonMatchingGroups: string[] = [];

for (const group of ingesterRemovedAssignedGroups) {
    if (totalAssignedGroups.includes(group)) {
    matchingGroups.push(group);
    } else {
    nonMatchingGroups.push(group);
    }
}

return {
    matchingGroups,
    nonMatchingGroups,
};
}

describe("IngesterOrchestratorV2", () => {
  let accounts: Signer[];
  let ingesterOrchestrator: Contract;
  let contract: Contract;
  let owner: SignerWithAddress;
  let ingester1: SignerWithAddress;
  let ingester2: SignerWithAddress;
  let ingester3: SignerWithAddress;
  let ingester4: SignerWithAddress;
  let ingester5: SignerWithAddress;
  let controller: SignerWithAddress;
  let controller2: SignerWithAddress;
  let controller3: SignerWithAddress;
  const message: string = 'hello';
  const nonce: number = 123;
  const maxIngesterPerGroup = 1;

  beforeEach(async () => {
    accounts = await ethers.getSigners();
    [owner, ingester1, ingester2, ingester3, ingester4, ingester5, controller, controller2, controller3] = await ethers.getSigners();
    const IngesterOrchestratorV2 = await ethers.getContractFactory("IngesterOrchestratorV2", owner);
    contract = await IngesterOrchestratorV2.deploy(maxIngesterPerGroup);
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

  describe("registerIngester", function () {
    it("should register a new ingester", async function () {
        const controller = ingester2;

        let hash = await contract._hash(ingester1.address, message, nonce);

        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        expect(contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig))
        .to.emit(contract, "IngesterRegistered")
        .withArgs(ingester1.address, controller.address);
    });

    it("should fail registering a new ingester when sig is incorrect", async function () {
        const controller = ingester2;

        const incorrectMessage = 'bye';

        let hash = await contract._hash(ingester1.address, message, nonce);
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));

        expect(contract.connect(controller).registerIngester(ingester1.address, incorrectMessage, nonce, sig)).to.be.revertedWith("Invalid signature.");
    });

    it("should create an ingester role when registering", async function () {
        //Register an ingester
        const controller = ingester2;
        
        let hash = await contract._hash(ingester1.address, message, nonce);
        const sig = await ingester1.signMessage(ethers.utils.arrayify(hash));
        
        await contract.connect(controller).registerIngester(ingester1.address, message, nonce, sig);
        //Fetch Ingester Role addresses
        const INGESTER_ROLE = await contract.INGESTER_ROLE();
        const ingesterCount = await contract.getRoleMemberCount(INGESTER_ROLE);
        const ingesterCountNum =  BigNumber.from(ingesterCount).toNumber()
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

        expect(contract.getIngester(ingester1.address)).to.be.revertedWith("Ingester does not exist.");
        
        //Fetch Ingester Role addresses
        const INGESTER_ROLE = await contract.INGESTER_ROLE();
        const ingesterCount = await contract.getRoleMemberCount(INGESTER_ROLE);
        const ingesterCountNum =  BigNumber.from(ingesterCount).toNumber();
        expect(ingesterCountNum == 0);
    });
   
  });

    describe("Manage Groups", function () {
    const numGroups = 7500;
    let  addedGroups: string[] = [];
    let ingesterToController: IngesterControllerMapping = {}
    let accounts: SignerWithAddress[] = [];
    let numIngesters = 25;
    let ingesters: SignerWithAddress[] = [];
    let numIngestersToRemove = 1;
    beforeEach(async function () {

        accounts = await ethers.getSigners();
        ingesters = [];

        for (let i = 1; i <= numIngesters; i++ ) {
            let hash = await contract._hash(accounts[i].address, message, nonce);
            const sig = await accounts[i].signMessage(ethers.utils.arrayify(hash));
            await contract.connect(accounts[i-1]).registerIngester(accounts[i].address, message, nonce, sig);
            ingesterToController[accounts[i].address] = accounts[i-1];
            ingesters.push(accounts[i]);
        }
    });

    it("should deploy contract and set maxNumberIngesterPerGroup correctly", async () => {
        expect(await contract._maxNumberIngesterPerGroup()).to.equal(1);
    });
    
    it("should set maxNumberIngesterPerGroup", async () => {
        await contract.connect(owner).setMaxNumberIngesterPerGroup(10);
        expect(await contract._maxNumberIngesterPerGroup()).to.equal(10);
    });

    it("should add a new group", async () => {
        expect(await contract.connect(owner).addGroup("group1")).to.emit(contract, "GroupAdded").withArgs("group1");
        const group = await contract.getGroup("group1");
        let groupUserNameIndex = BigNumber.from(group.groupUsernameIndex).toNumber();
        let groupUsernames = await contract._groupUsernames(groupUserNameIndex);
        expect(group.isAdded).to.be.true;
        expect(groupUsernames == "group1");
    });

    it("should remove an existing group", async () => {
        await contract.connect(owner).addGroup("group1");
        expect(await contract.connect(owner).removeGroup("group1")).to.emit(contract, "GroupRemoved").withArgs("group1");
        const group = await contract.getGroup("group1");
        expect(group.isAdded).to.be.false;
    });

    it("should distribute to ingesters when groups are added", async () => {
        //each ingester should have at least 33 groups
        let ingesterCount = await contract._ingesterCount();
        let maxGroupsPerIngester = Math.ceil(numGroups / ingesterCount);
        // check group assignement are within constraints
        for (let i = 0; i < numGroups; i++) {
            await contract.connect(owner).addGroup(`group${i}`);
            const group = await contract.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            
        }
        // check ingester group assignemnet are within constraints
        for (let i = 0; i < ingesterCount; i++) {
            let _ingesterAddresses = await contract._ingesterAddresses(i);
            let ingester = await contract.getIngester(_ingesterAddresses);
            expect(ingester.assignedGroups.length <= maxGroupsPerIngester);
        }
    });

    it("should remove assigned groups once groups are removed", async () => {
        const groupsToRemove = 100;
        let ingesterCount = await contract._ingesterCount();
        let maxGroupsPerIngester = Math.ceil(numGroups / ingesterCount);
        // check group assignement are within constraints
        for (let i = 0; i < numGroups; i++) {
            expect(await contract.connect(owner).addGroup(`group${i}`)).to.emit(contract, "GroupAdded").withArgs(`group${i}`);
            const group = await contract.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
            
        }
        // Remove Groups
        for (let i = 0; i < groupsToRemove ; i++) {
            expect(await contract.connect(owner).removeGroup(`group${i}`)).to.emit(contract, "GroupRemoved").withArgs(`group${i}`);
            const group = await contract.getGroup(`group${i}`);
            const groupUsername = await contract._groupUsernames(i);
            //Check they were removed correctly from groups storage
            expect(group.isAdded).to.be.false;
            expect(group.ingesterAddresses.length == 0);
            expect(groupUsername == "");
            // check group has been removed from ingesters storage
            for (let j = 0; j < ingesterCount; j++) {
                let _ingesterAddresses = await contract._ingesterAddresses(j);
                let ingester = await contract.getIngester(_ingesterAddresses);
                expect(ingester.assignedGroups).to.not.include(`group${i}`);
            }
        }
    });

    it("should re-adjust groups when ingester is removed", async () => {
        let ingesterCount = await contract._ingesterCount();
        let maxGroupsPerIngesterBeforeUnregistering = Math.ceil(numGroups / ingesterCount);

        // check group assignement are within constraints
        for (let i = 0; i < numGroups; i++) {
            await contract.connect(owner).addGroup(`group${i}`);
            const group = await contract.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
        }

        let contractIngesters = [];
        for (let i=0; i<ingesterCount; i++) {
            contractIngesters.push(await contract._ingesterAddresses(i));
        }

        let ingesterToRemove = await contract.getIngester(ingesters[0].address);
        let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;

        const start = new Date().getTime();

        // Run some code..
        await contract.connect(ingesterToController[ingesters[0].address]).unRegisterIngester(ingesters[0].address);

        let elapsed = new Date().getTime() - start;
        console.log("🚀 ~ file: IngesterRegistryV2.ts:334 ~ it ~ elapsed:", elapsed)

        let ingesterCountAfter = await contract._ingesterCount();
        let maxGroupsPerIngesterAfterUnregistering = Math.ceil(numGroups / ingesterCountAfter);
        
        expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);

        let totalAssignedGroups: string[] = []
        let remainingIngesters: SignerWithAddress[] = ingesters.slice(1);
        for (let j = 0; j < remainingIngesters.length; j++) {
            let ingester = await contract.getIngester(remainingIngesters[j].address);
            totalAssignedGroups = totalAssignedGroups.concat(ingester.assignedGroups);
            expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
            expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
        }

        //make sure that the removed assigned groups have been re-allocated to the existing ingesters
        const allGroupsAreReallocated = ingesterRemovedAssignedGroups.every(removedGroup => {
            return totalAssignedGroups.includes(removedGroup)
        })
        expect(allGroupsAreReallocated).to.be.true;
    });

    it("should re-adjust groups when multiple ingesters are removed", async () => {
        let ingesterCount = await contract._ingesterCount();
        let maxGroupsPerIngesterBeforeUnregistering = Math.ceil(numGroups / ingesterCount);

        // check group assignement are within constraints
        for (let i = 0; i < numGroups; i++) {
            await contract.connect(owner).addGroup(`group${i}`);
            const group = await contract.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
        }

        let contractIngesters = [];
        for (let i=0; i<ingesterCount; i++) {
            contractIngesters.push(await contract._ingesterAddresses(i));
        }

        let ingestersRemaining = ingesters;
        for (let i = 0; i < numIngestersToRemove; i++) {
            let ingesterToRemove = await contract.getIngester(ingesters[i].address);
            let ingesterRemovedAssignedGroups: string[] = ingesterToRemove.assignedGroups;
            
            const start = new Date().getTime();
            
            await contract.connect(ingesterToController[ingesters[i].address]).unRegisterIngester(ingesters[i].address);
            
            let elapsed = new Date().getTime() - start;
            console.log("🚀 Unregistering an ingester took: ", elapsed)

            let ingesterCountAfter = await contract._ingesterCount();
            let maxGroupsPerIngesterAfterUnregistering = Math.ceil(numGroups / ingesterCountAfter);

            expect(maxGroupsPerIngesterAfterUnregistering > maxGroupsPerIngesterBeforeUnregistering);

            let totalAssignedGroups: string[] = []
            // Remove the ingester from structure
            let slicerIndex = i == 0 ? 1 : i;
            ingestersRemaining = ingestersRemaining.slice(slicerIndex);
            let remainingIngestersAddreses = ingestersRemaining.map( ingester => ingester.address);

            // check i remaining ingesters contain all the groups that were removed 
            for (let j = 0; j < ingestersRemaining.length; j++) {
                let ingester = await contract.getIngester(ingestersRemaining[j].address);
                totalAssignedGroups = totalAssignedGroups.concat(ingester.assignedGroups);
                expect(ingester.assignedGroups.length > maxGroupsPerIngesterBeforeUnregistering);
                expect(ingester.assignedGroups.length < maxGroupsPerIngesterAfterUnregistering);
            }

            //make sure that the removed assigned groups have been re-allocated to the existing ingesters
            const allGroupsAreReallocated = ingesterRemovedAssignedGroups.every(removedGroup => {
                return totalAssignedGroups.includes(removedGroup)
            })
            let groupComparisonResult = compareGroups(ingesterRemovedAssignedGroups, totalAssignedGroups );
            expect(allGroupsAreReallocated).to.be.true;
        }
    });

    it("should allocate new groups when available to newly registered ingester", async () => {
        let ingesterCount = await contract._ingesterCount();
        let maxGroupsPerIngesterBeforeUnregistering = Math.ceil(numGroups / ingesterCount);

        // check group assignement are within constraints
        for (let i = 0; i < numGroups; i++) {
            await contract.connect(owner).addGroup(`group${i}`);
            const group = await contract.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)
        }

        // use last available account as new test ingester to be registered
        let hash2 = await contract._hash(accounts[accounts.length -1].address, message, nonce);
        const sig2 = await accounts[accounts.length - 1].signMessage(ethers.utils.arrayify(hash2));
        await contract.connect(accounts[accounts.length - 2]).registerIngester(accounts[accounts.length - 1].address, message, nonce, sig2);

        // check all new incoming groups get allocated to the new ingester
        for (let i = numGroups; i < numGroups + 10; i++) {
            await contract.connect(owner).addGroup(`group${i}`);
            const group = await contract.getGroup(`group${i}`);
            expect(group.isAdded).to.be.true;
            expect(group.ingesterAddresses).to.include(accounts[accounts.length -1].address);
            expect(group.ingesterAddresses.length <= maxIngesterPerGroup)

            let newIngester = await contract.getIngester(accounts[accounts.length -1].address);
            expect(newIngester.assignedGroups).to.include(`group${i}`);
        }
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
});