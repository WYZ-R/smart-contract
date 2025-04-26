// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Voting {

    struct Proposal {
        string description ;// 提案的描述
        uint256 voteCount ;// 得票数量
    }

    Proposal[] public proposals; // 动态数组，存所有提案

    mapping(address => bool) public hasVoted; // 记录地址是否已经投过票

    // 通过名字找到提案
    mapping(string => Proposal) public proposalByName;

    // 添加一个新的提案
    function addProposal(string memory _name,string memory _description) public {
        // 直接创建一个结构体的引用，然后赋值，然后再往数组里去推
        Proposal memory newProposal = Proposal({
            description: _description,
            voteCount: 0
        });
        proposals.push(newProposal);
        proposalByName[_name] = newProposal;
    }

    // 给某个提案投票
    function vote(uint256 proposalIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(proposalIndex < proposals.length, "Invalid proposal");

        proposals[proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    // 查看提案的总数
    function getProposalCount() public view returns (uint256) {
        return proposals.length;
    }

    // 查看某个提案详情
    function getProposal(uint256 index) public view returns (string memory description, uint256 voteCount) {
        require(index < proposals.length, "Invalid proposal index");
	// 这里我是想改进一下的因为通过index去找提案感觉很奇怪，所以我想着说通过名字去找提案，所以我想着给提案加个名字，然后我能通过名字去查看提案的详情
        Proposal storage proposal = proposals[index];
        return (proposal.description, proposal.voteCount);
    }
}

