/* SPDX-License-Identifier: MIT */
pragma solidity 0.8.6;

contract HashTagManager {
    uint256 public baseReward; // the minimum reward a previousIt receives after their taggee tags another account
    uint256 public cliff;// the period after which the reward multiplier ends and $TAG can be minted to dilute existing $TAG holders

    address public depositToken;
}