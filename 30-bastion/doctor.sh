#!/bin/bash

dnf install ansible -y

cd /tmp

git clone https://github.com/VidyaSagar-P/doctorAppointment-ansible.git
cd doctorAppointment-ansible
ansible-playbook -i inventory.ini mysql.yaml
ansible-playbook -i inventory.ini backend.yaml
ansible-playbook -i inventory.ini frontend.yaml