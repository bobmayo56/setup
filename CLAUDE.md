# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal account setup for Bob Mayo. Stores dotfiles, custom CLI tools, and provisioning scripts to bootstrap a new Linux/Mac account consistently. Intended to be **public** — no secrets or credentials should be committed.

## Installing

```bash
make home_dir   # copies home_template/ to $HOME; backs up existing files as .orig (once)
```

Bootstrap a fresh machine (installs git if missing, then clones the repo):

```bash
bash provision/bootstrap.sh
```

Individual package/tool installers:

```bash
make install-node
make install-aws
make install-packages
make update
```

## Structure

- **`home_template/`** — mirrors `$HOME` exactly. Drop a file here at the right relative path and `make home_dir` will install it.
  - **`home_template/bin/`** — custom CLI scripts installed to `$HOME/bin`. Each is standalone.
  - **`home_template/.ssh/config`** — SSH client shortcuts for personal hosts (apibobmayo, loghost, riscv, snooper, dc7900).
- **`provision/`** — `bootstrap.sh`, `install-home.sh`, `install-aws.sh`, `install-node.sh`.
- **`modules/`** — individual setup scripts invoked by `make` targets.
- **`archive/`** — historical snapshots not installed by `make` (e.g. `2026-03-03_from_macbook/`).
- **`config/qemu/`** — QEMU VM config (`target-x86_64.conf`).

## Tools overview

| Tool | What it does |
|------|-------------|
| `make-archive` / `extract-archive` | Password-protected 7z archives; uses `7zz` by default, override with `SEVENZIP_PROGRAM=` |
| `make-codecard` | Generates a printable grid of cryptographically random characters (Python 3, uses `secrets`) |
| `gencodexcard` | Older Python 2 version of the code card generator |
| `gentoken` / `gentoken2` | Random token generators (hex, base64, UUID) |
| `gridtoken` | 10×10 grid of two-digit random numbers |
| `debuginternet` / `checkinternet` | Pings a chain of hosts (localhost → home router → modem → ISP → internet) in a loop to locate connectivity failures |
| `internetmetrics` | Posts latency measurements to a Librato metrics endpoint |
| `dogitconfig` | Sets global git identity to Robert Mayo / GitHub noreply email |
| `hosttype` | Prints `uname -s` (Linux or Darwin) for use in other scripts |
| `ti` / `title` | Sets the terminal window title via ANSI escape |

## Conventions

- Shell tools use `#!/bin/sh` (POSIX-compatible, works with bash and zsh). Exceptions: `make-archive` and `extract-archive` use `#!/usr/bin/env bash` for `read -s`; `rcacheupdate` uses `#!/bin/bash` for process substitution.
- Python tools: newer ones use Python 3 (`#!/usr/bin/env python3`); older ones (`gencodexcard`, `gentoken`, `gridtoken`) are Python 2 and use the `commands` module — leave them as-is unless actively updating.
- `make-archive` / `extract-archive` respect the `SEVENZIP_PROGRAM` env var to switch between `7zz`, `7z`, etc.
- `make home_dir` backs up any pre-existing `$HOME/.foo` to `$HOME/.foo.orig` **once** (never overwrites an existing `.orig`).
