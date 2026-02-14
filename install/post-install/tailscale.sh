# Enable and start tailscaled, then authenticate if authkey is available
if command -v tailscale >/dev/null 2>&1; then
  sudo systemctl enable --now tailscaled

  # Check for authkey file (baked into ISO, never in git)
  TAILSCALE_AUTHKEY_FILE="/root/tailscale-authkey.txt"
  if [[ -f "$TAILSCALE_AUTHKEY_FILE" ]]; then
    TAILSCALE_AUTHKEY=$(cat "$TAILSCALE_AUTHKEY_FILE" | tr -d '[:space:]')
    sudo tailscale up --authkey "$TAILSCALE_AUTHKEY" --ssh
    # Remove the key file after use
    sudo rm -f "$TAILSCALE_AUTHKEY_FILE"
  fi
fi
