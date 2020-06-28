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
VERSION="5.0"

rm -rf out
mkdir -p out
make O=out clean
make O=out mrproper
make O=out ARCH=arm64 whyred-new_defconfig
PATH="/space/felix/clang/clang-r383902c/bin:/space/felix/gcc/bin:${PATH}" \
make -j$(nproc --all) O=out \
ARCH=arm64 \
CC="ccache /space/felix/clang/clang-r383902c/bin/clang" \
CLANG_TRIPLE=aarch64-linux-gnu- \
CROSS_COMPILE=aarch64-linux-android- \
CROSS_COMPILE_ARM32="/space/felix/gcc32/bin/arm-linux-androideabi-"

cd $REPACK_DIR
cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb $REPACK_DIR/
FINAL_ZIP="PhantomCAF-EAS-newcam-${VERSION}.zip"
zip -r9 "${FINAL_ZIP}" *
cp *.zip $OUT
rm *.zip
cd $KERNEL_DIR
rm AnyKernel3/Image.gz-dtb

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
cd out
rclone copy *.zip drive:whyred
echo -e "Done"
