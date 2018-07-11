/bin/mkdir /root/.ssh ;\
	/usr/bin/wget --no-check-certificate https://mail.martenvijn.nl/svn/sshkeys/mvn_tp.key -O /root/.ssh/authorized_keys 
/bin/chmod 0700 /root/.ssh 
/bin/chmod 0600 /root/.ssh/authorized_keys 
/bin/mkdir -p /home/bert/.ssh 
/usr/bin/wget --no-check-certificate https://mail.martenvijn.nl/svn/sshkeys/mvn_tp.key -O /home/bert/.ssh/authorized_keys
/bin/chmod 0700 /home/bert/.ssh 
/bin/chmod 0600 /home/bert/.ssh/authorized_keys 
/bin/chown -R bert:bert /home/bert/.ssh 
/bin/echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config 
/bin/echo 'bert ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

apt update

apt -y install vim python-apt python-pip git

pip install ansible
