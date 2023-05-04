# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```

# Install foundry to use the foundry tests (optional)

Download:
```
curl -L https://foundry.paradigm.xyz | bash
```

To install, run:
```
foundryup
```

Then you should be able to build:
```
forge build
```

and run the forge tests: 
```
forge test
```

# Ingester Orchestrator Diamond Pattern

A Diamond contract consists of:

Storage: The contract's state variables.
Facets: Individual contracts that implement the desired behaviors.
Diamond Cutter: A contract responsible for adding, replacing, or removing facets.
Diamond Loupe: A set of standardized functions that provide information about the diamond's facets, function selectors, and supported interfaces.


## Ingester Contracts and Facets

The Ingester Contracts for IPFS Hashes Storage, built on the Diamond Standard, have the following primary components and facets:

**CommonFunctionsFacet**: This facet implements common utility functions that are used across other facets, such as helper functions for managing arrays and other data structures.

**AccessControlFacet**: This facet is responsible for managing access control, including roles and permissions, ensuring that only authorized entities can perform specific actions within the contract.

**GroupManagerFacet**: This facet manages the creation and organization of ingester groups responsible for processing and storing specific types of IPFS hashes. It also enables the addition, modification, or removal of ingester groups.

**RegistryFacet**: This facet manages the storage of IPFS hashes and their associated metadata. It enables the efficient and secure storage and retrieval of IPFS hashes and provides functions for querying the stored data.

**DataGatheringFacet**: This facet provides a bridge between the ingester contracts and external data sources, such as oracles or other blockchain contracts. It enables the ingester contracts to access and store IPFS hashes from various sources efficiently and securely.

All functions called to diamond will be relayed to the respective facets using `delegatecall` so the different contracts are abstracted away.

## Smart Contract Interaction

1. First the ingesters should be registered:
- Register an ingester using the registerIngester function in the diamond contract. You need to provide a valid signature proving that you control the ingester address. The signature is generated off-chain using the ingester's private key. Here's a step-by-step process:
    - Create a message: create a message that includes the ingester's Ethereum address and any additional information, e.g. <public_key>_<nonce>_<timestamp>
    - Create a nonce: generate a nonce (a random or incrementing number)
    - Hash the message: The message, along with the ingester's Ethereum address and the nonce, needs to be hashed using the keccak256 hashing algorithm (SHA-3). You can also call the `_hash` function on the diamond contract to do this. Example:
    ```const messageHash = await contract._hash(ingesterAddress, message, nonce);```
    - Sign the hash: Now, the controller should sign the hash using its private key. Example call:
    ```const sig = await controllerWeb3Account.signMessage(ethers.utils.arrayify(messageHash));```
    - Call the registerIngester function: With the signature components ready, you can now call the registerIngester function in the IngesterRegistry contract. Example call:
    ```await contract.connect(controllerWeb3Account).registerIngester(ingesterAddress, message, nonce, sig);```
    - Once registered, the ingester can interact with the smart contract system as an authorized participant.

2. Add or remove groups using the addGroup and removeGroup functions in the IngesterOrchestratorProxy contract. This action can only performed by the admin address. Note that addGroups will automatically try to distribute the groups to the registered ingesters, if none are are registered the transaction will fail due to not having ingesters to assign to.
    - To add a group:
    ```await contract.connect(adminWeb3Account).addGroup(groupUsername);```
    - To remove a group:
    ```await contract.connect(adminWeb3Account).removeGroup(groupUsername);```

3. Add IPFS hashes for the registered ingester using the addIpfsHash function in the IngesterDataGatheringV2 contract.
- Prepare the IPFS hashes: You should have three separate IPFS hashes for users, chats, and messages data.
- Call the addIpfsHash function: Interact with the IngesterDataGatheringV2 contract and call the addIpfsHash function, passing the following parameters:
    - usersHash: The IPFS hash of the users data.
    - chatsHash: The IPFS hash of the chats data.
    - messagesHash: The IPFS hash of the messages data.
    - Connect to the contract with the web3 account from ingester. Here is an example: 
    ```await contract.connect(ingesterWeb3Account).addIpfsHash(ingesterWeb3Account.address, usersHash, chatsHash, messagesHash);```
- To confirm that the hashes have been written correctly or verify what the latest hashes for a specific ingester: 
    ```await contract.getIpfsHashes(ingesterWeb3Account.address);```

4. Unregister an ingester using the unRegisterIngester function in the IngesterOrchestratorProxy contract. Example:
```await contract.connect(controllerWeb3Account).unRegisterIngester(ingesterWeb3Account.address);```
    - This is the most computationally expensive function in this contract. Expect a longer run time. 
    - Current limitations:
        - For one ingester, do not use more than 300 groups. 
        - Do not exceed 7500 groups with current implementation. Maximum was tested with 7500 groups and 25 ingesters.

5. If the maximum number of ingester per group is changed (it will be started with 1 at deployment), call setMaxNumberIngesterPerGroup function in the IngesterOrchestratorProxy contract.
```await contract.connect(adminWeb3Account).setMaxNumberIngesterPerGroup(newMaxNumberIngesterPerGroup);```

6. In the case of wanting to register an ingester AFTER the groups already being added. A subsequent call to distributeGroups to ingester needs to be made: 
- First register the ingester as described in step 1.
- Then call ```await contract.connect(controllerWeb3Account).distributeGroups(ingesterAddress);```
- This will then distribute the available groups to the ingesterAddress defined
