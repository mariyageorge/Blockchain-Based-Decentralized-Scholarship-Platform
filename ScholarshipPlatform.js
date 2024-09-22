import { ethers } from "ethers";
import ScholarshipPlatformABI from "./ScholarshipPlatformABI.json"; // You will need to create this ABI file

const contractAddress = "0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3"; // Replace with your deployed contract address

export const getContract = async () => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, ScholarshipPlatformABI, signer);
    return contract;
};
