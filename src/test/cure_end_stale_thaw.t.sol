// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.6.12;

import "ds-test/test.sol";

import {Cure} from "../cure.sol";
import {End} from "../end.sol";

interface Hevm {
    function warp(uint256) external;
}

contract MutableCureSource {
    uint256 public cure;

    constructor(uint256 cure_) public {
        cure = cure_;
    }

    function update(uint256 cure_) external {
        cure = cure_;
    }
}

contract CageOnlyMock {
    uint256 public live = 1;

    function cage() external {
        live = 0;
    }
}

contract VatThawMock {
    uint256 public live = 1;
    uint256 public debtValue;
    uint256 public daiValue;

    constructor(uint256 debt_) public {
        debtValue = debt_;
    }

    function cage() external {
        live = 0;
    }

    function debt() external returns (uint256) {
        return debtValue;
    }

    function dai(address) external view returns (uint256) {
        return daiValue;
    }
}

contract CureEndStaleThawTest is DSTest {
    Hevm hevm;

    Cure cure;
    End end;
    VatThawMock vat;
    CageOnlyMock cat;
    CageOnlyMock dog;
    CageOnlyMock vow;
    CageOnlyMock pot;
    CageOnlyMock spot;
    MutableCureSource source;

    function setUp() public {
        hevm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

        vat = new VatThawMock(1_000);
        cat = new CageOnlyMock();
        dog = new CageOnlyMock();
        vow = new CageOnlyMock();
        pot = new CageOnlyMock();
        spot = new CageOnlyMock();

        cure = new Cure();
        source = new MutableCureSource(100);
        cure.lift(address(source));
        cure.file("wait", 1 hours);

        end = new End();
        end.file("vat", address(vat));
        end.file("cat", address(cat));
        end.file("dog", address(dog));
        end.file("vow", address(vow));
        end.file("pot", address(pot));
        end.file("spot", address(spot));
        end.file("cure", address(cure));
        end.file("wait", 1 hours);

        cure.rely(address(end));
    }

    // Local PoC only. It demonstrates that Cure's one-time loaded marker does
    // not bind freshness: after a source changes, tell() can still return the
    // previously cached amount and End.thaw() consumes that cached total.
    function test_stale_loaded_value_is_consumed_by_thaw() public {
        end.cage();

        // Anyone can populate Cure after cage.
        cure.load(address(source));
        assertEq(cure.lCount(), 1);
        assertEq(cure.tell(), 100);

        // The underlying source changes during the settlement window.
        source.update(200);

        // The "all sources loaded once" marker remains true, so tell() still
        // exposes the cached value until another permissionless load occurs.
        assertEq(cure.lCount(), 1);
        assertEq(cure.tell(), 100);

        // Once End's own wait has elapsed, thaw() is permissionless and reads
        // the stale cached aggregate.
        hevm.warp(block.timestamp + 1 hours);
        end.thaw();

        assertEq(end.debt(), 900); // 1,000 - stale 100

        // Fresh re-load would have produced a different settlement debt.
        cure.load(address(source));
        assertEq(cure.tell(), 200);
        assertEq(vat.debtValue() - cure.tell(), 800);
    }
}
