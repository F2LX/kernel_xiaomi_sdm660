#!/bin/bash
#
# Copyright © 2018-2019, "penglezos" <panagiotisegl@gmail.com>
# Thanks to Vipul Jha for zip creator
# Android Kernel Compilation Script
#

echo -e "==============================================="
echo    "         Compiling Phantom CAF Kernel             "
echo -e "==============================================="

LC_ALL=C date +%Y-%m-%d
date=`date +"%Y%m%d-%H%M"`
BUILD_START=$(date +"%s")
KERNEL_DIR=$PWD
REPACK_DIR=$KERNEL_DIR/AnyKernel3
OUT=$KERNEL_DIR/out
VERSION="nightly"

export ARCH=arm64 && SUBARCH=arm64
export CROSS_COMPILE="/home/felix/aospgcc/bin/aarch64-linux-android-"

rm -rf out
mkdir -p out
make O=out clean
make O=out mrproper
make O=out ARCH=arm64 tulip-new_defconfig
make -j$(nproc --all) O=out

cd $REPACK_DIR
cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb $REPACK_DIR/
FINAL_ZIP="PhantomCAF-tulip-newcam-${VERSION}.zip"
zip -r9 "${FINAL_ZIP}" *
cp *.zip $OUT
rm *.zip
cd $KERNEL_DIR
rm AnyKernel3/Image.gz-dtb

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo -e "Done"
