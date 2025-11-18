#/usr/bin/env bash
# Used by cy*-conda*.Dockerfile

vars=("cy_conda" "cy_ver" "py_ver" "gxx_ver" "make_ver" "cmake_ver")

vals=("$@")

varnum=${#vars[@]}

for ((i = 0; i < ${varnum}; ++i)) ; do
    eval ${vars[$i]}=${vals[$i]}
done

miniforge_install(){
    bash Miniforge3-$(uname)-$(uname -m).sh -p /opt/conda -b 
    rm Miniforge3-$(uname)-$(uname -m).sh 
    # Initialize the shell for Conda (using the profile script)
    . /opt/conda/etc/profile.d/conda.sh 
}

conda_env_setup(){
    # Create the environment
    conda create -n cytnx python="${py_ver}" _openmp_mutex=*=*_llvm -y 
    # Activate and install (must be in the same RUN command)
    conda activate cytnx 
    [[ ${cy_conda} == "ON" ]] && conda install -c kaihsinwu cytnx="${cy_ver}" -y 
    # Clean up Conda files to keep the image small
    conda clean --all -f -y 
    conda install -c conda-forge gxx="${gxx_ver}" make="${make_ver}" cmake="${cmake_ver}" -y
}

miniforge_install
conda_env_setup
