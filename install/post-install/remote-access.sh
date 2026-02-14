# Enable and configure SSH for remote access

# Install openssh if not present
if ! command -v sshd >/dev/null 2>&1; then
  sudo pacman -S --noconfirm --needed openssh
fi

# Enable sshd to start on boot
sudo systemctl enable sshd.service

# Allow SSH through UFW firewall
if command -v ufw >/dev/null 2>&1; then
  sudo ufw allow 22/tcp comment 'allow-ssh'
  sudo ufw reload 2>/dev/null || true
fi
