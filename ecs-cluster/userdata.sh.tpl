#!/bin/bash
sudo iptables-save | sudo tee /etc/sysconfig/iptables && sudo systemctl enable --now iptables

cat <<'EOF' >> /etc/ecs/ecs.config
ECS_CLUSTER=${cluster_name}
EOF
