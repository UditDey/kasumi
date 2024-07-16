.DEFAULT_GOAL := image

# Kernel targets
.PHONY: kernel_check
kernel_check:
	@cd kernel; cargo clippy

.PHONY: kernel_test
kernel_test:
	@cd kernel_lib; cargo test

.PHONY: kernel_build
kernel_build:
	@cd kernel; cargo build --release

.PHONY: kernel_clean
kernel_clean:
	@cd kernel; cargo clean


# Top level targets
.PHONY: check
check: kernel_check

.PHONY: test
test: kernel_test

.PHONY: build
build: kernel_build

.PHONY: clean
clean: kernel_clean
	@rm disk.img


disk.img:
	@echo Creating disk.img...
	@dd if=/dev/zero of=disk.img count=8 bs=1M
	@printf "n\n\n\n\n\nt\nb\na\nw\n" | fdisk disk.img
	@sudo losetup -P /dev/loop0 disk.img
	@sudo mkfs.vfat /dev/loop0p1
	@sudo limine bios-install /dev/loop0
	@sudo losetup -d /dev/loop0

.PHONY: image
image: build disk.img
	@echo Copying files to disk.img...
	@sudo losetup -P /dev/loop0 disk.img
	@sudo mount /dev/loop0p1 /mnt
	@sudo rm -rf /mnt/*
	@sudo mkdir /mnt/boot
	@sudo cp /usr/share/limine/limine-bios.sys /mnt/boot
	@sudo cp limine.cfg /mnt/boot
	@sudo cp kernel/target/target/release/kernel /mnt/boot
	@echo Contents of /boot:
	@ls /mnt/boot
	@sudo umount /mnt
	@sudo losetup -d /dev/loop0

.PHONY: run
run: image
	@qemu-system-x86_64 -drive format=raw,file=disk.img -cpu Broadwell,pdpe1gb -m 512 -serial mon:stdio -d int -D qemu.log
