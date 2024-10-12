### Overview
The **Decentralized Scholarship Platform** aims to transform the traditional scholarship process by leveraging blockchain technology. It ensures transparency, accountability, and security for both sponsors and applicants. Sponsors can track the use of their contributions, while applicants can trust the integrity and security of their submitted information.

### Key Features

#### **For Sponsors:**
- **Donation Management**: Sponsors can easily donate to the platform.
- **Transaction Transparency**: All transactions are logged and visible on the blockchain, ensuring the proper use of funds.
- **Token Rewards**: Sponsors receive tokens as rewards, incentivizing continued support.

#### **For Applicants:**
- **Application Submission**: Applicants submit their academic information, including grades, qualifications, and upload necessary documents as proof.
- **Scholarship Application**: The platform streamlines the scholarship application process, allowing applicants to include reservation details.
- **Verification Process**: All applications go through a verification process, maintaining a fair and trustworthy system.

This system fosters a more reliable scholarship ecosystem by building trust between sponsors and applicants.

---

### Technology Stack
- **Blockchain**: Ethereum
- **Smart Contracts**: Solidity
- **Frontend**: HTML, CSS, JavaScript
- **Web3 Library**: Ethers.js

---

### Project Structure
```
DecentralizedScholarshipPlatform/
├── contracts/
│   └── ScholarshipPlatform.sol
├── scripts/
│   └── deploy.js
├── frontend/
│   ├── index.html
│   ├── style.css
│   ├── app.js
│   └── package.json
├── hardhat.config.js
└── package.json
```

---

### Getting Started

#### **Prerequisites**
- Node.js
- npm
- MetaMask (for DApp interaction)

#### **Setup Instructions**
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/DecentralizedScholarshipPlatform.git
   cd DecentralizedScholarshipPlatform
   ```

2. **Install Hardhat**:
   ```bash
   npm install --save-dev hardhat
   ```

3. **Run Hardhat**:
   ```bash
   npx hardhat
   ```

4. **Install Frontend Dependencies**:
   Navigate to the frontend directory and install dependencies:
   ```bash
   cd frontend
   npm install
   ```

5. **Deploy the Smart Contract**:
   From the root directory, deploy the smart contract:
   ```bash
   npx hardhat run scripts/deploy.js --network localhost
   ```

6. **Start the Frontend**:
   In the frontend directory, start the development server:
   ```bash
   npm run dev
   ```

7. **Access the Application**:
   Open [http://localhost:3000](http://localhost:3000) to interact with the decentralized application (DApp).

---

### Usage

- **For Sponsors**: Log in, donate, and verify the allocation of funds via the transparent blockchain system.
- **For Applicants**: Register, submit academic details, and apply for scholarships by uploading documents for verification.

---

### Acknowledgments
Inspired by the need for a transparent and accountable scholarship process. Special thanks to the Ethereum, Solidity, and web development communities for their support.

**YouTube Demo**: [Watch here](https://youtu.be/W-qou4I90o0?si=EdditdwyXdzghSs3)

