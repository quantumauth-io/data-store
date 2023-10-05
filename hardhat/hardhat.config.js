require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
const contract = require('./artifacts/contracts/WorldWideWeb3.sol/WorldWideWeb3.json')
const {ethers} = require("ethers");
const name = "idecentralize";
const version = "1";

const tokenName = "IDFI";
const tokenSymbol = "IDFI";

/** @type import('hardhat/config').HardhatUserConfig */

task(
    "deploy",
    "Deploy The contract",
    async (_, {accounts}) => {
        const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');
        const owner = await new ethers.Wallet(process.env.PRIVATE_KEY, provider);
        const validator = await new ethers.Wallet(process.env.VALIDATOR_KEY, provider);
        const WWW3 = await new  ethers.ContractFactory(contract.abi, contract.bytecode,owner);
        console.log(validator.address)
        const www3 = await WWW3.deploy(name, version, validator.address, tokenName, tokenSymbol);
        const receipt = await www3.deploymentTransaction();
        console.log("www3 deployed:", receipt);
        console.log("address", www3.target)
    })
module.exports = {
    defaultNetwork: "hardhat",
  networks: {
      hardhat: {
        mining: {
          auto: true,
          interval: 5000
        }
      }
    },
    paths: {
    sources: "./contracts",
    tests: "./test",
    artifacts: "./artifacts"


},
    solidity: {
        version: "0.8.20",
        settings: {
            optimizer: {
                enabled: true,
                runs: 200
            },
            // Specify the relative path to the OpenZeppelin contracts from the contracts directory
            evmVersion: "london",
            metadata: {
                bytecodeHash: "none",

            },

        }
    }
};
