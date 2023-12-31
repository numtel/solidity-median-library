// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {MedianLibrary} from "../src/MedianLibrary.sol";

contract MedianLibraryTest is Test {
  using MedianLibrary for MedianLibrary.Data;

  MedianLibrary.Data data;

  function testBasic5() public {
    data.set(address(1), 1);
    data.set(address(2), 2);
    data.set(address(3), 4);
    data.set(address(4), 5);
    data.set(address(5), 9);
    assertEq(data.median(), 4);
  }

  function testBasic4() public {
    data.set(address(1), 1);
    data.set(address(2), 2);
    data.set(address(3), 4);
    data.set(address(4), 5);
    assertEq(data.median(), 3);
  }

  function testBasic3() public {
    data.set(address(1), 1);
    data.set(address(2), 2);
    data.set(address(4), 5);
    assertEq(data.median(), 2);
  }

  function testBasic2() public {
    data.set(address(1), 1);
    data.set(address(4), 7);
    assertEq(data.median(), 4);
  }

  function testBasic2_Update() public {
    data.set(address(1), 1);
    data.set(address(4), 7);
    assertEq(data.median(), 4);

    data.set(address(1), 11);
    assertEq(data.median(), 9);
  }

  function testBasic1() public {
    data.set(address(1), 1);
    assertEq(data.median(), 1);
  }

  function testMany(uint count) public {
    count = bound(count, 1, 100);

    for(uint i = 1; i < count + 1; i++) {
      data.set(address(uint160(i)), i);
    }

    assertEq(data.median(), (count + 1) / 2);
  }

  function testBucket() public {
    data.set(address(1), 1);
    data.set(address(2), 1);
    data.set(address(3), 1);
    data.set(address(4), 4);
    data.set(address(5), 4);
    assertEq(data.median(), 1);
  }

  function testBucket2() public {
    data.set(address(1), 1);
    data.set(address(2), 1);
    data.set(address(3), 1);
    data.set(address(4), 3);
    data.set(address(5), 5);
    data.set(address(6), 6);
    data.set(address(7), 6);
    data.set(address(8), 7);
    assertEq(data.median(), 4);
  }

}
