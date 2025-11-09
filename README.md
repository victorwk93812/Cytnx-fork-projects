# My Cytnx Fork and Test Projects

Location/Name of this Cytnx-related projects repository  

|Local|Remote|
|:-:|:-:|
|`$HOME/Desktop/develop/cus/`|[`victorwk93812/Cytnx-fork-projects - Github`](https://github.com/victorwk93812/Cytnx-fork-projects)|

## Hierarchy

Main directories and purposes of them.  

- `Cytnx/` -- Cytnx fork of [upstream Cytnx](https://github.com/Cytnx-dev/Cytnx), a **git submodule**  
- `projects/` -- Projects involving Cytnx, may involve **git submodules**  
    - `cpp/` -- Cpp projects
    - `python/` -- Python projects
- `Cytnx-installation-YYYYMMDD-NUM/` -- Cytnx installation (including C++ libraries and python modules) built on `YYYYMMDD` trial no. `NUM`, ignored  

## Dependency Management and Build System

The Cytnx fork under `Cytnx/` and python projects under `projects/python/` are managed with [uv](https://docs.astral.sh/uv/).  
