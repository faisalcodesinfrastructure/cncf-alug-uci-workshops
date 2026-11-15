# Testing the Workshop on Linux, macOS and Windows

Two audiences: **testers** (anyone trying the workshop before or after a session) and **maintainers** (people changing the repo).

---

## Part 1: For testers (30 to 45 minutes)

You do not need to be an expert. Your job is to follow the instructions exactly as written and tell us where they fail. Do **not** fix problems yourself and carry on quietly; the problem is the useful part.

### Before you start

- Use a laptop you would use for the real workshop.
- If you already have Docker or kind installed, say so in your report.
- Keep notes as you go: what you typed, what you expected, what happened.

### Step 1: Pick your path

| Your laptop | Start at |
|-------------|----------|
| Windows 10 or 11 | [windows-wsl2.md](../session-01-intro-to-kubernetes/modules/00-toolkit-setup/windows-wsl2.md) |
| macOS | [macos.md](../session-01-intro-to-kubernetes/modules/00-toolkit-setup/macos.md) |
| Linux | [linux.md](../session-01-intro-to-kubernetes/modules/00-toolkit-setup/linux.md) |

### Step 2: Install the toolkit

Follow your page top to bottom. Note any step that was unclear, took more than 10 minutes, or gave an error.

### Step 3: Run the verify script

From the repo root (on Windows, in your Ubuntu/WSL2 terminal):

```bash
bash session-01-intro-to-kubernetes/modules/00-toolkit-setup/verify.sh
```

Every line should say `[ok]`. Copy the whole output into your report if anything fails.

### Step 4: Run the modules in order

Do each module's steps, then its **Verify** and **Clean up** sections.

1. [Module 01: Containers vs VMs](../session-01-intro-to-kubernetes/modules/01-containers-vs-vms/README.md)
2. [Module 02: Containers are just Linux](../session-01-intro-to-kubernetes/modules/02-containers-are-linux/README.md). On macOS, skip Part B (`unshare` is Linux only).
3. [Module 03: Cluster architecture](../session-01-intro-to-kubernetes/modules/03-cluster-architecture/README.md) (reading only)
4. [Module 04: Your first kind cluster](../session-01-intro-to-kubernetes/modules/04-first-kind-cluster/README.md)
5. [Module 05: Deploy, scale and heal](../session-01-intro-to-kubernetes/modules/05-deploy-scale-heal/README.md)

### Step 5: Confirm cleanup worked

```bash
kind get clusters
docker ps -a
```

`kind get clusters` should not list `workshop`, and `docker ps -a` should show no leftover workshop containers.

### Step 6: Send your report

Open an issue in the repo (or send to the organizers) with:

```
Operating system and version:
Laptop type (for example Intel, Apple Silicon, ARM Windows):
Already had Docker/kind installed? (yes/no)
Docker Desktop version (if any):

Steps that worked:
Steps that failed (module, step number, command, exact error text):
Steps that were unclear:
How long it took (total):
```

---

## Part 2: For maintainers

### What is automated

| Check | Where | What it covers |
|-------|-------|----------------|
| `bash -n` and `shellcheck` on all `.sh` files | GitHub Actions, `lint` job | Script syntax and common mistakes |
| CRLF line-ending check | GitHub Actions, `lint` job | The classic Windows failure (`\r: command not found`) |
| End-to-end run on Ubuntu | GitHub Actions, `e2e-linux` job | Modules 00, 04, 05: cluster, deploy, scale, heal, health check |

Run the end-to-end test locally on any machine with Docker, kind and kubectl:

```bash
bash scripts/e2e-session01.sh
```

It deletes the `workshop` cluster when it finishes, even if a step fails.

### What cannot be automated

GitHub's macOS and Windows runners do not provide a usable Docker for Linux containers, so they cannot run the cluster steps. Test these by hand before each session.

### Manual test: macOS

1. Use a Mac that has **not** run the workshop before, or remove old state first with `bash scripts/teardown.sh --images`.
2. Follow `macos.md`, then run `verify.sh`.
3. Run `bash scripts/e2e-session01.sh`, then run modules 01 and 02 by hand (the end-to-end script does not cover them).
4. If you have both an Intel Mac and an Apple Silicon Mac, repeat on each. The `kindest/node` platform warning appears only on Apple Silicon.
5. Note in Module 02 that `docker top` shows VM process IDs on Docker Desktop, and `unshare` is unavailable.

### Manual test: Windows

1. Use a clean Windows 10 or 11 machine. A student laptop is ideal. Check that virtualization is enabled (Task Manager > Performance > CPU > Virtualization).
2. Follow `windows-wsl2.md` from the very first command, including `wsl --install`.
3. Clone the repo **inside WSL** (in `~`), not under `/mnt/c`.
4. Run `verify.sh`, then `bash scripts/e2e-session01.sh`, then modules 01 and 02 by hand.
5. Test Module 02 Part B (`unshare`) inside WSL2; it should work there.
6. Try cloning from Windows (Git for Windows) and running a script from WSL on that copy. If it fails with `\r`, confirm `.gitattributes` is present in the repo.

### Manual test: Linux

CI already covers Ubuntu. Also try one other distro (Fedora or Debian) for `linux.md`, since the Docker install differs.

### Before each session (checklist)

- [ ] CI is green on `main`
- [ ] You ran modules 01 and 02 on your own Mac
- [ ] A Windows machine ran `windows-wsl2.md` since the last change to Module 00
- [ ] Pinned versions (`kind` v0.23.0, `kindest/node:v1.29.0`) still work. Check the latest releases at https://github.com/kubernetes-sigs/kind/releases
- [ ] Slide commands match the module READMEs
