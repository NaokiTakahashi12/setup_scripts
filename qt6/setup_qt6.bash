#!/bin/bash -ueo

sudo apt-get update --fix-missing

sudo apt-get install -y \
    qt6-base-dev \
    qt6-declarative-dev \
    qt6-quick3d-dev \
    qt6-quick3d-dev-tools \
    libqt6opengl6-dev \
    libgl1-mesa-dev \
    qml6-module-qtquick \
    qml6-module-qtqml-workerscript \
|| exit 129
