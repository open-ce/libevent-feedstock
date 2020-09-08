#!/bin/bash

export CFLAGS="-I${PREFIX}/include ${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"
export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"

# Set the fallback library environment variable.
export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH

chmod +x ./autogen.sh

./autogen.sh
./configure --prefix="${PREFIX}" --host="${HOST}" --disable-dependency-tracking
make -j${CPU_COUNT}

eval ${LIBRARY_SEARCH_VAR}="${PREFIX}/lib" make check

make install

# Remove Python script to avoid confusion and a Python dependency.
rm -fv "${PREFIX}/bin/event_rpcgen.py"
