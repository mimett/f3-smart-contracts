// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Marketplace.sol";
import "../src/NFT/F3NFT.sol";
import "../src/MockRandom.sol";
import "../src/F3Box.sol";
import "../src/peripherals/F3MultiView.sol";
import "../src/F3Token.sol";
import "../src/BUSDMock.sol";
import "../src/PoolReward.sol";
import "../src/tournament/TournamentRBT.sol";
import "../src/lottery/LotteryToken.sol";
import "../src/Referral.sol";
import "../src/F3NameService.sol";
import "forge-std/console.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address busdAddress = vm.envAddress("BUSD_ADDRESS");

        address multiViewAddress = vm.envAddress("MULTI_VIEW_ADDRESS");
        F3MultiView multiView = F3MultiView(multiViewAddress);
        if (multiViewAddress == address(0)) {
            multiView = new F3MultiView();
        }
        console.log("Multiview:", address(multiView));

        address f3NameServiceAddress = vm.envAddress("F3_CENTER_ADDRESS");
        F3NameService f3NameService = F3NameService(f3NameServiceAddress);
        if (f3NameServiceAddress == address(0)) {
            f3NameService = new F3NameService(address(busdAddress));
        }
        console.log("F3NameService:", address(f3NameService));
        vm.stopBroadcast();
    }
}
