#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf install -y dkms gcc kernel-devel kernel-headers
cd /tmp/wifi
ls /usr/lib/modules/6.12.11-200.fc41.x86_64
sed -i 's|/lib/modules/\${kernelver}/build|/usr/lib/modules/6.12.11-200.fc41.x86_64/build|' dkms.conf
sed -i 's|dkms build -m .* -v .*|dkms build -m ${DRV_NAME} -v ${DRV_VERSION} -k 6.12.11-200.fc41.x86_64|' dkms-install.sh
sed -i 's|dkms install -m .* -v .*|dkms install -m ${DRV_NAME} -v ${DRV_VERSION} -k 6.12.11-200.fc41.x86_64|' dkms-install.sh

# ls /usr/lib/modules
# cat dkms.conf
./dkms-install.sh

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File
