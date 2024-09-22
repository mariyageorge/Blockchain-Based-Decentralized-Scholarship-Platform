import { useState } from "react";
import { ethers } from "ethers";
import { getContract } from "./contracts/ScholarshipPlatform";

function App() {
    const [applicantName, setApplicantName] = useState("");
    const [marks, setMarks] = useState("");
    const [proof, setProof] = useState("");
    const [amount, setAmount] = useState("");
    const [sponsorId, setSponsorId] = useState(""); // New state for Sponsor ID
    const [account, setAccount] = useState(null);
    const [submittedSponsor, setSubmittedSponsor] = useState(null);
    const [submittedApplicant, setSubmittedApplicant] = useState(null);

    // Connect to MetaMask function
    const connectWallet = async () => {
        if (window.ethereum) {
            try {
                const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
                setAccount(accounts[0]);
                alert(`Connected to MetaMask: ${accounts[0]}`);
            } catch (error) {
                console.error("Error connecting to MetaMask:", error);
                alert("Failed to connect to MetaMask");
            }
        } else {
            alert("MetaMask is not installed. Please install it to use this DApp.");
        }
    };

    const handleDonate = async () => {
        if (!account) {
            alert("Please connect your wallet first.");
            return;
        }

        const contract = await getContract();
        const tx = await contract.donate({ value: ethers.utils.parseEther(amount) });
        await tx.wait();
        setSubmittedSponsor({ id: sponsorId, amount }); // Save sponsor ID and amount
        setSponsorId(""); // Clear the sponsor ID input
        setAmount(""); // Clear the amount input
        alert("Donation Successful!");
    };

    const handleSubmitApplication = async () => {
        if (!account) {
            alert("Please connect your wallet first.");
            return;
        }

        const contract = await getContract();
        const tx = await contract.submitApplication(applicantName, marks, proof);
        await tx.wait();
        setSubmittedApplicant({ name: applicantName, marks, proof });
        setApplicantName(""); // Clear inputs
        setMarks("");
        setProof("");
        alert("Application Submitted!");
    };

    return (
        <div style={{
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            height: '100vh',
            backgroundColor: '#f3e5f5',
            color: '#5e35b1',
            fontFamily: 'Arial, sans-serif',
        }}>
            <h1 style={{
                fontSize: '40px',
                marginBottom: '20px',
                textShadow: '2px 2px 4px rgba(0, 0, 0, 0.3)',
            }}>
                Scholarship Platform
            </h1>

            <div>
                <button onClick={connectWallet} style={{
                    padding: '10px 20px',
                    fontSize: '16px',
                    backgroundColor: '#8e24aa',
                    color: 'white',
                    border: 'none',
                    borderRadius: '5px',
                    cursor: 'pointer',
                }}>
                    {account ? `Connected: ${account.substring(0, 6)}...${account.substring(account.length - 4)}` : "Connect to MetaMask"}
                </button>
            </div>

            <div style={{ display: 'flex', justifyContent: 'space-around', width: '100%', maxWidth: '800px', marginTop: '20px' }}>
                {/* Sponsor's Login */}
                <div style={{ textAlign: 'center', margin: '10px', marginRight: '40px' }}>
                    <h2>Sponsor's Login</h2>
                    <div>
                        <input placeholder="Sponsor ID" value={sponsorId} onChange={(e) => setSponsorId(e.target.value)} style={{ margin: '5px', padding: '10px', width: '200px' }} />
                    </div>
                    <div>
                        <input placeholder="Amount to donate (ETH)" value={amount} onChange={(e) => setAmount(e.target.value)} style={{ margin: '5px', padding: '10px', width: '200px' }} />
                    </div>
                    <button onClick={handleDonate} style={{
                        padding: '10px 20px',
                        fontSize: '16px',
                        backgroundColor: '#8e24aa',
                        color: 'white',
                        border: 'none',
                        borderRadius: '5px',
                        cursor: 'pointer',
                        marginTop: '10px',
                    }}>
                        Submit
                    </button>
                    {submittedSponsor && (
                        <p style={{ marginTop: '10px' }}>
                            Submitted: Sponsor ID - {submittedSponsor.id}, Amount - {submittedSponsor.amount} ETH
                        </p>
                    )}
                </div>

                {/* Applicant's Login */}
                <div style={{ textAlign: 'center', margin: '10px', marginLeft: '40px' }}>
                    <h2>Applicant's Login</h2>
                    <div>
                        <input placeholder="Name" value={applicantName} onChange={(e) => setApplicantName(e.target.value)} style={{ margin: '5px', padding: '10px', width: '200px' }} />
                    </div>
                    <div>
                        <input placeholder="Marks" value={marks} onChange={(e) => setMarks(e.target.value)} style={{ margin: '5px', padding: '10px', width: '200px' }} />
                    </div>
                    <div>
                        <input placeholder="Proof (hash)" value={proof} onChange={(e) => setProof(e.target.value)} style={{ margin: '5px', padding: '10px', width: '200px' }} />
                    </div>
                    <button onClick={handleSubmitApplication} style={{
                        padding: '10px 20px',
                        fontSize: '16px',
                        backgroundColor: '#8e24aa',
                        color: 'white',
                        border: 'none',
                        borderRadius: '5px',
                        cursor: 'pointer',
                        marginTop: '10px',
                    }}>
                        Submit
                    </button>
                    {submittedApplicant && (
                        <p style={{ marginTop: '10px' }}>
                            Submitted: Name - {submittedApplicant.name}, Marks - {submittedApplicant.marks}, Proof - {submittedApplicant.proof}
                        </p>
                    )}
                </div>
            </div>
        </div>
    );
}

export default App;
