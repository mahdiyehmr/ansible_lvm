#!/bin/bash
DEBIAN_FRONTEND="noninteractive" sudo apt -yq install python3-pip
sudo pip3 install virtualenv
VENV_DIR=$(pwd)/.env
virtualenv "$VENV_DIR"
source .env/bin/activate
pip3 install -r requirements.txt
ansible-galaxy collection install community.general ansible.posix
echo "After running this script, Please execute 'source ./.env/bin/activate'"