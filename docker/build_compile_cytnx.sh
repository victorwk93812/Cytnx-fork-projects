#/usr/bin/env bash

vars=("CMAKE_INSTALL_PREFIX" \
    "BUILD_PYTHON" \
    "USE_ICPC" \
    "USE_MKL" \
    "USE_OMP" \
    "USE_CUDA" \
    "USE_HPTT" \
    "HPTT_ENABLE_FINE_TUNE" \
    "HPTT_ENABLE_AVX" \
    "HPTT_ENABLE_ARM" \
    "HPTT_ENABLE_IBM" \
    "USE_CUTENSOR" \
    "USE_CUQUANTUM" \
    "RUN_TESTS" \
    "RUN_BENCHMARKS" \
    "USE_DEBUG" \
    "BUILD_DOC" \
    "DEV_MODE")

vals=("$@")

varnum=${#vars[@]}

for ((i = 0; i < ${varnum}; ++i)) ; do
    eval ${vars[$i]}=${vals[$i]}
done

# cd ${cytnx_source_dir_specified_by_--build-arg}
# cmake install...
