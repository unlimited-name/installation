echo "==========Hello World !============"
sudo apt-get update && apt-get install curl git wget
cd ${HOME}
mkdir installation
export WORK_DIR=${HOME}/installation
echo "==============================="

echo "installing anaconda......"

cd ${WORK_DIR}
#自带python3.6的Anaconda大约是2018年的版本
curl -O https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
chmod +x Anaconda3-2018.12-Linux-x86_64.sh
./Anaconda3-2018.12-Linux-x86_64.sh -b -p ${HOME}/anaconda3
rm Anaconda3-2018.12-Linux-x86_64.sh
eval "$($HOME/anaconda3/bin/conda shell.bash hook)"
conda init

conda install -y -c anaconda boost cmake
conda install -y -c conda-forge pymesh2

#dos2unix chroma_env.sh
sudo cp chroma_env.sh /etc/profile.d/
source /etc/profile

echo "anaconda installed!"
echo "==============================="