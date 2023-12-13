cd ..
# opencv + cvbridge
git clone -b humble https://github.com/ros-perception/vision_opencv.git
cd ..

# ceres solver
sudo apt-get install -y cmake libgoogle-glog-dev libatlas-base-dev libsuitesparse-dev
wget http://ceres-solver.org/ceres-solver-2.1.0.tar.gz
tar zxf ceres-solver-2.1.0.tar.gz
cd ceres-solver-2.1.0
mkdir build && cd build
cmake -DEXPORT_BUILD_DIR=ON \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        ../
make -j $(nproc) # number of cores
make test -j $(nproc)
sudo make install -j $(nproc)
cd .. && cd ..

# eigen
wget -O eigen-3.3.9.zip https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.zip 
unzip eigen-3.3.9.zip
cd ~/eigen-3.3.9 && mkdir build && cd build
cmake ../ && sudo make install -j $(nproc)
cd .. && cd ..

