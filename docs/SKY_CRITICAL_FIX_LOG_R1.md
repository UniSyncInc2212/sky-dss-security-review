# Sky Critical-Invariant Fix Log R1

Repository: `UniSyncInc2212/sky-dss-security-review`  
Branch: `sky-critical-invariants-r1-20260918`  
Purpose: preserve an append-only engineering record of every harness fix, protocol observation, workflow run, and evidence boundary for the Sky/Immunefi local-fork investigation.

## Recording rule

Every material change must record:
- UTC timestamp or GitHub event time
- failure or observation
- root cause
- exact fix
- commit SHA
- workflow run / artifact when applicable
- evidence classification:
  - `HARNESS_FIX`
  - `INFRA_FAILURE`
  - `NEGATIVE_CONTROL_PASS`
  - `PROTOCOL_BREACH_CANDIDATE`
  - `NO_BREACH_ON_LANE`

Harness failures and fixture failures are never to be reported as protocol vulnerabilities.

---

## 2026-09-18T23:41:52Z — Initial critical invariant gate

**Classification:** `HARNESS_BUILD`

Commit: `a40b7faabed22a2bba740b6e83dee67e166fa587`

Added `.github/workflows/sky-critical-invariants-r1.yml` to replace the prior historical `Dog.bark` replay as the primary big-money gate.

Targeted invariants:
1. unprivileged `Vat.suck` must fail,
2. unprivileged `Vat.slip` must fail,
3. unprivileged `Vat.fold` must fail,
4. unprivileged `Vat.grab` must fail,
5. unauthorized `Vat.move` from a foreign balance must fail,
6. failed negative-control calls must leave `debt`, `vice`, attacker internal DAI, and attacker external DAI unchanged,
7. a bounded local-fork collateral/debt path must conserve economic value across `frob` and `DaiJoin.exit`.

Safety boundary:
- upstream RPC read only,
- all writes to `127.0.0.1:8545`,
- Anvil-only RPC check required before any transaction.

---

## 2026-09-18T23:41:54Z — Workflow parse failure

**Classification:** `HARNESS_FIX`

Workflow run: `35406700343`  
Head: `a40b7faabed22a2bba740b6e83dee67e166fa587`

Observed:
- workflow concluded failure immediately,
- no jobs were assigned,
- therefore no protocol test ran.

Root cause:
- embedded Python heredocs broke YAML block indentation.

Fix:
- replaced embedded heredocs with single-line `python3 -c` calculations.

Commit:
- `3f646bcc3f660d27fba7ca245d58d6a09465a7cc`

Evidence boundary:
- **not a Sky result**,
- **not a protocol failure**,
- **not bounty evidence**.

---

## 2026-09-18T23:43:31Z — Critical invariant run executes

Workflow run: `35406799731`  
Head: `3f646bcc3f660d27fba7ca245d58d6a09465a7cc`  
Fork block: `26007755`

Resolved live addresses:
- `MCD_VAT = 0x35D1b3F3D7966A1DFe207aa4514C12a259A0492B`
- `MCD_DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F`
- `MCD_JOIN_DAI = 0x9759A6Ac90977b93B58547b4A71c78317f391A28`
- `MCD_DOG = 0x135954d155898D42C90D2a57824C690e0c7BEf1B`

Code fingerprints:
- VAT SHA-256: `9ded3128c8f42b27357dc6567a65adb901cbdde06bb2fe07e46c0795fda17bb4`
- DAI SHA-256: `681f32db7986c544632b9a74978b14f7a93606f0ba642d4f3c5232dcad55f045`

### Gate A result

**Classification:** `NEGATIVE_CONTROL_PASS`

Attacker Vat ward:
- `0`

Observed expected reverts:
- `Vat.suck` -> `Vat/not-authorized`
- `Vat.slip` -> `Vat/not-authorized`
- `Vat.fold` -> `Vat/not-authorized`
- `Vat.grab` -> `Vat/not-authorized`
- foreign `Vat.move` -> `Vat/not-allowed`

State result:
- `NEGATIVE_CONTROL_STATE_CHANGED=NO`

Conclusion:
- this access-control lane did **not** produce a critical vulnerability.
- this result eliminates one false-positive path; it does not clear other Sky surfaces.

### Gate B fixture failure

**Classification:** `HARNESS_FIX`

Selected path:
- `ETH-A`
- join: `0x2F0b23f53734252Bda2277357e97e1517d6B042A`

Observed:
- direct `join(address)` fixture transaction reverted with empty revert data before the conservation test began.

Artifact:
- GitHub artifact ID: `10573490272`
- uploaded ZIP SHA-256: `5f09412b3ba65c1b971139ecdec98f3ffe5c914a916a093076385f6478663c98`

Conclusion:
- no economic invariant verdict was produced,
- this is a fixture failure, not a protocol failure.

---

## 2026-09-18 — Economic fixture repair

**Classification:** `HARNESS_FIX`

Commit:
- `5d89e02cba0edfb86fa5b6bc1ff43f4359dedfce`

Root cause addressed:
- the live collateral adapter's external `join()` behavior is not needed to test `Vat.frob` accounting and caused the harness to stop before the target invariant.

Fix:
- require the selected collateral adapter to already be a live `Vat.wards(adapter) == 1` authority,
- on **local Anvil only**, impersonate that already-authorized adapter,
- call `Vat.slip` solely to seed free collateral for the attacker fixture,
- immediately stop impersonation,
- run all tested `frob`, `move`, and `DaiJoin.exit` boundaries as the unprivileged attacker.

New evidence field:
- `FIXTURE_SEED_METHOD=ANVIL_IMPERSONATED_AUTHORIZED_ADAPTER_SLIP`

Boundary:
- impersonation is test-fixture setup only,
- it is not an exploit step,
- it cannot be used as bounty impact evidence,
- only post-fixture attacker actions can qualify as protocol evidence.

---

## Next required record

The next workflow run must record one of:

- `CRITICAL_INVARIANT_BREACH=YES` with exact before/after state and reproducible attacker sequence, or
- `CRITICAL_INVARIANT_BREACH=NO` and the tested lane is eliminated.

No payout claim is to be made from a harness fix, infrastructure error, fixture setup, or expected negative-control revert.


---

## 2026-09-18T23:46:08Z — Economic invariant run after fixture repair

**Classification:** `NEGATIVE_CONTROL_PASS / HARNESS_PATH_SETUP`

Workflow run:
- `35406953310`

Head:
- `f3caa79fbebe3dc93c4797284a556a9e866af2bc`

Fork block:
- `26007767`

Observed:
- attacker Vat ward remained `0`
- unauthorized `Vat.suck` denied with `Vat/not-authorized`
- unauthorized `Vat.slip` denied with `Vat/not-authorized`
- unauthorized `Vat.fold` denied with `Vat/not-authorized`
- unauthorized `Vat.grab` denied with `Vat/not-authorized`
- foreign `Vat.move` denied with `Vat/not-allowed`
- `NEGATIVE_CONTROL_STATE_CHANGED=NO`

Economic fixture:
- selected `ETH-A`
- authorized adapter `0x2F0b23f53734252Bda2277357e97e1517d6B042A`
- fixture seed: `ANVIL_IMPERSONATED_AUTHORIZED_ADAPTER_SLIP`
- free collateral seed: `1000000000000000000000`

Bounded draw:
- over-boundary `frob` reverted `Vat/not-safe`
- `EXPECTED_RAD_GAIN=906668965517241379310344652206419799310657816023872`
- `DRAW_CONSERVATION_OK=YES`

DAI exit leg:
- over-balance exit attempt reverted `Vat/not-allowed`
- root cause: attacker had not granted the normal `DaiJoin` consent path for its own internal DAI balance
- the valid exit leg therefore did not complete in this run

Artifact:
- ID `10573145994`
- ZIP SHA-256 `719bb19152d34d7e3a7a97ba86da3344e1782e52103d3134c54b37c63cbb0ae9`

Evidence boundary:
- no critical invariant breach was produced
- access control held
- over-boundary safety check held
- draw accounting conserved exactly
- the incomplete exit leg is a harness/path setup item, not a protocol vulnerability


---

## 2026-09-19T06:40:45Z — Authorized DaiJoin ALLOW path completed

**Classification:** `NO_BREACH_ON_LANE`

Workflow run:
- `35427242557`

Head:
- `80ee8eed0166d2b751c4df915eb0f745ea6ad6fa`

Fork block:
- `26009830`

Exact path correction:
- after the bounded `Vat.frob` created attacker-owned internal DAI, the attacker called `Vat.hope(MCD_JOIN_DAI)`,
- verified `Vat.can(attacker, MCD_JOIN_DAI) == 1`,
- then exercised `DaiJoin.exit(attacker, MAX_EXIT)` on the local Anvil fork.

Observed:
- `DAI_JOIN_CONSENT=1`
- over-balance `DaiJoin.exit` still reverted as expected,
- legitimate bounded `DaiJoin.exit` completed,
- `DRAW_CONSERVATION_OK=YES`,
- `FINAL_CONSERVATION_OK=YES`,
- `CRITICAL_INVARIANT_BREACH=NO`.

Economic record:
- `EXPECTED_RAD_GAIN=900086206896551724137930327963549634737717129426904`
- `FINAL_INTERNAL_DAI=327963549634737717129426904`
- `FINAL_EXTERNAL_DAI=900086206896551724137930`
- `FINAL_DEBT=12027249275318639131342911851589919279124466971554184613`

Artifact:
- ID `10579526924`
- ZIP SHA-256 `1673ab3aa8f887a641b1ba2d6f67c3ce4f37cd0051068fdf3ea591a1fb29a35a`

Evidence boundary:
- the previous exit blocker was harness consent setup, not a Sky vulnerability,
- the normal authorized ALLOW route now runs end-to-end,
- this lane is eliminated as a critical-bounty candidate unless a separate state transition or invariant violation is demonstrated.
