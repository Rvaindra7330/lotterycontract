// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Lottery is Ownable,ReentrancyGuard {

    struct Player{
        address addrs;
        uint amount;
    }
    Player[] public players;
    uint public entryfee = 0.0005 ether;
    event playerEntered(address indexed player,uint amount);
    constructor() Ownable(msg.sender) {}
    

    function enter() public payable{
        require(msg.value > entryfee ,"must pay some ether to enter the lottery");
        players.push(Player(msg.sender,msg.value));
        emit playerEntered(msg.sender, msg.value);
    }

    function pickWinner() public onlyOwner nonReentrant{
        require(players.length > 0,"no player in the lottery");
        uint winnerIndex = uint256(keccak256(abi.encodePacked(block.timestamp,players.length)))%players.length;
        payable(players[winnerIndex].addrs).transfer(address(this).balance);
        delete players;
        
    }

    function getPlayers() public view returns (address[] memory){
        address[] memory allPlayers = new address[](players.length);
        for(uint i=0;i<players.length;i++){
            allPlayers[i] = players[i].addrs;
        }
        return allPlayers;  
    }
}