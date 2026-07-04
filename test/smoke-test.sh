#!/usr/bin/env bash
# smoke-test.sh — end-to-end check of bin/harness-init, harness-attach,
# harness-check, harness-sync, and harness-upgrade against a throwaway
# project and fake $HOME. No dependencies beyond bash + the bin/ scripts.
set -euo pipefail

HARNESS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN="$HARNESS_ROOT/bin"

PROJECT_DIR="$(mktemp -d)"
FAKE_HOME="$(mktemp -d)"
trap 'rm -rf "$PROJECT_DIR" "$FAKE_HOME"' EXIT
export HOME="$FAKE_HOME"
cd "$PROJECT_DIR"

OUT="$(mktemp)"

assert_exit() {
  local expected="$1"; shift
  local actual=0
  "$@" >"$OUT" 2>&1 || actual=$?
  if [ "$actual" != "$expected" ]; then
    echo "FAIL: expected exit $expected, got $actual for: $*" >&2
    cat "$OUT" >&2
    exit 1
  fi
}

assert_contains() {
  if ! grep -qF "$1" "$OUT"; then
    echo "FAIL: expected output to contain: $1" >&2
    cat "$OUT" >&2
    exit 1
  fi
}

# harness-init bootstraps cleanly.
assert_exit 0 "$BIN/harness-init"
for f in AGENTS.md CLAUDE.md architecture.md .harness-root; do
  [ -e "$f" ] || { echo "FAIL: $f not created by harness-init" >&2; exit 1; }
done
for d in specs evals work; do
  [ -d "$d" ] || { echo "FAIL: $d/ not created by harness-init" >&2; exit 1; }
done
grep -q 'agent-harness version:' AGENTS.md || { echo "FAIL: no version stamp in AGENTS.md" >&2; exit 1; }
AGENTS_CHECKSUM="$(cksum AGENTS.md)"

# harness-init refuses to run twice.
assert_exit 1 "$BIN/harness-init"

# harness-check fails before skills are linked.
assert_exit 1 "$BIN/harness-check"
assert_contains "not yet linked"

# harness-sync links skills; harness-check now passes.
assert_exit 0 "$BIN/harness-sync"
assert_exit 0 "$BIN/harness-check"

# Simulate a skill removed upstream: break one link.
rm "$FAKE_HOME/.claude/skills/architecture"
ln -s "$HARNESS_ROOT/skills/architecture-does-not-exist" "$FAKE_HOME/.claude/skills/architecture"
assert_exit 1 "$BIN/harness-check"
assert_contains "Dangling skill links"

# harness-upgrade repairs the dangling link and harness-check passes again.
assert_exit 0 "$BIN/harness-upgrade"
[ -e "$FAKE_HOME/.claude/skills/architecture" ] || { echo "FAIL: architecture link not repaired" >&2; exit 1; }
assert_exit 0 "$BIN/harness-check"

# Simulate a fresh clone/second machine: .harness-root and the empty dirs
# are missing (gitignored / not pre-seeded), but AGENTS.md etc. are present.
rm -rf .harness-root specs evals work
assert_exit 0 "$BIN/harness-attach"
for d in specs evals work; do
  [ -d "$d" ] || { echo "FAIL: $d/ not recreated by harness-attach" >&2; exit 1; }
done
[ -e .harness-root ] || { echo "FAIL: .harness-root not recreated by harness-attach" >&2; exit 1; }
[ "$(cksum AGENTS.md)" = "$AGENTS_CHECKSUM" ] || { echo "FAIL: harness-attach modified AGENTS.md" >&2; exit 1; }

echo "smoke-test: all checks passed"
