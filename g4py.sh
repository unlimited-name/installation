echo "installing G4py......"

cd ${WORK_DIR}
mkdir ${WORK_DIR}/geant4.${VERSION_GEANT4} && cd ${WORK_DIR}/geant4.${VERSION_GEANT4}
sudo cp ${WORK_DIR}/g4py.4.10.05.p01.patch ./
git apply g4py.4.10.05.p01.patch
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