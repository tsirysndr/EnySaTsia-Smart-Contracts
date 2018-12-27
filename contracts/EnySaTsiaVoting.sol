pragma solidity ^0.5.0;

import "./Ownable.sol";

contract EnySaTsiaVoting is Ownable {

  bytes32 name;
  bool sessionOpen;
  bytes32[] questions;

  mapping(bytes32 => bool) voteOpen;
  mapping(address => mapping(bytes32 => bytes32)) votes;

  constructor(bytes32 _name) public {
    name = _name;
  }

  modifier validQuestion(bytes32 question) {
    require(isValidQuestion(question));
    _;
  }

  function isValidQuestion(bytes32 question) public view returns(bool) {
    for (uint i = 0; i < questions.length; i++) {
      if (questions[i] == question) {
        return false;
      }
    }
    return true;
  }

  function changeSessionName(bytes32 _name) public onlyOwner {
    name = _name;
  }

  function startSession() public onlyOwner {
    sessionOpen = true;
  }

  function closeSession() public onlyOwner {
    sessionOpen = false;
  }

  function createQuestion(bytes32 question) public onlyOwner validQuestion(question) {
    questions.push(question);
  }

  function changeQuestion(bytes32 question, bytes32 sentense) public onlyOwner {
    for (uint i = 0; i < questions.length; i++) {
      if (questions[i] == question) {
        questions[i] = sentense;
      }
    }
  }

  function startVote(bytes32 question) public onlyOwner {
    voteOpen[question] = true;
  }

  function closeVote(bytes32 question) public onlyOwner {
    voteOpen[question] = false;
  }

  function vote(bytes32 decision, bytes32 question) public {
    votes[msg.sender][question] = decision;
  }

}
