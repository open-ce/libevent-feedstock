#!/bin/bash
# *****************************************************************
# (C) Copyright IBM Corp. 2020, 2021. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# *****************************************************************

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
