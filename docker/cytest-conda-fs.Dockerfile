FROM ubuntu:latest
WORKDIR /opt

COPY setup_conda.sh build_compile_cytnx.sh .

ARG cy_conda="OFF"
ARG cy_ver="1"
ARG py_ver="3.9"
ARG gxx_ver="14"
ARG make_ver="4"
ARG cmake_ver="4.1"
ARG CMAKE_INSTALL_PREFIX="default"
ARG BUILD_PYTHON="default"
ARG USE_ICPC="default"
ARG USE_MKL="default"
ARG USE_OMP="default"
ARG USE_CUDA="default"
ARG USE_HPTT="default"
ARG HPTT_ENABLE_FINE_TUNE="default"
ARG HPTT_ENABLE_AVX="default"
ARG HPTT_ENABLE_ARM="default"
ARG HPTT_ENABLE_IBM="default"
ARG USE_CUTENSOR="default"
ARG USE_CUQUANTUM="default"
ARG RUN_TESTS="default"
ARG RUN_BENCHMARKS="default"
ARG USE_DEBUG="default"
ARG BUILD_DOC="default"
ARG DEV_MODE="default"

# --- 1. System Dependencies & Download (Separate RUNs for caching)
RUN apt-get update && apt-get install -y curl wget vim bash
RUN curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"

# --- 2. Conda Installation, Environment Setup, and Package Install (Crucially, one combined RUN)
RUN bash setup_conda.sh \
    ${cy_conda} \
    ${cy_ver} \
    ${py_ver} \
    ${gxx_ver} \
    ${make_ver} \
    ${cmake_ver}

# RUN bash build_compile_cytnx.sh \
#     # ${path to cytnx dir, git clone or path to bind mount}
# 	${CMAKE_INSTALL_PREFIX} \
# 	${BUILD_PYTHON} \
# 	${USE_ICPC} \
# 	${USE_MKL} \
# 	${USE_OMP} \
# 	${USE_CUDA} \
# 	${USE_HPTT} \
# 	${HPTT_ENABLE_FINE_TUNE} \
# 	${HPTT_ENABLE_AVX} \
# 	${HPTT_ENABLE_ARM} \
# 	${HPTT_ENABLE_IBM} \
# 	${USE_CUTENSOR} \
# 	${USE_CUQUANTUM} \
# 	${RUN_TESTS} \
# 	${RUN_BENCHMARKS} \
# 	${USE_DEBUG} \
# 	${BUILD_DOC} \
#     ${DEV_MODE}

# --- 3. Final Environment Configuration
# Set the PATH to include the Conda environment binaries
ENV PATH="/opt/conda/envs/cytnx/bin:/opt/conda/bin:$PATH"

WORKDIR /work

CMD ["/bin/bash"]
