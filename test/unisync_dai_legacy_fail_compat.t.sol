// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.6.12;

import "../src/test/dai.t.sol";

// Minimal Foundry compatibility adapter for the ten legacy ds-test testFail*
// negative controls. It does not modify Dai or the original test source.
// Each adapter calls the original external test function through a low-level
// self-call and requires that the call revert/fail, preserving testFail semantics.
contract DaiLegacyFailCompat is DaiTest {
    function _expectLegacyFail(bytes memory callData) internal {
        (bool ok,) = address(this).call(callData);
        require(!ok, "LEGACY_EXPECTED_DENY_BECAME_ALLOW");
    }

    function testCompatWrongAccountTransfers() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailWrongAccountTransfers.selector));
    }

    function testCompatInsufficientFundsTransfers() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailInsufficientFundsTransfers.selector));
    }

    function testCompatTransferWithoutApproval() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailTransferWithoutApproval.selector));
    }

    function testCompatChargeMoreThanApproved() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailChargeMoreThanApproved.selector));
    }

    function testCompatTransferFromSelfNonArbitrarySize() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailTransferFromSelfNonArbitrarySize.selector));
    }

    function testCompatMintGuyNoAuth() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailMintGuyNoAuth.selector));
    }

    function testCompatUntrustedTransferFrom() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailUntrustedTransferFrom.selector));
    }

    function testCompatPermitAddress0() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailPermitAddress0.selector));
    }

    function testCompatPermitWithExpiry() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailPermitWithExpiry.selector));
    }

    function testCompatReplay() public {
        _expectLegacyFail(abi.encodeWithSelector(this.testFailReplay.selector));
    }
}
