-----------------------------------------------------------------------------
#
# Package : golang_protobuf_extensions
# Version : fc2b8d3a73c4867e51861bbdd5ae3c1f0869dd6a
# Source repo : https://github.com/matttproud/golang_protobuf_extensions
# Tested on : RHEL ubi 8.5
# Language : GO
# Script License: Apache License, Version 2 or later
# Maintainer : Sandeep Yadav <Sandeep.Yadav10@ibm.com>
#
# Disclaimer: This script has been tested in root mode on given
# ========== platform using the mentioned version of the package.
# It may not work as expected with newer versions of the
# package and/or distribution. In such case, please
# contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

#!/bin/bash

CWD=`pwd`

PACKAGE_PATH=github.com/matttproud/golang_protobuf_extensions
PACKAGE_NAME=golang_protobuf_extensions
PACKAGE_VERSION=${1:-fc2b8d3a73c4867e51861bbdd5ae3c1f0869dd6a}
PACKAGE_URL=https://github.com/matttproud/golang_protobuf_extensions

# Install dependencies
yum install -y make git wget

# Download and install go
wget https://golang.org/dl/go1.17.5.linux-ppc64le.tar.gz
tar -xzf go1.17.5.linux-ppc64le.tar.gz
rm -rf go1.17.5.linux-ppc64le.tar.gz
export GOPATH=`pwd`/gopath
export PATH=`pwd`/go/bin:$GOPATH/bin:$PATH

# Clone the repo and checkout submodules
mkdir -p $GOPATH/src/$PACKAGE_PATH
cd $GOPATH/src/$PACKAGE_PATH
git clone $PACKAGE_URL
cd $PACKAGE_NAME
git checkout $PACKAGE_VERSION

go mod init
go mod tidy

go get github.com/golang/protobuf/proto

echo "Building $PACKAGE_PATH$PACKAGE_NAME with $PACKAGE_VERSION"

if ! go build -v ./...; then
echo "------------------$PACKAGE_NAME:build_fails-------------------------------------"
exit 1
else
echo "------------------$PACKAGE_NAME:install_success-------------------------"
exit 0
fi


