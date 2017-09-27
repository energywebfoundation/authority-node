#  Tobalaba Authority Node Setup

### Table of Contents
1. [*Introduction*](#1-introduction)
2. [*Requirements*](#2-requirements)
3. [*Ubuntu Instructions*](#3-ubuntu-instructions)
    - a. [*Create User*](#3a-create-user)
	- b. [*Install Dependencies*](#3b-install-dependencies)
	- c. [*Create Node*](#3c-create-node)
	- d. [*Health Check*](#3d-health-check)
4. [*Debian Instructions*](#4-debian-instructions)
	- a. [*Create User*](#4a-create-user)
	- b. [*Install Dependencies*](#4b-install-dependencies)
	- c. [*Create Node*](#4c-create-node)
	- d. [*Health Check*](#4d-health-check)
5. [*Register*](#5-register)
6. [*Troubleshooting*](#6-troubleshooting)
7. [*Security*](#7-security)

[*APPENDIX - Create Ubuntu 16 instance in AWS EC2*](#appendix-1-create-ubuntu-16-instance-in-aws-ec2)

## 1. Introduction
This tutorial will guide you through the setup process to install a Tobalaba client and become a member in the EWF blockchain. 

A blockchain is a data structure in a [*peer-to-peer network*](https://en.wikipedia.org/wiki/Peer-to-peer) of interconnected computers. The two most important features of this data storage system are that it is byzantine fault tolerant and distributed.

Any computer with access to this network can send transactions that are then stored into *blocks* by specific computers, known as authority nodes.

In [*proof-of-work*](http://nakamotoinstitute.org/bitcoin/) based blockchain networks a computer with the ability to create a block of transactions is called *miner*. Miners compete between each other by using computational power to be the first to find the next valid block for the blockchain.

Since competition between nodes is not desired in Tobalaba,  the network reaches consensus via a *proof-of-authority algorithm* named [Aura](https://github.com/paritytech/parity/wiki/Aura). 

Aura assigning *authorities* that have the right to create new blocks. Authorities still have to reach a consensus on the state of the virtual machine.

The authorities take turns signing a new block. These blocks are inmutable after more then 50% of the authorities signed them twice.

## 2. Requirements
- **Internet access.**
- **Previous use of command line interface and unix commands.**
- **The software is based on Docker and could virtually run in any of the [supported operational systems](https://docs.docker.com/engine/installation/#server)**

To proceed the reader must be logged into a server using an user account with elevated privileges. For instructions on how to setup a compatible [Ubuntu Server on AWS EC2](#appendix-create-ubuntu-16-instance-in-aws-ec2) just follow the link.
> The following instructions and scripts were designed for and tested on:
>
>- [Ubuntu Server 16.04 LTS](#3-ubuntu-instructions)
>- [Debian 9.1.0](#4-debian-instructions)
>
>Please contact [EWF ramp-up-team](http://energyweb.org/contact-us/) for support on installing in other supported OS.

## 3. Ubuntu Instructions

### 3a. Create User

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

### 3b. Install Dependencies

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
Test if it succeeded.
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
If the command output is different from the one above please carefully repeat the former steps or try contacting the technical team to report an issue.

### 3c. Create Node

Run the node deployment script.
```
$ ./ewf-create-authority.sh
Type password: (wallet)
Repeat password: (wallet)
Type your Wallet password one more time:  (wallet)
```

### 3d. Health Check

Finally test the service status, check if active and read the logs to guarantee it has connected peers. Type `q` to quit the log.
```
$ systemctl status ewf-tobalaba-authority@ewf.service
...
Active: active (running)
...
```
To see Parity peers and logs please follow the instructions in chapter 5 on how to see the logs using `docker logs`.

All done! Please proceed to the [register authority](#5-register) node section.

## 4. Debian Instructions

### 4a.  Create User

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

### 4b. Install Dependencies

Install dependencies.
```
$ ./debian-dependencies.sh
```
After installation the user must login again to refresh access rights.
```
$ su ewf
Password: (ewf)
```
Test if it succeeded.
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
If the command output is different from the one above please carefully repeat the former steps or try contacting the technical team to report an issue.
### 4c. Create Node

Run the node deployment script.
```
$ ./ewf-create-authority.sh
Type password: (wallet)
Repeat password: (wallet)
Type your Wallet password one more time:  (wallet)
```
### 4d. Health Check

Finally test the service status, check if active and read the logs to guarantee it has connected peers. Type `q` to quit the log.
```
$ systemctl status ewf-tobalaba-authority@ewf.service
...
Active: active (running)
...
```
To see Parity peers and logs please follow the instructions in chapter 5 on how to see the logs using `docker logs`.
All done! Please proceed to the register authority node section.

## 5. Register

After the installation please send the public key address of the installed wallet and enode address to members of the EWF ramp-up-team to register the node as an authority in the network.

The `enode` address is printed by parity in the logs on the first time it starts. To access it run `docker ps`, note down the `CONTAINER ID` of the parity process and then grep the address. Bellow is an example of the outputs.
```
$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  ...                                                                              NAMES
81c0dc0d1197        parity/parity:nightly   "/parity/parity --..."   ...

$ docker logs 8a82f6d1b3c0 2>&1 | grep enode
enode://80bdd812ff39cd4946ba84eabfced743a0e0888cdab7fab2344b57a630915fb3e50e258fbfa2c66d5a390c4ce2dde144403e814469792e0be137e79b7d95e9ef@54.166.247.12:30303
```

The key file contains the public address, just copy and execute the command bellow. What follows is an example of the output.
```
$ sudo cat ~/tobalaba/authority_node/chain/keys/Tobalaba/UTC-* | python -m json.tool | grep address`
"address": "58e3ed96f074106c41275463883f5f0718b37f2c",
```

## 6. Troubleshooting

- Dependencies installation failed.
Log in again with the `ewf` user.
Look for errors in the installation script, if found try to solve them. The objective of this step is to have the latest docker-ce installed from the official docker repository and to register the user in the `docker` group. If these requirements are manually or previously fulfilled, the node creation step will most likely succeed.

- Node creation failed or the service status is stopped.
Log in again with the `ewf` user and in the `/home/ewf/tobalaba/ewf-tobalaba` folder run `./ewf-create-authority.sh` again. This will clean all data from a previous installation and install a new instance.
> This procedure will destroy the previously created wallet. Proceed only if the wallet is empty and was never used. 
> Backup the former wallet by making a safety copy of the keys folder located at `/home/ewf/tobalaba/authority_node/chain/keys`.

- Parity was running but stopped.
This can occur due to a failure in the updating system. Contact EFW ramp-up-team.

- Parity is running but has only 1 or 0 peers.
Check that your firewall rules are allowing TCP  and UDP inbound and outbound on 30303.
Check that no chain fork has happened by asking EFW ramp-up-team.

## 7. Security

Peer to peer networks rely on providing services that other peers in the network can discover, by probing and automatically connecting to them.

As with all computers directly exposed to the internet, these services suffer from a myriad of automated and specifically engineered attacks with goals that vary from the denial of service, to fully fledged takeovers of whole infrastructures.

Recent threats like the [*heartbleed bug*](http://heartbleed.com/) exposed several services and protocols that were previously thought of trusted and secure, but were in fact secretly being exploited.

Mitigating the impacts of a possibly compromised computer is mandatory in this scenario. Regular security audits with hardening and penetration tests is highly advised.

To create an isolated environment we suggest a network topology with one-way-only path to access the authority node, in a way that if the authority node is taken the attacker can't easily gain access to other computers in the company infrastructure.

![Network topology diagram](https://github.com/slockit/ewf-tobalaba/blob/raspbian+docs/media/vpn-sec.png)

Above is a diagram of the topology tested in AWS to provide access to the authority node server via a VPN and a pre defined sequence of ssh tunnels.

The **Choke Point** guarantees that all traffic to the **Authority Node** passes through it like a security checkpoint. It has two network connections **VPC1** and **VPC2**. VPC1 has only it and the Authority Node connected. VPC2 is connected to company's **VPN**.

The firewall in the Authority Node only allows it to receive `ssh` connections from the Choke Point. The one in the Choke Point only receives `ssh` connections from computers inside the VPN.

This diagram and solution is just an example and additional security must apply. 

It is a common culture in companies that adopt proprietary and closed protocols to believe they are more secure than open source solutions. The National Institute of Standards and Technology (NIST) in the United States [specifically recommends](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-123.pdf) against this practice: "System security should not depend on the secrecy of the implementation or its components". 

Any [security by obscurity](https://en.wikipedia.org/wiki/Security_through_obscurity) method should be avoided.

## APPENDIX - Create Ubuntu 16 instance in AWS EC2

This appendix will help the reader to successfully create a virtual server in [Amazon Web Services Elastic Compute Cloud](https://aws.amazon.com/ec2) service.

1. In AWS website choose **EC2** in the **Services** drop-down menu
2. In EC2 Dashboard click on the **Lauch Instance** button.
3. You will be taken at Step 1 to choose a AMI. Choose **Ubuntu 16 LTS (HVM), SSD Volume Type**
4. Step2 makes you choose the instance type. This sets the computing power of your machine. For testing choose **t2-micro** using the *aws free-tier*. For production environment choose *m3.large* or higher. After choosing click the **Review and Launch** button.
5. Click **Edit security groups** to add the ports needed open for accepting connections from other nodes of the network.
	1. Change the Source of the SSH port to your IP if you want to add an extra layer of security. If your ip is dynamic remember to change it to the actual one every time you face access issues. For ubiquitous access leave 0.0.0.0/0.
	2. Add a new **Custom TCP** type, port **30303** and source **0.0.0.0/0**.
	3. Add a new **Custom UDP** type, port **30303** and source **0.0.0.0/0**. 
	4. Add a new **SSH** type, port **22** and source **my ip**.
	5. Click on the **Launch** button.
6. Now wait until the Instance State of the instance is running and try connecting.  
7. Click on the **Connect** button with the instance selected in the list.
8. Follow the instructions to create and download a new key pair.
9. Copy this key to a secure location and have it backed up.
10. In case you are using a linux machine as host you can run the following command to move it to the ssh keys default folder replacing *KEY_NAME* with the name just created in the previous step. 
`mv ~/Downloads/KEY_NAME.pem ~./ssh`

11. Now create a ssh tunnel to log in to the server by running the following command replacing *KEY_NAME* with the name of the key and the *INSTANCE_IP* from the **IPV4 Public Ip** tab in the AWS EC2 Dashboard website.
`ssh -i ~/.ssh/KEY_NAME.pem ubuntu@INSTANCE_IP`

12. After running the previous command the user is prompted by a message asking to ensure the fingerprint of the connected machine. Type **yes** and hit enter to continue.
``` sh
The authenticity of host 'INSTANCE_IP (INSTANCE_IP)' can't be established.
ECDSA key fingerprint is SHA256:cq5KC2MlIYrNdGJddb+gVipLS5wtbVfj9v2culoZN7k.
Are you sure you want to continue connecting (yes/no)?
```
13.  The user is then dropped to the shell.
`ubuntu@INSTANCE_IP $ _`

Congratulations you successfully created an AWS EC2 Ubuntu instance ready for running EWF Authority Node. Please read the [security chapter](#7-security) for basic security measures.

To start installing Tobalaba client please follow the steps in [chapter 2](#2-requirements).

