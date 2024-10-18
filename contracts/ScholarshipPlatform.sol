// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ScholarshipPlatform {
    struct Applicant {
        string name;
        string collegeEmail; 
        bool verified;
        bool exists;
    }

    struct Sponsor {
        string name;
        string uniqueId; 
        bool verified;
        bool exists;
    }

    mapping(address => Applicant) public applicants;
    mapping(address => Sponsor) public sponsors;
    mapping(string => bool) private verifiedEmails; 
    mapping(string => bool) private uniqueIds; 

    event ApplicantRegistered(address applicant, string name, string collegeEmail);
    event SponsorRegistered(address sponsor, string name, string uniqueId);

    modifier onlyVerifiedApplicant() {
        require(applicants[msg.sender].verified, "Not a verified applicant");
        _;
    }

    modifier onlyVerifiedSponsor() {
        require(sponsors[msg.sender].verified, "Not a verified sponsor");
        _;
    }

    function registerApplicant(string memory _name, string memory _collegeEmail) public {
        require(!applicants[msg.sender].exists, "Applicant already registered");
        require(!verifiedEmails[_collegeEmail], "Email already in use");

        applicants[msg.sender] = Applicant({
            name: _name,
            collegeEmail: _collegeEmail,
            verified: false,
            exists: true
        });

        verifiedEmails[_collegeEmail] = true;

        emit ApplicantRegistered(msg.sender, _name, _collegeEmail);
    }

    function verifyApplicant(address _applicant) public onlyVerifiedSponsor {
        require(applicants[_applicant].exists, "Applicant does not exist");
        applicants[_applicant].verified = true;
    }

    function registerSponsor(string memory _name, string memory _uniqueId) public {
        require(!sponsors[msg.sender].exists, "Sponsor already registered");
        require(!uniqueIds[_uniqueId], "Unique ID already in use");

        sponsors[msg.sender] = Sponsor({
            name: _name,
            uniqueId: _uniqueId,
            verified: false,
            exists: true
        });

        uniqueIds[_uniqueId] = true;

        emit SponsorRegistered(msg.sender, _name, _uniqueId);
    }

    function verifySponsor(address _sponsor) public {
        require(sponsors[_sponsor].exists, "Sponsor does not exist");
        sponsors[_sponsor].verified = true;
    }

    function getApplicantDetails(address _applicant) public view returns (string memory, string memory, bool) {
        Applicant memory applicant = applicants[_applicant];
        return (applicant.name, applicant.collegeEmail, applicant.verified);
    }

    function getSponsorDetails(address _sponsor) public view returns (string memory, string memory, bool) {
        Sponsor memory sponsor = sponsors[_sponsor];
        return (sponsor.name, sponsor.uniqueId, sponsor.verified);
    }
}
