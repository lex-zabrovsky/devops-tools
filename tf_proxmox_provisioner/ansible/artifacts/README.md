# Ansible Artifacts Directory

This directory dedicated to keeping binary artifacts for K8s cluster bootstrap
and configuration.

Current list of required artifacts:

- Helm: [K8s package manager](https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4)
- kubectl=v1.24.9: [K8s CLI tool](https://dl.k8s.io/release/v1.24.9/bin/linux/amd64/kubectl)
- rke=v1.8.10: [Rancher project CLI tool for K8s bootstrap](https://github.com/rancher/rke/releases/download/v1.8.10/rke_linux-amd64)
- OSS registry archive

Directory contents:

```shell
artifacts/
├── helm
├── kubectl
├── oss-registry.tar
└── rke
```
