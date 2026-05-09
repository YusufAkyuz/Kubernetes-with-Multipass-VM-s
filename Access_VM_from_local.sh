# Sanal makinelere yerel makineden SSH üzerinden erişim sağlamak için izlenecek adımları içeren rehber.
ssh-keygen -t ed25519 -C "local-vm-access"

----------------------------------------------------

sudo apt update
sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh

----------------------------------------------------

mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
# kopyalanan key'i buraya yapıştırırız

----------------------------------------------------

chmod 600 ~/.ssh/authorized_keys

----------------------------------------------------

ssh user_name@[IP_ADDRESS] ile erişimi sağlarız.