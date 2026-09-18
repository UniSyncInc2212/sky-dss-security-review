# Sky / Immunefi Bounty Change Backlog R1

Purpose: chronological source-of-truth record of Sky-bounty-related work, changes, runs, fixes, artifacts, and evidence boundaries across UniSync repositories.

Classification key:
- PREP — setup / architecture / packaging
- HARNESS — test harness change
- FIX — harness or evidence fix
- EVIDENCE — reproducibility / receipt / hash / artifact
- NEGATIVE_CONTROL_PASS — expected denial or conservation held
- PROTOCOL_BREACH_CANDIDATE — only if an unprivileged action produces an in-scope economic impact
- NOT_A_BOUNTY — explicitly non-qualifying work
- INFRA_FAILURE — CI / runner / parser / environment failure

Nothing in this backlog is an accepted bounty award unless separately supported by a program acceptance or payout record.

---

## 2026-09-16 — SecureOS Golden Intent / Sky preparation lane

### PR #199 — Golden Intent PoC: codecflow + reproducible Sky-target receipt

2026-09-16T22:23:08Z
- Commit: 8c439e1769840d94743d8339702fb9dc334be8ff
- Type: PREP
- Change: Wire founder Golden Intent codec flow through LightPATH.
- Detail: morphic stub → least-resistance path → Golden SSP loaded binary → seal / receipt / revoke readiness.
- Evidence boundary: local UniSync stack only.

2026-09-16T22:24:00Z
- Commit: cd71280d1082e8919780ffcb337f6ea212e6f1e0
- Type: HARNESS
- Change: Add Golden Intent PoC prove script and local receipt.
- Detail: reproducible loopback prove under Golden SSP lab.

2026-09-16T22:25:13Z
- Commit: 39ddd9944d6e880ed13d2fef1c966b65aa7d24e5
- Type: EVIDENCE
- Change: Record local prove seals and claims row.
- Result: LOCAL_PASS only.

2026-09-16T22:25:26Z
- Commit: 27ef6fe82359a46e494470daa00c89c87fcdf3ae
- Type: EVIDENCE
- Change: Bound Sky-target claim in claims register.
- Boundary: WAN/L4 held; local only.

2026-09-16T22:26:08Z
- Commit: d3111cff7b1691fc48a8d8a0e53ad77532438a64
- Type: EVIDENCE
- Change: Refresh PoC seals to final branch head.

2026-09-16T22:58:47Z
- Commit: 13f8351ae3e2315e2821d2b86c24b5ab94f88573
- Type: NOT_A_BOUNTY / CORRECTION
- Change: Correct Sky target mix-up.
- Result: PR #199 reclassified as LightPATH lab only.
- Explicit boundary: not Sky Protocol / MakerDAO evidence; no Immunefi bounty evidence claim.

---

## 2026-09-16 to 2026-09-18 — SecureOS Sky net evidence lane

### PR #200 — Golden Intent passage against Sky Protocol sky net

2026-09-16T23:08:46Z
- Commit: 4c089c5b944eceb76b40e752771ee61587b7fef6
- Type: PREP / HARNESS
- Change: Run Golden Intent passage against Sky Protocol sky net.
- Detail: pin live Ethereum mainnet Sky/Maker deployments and local-fork state; bind before/after pin digests.

2026-09-16T23:17:18Z
- Commit: a9afc926147da7b5f542d75f23f3e576c9996b4b
- Type: EVIDENCE
- Change: Record prove at block 25993264.
- Result: passage receipt, SSP1 wire seal, before/after pin match.

2026-09-17T08:32:47Z
- Commit: b5c20dfa9f2911160b7a607af68a938089f62881
- Type: PREP / SCOPE
- Change: Expand Sky net pin to chainlog-max / Immunefi-core coverage.
- Boundary: binding evidence only; no award claim.

2026-09-17T08:35:41Z
- Commit: e3bdb637fcc6c81681be57043500616bf8903e26
- Type: FIX / EVIDENCE
- Change: Fix Sky pin key fallbacks and record chainlog-max prove.
- Result: documented 305-target max passage + 24-target Immunefi-core PASS.

2026-09-17T08:43:41Z
- Commit: e95984de319227cd11de779787c184ee937b2717
- Type: PREP / SCOPE
- Change: Exhaust defensive avenues with full chainlog pin + source forks.
- Boundary: no vulnerability claim.

2026-09-17T08:44:14Z
- Commit: 9919728d6f3507b9d4fef6cf655a5f626356c4e0
- Type: EVIDENCE
- Change: Document full chainlog defensive dry prove.

2026-09-17T08:48:41Z
- Commit: 702fdc53bb49f0ec58b9135e2c80eb3b1fcede48
- Type: PREP
- Change: Add Sky Immunefi high-level bounty brief.
- Boundary: no exploit path; not a vulnerability claim, filing, or award.

2026-09-17T09:01:28Z
- Commit: 878913c5cd85711b81e78002bdd8d61f8fbc8cc4
- Type: PREP / EVIDENCE
- Change: Add Sky bounty handoff collect pack.
- Contents: scope, prove modes, coverage matrix, HLB-1 brief, source-fork pins, Drive/PR index, checksums, tarball pointer.
- Boundary: binding / triage evidence only.

2026-09-17T09:01:58Z
- Commit: c705adb6e5749220159a91eda8e0dd115f867547
- Type: EVIDENCE
- Change: Include prove logs in handoff pack as .log.txt.

2026-09-17T09:48:36Z
- Commit: 588416fd2d5155f3cd86f8d4865c52eaebecf996
- Type: EVIDENCE / NOT_A_BOUNTY
- Change: Record ordered metadata alter-hash before restore.
- Sequence:
  - BEFORE hash
  - ALTERED hash
  - RESTORED hash
- Boundary: local metadata mutation only; not an on-chain Sky change; not a bounty PoC.

2026-09-17T18:39:21Z
- Commit: 7a51fdfcdf839ee3587e3c2da02424ce358549dd
- Type: HARNESS
- Change: CI exact Sky Golden SSP reproduce passes.

2026-09-18T00:32:30Z
- Commit: 78f9c6ac71d96bc587b584811ef09991f9e5e73c
- Type: FIX
- Change: make Sky evidence paths runner-portable.

2026-09-18T00:33:29Z
- Commit: e8c00f571629e40482df8c4d33de9af08c42499a
- Type: FIX
- Change: add Golden SSP loaded-binary runner bootstrap.

2026-09-18T00:33:46Z
- Commit: a3ad5a59b20334b33411a546f7b0ce0aa6b1f32f
- Type: FIX / INFRA
- Change: require loaded-binary self-hosted runner for Sky passes.

2026-09-18T00:41:09Z
- Commit: fbab2fd9be3943efcc6d6f1da3f7c2127664ef5c
- Type: FIX
- Change: fail closed on external Sky dependencies.

2026-09-18T00:41:13Z
- Commit: 385bd34e76026520794e6fa0119014c58207f085
- Type: FIX
- Change: prohibit source clones in offline Sky pass.

2026-09-18T00:41:33Z
- Commit: 67b57e9afdb2d735c92a41f94685a8048e6175b9
- Type: HARNESS
- Change: add one-pass local-only Sky bundle.

### SecureOS workflow outcomes
All listed workflow runs below concluded FAILURE and therefore are not bounty-impact proof:
- 35260145807 — Sky Golden SSP Reproduce Passes — 7a51fdf
- 35291629044 — Sky Golden SSP Reproduce Passes — 78f9c6a
- 35291697115 — Sky Golden SSP Reproduce Passes — e8c00f5
- 35291715901 — workflow file run — a3ad5a5
- 35292222474 — workflow file run — fbab2fd
- 35292224793 — workflow file run — 385bd34
- 35292247651 — workflow file run — 67b57e9

Classification: INFRA_FAILURE / HARNESS_FAILURE unless an attached artifact proves otherwise.

---

## 2026-09-17 — Sky DSS local-fork replay lane

Repository: UniSyncInc2212/sky-dss-security-review

2026-09-17T17:49:19Z
- Commit: 525f3f8e240b01192d59e0cd24ff4e66a9ff55f4
- Type: HARNESS
- Change: run Sky local-fork PoC replay.

2026-09-17T18:12:36Z
- Commit: 1c83f616d4b4145a765dfd8825793bc1cc8af96f
- Type: HARNESS
- Change: trigger existing Sky local-fork PoC.

Workflow outcomes:
- 35255063655 — Sky local-fork PoC — failure
- 35255063544 — tests.yaml — failure
- 35257423388 — Sky local-fork PoC — failure
- 35257423335 — tests.yaml — failure

Boundary:
- historical Dog.bark replay was a harness / behavior replay.
- it did not establish unauthorized economic impact.

---

## 2026-09-18 — Critical economic invariant lane

Branch: sky-critical-invariants-r1-20260918

2026-09-18T23:41:52Z
- Commit: a40b7faabed22a2bba740b6e83dee67e166fa587
- Type: HARNESS
- Change: add critical economic invariant gate.
- Targets:
  - unauthorized suck
  - unauthorized slip
  - unauthorized fold
  - unauthorized grab
  - unauthorized foreign move
  - negative-control state conservation
  - bounded frob accounting
  - DaiJoin exit accounting
- Safety: upstream read-only; all transactions local Anvil only.

Workflow run 35406700343
- Result: failure before runner assignment.
- Classification: HARNESS parse failure.
- Not a Sky result.

2026-09-18T23:43:28Z
- Commit: 3f646bcc3f660d27fba7ca245d58d6a09465a7cc
- Type: FIX
- Change: fix workflow YAML / embedded Python parsing.

Workflow run 35406799731
- Fork block: 26007755
- Resolved:
  - MCD_VAT 0x35D1b3F3D7966A1DFe207aa4514C12a259A0492B
  - MCD_DAI 0x6B175474E89094C44Da98b954EedeAC495271d0F
  - MCD_JOIN_DAI 0x9759A6Ac90977b93B58547b4A71c78317f391A28
  - MCD_DOG 0x135954d155898D42C90D2a57824C690e0c7BEf1B
- Attacker ward: 0
- Expected denies:
  - Vat.suck -> Vat/not-authorized
  - Vat.slip -> Vat/not-authorized
  - Vat.fold -> Vat/not-authorized
  - Vat.grab -> Vat/not-authorized
  - foreign Vat.move -> Vat/not-allowed
- NEGATIVE_CONTROL_STATE_CHANGED=NO
- Result: NEGATIVE_CONTROL_PASS
- Economic leg stopped at direct ETH-A join fixture.
- Artifact ID: 10573490272
- Artifact ZIP SHA-256: 5f09412b3ba65c1b971139ecdec98f3ffe5c914a916a093076385f6478663c98
- Classification: HARNESS fixture failure, not protocol issue.

2026-09-18T23:45:41Z
- Commit: 5d89e02cba0edfb86fa5b6bc1ff43f4359dedfce
- Type: FIX
- Change: replace direct ETH join fixture with local-only impersonated already-authorized adapter calling Vat.slip to seed collateral.
- Boundary: fixture setup only; not exploit evidence.

2026-09-18T23:46:05Z
- Commit: f3caa79fbebe3dc93c4797284a556a9e866af2bc
- Type: EVIDENCE
- Change: add docs/SKY_CRITICAL_FIX_LOG_R1.md.

Workflow run 35406953310
- Fork block: 26007767
- Gate A: all unauthorized privileged/foreign-balance attempts correctly denied.
- NEGATIVE_CONTROL_STATE_CHANGED=NO
- Economic fixture:
  - ETH-A
  - authorized adapter 0x2F0b23f53734252Bda2277357e97e1517d6B042A
  - local Anvil impersonated adapter seed
  - FREE_GEM = 1000000000000000000000
  - RATE = 1380239516962996307981531961
  - SPOT = 1813337931034482758620689655172
  - DUST = 7500000000000000000000000000000000000000000000000
  - MAX_DART = 1313784969020777321355904
  - TARGET_DART = 656892484510388660677952
- Over-boundary frob:
  - reverted Vat/not-safe
  - classification: NEGATIVE_CONTROL_PASS
- Valid draw:
  - EXPECTED_RAD_GAIN = 906668965517241379310344652206419799310657816023872
  - DRAW_CONSERVATION_OK=YES
  - classification: NEGATIVE_CONTROL_PASS / NO_BREACH_ON_LANE
- DAI exit over-balance:
  - reverted Vat/not-allowed because attacker had not granted DaiJoin permission
  - classification: HARNESS path-setup issue, not protocol issue
- Artifact ID: 10573145994
- Artifact ZIP SHA-256: 719bb19152d34d7e3a7a97ba86da3344e1782e52103d3134c54b37c63cbb0ae9

Current conclusion:
- no critical economic invariant breach has been proven in this lane.
- access-control and draw-conservation checks held.
- DAI exit path still requires normal user-consent setup before the final conservation leg can be completed.

---

## Billing / claim boundary

This backlog is evidence of work performed and investigation history.

It does NOT by itself establish:
- an accepted Immunefi report,
- a bounty award,
- a legally due debt,
- an invoiceable amount.

If a qualifying finding is produced and accepted by the bounty program, the accepted amount can then be converted into an invoice / payment demand.

Before acceptance, the appropriate commercial document is:
- Bounty Claim Statement / Notice of Claim
- with requested amount, evidence references, and program terms
- clearly marked as pending review / disputed / contingent until accepted.
