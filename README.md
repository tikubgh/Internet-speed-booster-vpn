After connected to this vpn your internet speed will increase 5x by using deep network optimisation host via any vps server one liner installation script

Setup any debian vps server,
Then setup firewalls, 
Then final code run in vps terminal,
Then ss client code will output after complete setup
Then use your own vps server ip in ss key 
Then connect vpn client using OUTLINE.

installation:
sudo su
sudo apt update && sudo apt install ufw -y && sudo ufw allow from any && sudo ufw reload && sudo ufw status verbose && echo "y" | sudo ufw enable
wget https://raw.githubusercontent.com/tikubgh/Internet-speed-booster-vpn/refs/heads/main/script.sh
chmod +x script.sh && ./script.sh

Installation Complete:
Downdload vpn client
https://outline-vpn.com/download.php?os=c_windows

Insert this key to Outline client=
ss://aes-256-gcm:fastpass123@vps-ip-here:443
