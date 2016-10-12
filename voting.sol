pragma solidity >=0.3.0;
contract VotingContract {

  mapping(address => uint) votes_per_candidate;
  mapping(address => address) votes;
  mapping(address => bool) candidates;

  function add_candidate(address candidate) {
    candidates[candidate] = true;
  }

  function add_vote(address voter, address candidate)  returns (address) {
    if (votes[voter]!= address(0) && candidates[candidate]) {
      votes[voter] = candidate;
      votes_per_candidate[candidate]++;
    } else {
      throw;
    }
    return votes[voter];
  }

  function get_vote_of_voter(address voter) returns (address) {
    return votes[voter];
  }

  function get_votes_of_candidate(address candidate) returns (uint) {
    return votes_per_candidate[candidate];
  }
}
