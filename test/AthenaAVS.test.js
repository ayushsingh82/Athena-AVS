const { expect } = require("chai");

describe("AthenaAVS", function () {
  let owner, operator, athenaAVS, clientAppRegistry, taskRegistry;

  beforeEach(async function () {
    [owner, operator] = await ethers.getSigners();

    const ClientAppRegistry = await ethers.getContractFactory("ClientAppRegistry");
    clientAppRegistry = await ClientAppRegistry.deploy(owner.address);

    const TaskRegistry = await ethers.getContractFactory("TaskRegistry");
    taskRegistry = await TaskRegistry.deploy(owner.address);

    const AthenaAVS = await ethers.getContractFactory("AthenaAVS");
    athenaAVS = await AthenaAVS.deploy(owner.address, clientAppRegistry.address, taskRegistry.address);
  });

  it("Should register an operator", async function () {
    await athenaAVS.connect(owner).registerOperator(operator.address);
    expect(await athenaAVS.isOperatorRegistered(operator.address)).to.be.true;
  });

  // Additional tests go here
});
