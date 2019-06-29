using BinaryBuilder

name = "Darknet"
version = v"1.0.0"

# Collection of sources required to build HDF5.  Use the CMake download because
# it includes appropriate zlib and szip sources, letting us build them into libhdf5.
sources = [
    "https://github.com/AlexeyAB/darknet/archive/88cccfcad4f9591a429c1e71c88a42e0e81a5e80.zip" =>
    "ee54ccb1a648f0ae4cfa41c6f6e312c5d4f59bb907c985e705c7eae06f81f071"
]

GPU = true
CUDNN = true
CUDNN_HALF = false
OPENCV = false
DEBUG = false
OPENMP = false
LIBSO = true
ZED_CAMERA = false


# ./configure --prefix=$prefix --host=$target
# make -j${nproc}
# make install

# sed -i 's/GPU=0/GPU=1/g' Makefile
# sed -i 's/CUDNN=0/CUDNN=1/g' Makefile
# sed -i 's/CUDNN_HALF=0/CUDNN_HALF=1/g' Makefile
# sed -i 's/OPENCV=0/OPENCV=1/g' Makefile
# sed -i 's/DEBUG=0/DEBUG=1/g' Makefile
# sed -i 's/OPENMP=0/OPENMP=1/g' Makefile
# sed -i 's/LIBSO=0/LIBSO=1/g' Makefile
# sed -i 's/ZED_CAMERA=0/ZED_CAMERA=1/g' Makefile


# cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/darknet-*

./configure --prefix=$prefix --host=$target
make -j${nproc}
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    #Windows(:i686),
    #Windows(:x86_64),
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    #Linux(:aarch64, libc=:glibc),
    #Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    #Linux(:powerpc64le, libc=:glibc),
    #Linux(:i686, libc=:musl),
    #Linux(:x86_64, libc=:musl),
    #Linux(:aarch64, libc=:musl),
    #Linux(:armv7l, libc=:musl, call_abi=:eabihf),
    MacOS(:x86_64),
    #FreeBSD(:x86_64)
 ]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libdarknet", :libdarknet),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
