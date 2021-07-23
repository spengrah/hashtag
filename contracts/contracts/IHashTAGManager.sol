/* SPDX-License-Identifier: MIT */
pragma solidity 0.8.6;

interface IHashTAGManager {
    function baseReward() external view returns (uint256);

    function cliff() external view returns (uint256);

    function depositToken() external view returns (address);
}