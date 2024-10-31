// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


import {Ownable} from "./Ownable.sol";

struct ClientAppMetadata {
    string name;
    string description;
    string dockerUrl;
    string logoUrl;
}

contract ClientAppRegistry is Ownable {
    /*//////////////////////////////////////////////////////////////
                            EVENTS
    //////////////////////////////////////////////////////////////*/

    event ClientAppRegistered(bytes32 indexed clientAppId);

    /*//////////////////////////////////////////////////////////////
                              ERRORS
    //////////////////////////////////////////////////////////////*/

    error ClientAppAlreadyExists();

    /*//////////////////////////////////////////////////////////////
                              STATE VARIABLES
    //////////////////////////////////////////////////////////////*/

    mapping(bytes32 => ClientAppMetadata) public clientApps;
    mapping(bytes32 => bool) public isClientApp;

    /*//////////////////////////////////////////////////////////////
                              ADMIN FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    constructor(address _owner) Ownable(_owner) {}

    function registerClientApp(bytes32 clientAppId, ClientAppMetadata calldata metadata) external onlyOwner {
        if (isClientApp[clientAppId]) revert ClientAppAlreadyExists();

        clientApps[clientAppId] = metadata;
        isClientApp[clientAppId] = true;
        emit ClientAppRegistered(clientAppId);
    }

    function getClientAppMetadata(bytes32 clientAppId) external view returns (ClientAppMetadata memory) {
        return clientApps[clientAppId];
    }
}
