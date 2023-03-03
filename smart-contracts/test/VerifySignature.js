const {expect} = require('chai');
const { ethers } = require('hardhat');

describe("VerifySignature", function() {
    it("Check signature", async function() {
        const accounts = await ethers.getSigners(2);
        const VerifySignature = await ethers.getContractFactory("VerifySignature");
        const contract = await VerifySignature.deploy();
        await contract.deployed();

        const signer = accounts[0]; // ingester Node
        const to = accounts[1].address; // address that interacts with smart contract
        const amount = 999;
        const message = 'hello';
        const nonce = 123;

        const hash = await contract.getMessageHash(to, amount, message, nonce);
        const sig = await signer.signMessage(ethers.utils.arrayify(hash));

        const ethHash = await contract.getEthSignerMessageHash(hash);

        console.log('signer', signer.address);
        console.log('recovered signer', await contract.recoverSigner(ethHash, sig))

        expect(await contract.verify(signer.address, to, amount, message, nonce, sig)).to.equal(true);
        expect(await contract.verify(signer.address, to, amount + 1, message, nonce, sig)).to.equal(false);
    })
})