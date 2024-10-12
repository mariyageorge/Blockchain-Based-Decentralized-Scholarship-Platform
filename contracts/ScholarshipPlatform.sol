// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ScholarshipPlatform {
    struct Applicant {
        string name;
        uint marks;
        bool isVerified;
        string proof; // Hash of the document stored elsewhere
    }

    struct Sponsor {
        address addr;
        uint donation;
        uint tokensIssued;
    }

    mapping(address => Sponsor) public sponsors;
    mapping(address => Applicant) public applicants;

    uint public totalDonations;
    uint public tokenRate = 100; // 1 ETH = 100 Tokens

    event DonationReceived(address indexed sponsor, uint amount, uint tokensIssued);
    event ApplicationSubmitted(address indexed applicant, string name, uint marks);
    event ApplicationVerified(address indexed applicant);

    // Sponsor donates funds and receives tokens
    function donate() public payable {
        require(msg.value > 0, "Must send ETH to donate");
        
        uint tokens = msg.value * tokenRate; // Calculate tokens issued
        sponsors[msg.sender].donation += msg.value;
        sponsors[msg.sender].tokensIssued += tokens; // Track issued tokens
        totalDonations += msg.value;
        
        emit DonationReceived(msg.sender, msg.value, tokens);
    }

    // Applicant submits details
    function submitApplication(string memory name, uint marks, string memory proof) public {
        require(bytes(name).length > 0, "Name cannot be empty");
        require(marks > 0, "Marks must be greater than zero");
        
        applicants[msg.sender] = Applicant(name, marks, false, proof);
        emit ApplicationSubmitted(msg.sender, name, marks);
    }

    // Verify an applicant's application
    function verifyApplication(address applicantAddress) public {
        require(applicants[applicantAddress].marks > 0, "Applicant not found");
        applicants[applicantAddress].isVerified = true; // Change verification status
        emit ApplicationVerified(applicantAddress);
    }

    // Verify the utilization of funds by Sponsor (placeholder)
    function verifyUtilization(address applicantAddress) public view returns (bool) {
        // Example: Check if the applicant is verified and has marks
        return applicants[applicantAddress].isVerified && applicants[applicantAddress].marks > 0;
    }
}
