# Claude Code Dev Environment

Isolated Docker environment for Claude Code CLI with Python 3.11, AWS CLI, and rclone.
Mounts your entire `~/github` directory so all projects are accessible.

## Files

```
~/.claude-dev/
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Setup (first time only)

```bash
mkdir -p ~/.claude-dev
# copy Dockerfile and docker-compose.yml here, then:
cd ~/.claude-dev
docker compose build
```

## Daily workflow

```bash
cd ~/.claude-dev
docker compose run --rm dev bash
```

Once inside the container:

```bash
cd /workspace/data-lake    # or any other project
claude                     # launch Claude Code
```

## First-time login (OAuth)

The first time you start the container, run:

```bash
claude login
```

Follow the prompt — it will give you a URL to open in your Mac browser.
Your token is stored in the `claude-config` Docker volume and survives
container restarts. You should only need to do this once.

## Per-project Python venv

Each project manages its own virtual environment. There is no shared venv.
To set up a project for the first time:

```bash
cd /workspace/data-lake
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

On subsequent sessions, just activate:

```bash
source /workspace/data-lake/.venv/bin/activate
```

## Ports

Five ports are available for experimental web servers (Dash, Jupyter, etc.):

| Container | Your Mac        |
|-----------|-----------------|
| 3000      | localhost:3000  |
| 3001      | localhost:3001  |
| 3002      | localhost:3002  |
| 3003      | localhost:3003  |
| 3004      | localhost:3004  |

When starting a Jupyter or Dash server inside the container, bind to `0.0.0.0`
so it's reachable from your Mac:

```bash
jupyter lab --ip=0.0.0.0 --port=3000 --no-browser
```

By default, Jupyter binds to `localhost` which means "only accept connections
from this machine itself" — inside a container, that means the container only,
and your Mac browser can't reach it even though the port is forwarded.
`0.0.0.0` means "accept connections on any interface", which allows Docker's
port forwarding to work. This is safe because Docker itself only exposes the
ports you explicitly list in `docker-compose.yml`.

For Dash, the equivalent is:

```python
app.run(host="0.0.0.0", port=3000, debug=True)
```

Note: you never had to think about this before because you ran Jupyter directly
on your Mac. It's a new wrinkle specific to the containerized environment.

## AWS / S3

AWS CLI and rclone are pre-installed. Your AWS credentials are not baked into
the image — pass them in at runtime either via environment variables:

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_DEFAULT_REGION=us-west-2
docker compose run --rm \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_DEFAULT_REGION \
  dev bash
```

Or mount your credentials file by adding this to `docker-compose.yml` volumes:

```yaml
- ~/.aws:/root/.aws:ro
```

## Mounts summary

| Your Mac          | Inside container     | Notes          |
|-------------------|----------------------|----------------|
| `~/github`        | `/workspace`         | read-write     |
| `~/.gitconfig`    | `/root/.gitconfig`   | read-only      |
| `~/.ssh`          | `/root/.ssh`         | read-only      |
| `claude-config`   | `/root/.claude`      | Docker volume  |

## Rebuilding the image

If you change the Dockerfile (e.g. to add a new tool):

```bash
cd ~/.claude-dev
docker compose build
```

Your projects and Claude auth are unaffected — they live in mounts and volumes,
not in the image itself.

## Python version

Python 3.11 — chosen for maximum compatibility with pandas, pyarrow/parquet,
plotly, Dash, and Jupyter. Do not upgrade to 3.12 without testing your
requirements.txt files first.
