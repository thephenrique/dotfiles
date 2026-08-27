```
mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/c920-white-balance.service <<'EOF'
[Unit]
Description=Fix C920 white balance

[Service]
ExecStart=/bin/bash -c 'while true; do ~/.config/bin/c920-white-balance.sh >/dev/null 2>&1 || true; sleep 5; done'
Restart=always

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now c920-white-balance.service
```
