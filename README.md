# EWF Tobalaba Network Node Installation Script

### Description
Installation script for bash compatible shells.

Tested on:

 - Ubuntu Server 16.04 LTS
 - Debian 9.1.0

### Tobalaba
Energy Web Foundation's Tobalaba network is a PoA blockchain created for testing decentralised applications ( dapps ) and help building the future of the energy grids.

### Ubuntu
```
# adduser ewf
Enter new UNIX password:

# adduser ewf sudo

# su ewf

$ cd

$ mkdir tobalaba

$ cd tobalaba

$ git clone https://github.com/slockit/ewf-tobalaba.git

$ cd ewf-tobalaba

$ ./debian-dependencies.sh

$ su ewf
Password: (ewf)

$ ./ewf-create-authority.sh
Type password: (wallet)
Repeat password: (wallet)
Type your Wallet password one more time:  (wallet)

$ systemctl status ewf-tobalaba-authority@ewf.service
```
### Debian
```
$ su
Password: (root)

# sudo apt install git -y

# adduser ewf
Enter new UNIX password:

# adduser ewf sudo

# su ewf

$ cd

$ mkdir tobalaba

$ cd tobalaba

$ git clone https://github.com/slockit/ewf-tobalaba.git

$ cd ewf-tobalaba

$ ./debian-dependencies.sh

$ su ewf
Password: (ewf)

$ ./ewf-create-authority.sh
Type password: (wallet)
Repeat password: (wallet)
Type your Wallet password one more time:  (wallet)

$ systemctl status ewf-tobalaba-authority@ewf.service
```