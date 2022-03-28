#!/bin/bash
# Bootstrap machine

step=1

ensure_netplan_apply() {
    # First node up assign dhcp IP for eth1, not base on netplan yml
    sleep 5
    sudo netplan apply
}

step() {
    echo "Step $step $1"
    step=$((step+1))
}

resolve_dns() {
    step "===== Create symlink to /run/systemd/resolve/resolv.conf ====="
    sudo rm /etc/resolv.conf
    sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
}

install_openssh() {
    step "===== Installing openssh ====="
    sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y -qq
    sudo apt install openssh-server -y -qq
    sudo systemctl enable ssh
}

setup_root_login() {
    sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
    sudo echo "root:rootroot" | chpasswd
}

main() {
    ensure_netplan_apply
    resolve_dns
    install_openssh
    setup_root_login
}

main