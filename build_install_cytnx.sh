#!/usr/bin/env bash

test -d Cytnx_lib && echo "Cytnx_lib exists, manually remove it to reinstall" >&2 && exit 1
mkdir Cytnx_lib
cd Cytnx
#git checkout tags/v1.0.1
mkdir build
cd build
cmake ..   -DCMAKE_INSTALL_PREFIX=../../Cytnx_lib # -DBUILD_PYTHON=ON -DCMAKE_BUILD_TYPE=Release -DUSE_MKL=ON -DUSE_HPTT=OFF
make -j4
make install
cd ../../
