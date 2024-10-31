// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


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
