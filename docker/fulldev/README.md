# Full Dev Environment

Ubuntu 24.04-based development environment with Python 3, Node.js 20, AWS CLI, and rclone.
Functionally equivalent to claude-dev but built on Ubuntu rather than the node:20 image.
Mounts your entire `~/github` directory so all projects are accessible.

## Setup (first time only)

```bash
cd ~/setup/docker/fulldev
docker compose build
```

## Daily workflow

```bash
cd ~/setup/docker/fulldev
docker compose run --rm dev bash
```

## First-time login (OAuth)

```bash
claude login
```

## Per-project Python venv

```bash
cd /workspace/myproject
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Ports

| Container | Host           |
|-----------|----------------|
| 3000      | localhost:3000 |
| 3001      | localhost:3001 |
| 3002      | localhost:3002 |
| 3003      | localhost:3003 |
| 3004      | localhost:3004 |

Bind to `0.0.0.0` when starting servers inside the container so they're reachable from the host.

## Mounts summary

| Host               | Inside container     | Notes      |
|--------------------|----------------------|------------|
| `~/github`         | `/workspace`         | read-write |
| `~/.gitconfig`     | `/root/.gitconfig`   | read-only  |
| `~/.ssh`           | `/root/.ssh`         | read-only  |
| `~/.aws`           | `/root/.aws`         | read-only  |
| `~/.config/rclone` | `/root/.config/rclone` | read-only |
| `~/.claude`        | `/root/.claude`      | read-write |
