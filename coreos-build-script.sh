#!/bin/bash
set -ev

cd ~/coreos
./chromite/bin/cros_sdk -r
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
