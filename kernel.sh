#!/bin/bash
#
# Copyright © 2020 The LunaticSpace Project
#
# USage: . kernel.sh device version
#

echo "*  Lunatic Kernel Buildbot"

LC_ALL=C date +%Y-%m-%d
date=`date +"%Y%m%d-%H%M"`
BUILD_START=$(date +"%s")
KERNEL_DIR=$PWD
REPACK_DIR=$KERNEL_DIR/AnyKernel3
OUT=$KERNEL_DIR/out
DEVICE_NAME=$1
VERSION=$2

rm -rf out
mkdir -p out
make O=out clean
make O=out mrproper
make O=out ARCH=arm64 ${DEVICE_NAME}_defconfig
PATH="/mnt/ssd/felix/proton/bin:${PATH}" \
make -j$(nproc --all) O=out \
ARCH=arm64 \
CC="ccache /mnt/ssd/felix/proton/bin/clang" \
CROSS_COMPILE=aarch64-linux-gnu- \
CROSS_COMPILE_ARM32=arm-linux-gnueabi-

cd $REPACK_DIR
cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb $REPACK_DIR/
FINAL_ZIP="Garuda-Kernel_${VERSION}-${DEVICE_NAME}.zip"
zip -r9 "${FINAL_ZIP}" *
cp *.zip $OUT
rm *.zip
cd $KERNEL_DIR
rm AnyKernel3/Image.gz-dtb

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
cd out
rclone copy *.zip drive:garudanew
echo -e "Done"
