#!/bin/bash

export PREFIX=/opt/conda
export CFLAGS="${CFLAGS} -I${PREFIX}/include"
export CXXFLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"

./autogen.sh
./configure --prefix=$PREFIX
make -j 4 -C Python  # This works for x86_64
# make -C Python # Multi-Threading process caused memory error under RPi3 B+; thus, set to single thread.
# sudo make -C Python install
# Use setup.py if building is done from a Git checkout
# Reference: https://github.com/lballabio/QuantLib-SWIG/tree/master/Python
cd Python
python setup.py wrap
python setup.py build
python setup.py test
python setup.py install
