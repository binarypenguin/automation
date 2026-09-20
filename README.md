# Automation

A few simple [Ansible](https://docs.ansible.com) roles I use on my home network and VPSs.

## Getting started

Clone this repository and the `automation-inventory` repository side by side:

```text
parent-directory/
|-- automation/
`-- automation-inventory/
```

The default inventory is `../automation-inventory/production/inventory.yml`; its host and
group variables live alongside it in the `production` directory. Additional
inventories can be stored in subdirectories there. See the
[Ansible inventory documentation](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)
and review `playbook.yml` for the available host groups and their assigned
roles.

### VS Code dev container

The recommended development environment uses Python 3.14 and installs the
Python dependencies from `requirements.txt` and Galaxy collections from
`requirements.yml`.

1. Install Docker, VS Code, and the VS Code **Dev Containers** extension.
2. Open this repository in VS Code.
3. Run **Dev Containers: Reopen in Container** from the Command Palette.
4. After changing either requirements file or the container configuration, run
   **Dev Containers: Rebuild Container**.

The container installs the Codex, Red Hat Ansible, and YAML extensions and
configures the Ansible extension to use `/usr/local/bin/python`. Sign in to
Codex when prompted after the container opens.

The container also installs Node.js 24 and the official Ansible MCP server.
When the repository is trusted, Codex loads `.codex/config.toml` and starts the
server from the repository root over stdio. It uses the existing Ansible tools
installed from `requirements.txt`; no MCP network port is needed. After
rebuilding the container, restart the Codex extension and use `/mcp` to check
that the `ansible` server is connected. In a container terminal, run
`node --version` (expect version 24) and `codex mcp list` (expect `ansible`).

> [!WARNING]
> Inside the dev container, `localhost` and `127.0.0.1` refer to the container,
> not the physical host. Running the localhost inventory will configure the
> container. Use the physical host's reachable hostname or IP address if it is
> an intended managed node.

VS Code automatically forwards a running host SSH agent; private keys are not
copied into the container. Add the required key on the host before opening the
container, then verify forwarding from the container terminal:

```bash
ssh-add -l
```

Run a safe syntax check without contacting managed hosts:

```bash
ansible-playbook --syntax-check -i ../automation-inventory/localhost/hosts playbook.yml
```

To apply the playbook to the production inventory, use an interactive container
terminal. Add `--ask-vault-pass` when encrypted variables are required;
Ansible connects as `travis` by default, and become-password prompting is
enabled by `ansible.cfg`. Set `ansible_user` for hosts that use a different SSH
account.

```bash
ansible-playbook -i ../automation-inventory/production/inventory.yml playbook.yml --ask-vault-pass
```

### Local virtual environment

If you do not use the dev container, install the dependencies in a virtual
environment and install the Galaxy requirements separately:

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
ansible-galaxy collection install -r requirements.yml
```

## Roles

### Common

Installs a few common utilities on each machine.

### Monitoring

Installs Prometheus node exporter on Debian, Ubuntu, and Fedora hosts that have
a Tailscale interface. The exporter binds to the Tailscale IPv4 address on
port `9100` by default, so hosts without `tailscale0` are skipped. Override
`monitoring_tailscale_interface` or `monitoring_node_exporter_port` in inventory
when needed.

### Docker

Installs Docker Engine from Docker's official repositories on hosts in the
`docker_hosts` inventory group. By default, the role enables and checks the
system Docker service. Users are not added to the `docker` group; run rootful
Docker with `sudo`.

For rootless Docker, set the mode and accounts in that host's `host_vars` file:

```yaml
docker_rootless: true
docker_rootless_users:
  - name: frigate
    uid: 1500
```

Each UID is required, unique on the host, and between 1500 and 1599. The role
stops and disables the system Docker service and socket, creates the accounts
under `/home`, enables lingering, and starts each user's Docker service. The
role leaves subordinate ID allocation to the host's account tools and preserves
existing assignments. Keep each home on a local filesystem with enough space
for Docker's default data directory, `~/.local/share/docker`. Put Compose files
in a user-owned directory such as `/home/frigate/compose/frigate/compose.yaml`,
and run `docker compose` as that user from the project directory (for example,
`sudo -iu frigate` followed by `cd ~/compose/frigate && docker compose up -d`).
Keep large persistent bind-mounted data on a suitable separate filesystem if
needed, with permissions that allow the rootless account to access it.

### GitHub App Checkout

Checks out private GitHub repositories on hosts in the
`github_app_checkout_hosts` inventory group by minting a short-lived GitHub App
installation token from a PEM file mounted into the Ansible controller at
`/run/secrets/binary-penguin-pull-app.pem`. The token is passed to
`ansible.builtin.git` for the checkout and is not persisted on the managed host.
Set `github_app_checkout_app_id`, `github_app_checkout_installation_id`, and
`github_app_checkout_repositories` in inventory.

### Workstation

Installs Workstation only application.

## Updating Python dependencies

Direct dependencies are maintained in `requirements.in`. The fully pinned `requirements.txt` file is generated with [`pip-tools`](https://pip-tools.readthedocs.io/) and should not be edited manually.

To update all dependencies:

```bash
python -m pip install --upgrade pip pip-tools
pip-compile --upgrade requirements.in
python -m pip install --upgrade -r requirements.txt
```

Commit both `requirements.in` and the regenerated `requirements.txt`.
