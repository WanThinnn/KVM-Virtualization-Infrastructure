#!/bin/bash

# Function to create the seed ISO
create_seed_iso() {
    echo "Creating a seed ISO file with userdata and metadata..."

    # Create a directory for userdata and metadata
    mkdir -p ~/Documents/NT132/kvm_userdata

    # Prompt for personal details
    read -p "Enter your full name: " FULL_NAME
    read -p "Enter Linux hostname (default: ubuntu-vm): " LINUX_HOSTNAME
    LINUX_HOSTNAME=${LINUX_HOSTNAME:-ubuntu-vm}
    read -p "Enter username for your VM (default: user): " VM_USERNAME
    VM_USERNAME=${VM_USERNAME:-user}
    # Prompt for password input and validate twice
    while true; do
        echo "Enter password for your VM: "
        read -s PASSWORD1
        echo "Re-enter password for your VM: "
        read -s PASSWORD2

        if [ "$PASSWORD1" == "$PASSWORD2" ]; then
            echo "Password confirmed."
         
            break
        else
            echo "Passwords do not match. Please try again."
        fi
    done


    # Create the user-data file
    cat <<EOF > ~/Documents/NT132/kvm_userdata/user-data
#cloud-config
autoinstall:
  version: 1
  identity:
    hostname: $LINUX_HOSTNAME
    username: $VM_USERNAME
    password: $(openssl passwd -6 "$PASSWORD2")
    realname: $FULL_NAME
  locale: en_US
  ssh:
    install-server: true
    allow-pw: true
EOF

    # Create the meta-data file
    cat <<EOF > ~/Documents/NT132/kvm_userdata/meta-data
instance-id: $LINUX_HOSTNAME
local-hostname: $LINUX_HOSTNAME
EOF

    # Generate the ISO file containing userdata and metadata
    genisoimage -output ~/Documents/NT132/kvm_userdata/seed.iso \
      -volid cidata -joliet -rock \
      ~/Documents/NT132/kvm_userdata/user-data ~/Documents/NT132/kvm_userdata/meta-data

    echo "ISO file with userdata and metadata has been created at ~/Documents/NT132/kvm_userdata/seed.iso."
}

# Function to create and start a virtual machine
create_vm() {
    # Prompt user for VM details
    read -p "Enter VM name (default: ubuntu-server-vm): " VM_NAME
    VM_NAME=${VM_NAME:-ubuntu-server-vm}

    read -p "Enter ISO file path: " ISO_PATH

    # Default seed ISO path
    SEED_ISO=${SEED_ISO:-$HOME/Documents/NT132/kvm_userdata/seed.iso}

    read -p "Enter disk size (default: 25G): " DISK_SIZE
    DISK_SIZE=${DISK_SIZE:-25G}

    read -p "Enter number of CPUs (default: 4): " CPU
    CPU=${CPU:-4}

    read -p "Enter RAM size in MB (default: 4096): " RAM
    RAM=${RAM:-4096}

    read -p "Enter network type (default: NAT): " NETWORK
    NETWORK=${NETWORK:-default}

    # Disk path is set automatically based on VM name
    DISK_PATH="/var/lib/libvirt/images/$VM_NAME.qcow2"

    read -p "Enter OS variant for VM: " osvariant
    OS_VARIANT=$osvariant

    # Create the virtual disk
    echo "Creating virtual disk at $DISK_PATH with size $DISK_SIZE..."
    sudo qemu-img create -f qcow2 $DISK_PATH $DISK_SIZE

    # Start the VM installation
    echo "Starting VM installation..."
    sudo virt-install \
      --name "$VM_NAME" \
      --vcpus "$CPU" \
      --memory "$RAM" \
      --disk path="$DISK_PATH",format=qcow2 \
      --cdrom "$ISO_PATH" \
      --disk path="$SEED_ISO",device=cdrom \
      --os-variant "$OS_VARIANT" \
      --network network="$NETWORK" \
      --boot cdrom,hd \
      --noautoconsole

    # Display message about GUI
    sudo virt-manager --connect qemu:///system --show-domain-console $VM_NAME
}

# Main script execution
echo "Starting script to create a VM..."
create_seed_iso
create_vm

