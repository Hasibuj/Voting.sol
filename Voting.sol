// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVoting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates;
    address public owner;
    mapping(address => bool) public hasVoted;

    event VoteCast(address indexed voter, uint256 candidateIndex);

    constructor(string[] memory _candidateNames) {
        owner = msg.sender;
        for (uint i = 0; i < _candidateNames.length; i++) {
            candidates.push(Candidate(_candidateNames[i], 0));
        }
    }

    function vote(uint256 _candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted!");
        require(_candidateIndex < candidates.length, "Invalid candidate index!");

        candidates[_candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
        
        emit VoteCast(msg.sender, _candidateIndex);
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getCandidatesCount() public view returns (uint256) {
        return candidates.length;
    }
}
