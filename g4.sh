export WORK_DIR=${HOME}
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