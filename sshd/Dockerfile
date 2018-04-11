FROM centos:7
MAINTAINER qinzhiming

RUN yum install -y openssh-server
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config  
RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''

RUN mkdir /var/run/sshd 
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

