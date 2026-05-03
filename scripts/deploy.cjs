const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  console.log("🚀 Starting Guestbook deployment on LitVM...\n");

  const [deployer] = await hre.ethers.getSigners();
  console.log("📝 Deploying contract with account:", deployer.address);

  const balance = await hre.ethers.provider.getBalance(deployer.address);
  console.log("💰 Account balance:", hre.ethers.formatEther(balance), "zkLTC\n");

  console.log("⏳ Deploying Guestbook contract...");
  const Guestbook = await hre.ethers.getContractFactory("Guestbook");
  const guestbook = await Guestbook.deploy();

  await guestbook.waitForDeployment();
  const contractAddress = await guestbook.getAddress();

  console.log("✅ Guestbook deployed to:", contractAddress);
  console.log("🔗 Explorer:", `https://liteforge.explorer.caldera.xyz/address/${contractAddress}\n`);

  // Save contract address and ABI to frontend config
  const frontendDir = path.join(__dirname, "..", "frontend");
  if (!fs.existsSync(frontendDir)) {
    fs.mkdirSync(frontendDir, { recursive: true });
  }

  const configPath = path.join(frontendDir, "config.json");
  const artifactPath = path.join(__dirname, "..", "artifacts", "contracts", "Guestbook.sol", "Guestbook.json");

  let abi = [];
  if (fs.existsSync(artifactPath)) {
    const artifact = JSON.parse(fs.readFileSync(artifactPath, "utf8"));
    abi = artifact.abi;
  }

  const config = {
    contractAddress: contractAddress,
    chainId: 4441,
    chainName: "LitVM LiteForge Testnet",
    rpcUrl: "https://liteforge.rpc.caldera.xyz/http",
    explorerUrl: "https://liteforge.explorer.caldera.xyz",
    nativeCurrency: {
      name: "zkLTC",
      symbol: "zkLTC",
      decimals: 18
    },
    abi: abi
  };

  fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
  console.log("💾 Configuration saved to frontend/config.json");
  console.log("\n🎉 Deployment complete!");
  console.log("\n📋 Next steps:");
  console.log("1. Update your .env file with the contract address if needed");
  console.log("2. Deploy the frontend folder to Vercel");
  console.log("3. Start interacting with your guestbook!\n");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
