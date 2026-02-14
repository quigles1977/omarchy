# Install base packages - use minimal list if requested
if [[ $OMARCHY_MINIMAL == "true" ]]; then
  if [[ -f "$OMARCHY_INSTALL/omarchy-minimal.packages" ]]; then
    mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-minimal.packages" | grep -v '^$')
  else
    mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-base.packages" | grep -v '^$')
  fi
else
  mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-base.packages" | grep -v '^$')
fi
sudo pacman -S --noconfirm --needed "${packages[@]}"
