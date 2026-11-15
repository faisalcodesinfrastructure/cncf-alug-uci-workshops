# Toolkit setup: macOS

Works on Intel and Apple Silicon. Docker Desktop currently needs macOS 14 (Sonoma) or newer. Check yours under  > About This Mac.

## 1. Install Homebrew (skip if you have it)

Check with `brew --version`. If it is missing, install it from https://brew.sh (copy the one-line command from that page into Terminal).

## 2. Install git, kind and kubectl

```bash
brew install git kind kubectl
```

## 3. Install Docker Desktop

Docker Desktop is the app that runs containers on your Mac. Install it one of two ways. Use only one.

**Option A: with Homebrew (one command)**

```bash
brew install --cask docker-desktop
```

You will be asked for your Mac password. This installs the Docker Desktop app into your Applications folder.

**Option B: with the installer**

1. Download Docker Desktop for Mac from https://www.docker.com/products/docker-desktop/. Pick **Apple Silicon** for M1/M2/M3/M4 Macs, or **Intel chip** for older Macs. (Not sure? Click  > About This Mac and look at "Chip" or "Processor".)
2. Open the downloaded `.dmg` file and drag **Docker** into **Applications**.

## 4. Start Docker Desktop

Installing the app does not start it. Docker is not usable until you open it:

1. Press Cmd+Space, type **Docker**, and press Enter. (Or open it from Applications.)
2. On first launch, accept the license terms and the request to install a helper (it asks for your Mac password).
3. If it offers to sign in or take a survey, you can skip it. An account is not needed for this workshop.
4. Wait until the whale icon in the menu bar stops animating and Docker Desktop says it is running. The first start can take a minute or two.

Docker Desktop runs a small hidden Linux VM, which is why containers behave like Linux even on a Mac.

Check it from Terminal:

```bash
docker run --rm hello-world
```

You should see "Hello from Docker!". If you get `Cannot connect to the Docker daemon`, Docker Desktop is not running yet.

## 5. Verify everything

From the repo root:

```bash
bash session-01-intro-to-kubernetes/modules/00-toolkit-setup/verify.sh
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `Cannot connect to the Docker daemon` | Docker Desktop is not running. Open it and wait for the whale icon to settle. |
| `brew install --cask docker-desktop` says the cask is not found | Run `brew update`, then try again. Or use Option B. |
| Docker Desktop will not open or says your macOS is too old | Update macOS, or check Docker's current system requirements at https://docs.docker.com/desktop/setup/install/mac-install/ |
| Image platform warnings on Apple Silicon | Add `--platform linux/amd64` to the `docker pull` command |
| Not enough memory | Docker Desktop > Settings > Resources: give it at least 4 GB |

## Uninstall (later, optional)

```bash
brew uninstall kind kubectl
brew uninstall --cask docker-desktop
```

If you used Option B, quit Docker Desktop and drag it from Applications to the Trash.
