# CNCF x ALUG@UCI Hands-On Workshops

Free, hands-on workshops on cloud native open source, run by the Cloud Native Computing Foundation (CNCF) community with the Anteater Linux User Group at UC Irvine (ALUG@UCI).

Every session runs on your own laptop with free, open source tools. No cloud account or credit card is needed.

## How this repo is organized

Each workshop session has its own folder. Inside a session, every capability is its own **module** with its own folder, README and (when needed) manifests and verify script.

```
cncf-alug-uci-workshops/
  README.md                          this file
  docs/                              cheatsheets and the testing guide
  scripts/                           teardown and the end-to-end test
  .github/workflows/                 automated checks
  session-01-intro-to-kubernetes/
    README.md                        agenda, module list, homework
    deck/                            slides for the session
    modules/
      00-toolkit-setup/              install Docker, kind, kubectl (Linux, macOS, Windows)
      01-containers-vs-vms/
      02-containers-are-linux/
      03-cluster-architecture/
      04-first-kind-cluster/
      05-deploy-scale-heal/
  session-02-.../                    added as the series grows
```

A module README always has the same parts: time estimate, goal, prerequisites, steps, a verify check and a **Clean up** section, so you can delete what you created when you finish.

## Sessions

| # | Session | Status |
|---|---------|--------|
| 1 | [From Code to Career: Intro to Kubernetes](session-01-intro-to-kubernetes/README.md) | In progress |
| 2 | Containers and Kubernetes, in depth | Planned |
| 3 | Kubernetes networking | Planned |
| 4 | GitOps with Argo CD | Planned |
| 5 | Observability with Prometheus and Grafana | Planned |
| 6 | Kubernetes security basics | Planned |
| 7 | Platform engineering, AI and your career | Planned |

Topics and order may change as sessions are scheduled.

## Quick start (do this before the first session)

1. Get the repo onto your laptop. You need `git` for this step, so check it first with `git --version`.

   | Your laptop | If `git` is missing | Where to run the commands |
   |-------------|---------------------|---------------------------|
   | macOS | Run `git --version`; macOS offers to install the developer tools. Accept, or run `brew install git` | Terminal |
   | Linux | `sudo apt-get update && sudo apt-get install -y git` (Ubuntu/Debian) | Any terminal |
   | Windows | Follow [windows-wsl2.md](session-01-intro-to-kubernetes/modules/00-toolkit-setup/windows-wsl2.md) steps 1 and 3 first, then clone | **Ubuntu (WSL2) terminal**, in your home folder (`cd ~`), not PowerShell and not under `/mnt/c` |

   ```bash
   git clone https://github.com/faisalcodesinfrastructure/cncf-alug-uci-workshops.git
   cd cncf-alug-uci-workshops
   ```

   No git at all? Use the green **Code > Download ZIP** button on GitHub and unzip it. On Windows, unzip inside WSL.
2. Do [Module 00: Toolkit setup](session-01-intro-to-kubernetes/modules/00-toolkit-setup/README.md) for your operating system.
3. Do [Module 04: First kind cluster](session-01-intro-to-kubernetes/modules/04-first-kind-cluster/README.md) to confirm you can create a cluster.
4. Delete it when you are done. Cleanup steps are at the end of each module, and `scripts/teardown.sh` removes the workshop cluster.

Want to help test? See [docs/TESTING.md](docs/TESTING.md) for a step-by-step tester guide for Windows, macOS and Linux.

If something does not work, bring the error message to the session. That is exactly what we are there to help with.

## Windows, macOS and Linux

All module commands are written for a bash shell. On Windows, use WSL2 (Windows Subsystem for Linux) and run everything inside it. Only Module 00 has separate pages per operating system, because installation differs.

## License

- Code, scripts and manifests: [Apache License 2.0](LICENSE)
- Documentation and written lesson content: Creative Commons Attribution 4.0 (CC BY 4.0)
- The CNCF name, logo and slide template are CNCF trademarks and branded material. They are not covered by the licenses above.
