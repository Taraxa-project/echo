// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../contracts/Counter.sol";
import {IngesterProxy} from "../../contracts/IngesterOrchestratorProxy/IngesterProxy.sol";
import {IngesterGroupManager} from "../../contracts/IngesterOrchestratorProxy/IngesterGroupManager.sol";
import {IngesterRegistry} from "../../contracts/IngesterOrchestratorProxy/IngesterRegistry.sol";
import {IngesterDataGathering} from "../../contracts/IngesterOrchestratorProxy/IngesterDataGathering.sol";

//test foundry
contract CounterTest is Test {
    Counter public counter;

    function setUp() public {

        counter = new Counter();
        counter.setNumber(0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
