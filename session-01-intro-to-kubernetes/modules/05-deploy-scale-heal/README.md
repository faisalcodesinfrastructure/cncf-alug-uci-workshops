# Module 05: Deploy, Scale and Watch It Heal

> Time: 30 minutes | Goal: run your own app on Kubernetes, scale it, then delete a Pod and watch Kubernetes replace it

## Prerequisites

- [Module 04](../04-first-kind-cluster/README.md) done, and the `workshop` cluster is running (`kubectl get nodes` shows `Ready`)
- A terminal at the **repo root**

Set a shortcut for this module's folder:

```bash
M=session-01-intro-to-kubernetes/modules/05-deploy-scale-heal
```

## Steps

### 1. Build the app image

The demo app is a small Node.js web server in `app/`.

```bash
docker build -t k8s-workshop-demo:1.0.0 $M/app
```

### 2. Load the image into kind

kind's node is a container that cannot see your local Docker images, so load it in:

```bash
kind load docker-image k8s-workshop-demo:1.0.0 --name workshop
```

On a real cloud cluster you would push to a registry instead.

### 3. Create the namespace and deploy

```bash
kubectl apply -f $M/manifests/namespace.yaml
kubectl apply -f $M/manifests/deployment.yaml
kubectl apply -f $M/manifests/service.yaml
```

Wait for it:

```bash
kubectl rollout status deployment/demo-app -n workshop-app
kubectl get pods -n workshop-app
```

You should see 2 Pods in `Running` state.

### 4. Open the app

```bash
kubectl port-forward svc/demo-app-svc 8080:80 -n workshop-app
```

Visit http://localhost:8080. Stop the forward with Ctrl+C. (Run it in its own terminal if you want to keep it open while doing the next steps.)

### 5. Scale it

```bash
kubectl scale deployment demo-app --replicas=5 -n workshop-app
kubectl get pods -n workshop-app
```

Scale back down: `kubectl scale deployment demo-app --replicas=2 -n workshop-app`

### 6. Delete a Pod and watch it heal

In one terminal, watch:

```bash
kubectl get pods -n workshop-app -w
```

In another, delete a Pod (use a real name from the list):

```bash
kubectl delete pod <pod-name> -n workshop-app
```

A replacement appears within seconds. You declared the desired state (2 replicas); the Deployment controller noticed the gap and closed it.

## Verify

`kubectl get deployment demo-app -n workshop-app` shows `2/2` ready after the Pod you deleted is replaced.

## Clean up

Remove just the app:

```bash
kubectl delete namespace workshop-app
```

Remove the whole cluster:

```bash
kind delete cluster --name workshop
```

Remove the image from Docker (optional):

```bash
docker rmi k8s-workshop-demo:1.0.0
```

`bash scripts/teardown.sh --images` does the last two for you.

## What is in the manifests

| File | Creates |
|------|---------|
| `manifests/namespace.yaml` | Namespace `workshop-app` |
| `manifests/deployment.yaml` | Deployment `demo-app`, 2 replicas, with health probes and resource limits |
| `manifests/service.yaml` | Service `demo-app-svc`, port 80 to the app's port 3000 |

Read `deployment.yaml` top to bottom. The comments explain each field.
