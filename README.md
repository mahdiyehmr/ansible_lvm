# Vagrant
If you want to test this ansible in your local environment you can just download vagrant and after cloning the repository and going to the working directory where the Vagrantfile is, follow these steps to prepare the required test environment.
```
VAGRANT_EXPERIMENTAL=disks vagrant up
```
You can use the following command to find the state of your vagrant host.
```
vagrant status
```
Now your host is up and running you can use the following command to connect to the ssh console.
```
vagrant ssh
```
You can change the number and size of the disks in the Vagrantfile if you like. For checking the available disks run the following command.
```
lsblk
```
## Deploy
In order to apply LVM partitioning, Follow these steps:

1. Install virtualenv via Pip:
```
pip install virtualenv
```
2. Create a new virtual environment:
```
virtualenv .env
```
3. Switch to the environment:
```
source .env/bin/activate
```
4. Install ansible and netaddr packages:
```
pip3 install -r requirements.txt
```
5. Install ansible collections which are required by the playbooks:
```
ansible-galaxy collection install -r requirements.yml
```
6. Update your inventory in **inventory/vagrant_hosts** or create a new one.
7. Update your group vars in **inventory/vagrant_hosts/group_vars**
8. Check the correctness of your inventory groups and hosts:
```
ansible -b -i inventory/vagrant_hosts/hosts.yml -m ping all
```
9. Apply your LVM partitioning:
```
ansible-playbook -b -i inventory/vagrant_hosts/hosts.yml lvm.yml
```
10. After applying the partitioning, To verify the correctness of your partitioning run this command:
```
ansible -b -i inventory/vagrant_hosts/hosts.yml -m shell -a "vgs" all
ansible -b -i inventory/vagrant_hosts/hosts.yml -m shell -a "lvs" all
ansible -b -i inventory/vagrant_hosts/hosts.yml -m shell -a "df -h" all
```
## Resize
If after running the ansible you want to increase the size of one or multiple of them you can just change the size in all.yml file and then run the playbook again.
You can write **+the size you want to add** or write the total amount the space infront of the size in yaml file.
```
ansible-playbook -b -i inventory/vagrant_hosts/hosts.yml lvm.yml
```
## Remove
Make sure you have a backup from your data because all the data in your lvs would be lost after this step.
Note that this playbook won't delete your vgs, it just deletes the lvs and their mount points.
For removing the partitions:
```
ansible-playbook -b -i inventory/vagrant_hosts/hosts.yml lvm-remove.yml
```
## Notes
1. Instead of steps 1 to 5 you can run [install-env](https://github.com) script and switch to the environment.
```
source .env/bin/activate
```
