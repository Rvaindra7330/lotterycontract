const {expect}=require("chai");

describe("Lottery" ,()=>{

  let lottery,owner,player1;

  beforeEach(async ()=>{
    const Lottery = await ethers.getContractFactory("Lottery");
    [owner,player1] = await ethers.getSigners();
    lottery = await Lottery.deploy();
    await lottery.waitForDeployment();
  });
  it("contact deployed successfully and sets owner",async ()=>{
    const contractowner = await lottery.owner();
    expect(contractowner).to.equal(owner.address);
    expect(lottery.address).to.not.equal(0);
  });
  it("allows a player to enter", async function () {
    await lottery.connect(player1).enter({ value: ethers.parseEther("0.1") });
    const players = await lottery.getPlayers();
    expect(players[0]).to.equal(player1.address);
    expect(players.length).to.equal(1);
});
})