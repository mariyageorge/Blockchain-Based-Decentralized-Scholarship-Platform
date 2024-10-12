Overview
The Decentralized Scholarship Platform addresses the challenges faced by both sponsors and applicants in the scholarship process. By utilizing blockchain technology, this platform ensures transparency, accountability, and trust in the distribution and utilization of scholarship funds. Sponsors can easily track their contributions, while applicants can confidently submit their applications, knowing that their information is secure and verifiable.

Key Features
Sponsor Login:
Donation Management: Sponsors can donate funds to the scholarship platform with ease.
Transaction Transparency: Sponsors can view and verify how their funds are utilized, ensuring accountability.
Token Rewards: Sponsors receive tokens as rewards for their contributions, providing an incentive for ongoing support.
Applicant Login:
Application Submission: Applicants can enter their academic details (marks, qualifications, etc.) along with valid proof (e.g., document uploads).
Scholarship Application: Applicants can apply for scholarships and provide reservation details if applicable, streamlining the application process.
Verification Process: The platform ensures that applications are verified, promoting integrity and trustworthiness.
This project aims to create a more efficient and reliable scholarship ecosystem, fostering trust among sponsors and applicants alike.

Technology Stack
Blockchain: Ethereum
Smart Contracts: Solidity
Frontend: HTML, CSS, JavaScript
Web3 Library: Ethers.js
Project Structure
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
Getting Started
Prerequisites
Node.js
npm
MetaMask (for interacting with the DApp)
Setup Instructions
Clone the repository:

git clone https://github.com/yourusername/DecentralizedScholarshipPlatform.git
cd DecentralizedScholarshipPlatform
Install Hardhat:

npm install --save-dev hardhat
Run Hardhat:

npx hardhat
Install Frontend Dependencies: Navigate to the frontend directory and install dependencies:

cd frontend
npm install
Deploy the Smart Contract: From the root of your project:

npx hardhat run scripts/deploy.js --network localhost
Start the Frontend: In the frontend directory, run:

npm run dev
Open the Application: Visit http://localhost:3000 in your web browser to interact with the DApp.

Usage
Sponsor Actions: Sponsors can log in, make donations, and view their transaction history to verify fund utilization.
Applicant Actions: Applicants can register, submit their academic details, and apply for scholarships while uploading necessary proof documents.
Acknowledgments
Inspired by the need for transparency and accountability in the scholarship process.

Special thanks to the Ethereum, Solidity, and web development communities for their invaluable contributions and resources.

Youtube Video
https://youtu.be/W-qou4I90o0?si=EdditdwyXdzghSs3
