使用方法：
chroma_env.sh 为在开机时写入环境变量，这部分工作在setup.sh中会自动完成
若要移除这个脚本，使用sudo rm /etc/profile.d/chroma_env.sh

anaconda.sh 与 setup.sh为安装脚本。由于在Windows中写成，运行之前需要先转化文本格式：
dos2unix anaconda.sh
dos2unix setup.sh
然后赋权与运行
chmod +x blabla.sh && ./blabla.sh

应当先运行anaconda.sh安装anaconda与pymesh
原脚本中pymesh的安装是使用源代码安装，由于包含大量github第三方内容所以经常复制失败
改用conda安装。缺点是conda-forge的pymesh只支持python3.6，可以用conda create创建环境或直接conda install python=3.6
也可以去找python版本为3.6的anaconda历史版本。原脚本的pymesh安装被我注释掉了，以备需求
理论上来说只要代码中没有需要import pymesh的函数，这部分就算安装失败也不会有任何问题。
基于以上考虑，把anaconda的安装脚本另外放了个文件方便更改试错，另外也可以在anaconda安装完之后重启一次。

g4py.4.xxx.patch 为G4py安装包，大概是他们自己改写过的，所以我只能照搬。

脚本中的CUDA版本需要匹配服务器提供的GPU版本，可以先运行nvidia-smi查看版本后去官网找对应的CUDA版本。
安装时注意只需要选toolkit和examples，云服务器应该是有Driver不需要重复安装

将所有文件复制到$HOME目录下运行两个.sh脚本即可一键搞定安装，国内服务器可能有网络问题，注意避开国内夜间高峰期。
总安装耗时很久，可以挂后台干别的，除了CUDA安装，其他应当都不需要看（我这里看过，应该没问题。）