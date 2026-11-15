# Module 00: Toolkit Setup

> Time: 20 to 30 minutes (mostly downloads) | Goal: Docker, kind and kubectl installed and verified on your laptop

Do this **before** the session. Downloads over campus Wi-Fi are slow, and install problems are easier to fix on your own time.

## What you are installing

| Tool | What it does |
|------|--------------|
| **Docker** | Runs containers on your machine |
| **kind** | "Kubernetes in Docker": creates a Kubernetes cluster that runs as containers on your laptop |
| **kubectl** | The command line tool for talking to any Kubernetes cluster |
| **git** | To clone this repo |

You need roughly 4 GB of free RAM for Docker and 10 GB of free disk space.

## Pick your operating system

| Your laptop | Follow |
|-------------|--------|
| macOS (Intel or Apple Silicon) | [macos.md](macos.md) |
| Linux (Ubuntu, Debian, Fedora, others) | [linux.md](linux.md) |
| Windows 10 or 11 | [windows-wsl2.md](windows-wsl2.md) |

## Verify

After installing, run this from the repo root (on Windows, inside your WSL2 terminal):

```bash
bash session-01-intro-to-kubernetes/modules/00-toolkit-setup/verify.sh
```

Every line should show a check mark. If one fails, the script prints a hint. Bring any error to the session.

## Pre-pull the node image (recommended)

kind needs one large image (about 1 GB). Download it now so cluster creation is quick later:

```bash
docker pull kindest/node:v1.29.0
```

On an Apple Silicon Mac, if this reports a platform problem, run `docker pull --platform linux/amd64 kindest/node:v1.29.0`.

## Clean up

Nothing here runs in the background, but if you want to remove the tools later:

- Pre-pulled image: `docker rmi kindest/node:v1.29.0`
- Everything else: follow the uninstall notes at the bottom of your OS page.
