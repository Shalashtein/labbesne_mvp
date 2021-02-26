# Turn it (off) on
# sudo swapoff -a
sudo swapon -s

# Create a swap file
# 512k --> Swapfile of 512 MB
sudo dd if=/dev/zero of=/swapfile bs=1024 count=512k

# Use the swap file
sudo mkswap /swapfile
sudo swapon /swapfile

# make sure the swap is present after reboot:
sudo echo " /swapfile       none    swap    sw      0       0 " >> /etc/fstab

# Set the swappiness (performance - aware)
echo 10 | sudo tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf

# Change the permission to non-world-readable
sudo chown root:root /swapfile
sudo chmod 0600 /swapfile
