```
sudo dnf install -y epel-release
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
sudo dnf install -y nvidia-driver cuda
reboot
```
