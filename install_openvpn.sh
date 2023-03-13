#!/bin/bash

# Define function for OpenVPN installation
install_openvpn() {
    # Install OpenVPN package
    sudo apt update
    sudo apt install -y openvpn

    # Configure OpenVPN
    sudo cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/
    sudo gzip -d /etc/openvpn/server.conf.gz
    sudo sed -i 's/;tls-auth ta.key 0/tls-auth ta.key 0/g' /etc/openvpn/server.conf
    sudo sed -i 's/;cipher AES-128-CBC/cipher AES-128-CBC\nauth SHA256/g' /etc/openvpn/server.conf
    sudo mkdir /etc/openvpn/keys
    sudo chmod 700 /etc/openvpn/keys
    sudo cp /usr/share/doc/openvpn/examples/easy-rsa/2.0/* /etc/openvpn/easy-rsa/
    sudo chown -R $USER /etc/openvpn/easy-rsa/
    cd /etc/openvpn/easy-rsa/
    source ./vars
    ./clean-all
    ./build-ca
    ./build-key-server server
    openvpn --genkey --secret /etc/openvpn/keys/ta.key
}

# Define function for certificate generation
generate_certificate() {
    # Generate client certificate and key
    cd /etc/openvpn/easy-rsa/
    source ./vars
    ./build-key client
    sudo cp /etc/openvpn/keys/ca.crt /etc/openvpn/keys/client.crt /etc/openvpn/keys/client.key /etc/openvpn/
    sudo chmod 644 /etc/openvpn/client.key
    # Generate OpenVPN configuration file
    sudo cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/client.ovpn
    sudo sed -i 's/remote my-server-1 1194/remote <your server IP> 1194/g' /etc/openvpn/client.ovpn
    sudo sed -i '/ca/ca /etc/openvpn/ca.crt' /etc/openvpn/client.ovpn
    sudo sed -i '/cert/cert /etc/openvpn/client.crt' /etc/openvpn/client.ovpn
    sudo sed -i '/key/key /etc/openvpn/client.key' /etc/openvpn/client.ovpn
}

# Define function for displaying menu
show_menu() {
    echo "========================================="
    echo "            OPENVPN INSTALLER             "
    echo "========================================="
    echo "1. Install OpenVPN"
    echo "2. Generate Certificate"
    echo "3. Exit"
    echo "========================================="
    read -p "Enter your choice [1-3]: " choice
    case $choice in
        1) install_openvpn ;;
        2) generate_certificate ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Please try again." ; echo ; show_menu ;;
    esac
}

# Call function to display menu
show_menu
