One liner installation script in vps server using shadowsocks & outline , optimised for speed
installation:

1. sudo su
2. sudo apt update && sudo apt install ufw -y && sudo ufw allow from any && sudo ufw reload && sudo ufw status verbose && echo "y" | sudo ufw enable
3. wget https://raw.githubusercontent.com/tikubgh/Internet-speed-booster-vpn/refs/heads/main/script.sh
4. chmod +x script.sh && ./script.sh
   
Installation Complete: Downdload vpn client https://outline-vpn.com/download.php?os=c_windows

Insert this key to Outline client= ss://aes-256-gcm:fastpass123@vps-ip-here:443
SS client code will output after complete setup then use your own vps server ip in ss key then connect vpn client using OUTLINE
Enjoy...
