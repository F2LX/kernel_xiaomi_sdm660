#!/bin/bash

export KERNELNAME=Zaky_ma

export LOCALVERSION=1

export KBUILD_BUILD_USER=Zaky_Ma

export KBUILD_BUILD_HOST=.

export TOOLCHAIN=clang

export DEVICES=whyred,tulip,wayne

source helper

gen_toolchain

send_msg "Start building..."

START=$(date +"%s")

for i in ${DEVICES//,/ }
do
	build ${i} -oldcam

	build ${i} -newcam
done

send_msg "Build OC..."

git apply oc.patch

for i in ${DEVICES//,/ }
do
	if [ $i == "whyred" ] || [ $i == "tulip" ]
	then
		build ${i} -oldcam -overclock

		build ${i} -newcam -overclock
	fi
done

END=$(date +"%s")

DIFF=$(( END - START ))

send_msg "Build complete in $((DIFF / 60))m $((DIFF % 60))s"
