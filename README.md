# Install Openvpn Ubuntu Server 22.04
Bash Script install openvpn ubuntu server 

# How to use script
To use this script, save the bash script on the Ubuntu 22.04 server and run it using the bash script_name.sh command or by giving executable permissions to the script and running it using the ./script_name.sh command. Then, follow the menus displayed on the screen to install OpenVPN or generate certificates and OpenVPN configuration files with the .ovpn extension. Make sure to replace <your server IP> in the OpenVPN configuration with the server's IP address being used.

# Explanation of the above script
1.  The install_openvpn() function contains commands to install OpenVPN on Ubuntu Server 22.04.
2.  The generate_certificate() function contains commands to generate a certificate for the OpenVPN client and produce an OpenVPN configuration file with the .ovpn 
    extension in the /etc/openvpn/ directory.
3.  The show_menu() function displays the main menu and prompts the user to input their desired menu choice.
4.  The command read -p "Enter your choice [1-3]: " choice is used to prompt the user for input.
5.  The case $choice in ... esac command is used to execute the appropriate function based on the user's input.
6.  Finally, the show_menu() function is called to display the main menu.
