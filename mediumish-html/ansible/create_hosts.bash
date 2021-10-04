#!/bin/bash
touch hosts.txt
publicIP=$(curl icanhazip.com)

echo "[WebServers]
WebServer  ansible_host=$publicIP  ansible_user=ec2_user  ansible_ssh_private_key_file=/var/lib/jenkins/.ssh/id_rsa.pub" >> hosts.txt
