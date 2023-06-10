// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function run() external {
        address mostRecentyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(mostRecentyDeployed);
    }

    function fundFundMe(address mostRecentlyDepolyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDepolyed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function run() external {
        address mostRecentyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(mostRecentyDeployed);
    }

    function withdrawFundMe(address mostRecentlyDepolyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDepolyed)).withdraw();
        vm.stopBroadcast();
    }
}
