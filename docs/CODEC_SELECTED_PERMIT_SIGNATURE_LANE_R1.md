# Codec-Selected Permit-Signature Lane Review R1

## Authority and lane selection

This lane was not chosen by the Sky target implementation.

Golden SSP selection evidence:
- authority: `GoldenSSP`
- codec: `ssp-network-v1`
- wire: `SSP1`
- closed lanes: `consent-boundary`, `accounting-conservation`
- selected lane: `permit-signature`
- route nodes: `[1,30,99]`
- resistance: `3`
- path reference: `ssp-path-078b167c85baa9b7bf7ab4b016fb5717c6e4c890a1f0315efe4c7932343a70d2`

Source proof is pinned in the UniSync SecureOS branch and copied into this investigation record.

## Deployed target evidence already captured

Prior local-fork evidence resolved:
- `MCD_DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F`
- deployed code SHA-256: `681f32db7986c544632b9a74978b14f7a93606f0ba642d4f3c5232dcad55f045`

The bounty scope explicitly names `MCD_DAI`; deployed-contract impact is required for reward eligibility.

## Permit state machine under review

The current source implements the permit authorization sequence as:

1. build EIP-712 digest from:
   - `DOMAIN_SEPARATOR`
   - `PERMIT_TYPEHASH`
   - holder
   - spender
   - nonce
   - expiry
   - allowed
2. reject zero holder;
3. require `ecrecover(digest, v, r, s) == holder`;
4. require permit is not expired;
5. require supplied nonce equals the holder nonce;
6. increment nonce;
7. set allowance to max uint when `allowed=true`, or zero when `allowed=false`.

## Boundary invariants

A real candidate on this lane requires at least one of these observations on the deployed contract in a permitted local-fork reproduction:

| Invariant | Required behavior | Candidate trigger |
|---|---|---|
| Wrong signer | DENY | permit succeeds or protected state changes |
| Replay | DENY | same authorization succeeds twice |
| Wrong nonce | DENY | nonce mismatch mutates allowance or nonce |
| Expired authorization | DENY | expired signed permit changes state |
| Valid permit | ALLOW | establishes baseline only |
| Valid revoke | ALLOW | establishes baseline only |

For every expected-DENY case, both `nonces(holder)` and `allowance(holder,spender)` must remain unchanged.

## Source-level observations

The source already has explicit checks for:
- signer recovery,
- expiration,
- nonce equality,
- zero-address holder.

The existing source test suite contains cases for:
- normal permit,
- expiry,
- replay,
- zero holder.

This does **not** prove the deployed contract is free of a permit vulnerability. It does mean a payout-quality report on this lane must demonstrate behavior beyond those expected controls and must reproduce against the deployed `MCD_DAI` state.

## Non-claims

- No permit vulnerability is claimed from source inspection alone.
- A normal valid permit is not a vulnerability.
- A rejected replay is not a vulnerability.
- A test harness failure is not a vulnerability.
- This lane is not closed until the deployed local-fork state transition is reproduced or an equivalent deployed-bytecode proof is obtained.
