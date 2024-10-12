const hre = require("hardhat");

async function main() {
    const ScholarshipPlatform = await hre.ethers.getContractFactory("ScholarshipPlatform");
    const scholarshipPlatform = await ScholarshipPlatform.deploy();

    await scholarshipPlatform.deployed();
    console.log("ScholarshipPlatform deployed to:", scholarshipPlatform.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
