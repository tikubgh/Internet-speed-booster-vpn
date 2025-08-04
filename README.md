Setup any debian vps server,
Then setup firwalls, 
Then final code run in vps terminal,
Final the ss client code output using Outline
use your own vps server ip in ss key.

run as root:
sudo su

Firewall:
sudo apt update && sudo apt install ufw -y && sudo ufw allow from any && sudo ufw reload && sudo ufw status verbose && echo "y" | sudo ufw enable

Auto setup Script:



