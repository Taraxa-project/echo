import { ethers } from 'hardhat';
import { Contract } from '@ethersproject/contracts';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from 'chai';
import { BigNumber } from 'ethers';

interface Ingester {
  ingesterAddress: string;
  verified: boolean;
  assignedGroups: string[];
}

interface Group {
  isAdded: boolean;
  ingesterAddresses: string[];
}

interface Groups {
  [groupUsername: string]: Group;
}

function calcUnassignedGroups(groups: string[], ingesters: Ingester[]): string[] {
  const assignedGroups = ingesters.reduce((groups, ingester) => groups.concat(ingester.assignedGroups), []);
  const unassignedGroups = groups.filter(group => !assignedGroups.includes(group));
  return unassignedGroups;
}

function distributeGroupsToIngesters(groups: Groups, ingesters: Ingester[], maxIngesterPerGroup: number): [Ingester[], Groups]  {
  const numIngesters = ingesters.length;
  const groupIds = Object.keys(groups);
  console.log("🚀 groups size", groupIds.length)
  console.log('ingesters size', ingesters.length);

  const unassignedGroups = calcUnassignedGroups(groupIds, ingesters);
  console.log("🚀 ~ file: IngesterRegistry.ts:596 ~ distributeGroupsToIngesters ~ unassignedGroups:", unassignedGroups)

  if (unassignedGroups.length === 0) {
    return [ingesters,groups ];
  }

  const targetGroupsPerIngester = Math.ceil((groupIds.length * maxIngesterPerGroup) / numIngesters);

  for (const group of unassignedGroups) {
        // Find the ingesters that have the fewest assigned groups
        const sortedIngesters = ingesters.sort((a, b) => a.assignedGroups.length - b.assignedGroups.length);
        const availableIngesters = sortedIngesters.filter(ingester => ingester.assignedGroups.length <= targetGroupsPerIngester);
        if (availableIngesters.length === 0) {
          // If there are no available ingesters, move on to the next group
          continue;
        }
    
        // Assign the group to an ingester
        for(const ingester of ingesters) {
          if (ingester.ingesterAddress == availableIngesters[0].ingesterAddress) {
            ingester.assignedGroups = [...ingester.assignedGroups, group]
          }
        }
        // Add the ingester to the group's assignment list
        groups[group].ingesterAddresses = [...groups[group].ingesterAddresses, availableIngesters[0].ingesterAddress];
  }

  // Assign remaining groups to ingesters in an evenly fashion
  for (const [groupId, groupDetails] of Object.entries(groups)) {
    // if group is already at max capacity continue
    if (groups[groupId].ingesterAddresses.length >= maxIngesterPerGroup) {
      console.log(`this group ${groupId} already has the 3 ingesters assigned to it`);
      continue;
    }

    // Find the ingesters that have the fewest assigned groups
    const sortedIngesters = ingesters.sort((a, b) => a.assignedGroups.length - b.assignedGroups.length);
    const availableIngesters = sortedIngesters.filter(ingester => !ingester.assignedGroups.includes(groupId) && ingester.assignedGroups.length < targetGroupsPerIngester);

    if (availableIngesters.length === 0) {
      // If there are no available ingesters, move on to the next group
      continue;
    }

    // // Assign the group to an ingester
    for (const availableIngester of availableIngesters) {
      // Add the ingester to the group's assignment list
      if (groups[groupId].ingesterAddresses.length < maxIngesterPerGroup) {
        groups[groupId].ingesterAddresses.push(availableIngester.ingesterAddress);
        availableIngester.assignedGroups.push(groupId);
      }
    }
  }

  return [ingesters, groups];

}

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
  let controller3: SignerWithAddress;
  const message: string = 'hello';
  const nonce: number = 123;

  beforeEach(async function () {
    const maxGroupsPerIngester = 3;
    [owner, ingester1, ingester2, ingester3, ingester4, ingester5, controller, controller2, controller3] = await ethers.getSigners();
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
      const groupId = 'group_username1';
      const tx = await contract.addGroup(groupId);
      await tx.wait();

      const group = await contract.getGroup(groupId);
      expect(group.isAdded).to.be.true;
      expect(group.ingesterAddresses).to.be.an('array').that.is.empty;
    });

    it('should not allow a non-admin to add a new group', async function () {
      const groupId = 'group_username2';
      expect(contract.connect(ingester1).addGroup(groupId)).to.be.revertedWith('Only admin can perform this action.');

      const group = await contract.getGroup(groupId);
      console.log("🚀 ~ file: IngesterRegistry.ts:40 ~ group:", group)
      expect(group.isAdded).to.be.false;
      expect(group.ingesterAddresses).to.be.empty;
    });

    it('should not allow adding a group that already exists', async function () {
      const groupId = 'group_username1';
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
            await contract.connect(owner).addGroup(`group_username${i}`);
        }
    });

    it("should remove an existing group", async function () {
      await contract.removeGroup(`group_username1`);

      const group = await contract.getGroup(`group_username1`);

      expect(group.isAdded).to.be.false;
      expect(group.ingesterAddresses.length).to.equal(0);
    });

    it("should not allow a group to be removed more than once", async function () {
      await contract.removeGroup(`group_username1`);

      await expect(contract.removeGroup(`group_username1`)).to.be.revertedWith(
        "Group does not exist."
      );
    });

    it("should emit a GroupRemoved event", async function () {
      expect(contract.removeGroup(`group_username1`)).to.emit(contract, "GroupRemoved").withArgs(1);
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
    const numGroups = 100;
    let  addedGroups: string[] = [];
    const maxIngesterPerGroup = 3;

    beforeEach(async function () {
        
        for (let i = 1; i < numGroups; i++) {
            await contract.connect(owner).addGroup(`group_username${i}`);
            addedGroups.push(`group_username${i}`);
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

        //Verify ingester4
        let hash5 = await contract._hash(ingester5.address, message, nonce);
        const sig5 = await ingester5.signMessage(ethers.utils.arrayify(hash5));
        await contract.connect(controller3).registerIngester(ingester5.address, message, nonce, sig5);

      });

    it("should not assign a group to an unregistered ingester", async function () {
      expect(contract.connect(ingester4).getIngesterGroups()).to.be.revertedWith("Ingester is not registered");
    });
  
    it("should not assign a group to an ingester not owned by the caller", async function () {
      expect(contract.connect(ingester4).getIngesterGroups()).to.be.revertedWith("Only registered ingester controller can perform this action.");
    });

    it("should assign a group(s) to a registered ingester and emit an event", async function () {
        expect(await contract.connect(controller).getIngesterGroups(ingester1.address, [`group_username1`,`group_username2`])).to.emit(contract, "IngesterRegisteredGroups").withArgs(ingester1.address, [1,2]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester = ingesterResponse['assignedGroups'];

        expect(assignedGroupsIngester.length == 2);
    });
  
    it("should assign different groups to different ingesters when assigning it different groups", async function () {
        // get groups for ingester1
        await contract.connect(controller).getIngesterGroups(ingester1.address, [`group_username1`,`group_username2`]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(controller).getIngesterGroups(ingester2.address, [`group_username3`,`group_username4`]);
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
        await contract.connect(controller).getIngesterGroups(ingester1.address, [`group_username1`,`group_username2`]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(controller).getIngesterGroups(ingester2.address, [`group_username1`,`group_username2`]);
        let ingesterResponse2 = await contract.getIngester(ingester2.address);
        let assignedGroupsIngester2 = ingesterResponse2['assignedGroups'];
        //check if there is no duplicates between the two responses
        const uniqueGroups = assignedGroupsIngester1.filter(item => assignedGroupsIngester2.includes(item));
        expect(assignedGroupsIngester1).include.members([`group_username1`,`group_username2`]);
        expect(assignedGroupsIngester2).include.members([`group_username1`,`group_username2`]);
    });

    it("should not exceed maxGroupPerIngester parameter when assigning the same groups to ingesters", async function () {
        // get groups for ingester1
        await contract.connect(controller).getIngesterGroups(ingester1.address, [`group_username1`,`group_username2`]);
        let ingesterResponse = await contract.getIngester(ingester1.address);
        let assignedGroupsIngester1 = ingesterResponse['assignedGroups'];

        // get groups for ingester2
        await contract.connect(controller).getIngesterGroups(ingester2.address, [`group_username1`,`group_username2`]);
        let ingesterResponse2 = await contract.getIngester(ingester2.address);
        let assignedGroupsIngester2 = ingesterResponse2['assignedGroups'];

        // get groups for ingester3
        await contract.connect(controller2).getIngesterGroups(ingester3.address, [`group_username1`,`group_username2`]);
        let ingesterResponse3 = await contract.getIngester(ingester3.address);
        let assignedGroupsIngester3 = ingesterResponse3['assignedGroups'];

        // get groups for ingester4 -> this should fail as the max is set to 3 groups per ingester
        expect(contract.connect(controller2).getIngesterGroups(ingester4.address, [`group_username1`,`group_username2`])).to.revertedWith("Could not assign group as it exceeded the max number of ingester per group: [1,2]");
    });

    it("should distribute the allocation of groups evenly using the distribution algorithm using fake data", async function () {

      //Algo for distribution
      let maxNumberIngesterPerGroup = await contract._maxNumberIngesterPerGroup();
      console.log("🚀 ~ file: IngesterRegistry.ts:372 ~ maxNumberIngesterPerGroup:", maxNumberIngesterPerGroup);

      let ingester1Data = await contract.getIngester(ingester1.address);
      let ingester2Data = await contract.getIngester(ingester2.address);
      let ingester3Data = await contract.getIngester(ingester3.address);
      let ingester4Data = await contract.getIngester(ingester4.address);
      let ingester5Data = await contract.getIngester(ingester5.address);

      let Ingester1: Ingester = { ingesterAddress: ingester1.address, verified:true, assignedGroups: ingester1Data['assignedGroups']}
      let Ingester2: Ingester = { ingesterAddress: ingester2.address, verified:true, assignedGroups: ingester1Data['assignedGroups']}
      let Ingester3: Ingester = { ingesterAddress: ingester3.address, verified:true, assignedGroups: ingester1Data['assignedGroups']}
      let Ingester4: Ingester = { ingesterAddress: ingester4.address, verified:true, assignedGroups: ingester1Data['assignedGroups']}
      let Ingester5: Ingester = { ingesterAddress: ingester5.address, verified:true, assignedGroups: ingester1Data['assignedGroups']}

      let ingesters = [Ingester1, Ingester2, Ingester3, Ingester4, Ingester5];

      const groupsExample: Groups = {
        "group_username1": { isAdded: true, ingesterAddresses: ['0x123'] },
        "group_username2": { isAdded: true, ingesterAddresses: ['0x123'] },
        "group_username3": { isAdded: true, ingesterAddresses: [] },
        "group_username4": { isAdded: true, ingesterAddresses: ['0x456'] },
        "group_username5": { isAdded: true, ingesterAddresses: ['0x456'] },
        "group_username6": { isAdded: true, ingesterAddresses: [] },
        "group_username7": { isAdded: true, ingesterAddresses: ['0x789', '0xabc'] },
        "group_username8": { isAdded: true, ingesterAddresses: ['0x789', '0xabc'] },
        "group_username9": { isAdded: true, ingesterAddresses: ['0x789', '0xabc'] },
        "group_username10": { isAdded: true, ingesterAddresses: [] },
        "group_username11": { isAdded: true, ingesterAddresses: [] },
        "group_username12": { isAdded: true, ingesterAddresses: [] },
        "group_username13": { isAdded: true, ingesterAddresses: ['0xdef'] },
        "group_username14": { isAdded: true, ingesterAddresses: ['0xdef'] },
        "group_username15": { isAdded: true, ingesterAddresses: ['0xdef'] },
        "group_username16": { isAdded: true, ingesterAddresses: [] },
        "group_username17": { isAdded: true, ingesterAddresses: [] },
        "group_username18": { isAdded: true, ingesterAddresses: [] },
        "group_username19": { isAdded: true, ingesterAddresses: [] },
        "group_username20": { isAdded: true, ingesterAddresses: [] },
        "group_username21": { isAdded: true, ingesterAddresses: [] },
        "group_username22": { isAdded: true, ingesterAddresses: [] },
        "group_username23": { isAdded: true, ingesterAddresses: [] }
      }
      
      

      const ingestersExample: Ingester[] = [
        { ingesterAddress: '0x123', verified: true, assignedGroups: ["group_username1","group_username2"] },
        { ingesterAddress: '0x789', verified: true, assignedGroups: ["group_username7","group_username8","group_username9"] },
        { ingesterAddress: '0xabc', verified: true, assignedGroups: ["group_username7","group_username8","group_username9"]},
        { ingesterAddress: '0x456', verified: true, assignedGroups: ["group_username4","group_username5"] },
        { ingesterAddress: '0xdef', verified: true, assignedGroups: ["group_username13","group_username14","group_username15"] },
      ];
      
      // Distribute the groups to the ingesters
      const [ingesterAssignments, groupAssignments ] = distributeGroupsToIngesters(groupsExample, ingestersExample, maxIngesterPerGroup);
      console.log('Group assignments:', JSON.stringify(groupAssignments, null, 2));
      console.log('ingesterAssignments assignments:', JSON.stringify(ingesterAssignments, null, 2));

      //Calculate metrics to check if the results are in line with the constraints
      const numIngesters = ingesters.length;
      const groupIds = Object.keys(groupsExample);
      const targetGroupsPerIngester = Math.ceil((groupIds.length * maxIngesterPerGroup) / numIngesters);
      for (const ingester of ingesterAssignments) {
        expect(ingester.assignedGroups.length <= (targetGroupsPerIngester)).to.be.true;
        
        // Check for duplicates
        const set = new Set(ingester.assignedGroups);
        expect(set.size === ingester.assignedGroups.length);
        
      }

      for (const [groupId, groupDetails] of Object.entries(groupAssignments)) {
        expect(groupDetails.ingesterAddresses.length <= maxIngesterPerGroup)
      }
  });

  it("should distribute the allocation of groups evenly using the distribution algorithm using contract data ( 100 groups, 5 ingesters)", async function () {

    let maxNumberIngesterPerGroup = await contract._maxNumberIngesterPerGroup();
    console.log("🚀 ~ file: IngesterRegistry.ts:372 ~ maxNumberIngesterPerGroup:", maxNumberIngesterPerGroup);

    let groupCount = BigNumber.from(await contract._groupCount()).toNumber();
    console.log("🚀 ~ file: IngesterRegistry.ts:553 ~ groupCount:", groupCount)
    let ingesterCount = BigNumber.from(await contract._ingesterCount()).toNumber();
    console.log("🚀 ~ file: IngesterRegistry.ts:374 ~ _ingesterCount:", ingesterCount);

    let groups: Groups = {};
    for (let i = 0; i < groupCount; i++) {
      let groupContract: Group = await contract.getGroup(`group_username${i}`);
      groups[i] = {isAdded: groupContract['isAdded'], ingesterAddresses: groupContract['ingesterAddresses']};
    }

    let ingesterSigners = [ingester1, ingester2, ingester3, ingester4, ingester5];
    let ingesters: Ingester[] = [];
    for (const ingester of ingesterSigners) {
      let ingesterData = await contract.getIngester(ingester.address);
      let Ingester: Ingester = { ingesterAddress: ingester.address, verified: ingesterData['verified'], assignedGroups: ingesterData['assignedGroups']}
      ingesters.push(Ingester);
    }

    // Distribute the groups to the ingesters
    const [ingesterAssignments, groupAssignments ] = distributeGroupsToIngesters(groups, ingesters, maxIngesterPerGroup);
    console.log('Group assignments:', JSON.stringify(groupAssignments, null, 2));
    console.log('ingesterAssignments assignments:', JSON.stringify(ingesterAssignments, null, 2));

    //Calculate metrics to check if the results are in line with the constraints
    const numIngesters = ingesters.length;
    const groupIds = Object.keys(groups);
    const targetGroupsPerIngester = Math.ceil((groupIds.length * maxIngesterPerGroup) / numIngesters);
    for (const ingester of ingesterAssignments) {
      //Check that assignedGroups for ingesters to not excceed the targetGroupsPerIngester per ingester
      expect(ingester.assignedGroups.length <= (targetGroupsPerIngester)).to.be.true;
      
      // Check for duplicates
      const set = new Set(ingester.assignedGroups);
      expect(set.size === ingester.assignedGroups.length);
      
    }
    //Check that all groups allocations to not exceed the maxIngesterPerGroup constraint
    for (const [groupId, groupDetails] of Object.entries(groupAssignments)) {
      expect(groupDetails.ingesterAddresses.length <= maxIngesterPerGroup)
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
  // Add more test cases for other functions as needed
});