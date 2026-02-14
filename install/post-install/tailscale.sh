# Enable tailscaled (chrootable - won't try to start in chroot)
if command -v tailscale >/dev/null 2>&1; then
  chrootable_systemctl_enable tailscaled

  # If authkey is present, create a first-boot service to auth tailscale
  # Can't run tailscale up in chroot - no network/systemd
  TAILSCALE_AUTHKEY_FILE="/root/tailscale-authkey.txt"
  if [[ -f "$TAILSCALE_AUTHKEY_FILE" ]]; then
    TAILSCALE_AUTHKEY=$(cat "$TAILSCALE_AUTHKEY_FILE" | tr -d '[:space:]')

    sudo tee /etc/systemd/system/tailscale-auth.service >/dev/null <<EOF
[Unit]
Description=Tailscale auto-auth on first boot
After=tailscaled.service network-online.target
Wants=tailscaled.service network-online.target

[Service]
Type=oneshot
ExecStart=/usr/bin/tailscale up --authkey $TAILSCALE_AUTHKEY --ssh
ExecStartPost=/bin/rm -f /etc/systemd/system/tailscale-auth.service
ExecStartPost=/bin/rm -f /root/tailscale-authkey.txt
ExecStartPost=/usr/bin/systemctl daemon-reload
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl enable tailscale-auth.service
    sudo rm -f "$TAILSCALE_AUTHKEY_FILE"
  fi
fi
