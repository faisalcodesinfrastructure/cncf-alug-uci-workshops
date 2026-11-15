# Toolkit setup: Windows (WSL2)

On Windows we run everything inside **WSL2** (Windows Subsystem for Linux), a real Linux environment built into Windows 10 and 11. After setup, every module command works exactly as written, because you are typing it into a Linux shell.

## 1. Install WSL2 with Ubuntu

Open **PowerShell as Administrator** and run:

```powershell
wsl --install -d Ubuntu
```

Restart when asked, then open **Ubuntu** from the Start menu and create a username and password.

Check that it is version 2 (in PowerShell):

```powershell
wsl -l -v
```

The `VERSION` column should say `2`.

## 2. Install Docker Desktop

Download Docker Desktop for Windows from https://www.docker.com/products/docker-desktop/ and install it with the **WSL 2 backend** selected.

Then turn on Ubuntu integration: **Docker Desktop > Settings > Resources > WSL Integration > enable Ubuntu**, and click Apply.

Inside your Ubuntu terminal, check:

```bash
docker run --rm hello-world
```

## 3. Install git, kind and kubectl (inside Ubuntu)

Run these in the **Ubuntu** terminal, not PowerShell:

```bash
sudo apt-get update && sudo apt-get install -y git curl
```

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind
```

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/kubectl
```

If your laptop has an ARM processor (for example a Snapdragon device), replace `amd64` with `arm64` in both URLs.

## 4. Keep your files inside WSL

Clone the repo into your Linux home folder (`~`), not under `/mnt/c/...`. File access across the boundary is slow and can break scripts.

```bash
cd ~
git clone https://github.com/faisalcodesinfrastructure/cncf-alug-uci-workshops.git
cd cncf-alug-uci-workshops
```

## 5. Verify

```bash
bash session-01-intro-to-kubernetes/modules/00-toolkit-setup/verify.sh
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `wsl --install` does nothing or errors | Turn on virtualization (VT-x / SVM) in your BIOS, and enable "Virtual Machine Platform" in Windows Features |
| `docker: command not found` in Ubuntu | WSL Integration is not enabled for Ubuntu in Docker Desktop |
| `\r: command not found` when running a script | The script got Windows line endings. Clone inside WSL, not Windows |
| Docker Desktop uses too much RAM | Create `%UserProfile%\.wslconfig` with `[wsl2]` and `memory=4GB`, then run `wsl --shutdown` |

## Uninstall (later, optional)

- Remove tools in Ubuntu: `sudo rm /usr/local/bin/kind /usr/local/bin/kubectl`
- Uninstall Docker Desktop from Windows Settings > Apps
- Remove the Linux distro (this deletes everything inside it): `wsl --unregister Ubuntu`
