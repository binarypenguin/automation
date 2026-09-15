# Automation

A few simple [Ansible](https://docs.ansible.com) roles I use on my home network and VPSs.

## Getting started

Clone the repository and create an inventory as needed. Each inventory can be a
subdirectory of `inventories`; see the
[Ansible inventory documentation](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html).
Review `playbook.yml` for the available host groups and their assigned roles.

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
ansible-playbook --syntax-check -i inventories/localhost/hosts playbook.yml
```

To apply the playbook to an intended inventory, use an interactive container
terminal. Add `--ask-vault-pass` when encrypted variables are required;
Ansible connects as `travis` by default, and become-password prompting is
enabled by `ansible.cfg`. Set `ansible_user` for hosts that use a different SSH
account.

```bash
ansible-playbook -i inventories/<inventory>/hosts playbook.yml --ask-vault-pass
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
`docker_hosts` inventory group. The role enables and starts `docker.service`,
then verifies that the service is running, enabled, and reachable through the
Docker CLI. Users are not added to the `docker` group; run Docker with `sudo`.

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
