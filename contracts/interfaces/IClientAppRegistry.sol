// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

interface IClientAppRegistry {
    function isClientApp(bytes32 clientAppId) external view returns (bool);
}
