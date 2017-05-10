# `prometheus_node_exporter_installer`

This is a simple script to install [Prometheus](https://github.com/prometheus/prometheus)'s [`node_exporter`](https://github.com/prometheus/node_exporter) on a systemd managed server.

### Description

This script will create a unprivileged system user under which the exporter will be run, retrieve the last version of `node_exporter`, create a systemd service for it and start it.

### Usage

```
$ bash <(curl -s https://raw.githubusercontent.com/chambo-e/prometheus_node_exporter_installer/master/node_exporter_installer.sh)
```
or
```
$ bash <(wget -qO- https://raw.githubusercontent.com/chambo-e/prometheus_node_exporter_installer/master/node_exporter_installer.sh)
```
or you can clone the repo
```
$ git clone https://github.com/chambo-e/prometheus_node_exporter_installer.git
```

You can customize installation via env vars:
- `EXPORTER_VERSION`: the `node_exporter` version (default:'0.14.0')
- `EXPORTER_FLAVOR`: the `node_exporter` system flavor (default:'linux-amd64')
- `EXPORTER_USER`: the user which will run the exporter (default:'prometheus')
- `SERVICE_NAME`: the name of the service created to run the exorter (default:'node_exporter')
- `DOWNLOAD_PATH`: the path where the node_exporter release will be downloaded (default:'/tmp')
- `BINARY_PATH`: the path where the node_exporter binary will be (default:'/usr/bin')

Example:
```
$ EXPORTER_USER=anotherprom SERVICE_NAME=myfreakingservice bash <(wget -qO- https://raw.githubusercontent.com/chambo-e/prometheus_node_exporter_installer/master/node_exporter_installer.sh)
```

### Contribution

Welcome and appreciated :)
