# Fail-Closed Invariant Policy R1

## Rule

For every tested security boundary, define the expected outcome before execution.

| Expected | Observed | Classification | System action |
|---|---|---|---|
| DENY | DENY | boundary held | continue |
| DENY | ALLOW | vulnerability candidate | FAIL CLOSED, terminate, preserve evidence |
| ALLOW | ALLOW | authorized path held | continue |
| ALLOW | DENY | path/configuration failure | stop lane, preserve evidence, diagnose |

## Immediate termination conditions

The run must stop immediately when any of the following occurs:

- a boundary expected to deny unexpectedly allows;
- protected state changes after a denied operation;
- accounting or conservation invariants break;
- authorization state changes without the expected authority;
- the observed transition differs materially from the declared pre-test invariant.

On trigger, record:

- exact test/lane identifier;
- expected outcome;
- observed outcome;
- before/after state;
- pinned code and block references;
- artifact hashes;
- `SYSTEM_ACTION=FAIL_CLOSED_TERMINATE`.

## Evidence rule

Expected authorization behavior is not a vulnerability merely because it passes.

A bounty candidate exists when the tested system crosses a boundary it was required to preserve, or produces another in-scope security impact under the bounty program's rules.

This policy is defensive and applies to local-fork and authorized test environments only.
