#!/usr/bin/env python3
from pathlib import Path
import json, re, sys

TEST_RE = re.compile(r"function\s+(test(?:Fail)?[A-Za-z0-9_]*)\s*\(")

def main():
    root = Path(sys.argv[1] if len(sys.argv) > 1 else "src/test")
    rows = []
    for path in sorted(root.glob("*.t.sol")):
        text = path.read_text(encoding="utf-8")
        for name in TEST_RE.findall(text):
            rows.append({
                "file": str(path),
                "test": name,
                "expected_behavior": "DENY_OR_REVERT" if name.startswith("testFail") else "ALLOW_OR_INVARIANT",
                "security_status": "UNEXECUTED",
                "finance_status": "NOT_REVENUE",
            })
    print(json.dumps({
        "schema": "unisync-security-result-accounting-r1",
        "counts": {
            "total": len(rows),
            "expected_deny_or_revert": sum(x["expected_behavior"] == "DENY_OR_REVERT" for x in rows),
            "expected_allow_or_invariant": sum(x["expected_behavior"] == "ALLOW_OR_INVARIANT" for x in rows),
        },
        "tests": rows,
    }, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
