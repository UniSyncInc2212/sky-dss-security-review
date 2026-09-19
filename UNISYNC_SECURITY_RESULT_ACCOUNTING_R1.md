# UniSync Security Result Accounting R1

This branch separates **runner status** from **security decision** and from
**finance status**.

## Required interpretation

For legacy ds-test tests named `testFail*`, a revert/failure of the tested
operation is the **expected security behavior**.

- expected DENY/revert + observed DENY/revert = **SECURITY PASS**
- expected DENY/revert + observed success = **SECURITY FAIL / candidate finding**
- expected ALLOW + observed success with invariant preserved = **SECURITY PASS**
- expected ALLOW + observed revert or invariant break = **SECURITY FAIL / candidate finding**

A GitHub Actions job marked failed is only **RUNNER FAIL** until test output
identifies the invariant result.

## Finance progression

```text
candidate → reproducible → submitted → accepted → awarded → receivable → paid
```

A SECURITY PASS is not revenue. A candidate finding is not revenue. External
program acceptance/award is required for an award/receivable; settlement
evidence is required for PAID/cash.

## First corrected Sky lane

The DAI suite contains explicit negative controls including:

- `testFailWrongAccountTransfers`
- `testFailInsufficientFundsTransfers`
- `testFailTransferWithoutApproval`
- `testFailChargeMoreThanApproved`
- `testFailTransferFromSelfNonArbitrarySize`
- `testFailMintGuyNoAuth`
- `testFailUntrustedTransferFrom`
- `testFailPermitAddress0`
- `testFailPermitWithExpiry`
- `testFailReplay`

Under ds-test, these names encode expected failure. Their protected operation
failing is a security PASS, not a vulnerability.

The bounty-relevant condition is the inverse: an expected-deny operation
unexpectedly succeeds, or another documented invariant is violated in an
authorized local/fork reproduction.

## Scope

Local/fork/sandbox evidence only. No live exploitation and no movement of
third-party funds.


<!-- Harness trigger marker: 2026-09-19 maintained-foundry-r1 -->

<!-- DAI execution trigger: bff7dd020d655149bea19e1142c00c065ee2a6c2 -->

<!-- DAI isolated execution: 62c2df2a81c3720e7ee72d87f8c18e92438a6694 -->

<!-- DAI remap execution: 28d03f7b6683d27f8a50970441268914ea91483d -->

<!-- legacy compat execution: 3114def00769550a141c7818c64316046185173e -->
