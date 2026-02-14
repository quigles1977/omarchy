# Omarchy Minimal - Custom packaging that skips bloat

# Only install base packages from our minimal list
run_logged $OMARCHY_INSTALL/packaging/fonts.sh
run_logged $OMARCHY_INSTALL/packaging/nvim.sh
run_logged $OMARCHY_INSTALL/packaging/icons.sh

# Skip webapps, tuis, asus-rog - these are bloat for minimal install
