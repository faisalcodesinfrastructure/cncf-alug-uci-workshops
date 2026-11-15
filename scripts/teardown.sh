#!/usr/bin/env bash
# teardown.sh: remove what the workshop modules create on your machine.
# Usage (from the repo root): bash scripts/teardown.sh [--images]
#   --images   also remove the workshop app image from your local Docker

set -uo pipefail

CLUSTER="workshop"
IMAGE="k8s-workshop-demo:1.0.0"

say() { printf '%s\n' "$1"; }

if ! command -v kind >/dev/null 2>&1; then
  say "kind is not installed, so there is no kind cluster to delete."
else
  if kind get clusters 2>/dev/null | grep -qx "$CLUSTER"; then
    say "Deleting kind cluster '$CLUSTER'..."
    kind delete cluster --name "$CLUSTER"
  else
    say "No kind cluster named '$CLUSTER' found. Nothing to delete."
  fi
fi

if [ "${1:-}" = "--images" ]; then
  if command -v docker >/dev/null 2>&1 && docker image inspect "$IMAGE" >/dev/null 2>&1; then
    say "Removing image $IMAGE..."
    docker rmi "$IMAGE"
  else
    say "Image $IMAGE not found. Nothing to remove."
  fi
fi

say "Done."
