#! /bin/bash
sudo rm -rf /etc/upocwin;
sudo rm -rf /opt/upocwin;
sudo rm -rf /var/log/upocwin;
sudo mkdir /etc/upocwin;
ssh-keygen -t rsa -b 4096 -N "" -C "contact@upocwin.com" -f ./static/upocwin
sudo cp ./static/configs.json /etc/upocwin/;
sudo mkdir /opt/upocwin;
sudo mkdir /opt/upocwin/.key;
sudo cp -r ./bin /opt/upocwin;
sudo cp ./static/upocwin /opt/upocwin/.key;
sudo chown $USER:$USER /opt/upocwin/.key/upocwin;
sudo touch /var/log/upocwin;
sudo chown $USER:$USER /var/log/upocwin;
sudo chmod 0755 /var/log/upocwin;