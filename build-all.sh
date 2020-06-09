echo -e "Compile Started for all devices"
source build-whyred.sh
cd out
rclone copy *.zip drive:whyred
cd ..
source build-whyred-new.sh
cd out
rclone copy *.zip drive:whyred
cd ..
source build-tulip.sh
cd out
rclone copy *.zip drive:tulip
cd ..
source build-tulip-new.sh
cd out
rclone copy *.zip drive:tulip
cd ..
source build-wayne.sh
cd out
rclone copy *.zip drive:wayne
cd ..
source build-wayne-new.sh
cd out
rclone copy *.zip drive:wayne
cd ..
echo -e "All files uploaded"
echo -e "Done, K thx"
