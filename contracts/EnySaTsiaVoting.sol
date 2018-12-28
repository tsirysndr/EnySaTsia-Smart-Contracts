pragma solidity ^0.5.0;

import "./Ownable.sol";

contract EnySaTsiaVoting is Ownable {

  bytes name;
  bool sessionOpen;
  bytes[] questions;

  mapping(bytes32 => bool) voteOpen;
  mapping(address => mapping(bytes32 => bytes)) votes;

  constructor(bytes memory _name) public {
    name = _name;
  }

  modifier validQuestion(bytes memory question) {
    require(
      isValidQuestion(question),
      "This Question already exists!"
    );
    _;
  }

  function isValidQuestion(bytes memory question) public view returns(bool) {
    for (uint i = 0; i < questions.length; i++) {
      if (sha256(questions[i]) == sha256(question)) {
        return false;
      }
    }
    return true;
  }

  function changeSessionName(bytes memory _name) public onlyOwner {
    name = _name;
  }

  function startSession() public onlyOwner {
    sessionOpen = true;
  }

  function closeSession() public onlyOwner {
    sessionOpen = false;
  }

  function createQuestion(bytes memory question) public onlyOwner validQuestion(question) {
    questions.push(question);
  }

  function changeQuestion(bytes memory question, bytes memory sentense) public onlyOwner {
    for (uint i = 0; i < questions.length; i++) {
      if (sha256(questions[i]) == sha256(question)) {
        questions[i] = sentense;
      }
    }
  }

  function startVote(bytes memory question) public onlyOwner {
    voteOpen[sha256(question)] = true;
  }

  function closeVote(bytes memory question) public onlyOwner {
    voteOpen[sha256(question)] = false;
  }

  function vote(bytes memory decision, bytes memory question) public {
    votes[msg.sender][sha256(question)] = decision;
  }

}
