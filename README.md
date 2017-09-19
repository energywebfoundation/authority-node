# EWF Tobalaba Network Node Installation Script

### Description
Installation script for bash compatible shells.

Tested on:

 - Ubuntu Server 16.04 LTS
 - Debian 9.1.0

### Tobalaba
Energy Web Foundation's Tobalaba network is a PoA blockchain created for testing decentralised applications ( dapps ) and help building the future of the energy grids.

### Ubuntu
First create `ewf` user and summon it.
```
# sudo adduser ewf
[sudo] password: (sudo)
Enter new UNIX password: (ewf)

# sudo adduser ewf sudo

# su ewf
Password: (ewf)
```
Create deployment folder and clone the install script repo from github.
```
$ cd

$ mkdir tobalaba

$ cd tobalaba

$ git clone https://github.com/slockit/ewf-tobalaba.git

$ cd ewf-tobalaba
```
Install dependencies.
```
$ ./debian-dependencies.sh
[sudo] password for ewf: (ewf)
```
After installation the user must login again to refresh access rights.
```
$ su ewf
Password: (ewf)
```
Run the node deployment script.
```
$ ./ewf-create-authority.sh
Type password: (wallet)
Repeat password: (wallet)
Type your Wallet password one more time:  (wallet)
```
Finally test the service status, check if active and read the logs to guarantee it has connected peers. Type `q` to quit the log.
```
$ systemctl status ewf-tobalaba-authority@ewf.service
...
Active: active (running)
...
```
Please read the register authority node section.

### Debian
First create `ewf` user and summon it.
```
$ su
Password: (root)

# sudo apt install git -y

# adduser ewf
Enter new UNIX password:

# adduser ewf sudo

# su ewf
```
Create deployment folder and clone the install script repo from github.
```
$ cd

$ mkdir tobalaba

$ cd tobalaba

$ git clone https://github.com/slockit/ewf-tobalaba.git

$ cd ewf-tobalaba
```
Install dependencies.
```
$ ./debian-dependencies.sh
```
After installation the user must login again to refresh access rights.
```
$ su ewf
Password: (ewf)
```
Create deployment folder and clone the install script repo from github.
```
$ ./ewf-create-authority.sh
Type password: (wallet)
Repeat password: (wallet)
Type your Wallet password one more time:  (wallet)
```
Finally test the service status, check if active and read the logs to guarantee it has connected peers. Type `q` to quit the log.
```
$ systemctl status ewf-tobalaba-authority@ewf.service
...
Active: active (running)
...
```
Please read the register authority node section.

### Register Authority Node
After the installation please send the public key address of the installed wallet and enode address to EWF members to register the node as an authority in the network.