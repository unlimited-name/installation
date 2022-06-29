# Installation of chroma on a Cloud platform
## Introduction
[Chroma](https://github.com/BenLand100/chroma) is a python-based GPU photon simulation pack, which works perticularly on Linux platform. 
The maintainer provides a Docker image for quick use, but it doesn't work on Windows machines. In order for the convenience of non-Linux users, we chose to use Cloud platforms like Google Cloud (or wherever you like). This repository is a collection of Linux shell batches used to install chroma on a Cloud Virtual Machine Instance. 

When creating the Virtual Machine Instance, remember to use Ubuntu system image; Since chroma uses GPUs for simulation, a machine with a GPU core is also mandatory. 

## Steps to install
With a new Ubuntu machine, first run `sudo apt-get update && sudo apt-get install -y git` to acquire git. Then clone this repository: `git clone https://github.com/unlimited-name/installation && cd installation`

First of all, use `chmod +x *.sh` and `./anaconda.sh` to install anaconda. After installation, you may need to restart the shell or use `source /etc/profile` to refresh the environment. Then run `./setup.sh` to finish chroma installation. **Note you need to check CUDA version of the GPU drive.** You will need to wait for seconds and type `accept`, and then choose CUDA Toolkit for installation. After this, you may leave and wait for a moment until the installation finishes automatically. 

### some explanation
In `setup.sh`, there are several parts stated as following: 
- CUDA Toolkit
- ROOT
- Geant4
- G4py
- pymesh
- chroma

Chroma integrates all of the above. Pymesh is actually ommited in our installation batch. All the jobs concerning meshes are recommended to be finished somewhere else, there is no need to wait for the time-consumer and error-maker aka pymesh installation. 

CUDA Toolkit **MUST** match your GPU and GPU drive version. Aside from CUDA, shell scripts for other parts are also separated in different files, you may try to run them separately but note `g4py.sh` should be executed after `g4.sh` and chroma should be the last part to install. 

## Tips for self-debugging
* How to check the GPU drive version

Run `nvidia-smi` will expose the information you need. 
* Environmental variables

They are written in `chroma_env.sh` and copied to /etc/profile.d. 
* G4py patch

G4py installation uses a patch file included in the repository. Although we tried to include flexibility of G4 version, the patch file needs to be modified for different versions. 
* Dockerfile and self-maintainace

The installation batch is written based on the Dockerfile used to build docker images, see [here](https://github.com/BenLand100/chroma/tree/master/installation) for more details. You can also write your own favored shell script with the information provided. 