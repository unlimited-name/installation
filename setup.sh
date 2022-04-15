#!/bin/bash
echo "==========Hello World !============"
#sudo apt-get update && apt-get install curl git wget
export WORK_DIR=${HOME}
sudo cp g4py.4.10.05.p01.patch ${WORK_DIR}
echo "==============================="

echo "installing CUDA......"

cd ${HOME}
wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda_11.0.2_450.51.05_linux.run
sudo sh cuda_11.0.2_450.51.05_linux.run
rm cuda_11.0.2_450.51.05_linux.run
#sudo systemctl enable nvidia-persistenced
#sudo cp /lib/udev/rules.d/40-redhat.rules /etc/udev/rules.d 
#sudo sed -i 's/SUBSYSTEM!="memory",.*GOTO="memory_hotplug_end"/SUBSYSTEM=="*", GOTO="memory_hotplug_end"/' /etc/udev/rules.d/40-redhat.rules

echo "CUDA installed!"
echo "==============================="


echo "installing ROOT......"

cd ${WORK_DIR}
export VERSION_ROOT=6.22.02
sudo apt-get update
set -x; buildDeps='dpkg-dev gcc g++ binutils libx11-dev libxpm-dev libxft-dev libxext-dev libgsl-dev libfftw3-dev libpcre3-dev libxerces-c-dev libxmu-dev libxi-dev freeglut3-dev libboost-all-dev'
sudo apt-get install -y $buildDeps
curl -O https://root.cern/download/root_v${VERSION_ROOT}.source.tar.gz
tar xf root_v${VERSION_ROOT}.source.tar.gz && rm root_v${VERSION_ROOT}.source.tar.gz
mkdir ${WORK_DIR}/root-${VERSION_ROOT}/build-root && cd ${WORK_DIR}/root-${VERSION_ROOT}/build-root
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${HOME}/root -Dpython3=ON -Ddavix=OFF -Dminuit2=ON -Droofit=ON ${WORK_DIR}/root-${VERSION_ROOT}
make -j12 && make install

cd ${WORK_DIR}
rm -rf ${WORK_DIR}/root-${VERSION_ROOT}

if [ -e $HOME/root/bin/thisroot.sh ]; then
    source $HOME/root/bin/thisroot.sh
fi

echo "ROOT installed!"
echo "==============================="

echo "installing Geant4......"

export DEBIAN_FRONTEND=noninteractive
export VERSION_GEANT4=10.05.p01

cd ${WORK_DIR}
curl -O https://geant4-data.web.cern.ch/geant4-data/releases/geant4.${VERSION_GEANT4}.tar.gz
tar xf geant4.${VERSION_GEANT4}.tar.gz && rm geant4.${VERSION_GEANT4}.tar.gz
mkdir ${WORK_DIR}/geant4.${VERSION_GEANT4}/build-g4 && cd ${WORK_DIR}/geant4.${VERSION_GEANT4}/build-g4
cmake -DCMAKE_BUILD_TYPE=Release -DGEANT4_INSTALL_DATA=ON -DCMAKE_INSTALL_PREFIX=${HOME}/Geant4 -DGEANT4_USE_GDML=ON -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_XM=OFF ${WORK_DIR}/geant4.${VERSION_GEANT4}
make -j12 && make install

if [ -e $HOME/Geant4/bin/geant4.sh ]; then
    source $HOME/Geant4/bin/geant4.sh
    export PYTHONPATH="$HOME/Geant4/lib:$PYTHONPATH"
fi

export "Geant4 installed!"
echo "==============================="

echo "installing G4py......"

cd ${WORK_DIR}
mkdir ${WORK_DIR}/geant4.${VERSION_GEANT4} && cd ${WORK_DIR}/geant4.${VERSION_GEANT4}
sudo cp ${WORK_DIR}/g4py.4.10.05.p01.patch ./
git apply g4py.10.05.p01.patch
mkdir ${WORK_DIR}/geant4.${VERSION_GEANT4}/build-g4py && cd ${WORK_DIR}/geant4.${VERSION_GEANT4}/build-g4py
export BOOST_ROOT=${HOME}/anaconda3
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${HOME}/Geant4 ${WORK_DIR}/geant4.${VERSION_GEANT4}/environments/g4py
make -j12
sed -i 's/install: preinstall/install:/' Makefile
find . -name '*.cmake' -exec sed -i -n -E '/\.pyc|\.pyo/!p' {} \;
sed -i -E 's/(.*G4LossTableManager.Instance.*)/#\1/' source/python3/__init__.py
make install

cd ${WORK_DIR}
rm -rf ${WORK_DIR}/geant4.${VERSION_GEANT4}

echo "G4py installed!"
echo "==============================="

#echo "installing PyMesh......"

#cd ${WORK_DIR}
#sudo apt-get update && apt-get install -y libgmp-dev libmpfr-dev libgmpxx4ldbl zip unzip patchelf
#dos2unix chroma_env.sh
#sudo cp chroma_env.sh /etc/profile.d/
#source /etc/profile
#git clone --branch v0.3 https://github.com/PyMesh/PyMesh.git
#cd PyMesh
#git submodule update --init
#export $PYMESH_PATH=${WORK_DIR}/PyMesh
#python setup.py build
#python setup.py install
#cd ${WORK_DIR}
#sudo rm -rf PyMesh
#conda install -c conda-forge pymesh2

#echo "PyMesh installed!"
#echo "==============================="

echo "installing chroma......"

cd ${HOME}
sudo apt-get install libboost-all-dev
wget -O chroma_version.json https://api.github.com/repos/BenLand100/chroma/git/refs/heads/master
git clone https://github.com/BenLand100/chroma
cd chroma
sed -i 's/VIRTUAL_ENV/CONDA_PREFIX/g' setup.py #use anaconda env instead
python setup.py develop

echo "chroma installed!"