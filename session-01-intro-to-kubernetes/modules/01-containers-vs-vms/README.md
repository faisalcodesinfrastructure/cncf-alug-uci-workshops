# Module 01: Containers vs VMs

> Time: 10 minutes | Goal: see for yourself that a container is lighter and faster than a VM

## Prerequisites

- [Module 00](../00-toolkit-setup/README.md) verified

## The idea

| | Virtual machine | Container |
|---|---|---|
| Includes | Its own full operating system and kernel | Your app and its dependencies only |
| Shares | Hardware, via a hypervisor | The host's Linux kernel |
| Size | Gigabytes | Megabytes |
| Start time | Seconds to minutes | Usually under a second |

A VM virtualizes hardware. A container isolates a process on a kernel you already have.

## Steps

### 1. Run a container and time it

```bash
time docker run --rm alpine echo "hello from a container"
```

The first run downloads the image. Run it a second time and notice how fast it is.

### 2. Look at the size

```bash
docker images alpine
```

Alpine is a complete small Linux userland in a few megabytes. Compare that with the multi-gigabyte ISO of a typical desktop Linux VM.

### 3. Run several at once

```bash
docker run -d --name c1 alpine sleep 300
docker run -d --name c2 alpine sleep 300
docker run -d --name c3 alpine sleep 300
docker ps
```

Three isolated environments, started in moments, with no extra operating systems booted.

## Verify

`docker ps` lists `c1`, `c2` and `c3` as running.

## Clean up

```bash
docker rm -f c1 c2 c3
```

Optional, to remove the image: `docker rmi alpine`.
