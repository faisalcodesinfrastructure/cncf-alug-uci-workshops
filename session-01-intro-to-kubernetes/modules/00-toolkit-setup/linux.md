# Toolkit setup: Linux

Commands assume Ubuntu or Debian. On Fedora, use `dnf` for git and follow the Docker docs for your distro: https://docs.docker.com/engine/install/

## 1. Install git and Docker

```bash
sudo apt-get update && sudo apt-get install -y git curl
curl -fsSL https://get.docker.com | sudo sh
```

Let your user run Docker without `sudo`:

```bash
sudo usermod -aG docker $USER
```

**Log out and back in** (or reboot) so the group change takes effect. Then check:

```bash
docker run --rm hello-world
```

## 2. Install kind

```bash
ARCH=$(uname -m); [ "$ARCH" = "x86_64" ] && ARCH=amd64; [ "$ARCH" = "aarch64" ] && ARCH=arm64
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-${ARCH}"
chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind
```

## 3. Install kubectl

```bash
ARCH=$(uname -m); [ "$ARCH" = "x86_64" ] && ARCH=amd64; [ "$ARCH" = "aarch64" ] && ARCH=arm64
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${ARCH}/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/kubectl
```

## 4. Verify

```bash
bash session-01-intro-to-kubernetes/modules/00-toolkit-setup/verify.sh
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `permission denied ... docker.sock` | You skipped the `usermod` step or did not log out and back in |
| `kind: command not found` | `/usr/local/bin` is not on your PATH, or the move step failed |
| Cluster creation fails on a very old kernel | Update your system; kind needs a reasonably recent kernel |

## Uninstall (later, optional)

```bash
sudo rm /usr/local/bin/kind /usr/local/bin/kubectl
sudo apt-get remove -y docker-ce docker-ce-cli containerd.io
```
