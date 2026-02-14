# Enable and configure SSH for remote access

# Install openssh if not present
if ! command -v sshd >/dev/null 2>&1; then
  sudo pacman -S --noconfirm --needed openssh
fi

# Enable sshd to start on boot (chrootable - won't try to start in chroot)
chrootable_systemctl_enable sshd

# Allow SSH through UFW firewall (only if not in chroot - ufw needs iptables)
if [[ -z "${OMARCHY_CHROOT_INSTALL:-}" ]]; then
  if command -v ufw >/dev/null 2>&1; then
    sudo ufw allow 22/tcp comment 'allow-ssh'
    sudo ufw reload 2>/dev/null || true
  fi
fi
