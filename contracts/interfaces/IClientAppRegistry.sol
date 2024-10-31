// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IClientAppRegistry {
    function isClientApp(bytes32 clientAppId) external view returns (bool);
}
