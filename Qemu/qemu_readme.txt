

qemu-img create -f qcow2 test.qcow 30G

lsusb
# ID Flash card
qemu-system-x86_64
-enable-kvm
-soundhw ac97
-cpu host
-smp cores=1
-m 1024
-machine q35
-device intel-iommu
-vga virtio
-device e1000,netdev=wan
-netdev user,id=wan
-cdrom my-iso.iso
-hda /dev/sdX
-hda ubuntu.qcow
-usb --device usb-host,vendorid=0x125f,productid=0xdb8a
-boot d
-bios /usr/share/edk2-ovmf/x64/OVMF_CODE.fd
-device e1000,netdev=net0
-netdev user,id=net0,hostfwd=tcp::22-:22,hostfwd=tcp::80-:80,hostfwd=tcp::443-:443

-L .
-drive file=/usr/share/ovmf/x64/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on
