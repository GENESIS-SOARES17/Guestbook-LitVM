require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  // Mantém a versão da sua lógica principal
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    // Sua conexão principal com a LitVM (Liteforge)
    liteforge: {
      url: "https://liteforge.rpc.caldera.xyz/http",
      chainId: 4441,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      
      /* 🚀 CORREÇÃO PARA O ERRO DE CARREGAMENTO:
         Forçamos o modo 'legacy' para evitar que o Hardhat tente usar 
         taxas dinâmicas (EIP-1559) que a LitVM não aceita.
      */
      gasPrice: 1000000000, // 1 gwei
      type: "legacy"
    }
  },
  // Preserva a estrutura do seu projeto atual
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  }
};
