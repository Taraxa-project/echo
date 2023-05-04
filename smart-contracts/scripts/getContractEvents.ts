import { ethers } from "hardhat";

const contractAddress = '0x1d8D1fB99B5a90FA9bce044D2616F26BB0dF4360';
const eventName = 'GroupAdded';

const main = async () => {
  const provider = ethers.provider;
  const contract = await ethers.getContractAt("IngesterGroupManager", contractAddress);
  const eventFragment = contract.interface.getEvent(eventName);
  const topic = contract.interface.getEventTopic(eventFragment);

  const filter = {
    fromBlock: 0,
    toBlock: 'latest',
    topics: [topic],
  };

  const logs = await provider.getLogs(filter);

  for (const log of logs) {
    if (log.topics.includes(topic)) {
      const decodedLog = contract.interface.decodeEventLog(eventFragment, log.data, log.topics);
      console.log(decodedLog);
    }
  }
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
