sudo rm -f setup/boot/initramfs.cpio.gz qb.iso
# sudo apt install build-essential grub-pc qemu-kvm xorriso mtools -y

if [ -d "rootfs" ]; then
    cd rootfs/ && mkdir -p {home,lib,lib64,proc,root,run,sys,tmp,var/cache,var/log,var/run,var/tmp,usr/bin,usr/sbin}
    find . | cpio -o -H newc | gzip > ../setup/boot/initramfs.cpio.gz && cd ..
else
    echo "rootfs file not found !!"
fi
grub-mkrescue -o qb.iso ./setup
# qemu-system-x86_64 -cdrom qb.iso
# qemu-system-x86_64 -cdrom qb.iso -vga std -display gtk,gl=on
qemu-system-x86_64 -cdrom qb.iso -vga std -display sdl,gl=on
# qemu-system-x86_64 -cdrom qb.iso -vga virtio -display gtk,gl=on -device virtio-vga,xres=1024,yres=768
# qemu-system-x86_64 -cdrom qb.iso -vga qxl -spice port=5930,disable-ticketing -device virtio-serial-pci -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent
# qemu-system-x86_64 -cdrom qb.iso -vga qxl -spice port=5930,disable-ticketing=on -device virtio-serial-pci -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent
