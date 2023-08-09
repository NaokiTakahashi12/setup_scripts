#!/bin/bash -ueo

qt_version="v6.5.2"
qt_build_dir="qt_build_$qt_version"

git clone https://code.qt.io/qt/qt5.git qt6 \
    --branch "$qt_version" \
    --depth 1 \
    --shallow-submodules \
    --recursive \
&& cmake \
    -S qt6 \
    -B "$qt_build_dir" \
    -DCMAKE_BUILD_TYPE=Release \
&& cmake \
    --build "$qt_build_dir" \
|| exit 129
