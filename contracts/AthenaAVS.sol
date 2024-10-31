// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Ownable} from "./Ownable.sol";
import {IClientAppRegistry} from "./interfaces/IClientAppRegistry.sol";
import {ITaskRegistry} from "./interfaces/ITaskRegistry.sol";

contract AthenaAVS is Ownable {
    /*//////////////////////////////////////////////////////////////
                            EVENTS
    //////////////////////////////////////////////////////////////*/

    event OperatorRegistered(address indexed operator);
    event OperatorDeregistered(address indexed operator);
    event ClientAppIdRegistered(address indexed operator, bytes32 clientAppId);

    /*//////////////////////////////////////////////////////////////
                              ERRORS
    //////////////////////////////////////////////////////////////*/

    error ClientAppIdInvalid();
    error OperatorNotRegistered();

    /*//////////////////////////////////////////////////////////////
                              STATE
    //////////////////////////////////////////////////////////////*/

    IClientAppRegistry public immutable clientAppRegistry;
    ITaskRegistry public immutable taskRegistry;
    mapping(address => bool) public isOperatorRegistered;
    mapping(address => mapping(bytes32 => bool)) public operatorClientAppIdRegistrationStatus;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address _owner, address _clientAppRegistry, address _taskRegistry) Ownable(_owner) {
        clientAppRegistry = IClientAppRegistry(_clientAppRegistry);
        taskRegistry = ITaskRegistry(_taskRegistry);
    }

    /*//////////////////////////////////////////////////////////////
                              OPERATOR FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function registerOperator(address operator) external onlyOwner {
        isOperatorRegistered[operator] = true;
        emit OperatorRegistered(operator);
    }

    function deregisterOperator(address operator) external onlyOwner {
        isOperatorRegistered[operator] = false;
        emit OperatorDeregistered(operator);
    }

    function registerClientAppId(bytes32 clientAppId) external {
        if (!clientAppRegistry.isClientApp(clientAppId)) revert ClientAppIdInvalid();
        if (!isOperatorRegistered[msg.sender]) revert OperatorNotRegistered();

        operatorClientAppIdRegistrationStatus[msg.sender][clientAppId] = true;
        emit ClientAppIdRegistered(msg.sender, clientAppId);
    }
}
