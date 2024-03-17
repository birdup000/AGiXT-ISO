#!/bin/bash

# Set variables
VM_NAME="MyVM"
VM_OS="Ubuntu_64"
VM_RAM="2048"
VM_DISK_SIZE="20000"
ISO_URL="http://example.com/ubuntu.iso"
EXPORT_FORMAT="ISO"
PROGRAM_TO_INSTALL="apache2"

# Create the virtual machine
VBoxManage createvm --name $VM_NAME --ostype $VM_OS --register

# Set VM settings
VBoxManage modifyvm $VM_NAME --memory $VM_RAM --vram 128
VBoxManage createhd --filename "$VM_NAME.vdi" --size $VM_DISK_SIZE
VBoxManage storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VM_NAME.vdi"
VBoxManage storagectl $VM_NAME --name "IDE Controller" --add ide
VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium emptydrive

# Download the ISO and attach it to the VM
wget -O ubuntu.iso $ISO_URL
VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium ubuntu.iso

# Enable unattended installation
VBoxManage unattended install $VM_NAME --iso=ubuntu.iso --user=username --password=password --full-user-name="Full Name" --install-additions --time-zone=UTC

# Start the virtual machine
VBoxManage startvm $VM_NAME --type headless

# Wait for the VM to boot and install the program
sleep 60
VBoxManage guestcontrol $VM_NAME run --username username --password password --exe "/usr/bin/sudo" -- sudo apt-get update
VBoxManage guestcontrol $VM_NAME run --username username --password password --exe "/usr/bin/sudo" -- sudo apt-get install -y $PROGRAM_TO_INSTALL

# Shutdown the VM
VBoxManage controlvm $VM_NAME acpipowerbutton

# Wait for the VM to shutdown
while VBoxManage showvminfo $VM_NAME | grep -q "running"; do
    sleep 5
done

# Export the VHD to an ISO
VBoxManage clonehd "$VM_NAME.vdi" "$VM_NAME.vhd" --format VHD
VBoxManage convertfromraw "$VM_NAME.vhd" "$VM_NAME.$EXPORT_FORMAT" --format $EXPORT_FORMAT

echo "Virtual machine creation, program installation, and ISO export completed."
