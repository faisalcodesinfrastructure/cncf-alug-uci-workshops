# Module 03: Inside a Kubernetes Cluster

> Time: 15 minutes | Goal: know the parts of a cluster and the core objects you will use in Module 05

This module is reading and discussion. There is nothing to install or clean up.

## The problem Kubernetes solves

One container is easy. Running hundreds across many machines is hard: what restarts a crashed one, spreads load, or rolls out a new version without downtime? Kubernetes is the system that keeps your declared plan true.

## Cluster architecture

```
                    You: kubectl apply -f ...
                              |
                              v
  +----------------- CONTROL PLANE ------------------+
  |  API server  <->  etcd (stores desired state)    |
  |  Scheduler (picks a node)   Controllers (fix drift)|
  +--------------------------------------------------+
            |                          |
            v                          v
  +---- WORKER NODE ----+    +---- WORKER NODE ----+
  | kubelet             |    | kubelet             |
  | container runtime   |    | container runtime   |
  |  [Pod] [Pod]        |    |  [Pod]              |
  +---------------------+    +---------------------+
```

| Component | Job |
|-----------|-----|
| API server | The front door. Everything, including kubectl, talks to it |
| etcd | The database holding the cluster's desired state |
| Scheduler | Chooses which node each new Pod runs on |
| Controllers | Watch actual state and make it match desired state |
| kubelet | Agent on each node that starts and watches containers |
| Container runtime | Actually runs the containers (containerd, CRI-O) |

In kind, each "node" is itself a Docker container. That is how a whole cluster fits on a laptop.

## Core objects

| Object | What it is |
|--------|-----------|
| **Pod** | One or more containers that run together. The smallest unit you deploy |
| **ReplicaSet** | Keeps N identical Pods running |
| **Deployment** | Manages ReplicaSets, and gives you rolling updates and rollbacks |
| **Service** | A stable address that load balances across a set of Pods |
| **Namespace** | A named partition of the cluster |

```
Deployment
  +-- ReplicaSet
        +-- Pod, Pod, Pod
```

In practice, create Deployments, not bare Pods. A bare Pod that dies stays dead.

## Desired state vs actual state

You declare "I want 3 replicas". Controllers constantly compare that with reality and fix any gap. This reconciliation loop is the central idea of Kubernetes, and it is the foundation of GitOps (a later session): Git holds the desired state, and a controller makes the cluster match.

## Check yourself

1. What stores the cluster's desired state?
2. Why would you use a Deployment instead of a bare Pod?
3. In kind, what is a node?

Answers: etcd; a Deployment replaces Pods that die; a Docker container.
