# Module 04: Your First kind Cluster

> Time: 20 minutes | Goal: create a working Kubernetes cluster on your laptop, look around, and delete it

## Prerequisites

- [Module 00](../00-toolkit-setup/README.md) verified (Docker running)
- A terminal at the **repo root** (on Windows, your WSL2 Ubuntu terminal)

## Steps

### 1. Create the cluster

```bash
kind create cluster --config session-01-intro-to-kubernetes/modules/04-first-kind-cluster/manifests/kind-config.yaml
```

This takes one to three minutes the first time. kind starts a Docker container that acts as the Kubernetes node.

### 2. Check that it works

```bash
kubectl cluster-info --context kind-workshop
kubectl get nodes
```

You want to see one node named `workshop-control-plane` with status `Ready`.

### 3. Look around

```bash
kubectl get pods -A
```

These are the cluster's own components (API server, etcd, scheduler and more), running as Pods in the `kube-system` namespace.

See the node as a container:

```bash
docker ps
```

### 4. Know which cluster kubectl is talking to

```bash
kubectl config current-context
```

It should print `kind-workshop`. If you use other clusters, this is how you avoid running commands against the wrong one.

## Verify

`kubectl get nodes` shows `Ready`.

## Clean up

Delete the cluster when you are done. You can recreate it in a couple of minutes.

```bash
kind delete cluster --name workshop
```

Confirm: `kind get clusters` no longer lists `workshop`. Or run `bash scripts/teardown.sh` from the repo root.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `Cannot connect to the Docker daemon` | Start Docker Desktop, or the docker service on Linux |
| Cluster creation hangs or times out | Give Docker at least 4 GB RAM; retry after `kind delete cluster --name workshop` |
| `node(s) already exist for a cluster with the name "workshop"` | You already have one: delete it with the command above |
| Image pull errors on Apple Silicon | `docker pull --platform linux/amd64 kindest/node:v1.29.0`, then retry |

## kind cheat sheet

```bash
kind get clusters
kind delete cluster --name workshop
kind load docker-image my-image:tag --name workshop
kind export logs
```
