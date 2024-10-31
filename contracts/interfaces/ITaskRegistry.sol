// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

struct TaskMetadata {
    string name;
    string description;
    string url;
    uint256 createdAt;
}

interface ITaskRegistry {
    function isTask(bytes32 taskId) external view returns (bool);
    function getTaskMetadata(bytes32 taskId) external view returns (TaskMetadata memory);
}
