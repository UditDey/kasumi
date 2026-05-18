.DEFAULT_GOAL: image

.PHONY: run
run: image
	@qemu-system-x86_64 -drive format=raw,file=disk.img -cpu Broadwell,pdpe1gb -m 1G -smp 1 -monitor stdio 

.PHONY: image
image: build
	@dd if=/dev/zero of=disk.img bs=1M count=64
	@printf 'label: mbr\n1M,,0x0c,*' | sfdisk disk.img
	@mformat -i disk.img@@1M -F ::
	@mmd -i disk.img@@1M ::/boot
	@mcopy -i disk.img@@1M kernel/target/os_target/release/kernel ::/boot
	@mcopy -i disk.img@@1M pid0.bin ::/boot
	@mcopy -i disk.img@@1M limine.conf ::/boot
	@mcopy -i disk.img@@1M /usr/local/share/limine/limine-bios.sys ::/boot
	@mdir -i disk.img@@1M -/ ::
	@limine bios-install disk.img

.PHONY: build
build: kernel_build pid0.bin

.PHONY: clean
clean: kernel_clean

.PHONY: kernel_build
kernel_build:
	@cd kernel && cargo build --release

.PHONY: kernel_clean
kernel_clean:
	@cd kernel && cargo clean

.PHONY: kernel_check
kernel_check:
	@cd kernel && cargo check

pid0.bin: pid0.asm
	nasm -f bin $< -o $@
