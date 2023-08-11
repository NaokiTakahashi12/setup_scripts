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
&& cmake \
    --install "$qt_build_dir" \
|| exit 129
