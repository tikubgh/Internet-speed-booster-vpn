rm setup.sh
cat > setup.sh << 'EOF'
#!/bin/bash
set -e
p=$(curl -s ifconfig.me);apt update -y&&apt install -y shadowsocks-libev libcap2-bin iptables net-tools&&setcap 'cap_net_bind_service=+ep' /usr/bin/ss-server;useradd -r -s /sbin/nologin -M shadowsocks 2>/dev/null||true;mkdir -p /etc/shadowsocks-libev&&chown shadowsocks:shadowsocks /etc/shadowsocks-libev&&echo '{"server":"0.0.0.0","server_port":443,"password":"fastpass123","method":"aes-256-gcm","timeout":5,"fast_open":true,"tcp_nodelay":true,"workers":'$(nproc)'}' >/etc/shadowsocks-libev/config.json&&chmod 600 /etc/shadowsocks-libev/config.json&&chown shadowsocks:shadowsocks /etc/shadowsocks-libev/config.json;echo 'net.ipv4.tcp_fastopen=3
net.core.rmem_max=268435456
net.core.wmem_max=268435456
net.ipv4.tcp_rmem=4096 33554432 268435456
net.ipv4.tcp_wmem=4096 33554432 268435456
net.ipv4.tcp_congestion_control=bbr
net.core.netdev_max_backlog=500000
net.core.somaxconn=524288
net.ipv4.tcp_max_syn_backlog=524288
net.ipv4.tcp_mtu_probing=1
net.ipv4.tcp_fin_timeout=3
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_slow_start_after_idle=0
net.ipv4.tcp_window_scaling=1
net.ipv4.tcp_base_mss=1460
net.ipv4.tcp_low_latency=1
net.ipv4.tcp_ecn=0
net.core.default_qdisc=fq
net.ipv4.tcp_adv_win_scale=1
net.ipv4.tcp_moderate_rcvbuf=1
net.ipv4.ip_no_pmtu_disc=1
net.ipv4.tcp_sack=1
net.ipv4.tcp_dsack=1
net.ipv4.tcp_fack=1
net.ipv4.tcp_no_metrics_save=1
net.ipv4.tcp_frto=2
net.ipv4.tcp_early_retrans=1
net.ipv4.tcp_autocorking=0
net.ipv4.tcp_thin_linear_timeouts=1' >/etc/sysctl.d/99-shadowsocks.conf&&sysctl -p /etc/sysctl.d/99-shadowsocks.conf&&modprobe tcp_bbr 2>/dev/null||true;iptables -A INPUT -p tcp --dport 22 -j ACCEPT;iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT;iptables -A INPUT -p tcp --dport 443 -j ACCEPT;iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT;netstat -tuln|grep :443&&{ echo "Port 443 in use by another process"; netstat -tulnp|grep :443; exit 1; };echo '[Unit]
Description=Shadowsocks-libev Server
After=network.target
[Service]
Type=simple
ExecStart=/usr/bin/ss-server -c /etc/shadowsocks-libev/config.json
Restart=on-failure
User=shadowsocks
Group=shadowsocks
LimitNOFILE=4194304
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE
[Install]
WantedBy=multi-user.target' >/etc/systemd/system/shadowsocks-libev.service&&systemctl daemon-reload&&systemctl enable shadowsocks-libev&&systemctl restart shadowsocks-libev&&sleep 3;systemctl is-active shadowsocks-libev >/dev/null&&echo "Setup complete! Use in Windows Outline client: ss://aes-256-gcm:fastpass123@$p:443"||{ echo "Failed: Service not running"; systemctl status shadowsocks-libev; exit 1; };netstat -tuln|grep :443&&echo "Server running on 443"||{ echo "Failed: Port 443 not open"; netstat -tulnp|grep :443; exit 1; }
EOF

bash setup.sh
