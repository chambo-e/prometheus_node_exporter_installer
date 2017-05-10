# Variables
EXPORTER_VERSION=${EXPORTER_VERSION:-0.14.0}
EXPORTER_FLAVOR=${EXPORTER_FLAVOR:-linux-amd64}
EXPORTER_USER=${EXPORTER_USER:-prometheus}
SERVICE_NAME=${SERVICE_NAME:-node_exporter}
DOWNLOAD_PATH=${DOWNLOAD_PATH:-/tmp}
BINARY_PATH=${BINARY_PATH:-/usr/bin}

# Create user
sudo useradd -s /usr/sbin/nologin -r -M $EXPORTER_USER

BINARY_FOLDER="node_exporter-${EXPORTER_VERSION}.${EXPORTER_FLAVOR}"
GZ_FILE="${BINARY_FOLDER}.tar.gz"

# Get node_exporter binary
wget -P $DOWNLOAD_PATH "https://github.com/prometheus/node_exporter/releases/download/v${EXPORTER_VERSION}/${GZ_FILE}"
tar -xzvf "${DOWNLOAD_PATH}/${GZ_FILE}" -C $DOWNLOAD_PATH
sudo mv "${DOWNLOAD_PATH}/${BINARY_FOLDER}/node_exporter" $BINARY_PATH

# Cleanup download folder
rm -r "${DOWNLOAD_PATH}/${GZ_FILE}" "${DOWNLOAD_PATH}/${BINARY_FOLDER}"


# Create service file
echo "[Unit]
Description=Prometheus node exporter
After=local-fs.target network-online.target network.target
Wants=local-fs.target network-online.target network.target

[Service]
User=$EXPORTER_USER
ExecStart=/usr/bin/node_exporter
Type=simple

[Install]
WantedBy=multi-user.target" | sudo tee "/lib/systemd/system/${SERVICE_NAME}.service"

# Reload systemd
sudo systemctl daemon-reload
# Enable service
sudo systemctl enable $SERVICE_NAME
# Start service
sudo systemctl start $SERVICE_NAME
