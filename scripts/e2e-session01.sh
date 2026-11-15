#!/usr/bin/env bash
# e2e-session01.sh: end-to-end test of Session 1 modules 04 and 05.
# Creates a kind cluster, deploys the demo app, scales it, deletes a Pod,
# checks it heals, then cleans up. Run from the repo root:
#   bash scripts/e2e-session01.sh
# Needs Docker, kind and kubectl. Takes a few minutes.

set -euo pipefail

M=session-01-intro-to-kubernetes/modules
NS=workshop-app
step() { printf '\n== %s\n' "$1"; }

cleanup() {
  step "Cleanup"
  kind delete cluster --name workshop || true
}
trap cleanup EXIT

step "Module 00: verify toolkit"
bash $M/00-toolkit-setup/verify.sh

step "Module 04: create cluster"
kind create cluster --config $M/04-first-kind-cluster/manifests/kind-config.yaml --wait 120s
kubectl get nodes | grep -q " Ready"

step "Module 05: build, load, deploy"
docker build -t k8s-workshop-demo:1.0.0 $M/05-deploy-scale-heal/app
kind load docker-image k8s-workshop-demo:1.0.0 --name workshop
kubectl apply -f $M/05-deploy-scale-heal/manifests/namespace.yaml
kubectl apply -f $M/05-deploy-scale-heal/manifests/deployment.yaml
kubectl apply -f $M/05-deploy-scale-heal/manifests/service.yaml
kubectl rollout status deployment/demo-app -n $NS --timeout=180s

step "Scale to 5"
kubectl scale deployment demo-app --replicas=5 -n $NS
kubectl rollout status deployment/demo-app -n $NS --timeout=180s
test "$(kubectl get deployment demo-app -n $NS -o jsonpath='{.status.readyReplicas}')" = "5"
kubectl scale deployment demo-app --replicas=2 -n $NS
kubectl rollout status deployment/demo-app -n $NS --timeout=180s

step "Delete a Pod and check it heals"
POD=$(kubectl get pods -n $NS -o jsonpath='{.items[0].metadata.name}')
kubectl delete pod "$POD" -n $NS
kubectl rollout status deployment/demo-app -n $NS --timeout=180s
test "$(kubectl get deployment demo-app -n $NS -o jsonpath='{.status.readyReplicas}')" = "2"

step "Service responds"
kubectl port-forward svc/demo-app-svc 8080:80 -n $NS >/dev/null 2>&1 &
PF=$!
sleep 5
curl -sf http://localhost:8080/health
kill $PF

step "ALL CHECKS PASSED"
