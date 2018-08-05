adduser --quiet --disabled-password --shell /bin/bash --home /home/ansible --gecos "User" ansible
echo "ansible:ansible" | chpasswd
adduser ansible sudo