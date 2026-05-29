#!/bin/bash

# Clean up old local_manifests
rm -rf .repo/local_manifests

# Clean the build environment
make clobber

# Initialize the repo
repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b sixteen-qpr2 --git-lfs

# Clone your local_manifest repository
git clone https://github.com/mdnoyon80123/hotdogb_local_manifest-j --depth 1 -b main .repo/local_manifests

# Sync the source code
/opt/crave/resync.sh

# Set environment variables for KernelSU
export WITH_KSU=true
export KSU_SUPPORT=1

# Setup build environment
source build/envsetup.sh

# Configure for your device with userdebug
breakfast hotdogb userdebug

# Start the compilation
m pixelos
