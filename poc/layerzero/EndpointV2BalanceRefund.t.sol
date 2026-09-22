// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import { EndpointV2Test } from "./EndpointV2.t.sol";
import { MessagingParams } from "../contracts/interfaces/ILayerZeroEndpointV2.sol";

contract EndpointV2BalanceRefundPoC is EndpointV2Test {
    function test_preexisting_endpoint_lz_balance_can_fund_next_send_and_refund_to_arbitrary_address() public {
        endpoint.setLzToken(address(lzToken));

        // Unrelated/pre-existing LZ-token balance already held by EndpointV2.
        lzToken.transfer(address(endpoint), 200);
        assertEq(lzToken.balanceOf(address(endpoint)), 200);

        address payable chosenRefund = payable(address(0xBEEF));
        MessagingParams memory params = MessagingParams(remoteEid, receiverB32, message, "", true);
        vm.deal(address(this), 1 ether);

        // No additional LZ tokens are supplied for this send.
        endpoint.send{ value: 100 }(params, chosenRefund);

        assertEq(lzToken.balanceOf(address(simpleMsgLib)), 99);
        assertEq(lzToken.balanceOf(chosenRefund), 101);
        assertEq(lzToken.balanceOf(address(endpoint)), 0);
    }
}
