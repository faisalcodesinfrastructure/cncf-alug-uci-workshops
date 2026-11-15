# Module 02: Containers Are Just Linux

> Time: 10 to 15 minutes | Goal: see that a container is an ordinary Linux process, isolated by namespaces and limited by cgroups

## Prerequisites

- [Module 00](../00-toolkit-setup/README.md) verified

## The idea

There is no "container" object in the Linux kernel. A container is a normal process with:

- **Namespaces**: what the process can *see* (its own process IDs, hostname, network, filesystem mounts)
- **cgroups**: how much the process can *use* (memory, CPU)
- **A root filesystem**: the image, used as the process's `/`

## Part A: With Docker (works on Linux, macOS and Windows)

### 1. Start a container with a memory limit

```bash
docker run -it --rm --memory 10m --name demo ubuntu bash
```

You are now inside the container. Try:

```bash
hostname
ps aux
cat /sys/fs/cgroup/memory.max
```

- `hostname` is the container ID, not your laptop's name (UTS namespace).
- `ps aux` shows only a couple of processes, and `bash` is PID 1 (PID namespace).
- `memory.max` shows `10485760`, which is 10 MiB (cgroup limit). On older systems using cgroup v1 the file is `/sys/fs/cgroup/memory/memory.limit_in_bytes`.

### 2. Look from the outside

Leave that container running and open a **second terminal**:

```bash
docker top demo
```

These are normal host processes. On macOS and Windows, Docker Desktop runs a hidden Linux VM, so the PIDs you see belong to that VM rather than your laptop. The idea is the same.

Back in the first terminal, type `exit` to stop the container.

## Part B: Without Docker (Linux or WSL2 only)

`unshare` is a Linux command, so this does not work in macOS Terminal.

```bash
sudo unshare --pid --fork --mount-proc --uts bash
hostname workshop-demo
hostname
ps aux
```

You are in a new PID and hostname namespace. `ps aux` shows only your shell and `ps`. Type `exit` to leave.

To list the namespaces on your machine: `lsns`

## Verify

You saw a different hostname and a short process list inside the container, and `memory.max` matched the limit you set.

## Clean up

The `--rm` flag removes the container on exit. If you exited abnormally:

```bash
docker rm -f demo
```

Optional: `docker rmi ubuntu`

## Credit and further reading

This module is inspired by Liz Rice's "Containers From Scratch" talk (builds a container in Go) and Julia Evans' zines on Linux and containers. `man 7 namespaces` and `man 7 cgroups` are the authoritative references.
