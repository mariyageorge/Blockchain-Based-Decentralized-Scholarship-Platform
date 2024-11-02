// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ScholarshipPlatform {
    struct Applicant {
        string name;
        string personalEmail; 
        bool verified;
        bool exists;
        uint256 fundsReceived;
    }

    struct Sponsor {
        string name;
        string email;
        string uniqueId;
        bool exists;
    }

    mapping(address => Applicant) public applicants;
    mapping(address => Sponsor) public sponsors;
    mapping(string => bool) private verifiedEmails;
    mapping(string => bool) private uniqueIds;
    mapping(string => address) private uniqueIdToAddress; // Map unique IDs to sponsor addresses

    event ApplicantRegistered(address applicant, string name, string personalEmail);
    event SponsorRegistered(address sponsor, string name, string email, string uniqueId);
    event DonationMade(address indexed sponsor, address indexed applicant, uint256 amount);
    event HelpRequested(address indexed applicant, string message);

    modifier onlyVerifiedApplicant() {
        require(applicants[msg.sender].verified, "Not a verified applicant");
        _;
    }


    function generateUniqueId(string memory _name, string memory _email) private pure returns (string memory) {
        return string(abi.encodePacked(keccak256(abi.encodePacked(_name, _email))));
    }

    function registerApplicant(string memory _name, string memory _personalEmail) public {
        require(!applicants[msg.sender].exists, "Applicant already registered");
        require(!verifiedEmails[_personalEmail], "Email already in use");

        applicants[msg.sender] = Applicant({
            name: _name,
            personalEmail: _personalEmail,
            verified: false,
            exists: true,
            fundsReceived: 0
        });

        verifiedEmails[_personalEmail] = true;

        emit ApplicantRegistered(msg.sender, _name, _personalEmail);
    }

    function verifyApplicant(address _applicant) public {
        require(applicants[_applicant].exists, "Applicant does not exist");
        applicants[_applicant].verified = true;
    }

    function registerSponsor(string memory _name, string memory _email) public {
        require(!sponsors[msg.sender].exists, "Sponsor already registered");


        string memory _uniqueId = generateUniqueId(_name, _email);
        require(!uniqueIds[_uniqueId], "Unique ID already in use");

        sponsors[msg.sender] = Sponsor({
            name: _name,
            email: _email,
            uniqueId: _uniqueId,
            exists: true
        });

        uniqueIds[_uniqueId] = true;
        uniqueIdToAddress[_uniqueId] = msg.sender;

        emit SponsorRegistered(msg.sender, _name, _email, _uniqueId);
    }


    function sponsorLogin(string memory _uniqueId) public view returns (bool) {
        return sponsors[uniqueIdToAddress[_uniqueId]].exists;
    }

    
    function donate(address _applicant) public payable {
        require(applicants[_applicant].exists, "Applicant does not exist");
        require(applicants[_applicant].verified, "Applicant is not verified");
        require(msg.value > 0, "Donation amount must be greater than 0");

        applicants[_applicant].fundsReceived += msg.value;

        emit DonationMade(msg.sender, _applicant, msg.value);
    }


    function requestHelp(string memory _message) public onlyVerifiedApplicant {
        emit HelpRequested(msg.sender, _message);
    }

    function getApplicantDetails(address _applicant) public view returns (string memory, string memory, bool, uint256) {
        Applicant memory applicant = applicants[_applicant];
        return (applicant.name, applicant.personalEmail, applicant.verified, applicant.fundsReceived);
    }

    function getSponsorDetails(address _sponsor) public view returns (string memory, string memory, bool) {

        Sponsor memory sponsor = sponsors[_sponsor];
        return (sponsor.name, sponsor.uniqueId, sponsor.exists);
    }
}
