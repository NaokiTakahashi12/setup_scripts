#!/bin/bash -ueo

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
    uuid-dev \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-python-dev \
    libgraphicsmagick++1-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libompl-dev \
    nlohmann-json3-dev \
|| exit 1

mkdir -p ros2_nav2_depend_library/src \
    && cd ros2_nav2_depend_library/src \
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
	    nav2_system_tests \
    --cmake-args \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_STANDARD_LIBRARIES="-latomic" \
        -DCMAKE_SHARED_LINKER_FLAGS="-latomic" \
        -DCMAKE_EXE_LINKER_FLAGS="-latomic" \
    || exit 1' > make.bash \
    && bash make.bash \
    && echo "Please 'source ros2_${ros_distro}/install/setup.bash'" \
|| exit 1

