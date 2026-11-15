# Toolkit setup: macOS

Works on Intel and Apple Silicon.

## 1. Install Homebrew (skip if you have it)

Check with `brew --version`. If it is missing, follow the one-line installer at https://brew.sh.

## 2. Install the tools

```bash
brew install git kind kubectl
brew install --cask docker
```

## 3. Start Docker Desktop

Open **Docker Desktop** from Applications and wait until the whale icon says it is running. The first launch asks for permission to install a helper; accept it.

Docker Desktop runs a small hidden Linux VM, which is why containers behave like Linux even on a Mac.

## 4. Verify

```bash
bash session-01-intro-to-kubernetes/modules/00-toolkit-setup/verify.sh
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `Cannot connect to the Docker daemon` | Docker Desktop is not running. Open it and wait. |
| Image platform warnings on Apple Silicon | Add `--platform linux/amd64` to the `docker pull` command |
| Not enough memory | Docker Desktop > Settings > Resources: give it at least 4 GB |

## Uninstall (later, optional)

```bash
brew uninstall kind kubectl
brew uninstall --cask docker
```
