echo Building seL4...

if [ ! -d build ]; then
    # Create build directory
    mkdir -p build build/install

    # Generate ninja files
    cd build
    cmake -DCROSS_COMPILER_PREFIX= -DCMAKE_TOOLCHAIN_FILE=../seL4/gcc.cmake -DCMAKE_INSTALL_PREFIX=install -G Ninja -C ../config.cmake ../seL4
    cd ..
fi

# Build seL4
cd build
ninja kernel.elf libsel4.a install
cd ..