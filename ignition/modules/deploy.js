const { buildModule }=require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("LotteryModule",(m)=>{
  const lottery = m.contract("Lottery",[]);
  console.log(lottery)
  return { lottery }
  
})