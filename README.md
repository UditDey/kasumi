# Kasumi

Kasumi is an `x86_64` PC operating system design built with [seL4](https://github.com/seL4/seL4/tree/master), Rust and [limine](https://github.com/limine-bootloader/limine/tree/trunk)

This project is an experiment in OS userspace design with the broad goals being:
- Can we build a graphical desktop grade OS atop the `seL4` microkernel?
- Can we create a userspace consisting of components communicating over a system-wide bus with well defined [flatbuffer](https://flatbuffers.dev/) schemas?
- Can we create a userspace with a common config file format with well defined schemas?

### Build Instructions

Kasumi is in very early development and it'll be a while before it will resemble anything like a real OS, but if you wanna try it out anyways:
```bash
# Compiles all components, builds the bootable disk image and runs it on qemu
make run

# Delete everything we built :D
make clean
```

Have fun collecting all the dependencies!