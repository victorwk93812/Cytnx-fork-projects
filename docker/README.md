# Cytnx Environment Containers

|Dockerfile|Purpose|Size|
|:-:|:-:|:-:|
|`cytest-conda.Dockerfile`|Using conda packaged Cytnx library|3.9 GB (miniforge install + env 3.5GB)|
|`cytest-conda-fs.Dockerfile`|Using Cytnx built from source in a conda env|(test in progress)|
|`cytest-native-fs.Dockerfile`|Using Cytnx built from source in native OS env||(test in progress)|
|`cydev-conda.Dockerfile`|Developing the Cytnx package in a conda env||(test in progress)|
|`cydev-native.Dockerfile`|Developing Cytnx package in native OS env||(test in progress)|

## Prerequisites

A working, properly configured container engine (docker, podman, etc.).  

## Usage

### Images

#### Build Stage

- `cytest-conda.Dockerfile`  

```bash
docker build\
    -t <image_tag>\
    -f cytest-conda.Dockerfile .
```

- `cytest-<type>-fs.Dockerfile`  

Specify the path/URL to a Cytnx repo so that the image build stage (re-)builds & (re-)compiles the project for you (on each repo modification, typically a new git commit).  
Defaults to [latest Github release of upstream Cytnx](https://github.com/Cytnx-dev/Cytnx/releases/latest).  
If you wish to stick to a Cytnx library version and avoid image rebuilds as much as possible, keep this path to your cloned local version.   

```bash
docker build [--build-arg CYTNX_ROOT_PATH=<path_to_Cytnx_repo> <CMAKE_FLAG>=<option>]\
    -t <image_tag>\
    -f cytest-<type>-fs.Dockerfile .
```


- `cydev-<type>.Dockerfile`  

```bash
docker build\
    -t <image_tag>\
    -f cydev-<type>.Dockerfile .
```

#### Runtime Stage

- `cytest-<type>.Dockerfile`  

Bind mount your source code that uses Cytnx so that progress is always saved. 
Moreover, coding and git operations could be done on the host machine using configured IDE/text editors!  

```bash
docker run -it --rm\
    --mount type=bind,src=<local_test_src_path>,dst=/work/src\
    <cytest_image_tag>
```

- `cydev-<type>.Dockerfile`  

The CMake build directory and the Cytnx library installation will be constantly modified (since you are developing), but should persist across container runs (since as a developer you want to keep the object files and libraries). 
Thus volumes are used for them.  

The reason for bind mounting the Cytnx source code is similar to bind mounting test code. 
Besides a similar reason for bind mounting the source code for test usage, there are more considerations on this approach. 
Consider we create a layer COPYing the git repo at build stage and build & compile the project following that. 
Once the repo changes (which frequently does since you're developing), the image needs a (automatic) rebuild. 
This is not intended since

1. Development should be able to stop at any time, not necessarily a git commit.  
2. Recompiling the entire Cytnx package is considerably slow.  

However, the downside of this is that first build and compilation of the project must be done manually in runtime as well. 
This should not be a problem to a developer who would be constantly doing this.  

```bash
docker run -it --rm\
    -v cydev-<type>-build:/work/Cytnx_build\
    -v cydev-<type>-lib:/usr/local/cytnx\
--mount type=bind,src=<path_to_Cytnx_repo>,dst=/work/Cytnx\
# --mount type=bind,src=<local_test_src_path>,dst=/work/src\ # optionally, if other source code is tested
    <cydev_image_tag>
```

### Developing

#### Using Cytnx

Coding on host machine using pre-configured binaries or directly in the container is optional.  
Just ensure tests are run in the container.  

#### As a Developer

Additionally ensure CMake builds and the install destination are located at `/work/Cytnx_build` and `/usr/local/cytnx`, respectively, so that binaries are saved in docker volumes.  

```bash
cd /work/Cytnx_build
cmake [options] <path_to_Cytnx_repo> # -DCMAKE_INSTALL_PREFIX defaults to /usr/local/cytnx
make
make install
```

## TODO

- Multi-platform?  
- GPU?  
