// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ScholarshipPlatform {
    struct Applicant {
        string name;
        string personalEmail;
        bool verified;
        bool exists;
        uint256 fundsReceived;
        string proofIpfsHash; 
        string username;
        string password; 
    }

    struct Sponsor {
        string name;
        string email;
        string uniqueId;
        bool exists;
    }

    mapping(address => Applicant) public applicants; 
    mapping(address => Sponsor) public sponsors; 
    mapping(string => address) public uniqueIdToAddress; 

    Applicant[] public applicantList; 
    Sponsor[] public sponsorList; 

    event ApplicantRegistered(address applicant, string name, string personalEmail, string proofIpfsHash);
    event SponsorRegistered(address sponsor, string name, string email, string uniqueId);
    event DonationMade(address indexed sponsor, address indexed applicant, uint256 amount);
    event HelpRequested(address indexed applicant, string message);

    
    function registerApplicant(
        string memory _name,
        string memory _personalEmail,
        string memory _proofIpfsHash,
        string memory _username,
        string memory _password
    ) public {
        require(!applicants[msg.sender].exists, "Applicant already registered");

        applicants[msg.sender] = Applicant({
            name: _name,
            personalEmail: _personalEmail,
            verified: false,
            exists: true,
            fundsReceived: 0,
            proofIpfsHash: _proofIpfsHash,
            username: _username,
            password: _password 
        });

        applicantList.push(applicants[msg.sender]);

        emit ApplicantRegistered(msg.sender, _name, _personalEmail, _proofIpfsHash);
    }

   
    function registerSponsor(string memory _name, string memory _email) public {
        require(!sponsors[msg.sender].exists, "Sponsor already registered");

        string memory _uniqueId = generateUniqueId(_name, _email);
        sponsors[msg.sender] = Sponsor({
            name: _name,
            email: _email,
            uniqueId: _uniqueId,
            exists: true
        });

        sponsorList.push(sponsors[msg.sender]); 
        emit SponsorRegistered(msg.sender, _name, _email, _uniqueId);
    }

    
    function sponsorLogin(string memory _uniqueId) public view returns (bool) {
        return sponsors[uniqueIdToAddress[_uniqueId]].exists;
    }

 
    function applicantLogin(string memory _username, string memory _password) public view returns (bool) {
        Applicant storage applicant = applicants[msg.sender];
        require(applicant.exists, "Applicant does not exist");
        return (keccak256(abi.encodePacked(applicant.username)) == keccak256(abi.encodePacked(_username)) &&
                keccak256(abi.encodePacked(applicant.password)) == keccak256(abi.encodePacked(_password)));
    }

 
    function getAllApplicants() public view returns (Applicant[] memory) {
        return applicantList;
    }

   
    function getAllSponsors() public view returns (Sponsor[] memory) {
        return sponsorList;
    }

    
    function donate(address _applicant) public payable {
        require(applicants[_applicant].exists, "Applicant does not exist");
        require(applicants[_applicant].verified, "Applicant is not verified");
        require(msg.value > 0, "Donation amount must be greater than 0");

        applicants[_applicant].fundsReceived += msg.value;

        emit DonationMade(msg.sender, _applicant, msg.value);
    }

   
    function generateUniqueId(string memory _name, string memory _email) private pure returns (string memory) {
        return string(abi.encodePacked(keccak256(abi.encodePacked(_name, _email))));
    }

  
    function getApplicantDetails(address _applicant) public view returns (string memory, string memory, bool, uint256, string memory) {
        Applicant memory applicant = applicants[_applicant];
        return (applicant.name, applicant.personalEmail, applicant.verified, applicant.fundsReceived, applicant.proofIpfsHash);
    }

   
    function getSponsorDetails(address _sponsor) public view returns (string memory, string memory, bool) {
        Sponsor memory sponsor = sponsors[_sponsor];
        return (sponsor.name, sponsor.uniqueId, sponsor.exists);
    }
}
