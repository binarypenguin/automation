FROM mcr.microsoft.com/devcontainers/python:3.14-bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends iputils-ping \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.yml /tmp/automation-requirements/

RUN python -m pip install \
        --disable-pip-version-check \
        --no-cache-dir \
        --requirement /tmp/automation-requirements/requirements.txt \
    && ansible-galaxy collection install \
        --requirements-file /tmp/automation-requirements/requirements.yml \
        --collections-path /usr/share/ansible/collections \
    && rm -rf /tmp/automation-requirements
