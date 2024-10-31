// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


import {Ownable} from "./Ownable.sol";

struct TaskMetadata {
    string title;
    string description;
    string executionUrl;
    string imageUrl;
}

contract TaskRegistry is Ownable {
    /*//////////////////////////////////////////////////////////////
                            EVENTS
    //////////////////////////////////////////////////////////////*/

    event TaskRegistered(bytes32 indexed taskId);
    event TaskUpdated(bytes32 indexed taskId);

    /*//////////////////////////////////////////////////////////////
                              ERRORS
    //////////////////////////////////////////////////////////////*/

    error TaskAlreadyExists();
    error TaskNotFound();

    /*//////////////////////////////////////////////////////////////
                              STATE VARIABLES
    //////////////////////////////////////////////////////////////*/

    mapping(bytes32 => TaskMetadata) public tasks;
    mapping(bytes32 => bool) public isTask;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address _owner) Ownable(_owner) {}

    /*//////////////////////////////////////////////////////////////
                              ADMIN FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function registerTask(bytes32 taskId, TaskMetadata calldata metadata) external onlyOwner {
        if (isTask[taskId]) revert TaskAlreadyExists();

        tasks[taskId] = metadata;
        isTask[taskId] = true;
        emit TaskRegistered(taskId);
    }

    function updateTask(bytes32 taskId, TaskMetadata calldata metadata) external onlyOwner {
        if (!isTask[taskId]) revert TaskNotFound();

        tasks[taskId] = metadata;
        emit TaskUpdated(taskId);
    }

    function getTaskMetadata(bytes32 taskId) external view returns (TaskMetadata memory) {
        return tasks[taskId];
    }
}

