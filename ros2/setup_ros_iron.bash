#!/bin/bash -ueo

# MIT License
#
# Copyright (c) 2023 NaokiTakahashi
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

ros_distro=humble

sudo apt-get update --fix-missing

sudo apt-get install -y \
    python3-pip \
    git \
    cmake \
    make \
    build-essential \
|| exit 1

python3 -m pip install \
    colcon-common-extensions \
    vcstool \
|| exit 1

sudo apt-get install -y \
    libacl1-dev \
    libtinyxml2-dev \
    libasio-dev \
    libcurl4-gnutls-dev \
    libx11-dev \
    libxaw7-dev \
    libeigen3-dev \
    libfreetype-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgmock-dev \
    libqt5widgets5 \
    libopencv-dev \
    libbullet-dev \
    liborocos-kdl-dev \
    liblttng-ust-dev \
    pkg-config \
    sip-dev \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    pyqt5-dev \
    pyqt5-dev-tools \
    pybind11-dev \
    python3-flake8 \
    python3-pytest \
    python3-lark \
    python3-sip-dev \
    python3-pyqt5.sip \
    python3-pyqt5 \
    python3-numpy \
    python3-netifaces \
    python3-psutil \
    python3-future \
    python3-sphinx \
|| exit 1

if [ "galactic" = "$ros_distro" ]
then
    sudo apt-get install -y \
        libbison-dev \
        liblog4cxx-dev \
        libboost-python-dev \
    || exit 1
fi

sudo apt-get install -y \
    libusb-dev \
    libusb-1.0-0-dev \
|| exit 1

export PATH=$PATH:$HOME/.local/bin

mkdir -p ros2_${ros_distro}/src \
    && cd ros2_${ros_distro} \
    && vcs import \
        --input https://raw.githubusercontent.com/ros2/ros2/${ros_distro}/ros2.repos \
        src \
    && echo 'MAKEFLAGS="-j1" \
    colcon build \
    --symlink-install \
    --executor sequential \
	--parallel-workers=1 \
	--packages-ignore \
	    test_communication \
        --cmake-args \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_CXX_STANDARD_LIBRARIES="-latomic" \
            -DCMAKE_SHARED_LINKER_FLAGS="-latomic" \
            -DCMAKE_EXE_LINKER_FLAGS="-latomic" \
        || exit 1' > make.bash \
    && bash make.bash \
    && echo "Please 'source ros2_${ros_distro}/install/setup.bash'" \
|| exit 1

