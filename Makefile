.PHONY: seL4 kernel build image run clean

SEL4_INSTALL_LOCATION = $(shell pwd)/seL4/build/install

image: build
	@echo Creating disk.img...
	@dd if=/dev/zero of=disk.img count=8 bs=1M
	@printf "n\n\n\n\n\nt\nb\na\nw\n" | fdisk disk.img
	@sudo losetup -P /dev/loop0 disk.img
	@sudo mkfs.vfat /dev/loop0p1
	@sudo limine bios-install /dev/loop0

	@echo Copying files to disk.img...
	@sudo mount /dev/loop0p1 /mnt
	@sudo mkdir /mnt/boot
	@sudo cp /usr/share/limine/limine-bios.sys /mnt/boot
	@sudo cp limine.cfg /mnt/boot
	@sudo cp seL4/build/kernel.elf /mnt/boot/seL4.elf
	@sudo cp kernel/target/x86_64-sel4-minimal/release/kernel.elf /mnt/boot
	@echo Contents of /boot:
	@ls /mnt/boot
	@sudo umount /mnt
	@sudo losetup -d /dev/loop0

run: image
	@qemu-system-x86_64 -drive format=raw,file=disk.img -cpu qemu64,pdpe1gb -serial stdio

seL4:
	@cd seL4; sh build.sh

kernel:
	@echo Building kernel...
	@cd kernel; SEL4_PREFIX=$(SEL4_INSTALL_LOCATION) cargo build --release # Prefix needed by rust-seL4 crate's build.rs

build: seL4 kernel

clean:
	@rm -r seL4/build || true
	@cd kernel; cargo clean
	@rm disk.img || true