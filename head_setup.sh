# installing nfs
sudo yum install nfs-utils

# making software directory
sudo mkdir /software

# setting permissions
sudo chmod -R 777 /software

# setting up nfs
sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock
sudo systemctl enable nfs-idmap
sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock
sudo systemctl start nfs-idmap

# setup export directory
sudo echo "/software *(rw,sync,no_root_squash,no_all_squash)" > etc/exports
sudo systemctl restart nfs-server

# let nfs service override centos7 firewall
sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --reload

# set client up, setup mount point from storage, to head
sudo sleep 180
sudo mkdir -p /scratch
sudo mount -t nfs 192.168.1.3:/scratch /scratch
# setup automount
sudo echo "192.168.1.3:/scratch /scratch nfs defaults 0 0" >> /etc/fstab

#install mpi
sudo chmod 777 /local/repository/install_mpi.sh
sudo /local/repository/install_mpi.sh

#install MariaDB

#install Munge
#sudo yum install epel-release
#sudo yum install munge munge-libs munge-devel -y
#sudo yum install rng-tools -y -NO
#rngd -r /dev/urandom          -NO
#/usr/sbin/create-munge-key -r
#sudo su -c "dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key"
