echo "==========Hello World !============"
export WORK_DIR=${HOME}
sudo cp g4py.4.10.05.p01.patch ${WORK_DIR}
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

if [ -e $HOME/Geant4/bin/geant4.sh ]; then
    source $HOME/Geant4/bin/geant4.sh
    export PYTHONPATH="$HOME/Geant4/lib:$PYTHONPATH"
fi

echo "G4py installed!"
echo "==============================="
