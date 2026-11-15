#!/usr/bin/env bash
# verify.sh: checks that your workshop toolkit is installed and working.
# Usage (from the repo root): bash session-01-intro-to-kubernetes/modules/00-toolkit-setup/verify.sh

PASS=0
FAIL=0

check() {
  local desc="$1" cmd="$2" hint="$3"
  if eval "$cmd" >/dev/null 2>&1; then
    printf '  [ok]   %s\n' "$desc"
    PASS=$((PASS + 1))
  else
    printf '  [FAIL] %s\n         hint: %s\n' "$desc" "$hint"
    FAIL=$((FAIL + 1))
  fi
}

echo
echo "Workshop toolkit check"
echo "----------------------"
check "git installed"        "command -v git"     "see your OS page in this module"
check "docker installed"     "command -v docker"  "see your OS page in this module"
check "docker is running"    "docker info"        "start Docker Desktop (macOS/Windows) or the docker service (Linux); on Linux check you are in the docker group"
check "kind installed"       "command -v kind"    "see your OS page in this module"
check "kubectl installed"    "command -v kubectl" "see your OS page in this module"
check "can run a container"  "docker run --rm hello-world" "check your internet connection and that Docker is running"

echo
if [ "$FAIL" -eq 0 ]; then
  echo "All $PASS checks passed. You are ready."
else
  echo "$FAIL check(s) failed, $PASS passed. Bring the hints above to the session."
  exit 1
fi
