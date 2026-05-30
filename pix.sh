#!/bin/bash

set -e  # Stop script if any command fails

echo "============================================"
echo "   PixelOS Sixteen-QPR2 - hotdogb Build    "
echo "============================================"

# 1. Clean old local manifests
echo "[1/7] Cleaning old local manifests..."
rm -rf .repo/local_manifests

# 2. Initialize repo
echo "[2/7] Initializing repo..."
repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b sixteen-qpr2 --git-lfs -q

# 3. Clone local manifest
echo "[3/7] Cloning local manifest..."
git clone https://github.com/mdnoyon80123/hotdogb_local_manifest-j --depth 1 -b main .repo/local_manifests

# 4. Sync sources
echo "[4/7] Starting source sync..."
/opt/crav/e/resync.sh

# 5. Setup build environment
echo "[5/7] Setting up build environment..."
source build/envsetup.sh

# 6. Set TARGET_RELEASE (Critical for Android 16)
echo "[6/7] Setting TARGET_RELEASE..."
export TARGET_RELEASE=trunk_staging

# 7. Configure device and start build
echo "[7/7] Configuring device and starting build..."

# Try breakfast first, fallback to lunch
if ! breakfast hotdogb userdebug; then
    echo "→ Breakfast failed, trying direct lunch..."
    lunch hotdogb-trunk_staging-userdebug
fi

echo "🚀 Starting compilation... (This will take a long time)"
m pixelos -j$(nproc --all) --no-print-directory

echo "============================================"
echo "          Build Process Completed!          "
echo "============================================"
