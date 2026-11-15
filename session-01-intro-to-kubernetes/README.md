# Session 1: From Code to Career (Intro to Kubernetes)

How open source runs the software you use. This session introduces CNCF, then builds up from Linux and containers to a running Kubernetes cluster on your laptop.

Slides live in [`deck/`](deck/).

## Two parts

| Part | Where | What |
|------|-------|------|
| **Part 1** | In the session | Concepts, with short demos: modules 01 to 03 |
| **Part 2** | Self-paced, at home | Install the tools, create a cluster, deploy an app, scale it and watch it heal: modules 00, 04 and 05 |

## Modules

| Module | Topic | When | Time (estimate) |
|--------|-------|------|-----------------|
| [00-toolkit-setup](modules/00-toolkit-setup/README.md) | Install Docker, kind, kubectl | **Before the session** | 20 to 30 min |
| [01-containers-vs-vms](modules/01-containers-vs-vms/README.md) | What a container is, and how it differs from a VM | Part 1 | 10 min |
| [02-containers-are-linux](modules/02-containers-are-linux/README.md) | Namespaces and cgroups, with Docker | Part 1 | 10 min |
| [03-cluster-architecture](modules/03-cluster-architecture/README.md) | Control plane, nodes, Pods, Deployments | Part 1 | 15 min |
| [04-first-kind-cluster](modules/04-first-kind-cluster/README.md) | Create, explore and delete a kind cluster | Homework | 20 min |
| [05-deploy-scale-heal](modules/05-deploy-scale-heal/README.md) | Deploy an app, scale it, delete a Pod and watch it come back | Part 2 | 30 min |

Time estimates are rough. Downloads on a slow connection can take longer, which is why Module 00 comes first.

## Homework before the next session

1. Finish Module 00 and run its verify script.
2. Create a cluster with Module 04, check that `kubectl get nodes` shows `Ready`, and delete it.
3. If you have time, try Module 05.

## Clean up when you are finished

```bash
bash scripts/teardown.sh
```

Run it from the repo root. It deletes the `workshop` kind cluster. Each module also has its own **Clean up** section.
