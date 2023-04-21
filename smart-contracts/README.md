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


# Ingester Orchestrator V2

The Ingester Orchestrator V2 is a decentralized system designed to manage and orchestrate the storage of data on IPFS by registered ingesters. The system is composed of several smart contracts that interact with each other to perform registration, access control, and data gathering operations.

## Smart Contracts
IngesterRegistryAccessControlV2: This contract manages access control and ownership for the Ingester Registry. It extends the Ownable and AccessControlEnumerable contracts from the OpenZeppelin library.

**IngesterRegistrationV2**: This contract is responsible for the registration and unregistration of ingesters. It extends the IngesterRegistryAccessControlV2 contract for access control.

**IngesterDataGatheringV2**: This contract manages the storage of IPFS hashes submitted by registered ingesters. It extends the IngesterRegistryAccessControlV2 contract and implements the IIngesterDataGatheringV2 interface.

**IngesterOrchestratorV2**: The orchestrator contract coordinates group assignments and ingester registrations. It extends the IngesterRegistrationV2 and IngesterDataGatheringV2 contracts, and implements the IIngesterOrchestratorV2 interface.

## Interfaces

**IIngesterDataGatheringV2**: This interface defines the structure and functions required for the data gathering contract.

**IIngesterRegistrationV2**: This interface defines the structure and functions required for the registration contract.

**IIngesterOrchestratorV2**: This interface defines the structure and functions required for the orchestrator contract.

## Functionality

**Access Control**: The system restricts access to certain functions based on the caller's role. For example, only contract admins can transfer ownership or unregister an ingester.

**Registration**: Ingesters can register themselves by providing a valid signature proving they control the ingester address. The system verifies the signature and assigns them the INGESTER_ROLE.

**Data Gathering**: Registered ingesters can store IPFS hashes for users, chats, and messages data. The system maintains a mapping of ingester addresses to their submitted IPFS hashes.

**Group Management**: The orchestrator contract enables admins to add or remove groups and assign ingesters to them. It also allows setting a maximum number of ingesters per group.


## Smart Contract Interaction

1. First the ingester should register:
- Register an ingester using the registerIngester function in the IngesterRegistrationV2 contract. You need to provide a valid signature proving that you control the ingester address. The signature is generated off-chain using the ingester's private key. Here's a step-by-step process:
    - Create a message: create a message that includes the ingester's Ethereum address and any additional information, e.g. <public_key>_<nonce>_<timestamp>
    - Create a nonce: generate a nonce (a random or incrementing number)
    - Hash the message: The message, along with the ingester's Ethereum address and the nonce, needs to be hashed using the keccak256 hashing algorithm (SHA-3). You can also call the `_hash` function on the `IngesterRegistrationV2` contract to do this. Example:
    ```const messageHash = await contract._hash(ingesterAddress, message, nonce);```
    - Sign the hash: Now, the ingester should sign the hash using its private key. Example call:
    ```const sig = await ingesterWeb3Account.signMessage(ethers.utils.arrayify(messageHash));```
    - Call the registerIngester function: With the signature components ready, you can now call the registerIngester function in the IngesterRegistrationV2 contract. Example call:
    ```await contract.connect(controllerWeb3Account).registerIngester(ingesterAddress, message, nonce, sig);```
    - Once registered, the ingester can interact with the smart contract system as an authorized participant.

2. Add IPFS hashes for the registered ingester using the addIpfsHash function in the IngesterDataGatheringV2 contract.
- Prepare the IPFS hashes: You should have three separate IPFS hashes for users, chats, and messages data.
- Call the addIpfsHash function: Interact with the IngesterDataGatheringV2 contract and call the addIpfsHash function, passing the following parameters:
    - ingesterAddress: The Ethereum address of the registered ingester.
    - usersHash: The IPFS hash of the users data.
    - chatsHash: The IPFS hash of the chats data.
    - messagesHash: The IPFS hash of the messages data.
    - Connect to the contract with the web3 account that controls the ingester address. Here is an example: 
    ```await contract.connect(controllerWeb3Account).addIpfsHash(ingesterWeb3Account.address, usersHash, chatsHash, messagesHash);```
- To confirm that the hashes have been written correctly or verify what the latest hashes for a specific ingester: 
    ```await contract.getIpfsHashes(ingesterWeb3Account.address);```

3. Add or remove groups using the addGroup and removeGroup functions in the IngesterOrchestratorV2 contract. This action can only performed by the admin address.
    - To add a group:
    ```await contract.connect(adminWeb3Account).addGroup(groupUsername);```
    - To remove a group:
    ```await contract.connect(adminWeb3Account).removeGroup(groupUsername);```

4. Unregister an ingester using the unRegisterIngester function in the IngesterOrchestratorV2 contract. Example:
```await contract.connect(controllerWeb3Account).unRegisterIngester(ingesterWeb3Account.address);```
    - This is the most computationally expensive function in this contract. Expect a longer run time. 
    - Current limitations:
        - For one ingester, do not use more than 300 groups. 
        - Do not exceed 7500 groups with current implementation. Maximum was tested with 7500 groups and 25 ingesters.

5. If the maximum number of ingester per group is changed (it will be started with 1 at deployment), call setMaxNumberIngesterPerGroup function in the IngesterOrchestratorV2 contract.
```await contract.connect(adminWeb3Account).setMaxNumberIngesterPerGroup(newMaxNumberIngesterPerGroup);```


# IngesterOrchestatorProxy

This implementation is an iteration from IngesterOrchestratorV2 with some more refined functionality. 
There are some differences in the smart contract interaction: 
- All calls are made to the ingesterProxy directly which will relay calls to the respective smart contracts, eg IngesterRegistry, IngesterDataGathering and IngesterGroupManager.
- Use controller wallet to sign the proof before registering an ingester instead of using ingester wallet
- In the situation that there are already groups added into the smart contract:
    - Registering an ingester will only register and will not assign groups to it. 
    - Registering an ingester should therefore be followed up by calling `distributeGroups(ingesterAddress)`

## Smart Contract Interaction

1. First the ingester should register:
- Register an ingester using the registerIngester function in the IngesterRegistry contract. You need to provide a valid signature proving that you control the ingester address. The signature is generated off-chain using the ingester's private key. Here's a step-by-step process:
    - Create a message: create a message that includes the ingester's Ethereum address and any additional information, e.g. <public_key>_<nonce>_<timestamp>
    - Create a nonce: generate a nonce (a random or incrementing number)
    - Hash the message: The message, along with the ingester's Ethereum address and the nonce, needs to be hashed using the keccak256 hashing algorithm (SHA-3). You can also call the `_hash` function on the `IngesterRegistry` contract to do this. Example:
    ```const messageHash = await contract._hash(ingesterAddress, message, nonce);```
    - Sign the hash: Now, the controller should sign the hash using its private key. Example call:
    ```const sig = await controllerWeb3Account.signMessage(ethers.utils.arrayify(messageHash));```
    - Call the registerIngester function: With the signature components ready, you can now call the registerIngester function in the IngesterRegistry contract. Example call:
    ```await contract.connect(controllerWeb3Account).registerIngester(ingesterAddress, message, nonce, sig);```
    - Once registered, the ingester can interact with the smart contract system as an authorized participant.

2. Add IPFS hashes for the registered ingester using the addIpfsHash function in the IngesterDataGatheringV2 contract.
- Prepare the IPFS hashes: You should have three separate IPFS hashes for users, chats, and messages data.
- Call the addIpfsHash function: Interact with the IngesterDataGatheringV2 contract and call the addIpfsHash function, passing the following parameters:
    - usersHash: The IPFS hash of the users data.
    - chatsHash: The IPFS hash of the chats data.
    - messagesHash: The IPFS hash of the messages data.
    - Connect to the contract with the web3 account from ingester. Here is an example: 
    ```await contract.connect(ingesterWeb3Account).addIpfsHash(ingesterWeb3Account.address, usersHash, chatsHash, messagesHash);```
- To confirm that the hashes have been written correctly or verify what the latest hashes for a specific ingester: 
    ```await contract.getIpfsHashes(ingesterWeb3Account.address);```

3. Add or remove groups using the addGroup and removeGroup functions in the IngesterOrchestratorProxy contract. This action can only performed by the admin address.
    - To add a group:
    ```await contract.connect(adminWeb3Account).addGroup(groupUsername);```
    - To remove a group:
    ```await contract.connect(adminWeb3Account).removeGroup(groupUsername);```

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
