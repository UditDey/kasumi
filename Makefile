.PHONY: kernel build image run clean

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
	@sudo cp kernel/target/x86_64-bare-metal/release/kernel /mnt/boot
	@echo Contents of /boot:
	@ls /mnt/boot
	@sudo umount /mnt
	@sudo losetup -d /dev/loop0

run: image
	@qemu-system-x86_64 -drive format=raw,file=disk.img -cpu Broadwell,pdpe1gb -serial mon:stdio -d int -D qemu.log

kernel:
	@cd kernel; cargo build --release

build: kernel

clean:
	@cd kernel; cargo clean