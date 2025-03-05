// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract Lottery {

    address public owner;
    address[] public players;

    constructor(){
        owner=msg.sender;
    }

    function enter() public payable{
        require(msg.value > 0 ,"must pay some ether to enter the lottery");
        players.push(msg.sender);
    }

    function pickWinner() public{
        require(msg.sender==owner,"only owner can pick the winner");
        uint winnerIndex = uint256(keccak256(abi.encodePacked(block.timestamp,players.length)))%players.length;

        address payable winner = payable(players[winnerIndex]);
        winner.transfer(address(this).balance);
        players = new address[](0);
    }

    function getPlayers() public view returns (address[] memory){
        return players;
    }
}