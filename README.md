# Kasumi

Kasumi is an experimental `x86_64` PC operating system design written in Rust

The project's broad design goals are:
- Uses the [limine](https://github.com/limine-bootloader/limine/tree/trunk) bootloader
- Microkernel with L4 inspired capabilities and IPC system
- Userspace designed around a system-wide bus with well defined schemas
- Common config file language with well defined schemas

### Build Instructions

Kasumi is in very early development and it'll be a while before it will resemble anything like a real OS, but if you wanna try it out anyways:
```bash
# Compiles all components, builds the bootable disk image and runs it on qemu
make run

# Delete everything we built :D
make clean
```