# Athena AVS Protocol

## What is Athena?
Athena is a decentralized Autonomous Validation System (AVS) enabling decentralized and autonomous operations for diverse Web3 applications. Athena provides the infrastructure necessary for Operators to validate and execute complex, off-chain tasks reliably and in a trustless manner. This protocol allows secure interactions with blockchain networks, ensuring efficient and transparent operations.

### Motivation
Web3 applications are transforming industries by introducing decentralized frameworks, but they often demand high levels of technical skill, constant user engagement, and complex cross-chain operations. Such requirements create inefficiencies, slow adoption, and increase security risks. Athena simplifies these challenges by offering a distributed validation framework that executes, validates, and verifies tasks through a trust-minimized approach.

## Athena's Autonomous System
Athena enables developers to register arbitrary client applications that Operators can execute and validate in a secure and decentralized environment. Operators in the network can engage in task execution, with results validated by Aggregators before being stored or broadcast on-chain. By integrating with Ethereum's EigenLayer, Athena ensures security, transparency, and tamper resistance for a wide range of Web3 applications.

### Core Components of Athena AVS
1. **AthenaAvs** - The main AVS component managing Operator registration.
2. **TaskRegistry** - Manages task registration, tracking, and execution by Operators.
3. **ClientAppRegistry** - Facilitates client application registration, enabling interoperability with registered tasks.
4. **Operators** - Nodes responsible for executing tasks registered within the Athena ecosystem.
5. **Aggregator** - Responsible for aggregating, validating, and broadcasting results from Operators, ensuring consensus before task completion.

## AVSthon Scope
The AVSthon version of Athena is a proof of concept that delivers a functional decentralized environment for off-chain task execution and validation. The scope includes:

- **AthenaAvs**: Implements basic Operator registration with Athena AVS.
- **TaskRegistry**: Manages task registration and Operator execution requests.
- **ClientAppRegistry**: Supports client application registration and access control.
- **Demo Operator Application**: A Rust-based executable that fetches data, packaged as a Docker container.
- **Aggregator**: Validates and verifies task results received from multiple Operators, confirming consensus before broadcasting results on-chain.


## Contract Deployments and Explorer Links



### ClientAppRegistry
- **Contract Address**: `0x08D1b5896F369FcE571BEDabFF48960B9727aDc1`
- **Explorer Link**: [ClientAppRegistry Transaction](https://holesky.etherscan.io/tx/0xe8b53c85f8d069bd0ad83477cb08978f1d223d3b88d6f04c12e75785de9d9c34)

### TaskRegistry
- **Contract Address**: `0x40840b6125C5a837A3D7f3815691F65F0D94Fc1e`
- **Explorer Link**: [TaskRegistry Transaction](https://holesky.etherscan.io/tx/0xd18740f0a7624e7aba2fd372340b866743b4ddb6dace215eea29674be9841d2a)

### Athena AVS
- **Contract Address**: `0xEf4c61F0570890A5160f483DC4c81FA875E23b5b`
- **Explorer Link**: [Athena AVS Transaction](https://holesky.etherscan.io/tx/0xe2f0e5a49a0454fc46a0d246313bf936e11a2b0be804814f2122e1312323159d)


## Workflow Overview

### Operator Registration
Operators register with EigenLayer, enabling them to participate in task execution within the Athena protocol. After registration, they can join specific client applications through the `optInClientAppId` function, gaining access to execute associated tasks.

### Task Execution Flow
1. **Task Creation**: A client application registers a task within the TaskRegistry.
2. **Task Monitoring**: Operators monitor tasks emitted from TaskRegistry.
3. **Task Execution**: Operators perform the tasks using Docker containers with pre-built applications.
4. **Result Aggregation**: Operators send signed results to the Aggregator.
5. **Consensus & Verification**: Aggregator verifies results using a quorum of signatures and broadcasts verified data to the TaskRegistry.

### Design Decisions and Future Improvements
1. **Operator Registration**: Currently managed directly through EigenLayer; future iterations will introduce a RegistryCoordinator for pre-registration verifications.
2. **Consensus Mechanism**: Uses majority voting consensus; future improvements will integrate advanced consensus protocols for enhanced security.
3. **Signature Scheme**: ECDSA is currently implemented for simplicity; planned upgrades will include BLS signatures for secure, efficient signature aggregation.

## Components

### AthenaAvs.sol
Manages registration and deregistration of Operators, allowing Operators to opt-in to client applications and update task metadata. Integrates directly with the AVSDirectory in EigenLayer to synchronize Operator states.

### TaskRegistry.sol
Handles the registration of tasks requested by client applications, emits task request events, and stores results once they are verified by the Aggregator.

### ClientAppRegistry.sol
Stores metadata for client applications, allowing verification and validation of client IDs before tasks are assigned to Operators.

## Getting Started

### Prerequisites
- Node.js & npm
- Docker
- Rust

### Setup Instructions

1. **Clone the Repository**
    ```bash
    git clone https://github.com/your-username/athena-avs
    cd athena-avs
    ```

2. **Install Dependencies**
    ```bash
    npm install
    ```

3. **Run Local Network**
    Start a local network using Hardhat:
    ```bash
    npx hardhat node
    ```

4. **Deploy Contracts**
    In a new terminal, deploy contracts to the local network:
    ```bash
    npx hardhat run scripts/deploy.js --network localhost
    ```

5. **Run Operator Node**
    Start the Operator node and monitor the task registry:
    ```bash
    cargo run --bin operator
    ```

6. **Aggregator Setup**
    Start the Aggregator for consensus validation:
    ```bash
    cargo run --bin aggregator
    ```

### Running Tests
Run the unit tests for contract functionality:
```bash
npx hardhat test
