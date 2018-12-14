sudo /usr/sbin/create-munge-key -f

sudo chown -R munge:munge /etc/munge/munge.key

sudo chmod 400 /etc/munge/munge.key

sudo cp /etc/munge/munge.key /scratch/

sudo chown -R munge: /etc/munge/ /var/log/munge/
sudo chmod 0700 /etc/munge/ /var/log/munge/

sudo systemctl enable munge
sudo systemctl start munge

cd /scratch/

wget https://download.schedmd.com/slurm/slurm-18.08.3.tar.bz2

sudo yum install perl-ExtUtils-MakeMaker -y
sudo rpmbuild -ta /scratch/slurm-18.08.3.tar.bz2

mkdir /scratch/slurm-rpms
sudo cp /root/rpmbuild/RPMS/x86_64/* /scratch/slurm-rpms/

sudo touch /scratch/rpm.done

sudo yum --nogpgcheck localinstall /scratch/slurm-rpms/* -y
