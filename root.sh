echo "==========Hello World !============"
export WORK_DIR=${HOME}

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
