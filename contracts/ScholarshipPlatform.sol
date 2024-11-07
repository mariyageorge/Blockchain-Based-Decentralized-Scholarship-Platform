// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ScholarshipPlatform {
    struct Applicant {
        string name;
        string personalEmail;
        bool exists;
        uint256 fundsReceived;
        string proofIpfsHash; 
    }

    struct Sponsor {
        string name;
        string email;
        bool exists;
    }

    mapping(address => Applicant) public applicants; 
    mapping(address => Sponsor) public sponsors; 

    Applicant[] public applicantList; 
    Sponsor[] public sponsorList; 

    event ApplicantRegistered(address applicant, string name, string personalEmail, string proofIpfsHash);
    event SponsorRegistered(address sponsor, string name, string email);
    event DonationMade(address indexed sponsor, address indexed applicant, uint256 amount);
    event Withdrawal(address indexed applicant, uint256 amount);
    event ProfileUpdated(address indexed user, string name, string email);

    
    function registerApplicant(
        string memory _name,
        string memory _personalEmail,
        string memory _proofIpfsHash
    ) public {
        require(!applicants[msg.sender].exists, "Applicant already registered");

        applicants[msg.sender] = Applicant({
            name: _name,
            personalEmail: _personalEmail,
            exists: true,
            fundsReceived: 0,
            proofIpfsHash: _proofIpfsHash
        });

        applicantList.push(applicants[msg.sender]);
        emit ApplicantRegistered(msg.sender, _name, _personalEmail, _proofIpfsHash);
    }

   
    function registerSponsor(string memory _name, string memory _email) public {
        require(!sponsors[msg.sender].exists, "Sponsor already registered");

        sponsors[msg.sender] = Sponsor({
            name: _name,
            email: _email,
            exists: true
        });

        sponsorList.push(sponsors[msg.sender]); 
        emit SponsorRegistered(msg.sender, _name, _email);
    }

    
    function donate(address _applicant) public payable {
        require(sponsors[msg.sender].exists, "Only sponsors can donate");
        require(applicants[_applicant].exists, "Applicant does not exist");
        require(msg.value > 0, "Donation amount must be greater than 0");

        applicants[_applicant].fundsReceived += msg.value;

        emit DonationMade(msg.sender, _applicant, msg.value);
    }

   
    function withdraw(uint256 amount) public {
        Applicant storage applicant = applicants[msg.sender];
        require(applicant.exists, "Only applicants can withdraw");
        require(applicant.fundsReceived >= amount, "Insufficient funds");

        applicant.fundsReceived -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");

        emit Withdrawal(msg.sender, amount);
    }

   
    function updateApplicantProfile(string memory _name, string memory _email, string memory _proofIpfsHash) public {
        require(applicants[msg.sender].exists, "Only applicants can update profile");

        applicants[msg.sender].name = _name;
        applicants[msg.sender].personalEmail = _email;
        applicants[msg.sender].proofIpfsHash = _proofIpfsHash;

        emit ProfileUpdated(msg.sender, _name, _email);
    }

   
    function updateSponsorProfile(string memory _name, string memory _email) public {
        require(sponsors[msg.sender].exists, "Only sponsors can update profile");

        sponsors[msg.sender].name = _name;
        sponsors[msg.sender].email = _email;

        emit ProfileUpdated(msg.sender, _name, _email);
    }

   
    function getApplicantDetails(address _applicant) public view returns (string memory, string memory, uint256, string memory) {
        Applicant memory applicant = applicants[_applicant];
        return (applicant.name, applicant.personalEmail, applicant.fundsReceived, applicant.proofIpfsHash);
    }

    function getSponsorDetails(address _sponsor) public view returns (string memory, string memory, bool) {
        Sponsor memory sponsor = sponsors[_sponsor];
        return (sponsor.name, sponsor.email, sponsor.exists);
    }
}
