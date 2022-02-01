echo "==========Hello World !============"
sudo apt-get update && apt-get install curl git wget
export WORK_DIR=${HOME}
echo "==============================="

echo "installing anaconda......"

cd ${WORK_DIR}
#自带python3.6的Anaconda大约是2018年的版本
curl -O https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
chmod +x Anaconda3-2021.05-Linux-x86_64.sh
./Anaconda3-2021.05-Linux-x86_64.sh -b -p ${WORK_DIR}/anaconda3
rm Anaconda3-2021.05-Linux-x86_64.sh
eval "$($HOME/anaconda3/bin/conda shell.bash hook)"
conda init
conda create -n work python=3.6
conda activate work
#conda install python=3.6
conda install -y -c anaconda boost cmake
conda install -y -c conda-forge pymesh2

#dos2unix chroma_env.sh
sudo cp chroma_env.sh /etc/profile.d/
source /etc/profile

echo "anaconda installed!"
echo "==============================="