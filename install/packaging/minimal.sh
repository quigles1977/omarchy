# Omarchy Minimal - Custom packaging that skips bloat

# Install base packages from our minimal list (base.sh reads OMARCHY_MINIMAL)
run_logged $OMARCHY_INSTALL/packaging/base.sh
run_logged $OMARCHY_INSTALL/packaging/fonts.sh
run_logged $OMARCHY_INSTALL/packaging/nvim.sh
run_logged $OMARCHY_INSTALL/packaging/icons.sh

# Skip webapps, tuis, asus-rog - these are bloat for minimal install
