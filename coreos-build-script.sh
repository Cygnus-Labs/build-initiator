#!/bin/bash
set -ev

git config --global user.email "lucractius@me.com"
git config --global user.name "Samuel Bishop"
git config --global color.ui "true"
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH="$PATH":`pwd`/depot_tools
mkdir coreos
cd coreos
repo init -u https://github.com/cygnus-labs/manifest.git -g minilayout --repo-url https://chromium.googlesource.com/external/repo.git
repo sync
# ./chromite/bin/cros_sdk -r
./chromite/bin/cros_sdk
./set_shared_user_password.sh testing
echo amd64-usr > .default_board
repo sync
./setup_board
./build_packages
./build_image --noenable_rootfs_verification dev
./image_to_vm.sh --from=../build/images/amd64-usr/developer-latest --board=amd64-usr --to=~ --format=ami
./image_to_vm.sh --from=../build/images/amd64-usr/developer-latest --board=amd64-usr --to=~ --format=vagrant_vmware_fusion
./image_to_vm.sh --from=../build/images/amd64-usr/developer-latest --board=amd64-usr --to=~ --format=virtualbox
./image_to_vm.sh --from=../build/images/amd64-usr/developer-latest --board=amd64-usr --to=~ --format=vagrant
