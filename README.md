# Guestbook LitVM

A decentralized guestbook application built on the LitVM LiteForge Testnet. Users can post messages to the blockchain with optional zkLTC tokens.

## 🚀 Live Deployment

- **Contract Address:** `0xBa35781765a752307d84670039626243c6E48682`
- **Network:** LitVM LiteForge Testnet
- **Explorer:** [View on Explorer](https://liteforge.explorer.caldera.xyz/address/0xBa35781765a752307d84670039626243c6E48682)

## Features

- 📝 Post messages to the blockchain
- 💎 Optional zkLTC token attachments
- 🔍 Search messages by wallet address
- 📊 Real-time statistics
- 📱 Responsive design
- 🔐 Secure wallet integration

## Tech Stack

- **Smart Contract:** Solidity 0.8.19
- **Development:** Hardhat
- **Frontend:** Vanilla HTML/CSS/JavaScript
- **Web3 Library:** Ethers.js v6
- **Network:** LitVM LiteForge Testnet (Chain ID: 4441)

## Prerequisites

- Node.js v16 or higher
- MetaMask or compatible Web3 wallet
- zkLTC tokens for testing (get from LitVM faucet)

## Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd guestbook-litvm
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file:
```bash
cp .env.example .env
```

4. Add your private key to `.env`:
```
PRIVATE_KEY=your_private_key_here
CONTRACT_ADDRESS=0xBa35781765a752307d84670039626243c6E48682
```

## Quick Start (Production Ready)

The contract is already deployed and configured! Simply:

1. Open `frontend/index.html` in your browser
2. Connect your MetaMask wallet
3. Ensure you're on the LitVM network (Chain ID: 4441)
4. Start posting messages!

The frontend automatically connects to the deployed contract at:
`0xBa35781765a752307d84670039626243c6E48682`

## Development & Redeployment

If you need to redeploy the contract:

1. Compile the smart contract:
```bash
npm run compile
```

2. Deploy to LitVM:
```bash
npm run deploy
```

The deployment script will automatically:
- Deploy the Guestbook contract
- Save the contract address and ABI to `frontend/config.json`
- Display the contract address and explorer link

## Vercel Deployment

1. Push your code to GitHub

2. Import the project in Vercel

3. The `vercel.json` configuration will automatically serve the frontend folder

4. Your dApp will be live at `https://your-project.vercel.app`

**Note:** The `frontend/config.json` file contains the production contract address and is ready for deployment.

## Network Configuration

- **Network Name:** LitVM LiteForge Testnet
- **Chain ID:** 4441
- **RPC URL:** https://liteforge.rpc.caldera.xyz/http
- **Explorer:** https://liteforge.explorer.caldera.xyz
- **Currency:** zkLTC

## Smart Contract Functions

### User Functions
- `postMessage(string _text)` - Post a message without tokens
- `postMessageWithToken(string _text)` - Post a message with zkLTC tokens (requires msg.value > 0)
- `getMessage(uint256 _index)` - Get a specific message
- `getMessageCount()` - Get total message count
- `getRecentMessages(uint256 _limit, uint256 _offset)` - Get recent messages with pagination
- `getMessagesByAddress(address _user, uint256 _limit, uint256 _offset)` - Search messages by address

### Owner Functions
- `withdraw()` - Withdraw accumulated zkLTC (owner only)
- `transferOwnership(address newOwner)` - Transfer contract ownership

## Security Features

- ✅ Reentrancy protection
- ✅ Input validation
- ✅ Access control (owner-only functions)
- ✅ Event emission for all state changes
- ✅ Solidity 0.8+ overflow protection

## Frontend Features

- 🎨 Beautiful gradient design
- 📱 Fully responsive
- 🔄 Real-time updates
- 🔍 Address search functionality
- 📄 Pagination support
- 💫 Smooth animations
- ⚡ Fast and lightweight

## Contract Verification

To verify the contract on the LitVM Explorer:

1. Visit: https://liteforge.explorer.caldera.xyz/address/0xBa35781765a752307d84670039626243c6E48682
2. Click "Verify & Publish"
3. Select Solidity 0.8.19
4. Paste the contract source code from `contracts/Guestbook.sol`
5. Enable optimization with 200 runs
6. Submit for verification

## Testing the dApp

1. **Get zkLTC tokens** from the LitVM faucet
2. **Connect your wallet** to the dApp
3. **Post a message** (with or without tokens)
4. **Search messages** by wallet address
5. **Browse messages** using pagination

## Troubleshooting

### MetaMask not connecting?
- Ensure you're using a compatible browser (Chrome, Firefox, Brave)
- Check that MetaMask is installed and unlocked
- Try refreshing the page

### Wrong network?
- Click "Switch to LitVM" button in the dApp
- Or manually add the network in MetaMask with the configuration above

### Transaction failing?
- Ensure you have enough zkLTC for gas fees
- Check that your message is not empty and under 500 characters
- If using `postMessageWithToken`, ensure you're sending zkLTC > 0

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details

## Contact

- **Developer:** EDSOSI
- **Twitter/X:** [@EDSOSI](https://x.com/EDSOSI)
- **Email:** edgardsilvasoares@gmail.com
- **Discord:** 1genesis17

## Acknowledgments

Built with ❤️ on LitVM LiteForge Testnet

---

## Production Deployment Checklist

- ✅ Smart contract deployed to LitVM Testnet
- ✅ Contract address: `0xBa35781765a752307d84670039626243c6E48682`
- ✅ Frontend configured with production contract address
- ✅ ABI included in `frontend/config.json`
- ✅ Network configuration verified
- ✅ Ready for Vercel deployment
- ✅ All features tested and working

**Status:** 🟢 Production Ready
