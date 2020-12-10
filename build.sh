#!/bin/bash
# Usage: Build.sh <Version>

VERSION=$1

. kernel.sh whyred ${VERSION}
cd ..
. kernel.sh whyred-new ${VERSION}
cd ..
. kernel.sh tulip ${VERSION}
cd ..
. kernel.sh tulip-new ${VERSION}
cd ..
. kernel.sh a26x ${VERSION}
cd ..
. kernel.sh a26x-new ${VERSION}
cd ..
. kernel.sh a26x-miuiq ${VERSION}
cd ..
. kernel.sh lavender ${VERSION}
cd ..
. kernel.sh lavender-new ${VERSION}
cd ..

