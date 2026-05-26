#!/bin/bash

rm -rf .repo/local_manifests

repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault

git clone https://github.com/mdnoyon80123/hotdogb_local_manifest --depth 1 -b inf-q2 .repo/local_manifests

/opt/crave/resync.sh

source build/envsetup.sh
lunch infinity_hotdogb-userdebug

m bacon
