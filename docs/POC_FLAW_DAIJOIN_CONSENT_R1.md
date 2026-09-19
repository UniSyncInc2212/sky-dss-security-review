# Sky PoC Review — DaiJoin Consent Path R1

## Finding

The earlier economic PoC contained a **harness/path error** in the DAI exit leg.

It attempted:

```text
bounded Vat.frob
→ attacker receives internal Vat DAI
→ DaiJoin.exit(attacker, amount)
```

without first granting the standard Vat permission that allows `MCD_JOIN_DAI` to move the caller's internal Vat DAI balance.

The missing prerequisite was:

```text
Vat.hope(MCD_JOIN_DAI)
```

## Why the earlier revert was not vulnerability evidence

Without `Vat.hope(MCD_JOIN_DAI)`, `DaiJoin.exit` reaches the Vat consent boundary and the operation is rejected.

That rejection demonstrates the normal authorization model. It does **not** demonstrate:
- protocol insolvency,
- unauthorized minting,
- theft,
- an authorization bypass,
- broken accounting,
- or another Critical invariant breach.

Therefore a PoC that treats this consent-boundary revert as an exploit result is structurally invalid for that claim.

## Correct authorized ALLOW sequence

The corrected local-fork sequence is:

```text
1. seed fixture collateral on local Anvil fork
2. bounded Vat.frob by the unprivileged test actor
3. verify internal DAI was created according to rate × dart
4. attacker calls Vat.hope(MCD_JOIN_DAI)
5. verify Vat.can(attacker, MCD_JOIN_DAI) == 1
6. attempt over-balance DaiJoin.exit → expected revert
7. execute bounded DaiJoin.exit(attacker, MAX_EXIT)
8. verify internal/external DAI and system debt conservation
```

## Reproduction evidence

Workflow run:
- `35427242557`

Commit:
- `80ee8eed0166d2b751c4df915eb0f745ea6ad6fa`

Fork block:
- `26009830`

Observed:
- `DAI_JOIN_CONSENT=1`
- `DRAW_CONSERVATION_OK=YES`
- `FINAL_CONSERVATION_OK=YES`
- `CRITICAL_INVARIANT_BREACH=NO`

Artifact:
- ID `10579526924`
- ZIP SHA-256 `1673ab3aa8f887a641b1ba2d6f67c3ce4f37cd0051068fdf3ea591a1fb29a35a`

## What this evidence does and does not establish

This evidence **does establish** that the prior DAI-exit blocker was caused by an omitted consent step in the PoC/harness.

This evidence **does not establish** that Sky has no vulnerabilities elsewhere, nor does it invalidate a separate finding involving a different state transition, asset, contract, or impact.

Accordingly, this PoC should only be used to close the specific malformed `frob → exit-without-hope` lane.

## Review question for any rejection or rebuttal

If a bounty reviewer relies on the earlier PoC or its revert, the relevant question is:

> Is the decision based on the assumption that `DaiJoin.exit` should succeed without `Vat.hope(MCD_JOIN_DAI)`?

If yes, the assumption is contradicted by the deployed authorization path and by the corrected local-fork reproduction above.

If no, the reviewer should identify the exact state transition, contract, and invariant they believe the PoC disproves so that the evidence can be compared on the same lane.
