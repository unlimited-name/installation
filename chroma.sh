echo "installing chroma......"

cd ${HOME}
sudo apt-get install libboost-all-dev
wget -O chroma_version.json https://api.github.com/repos/BenLand100/chroma/git/refs/heads/master
git clone https://github.com/BenLand100/chroma
cd chroma
sed -i 's/VIRTUAL_ENV/CONDA_PREFIX/g' setup.py #use anaconda env instead
python setup.py develop

echo "chroma installed!"