cd ..
# opencv + cvbridge
git clone -b humble https://github.com/ros-perception/vision_opencv.git
cd ..

sudo apt-get update
sudo apt-get install wget unzip

sudo apt install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev python3-pip python3-numpy
git clone https://github.com/opencv/opencv.git -b 3.4.1 --depth 1
git clone https://github.com/opencv/opencv_contrib.git -b $VERSION --depth 1

cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D INSTALL_C_EXAMPLES=OFF \
-D PYTHON_EXECUTABLE=$(which python2) \
-D BUILD_opencv_python2=OFF \
-D PYTHON3_EXECUTABLE=$(which python3) \
-D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules/ 

make -j $(nproc)
sudo make install
sudo ldconfig

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
cd eigen-3.3.9 && mkdir build && cd build
cmake ../ && sudo make install -j $(nproc)
cd .. && cd ..

