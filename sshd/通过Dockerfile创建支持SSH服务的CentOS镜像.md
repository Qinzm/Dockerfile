###通过Dockerfile创建支持SSH服务的CentOS镜像 

1、在/root目录下新建sshd_centos目录用于存放Dockerfile和其他相关文件。
	
	mkdir sshd_centos
	#进入该目录
	cd sshd_centos

2、在宿主机上生成RSA密钥

	ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key


然后将生成的密钥复制到sshd_centos目录中


	cat ~/.ssh/id_rsa.pub >authorized_keys

3、 在/root/sshd_centos目录下新建Dockerfile文件

	vim Dockerfile


Dockerfile内容：

	FROM centos:7
	MAINTAINER qinzhiming

	RUN yum -y install openssh-server
	RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

	RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
	RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
	RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''

	ADD authorized_keys /root/.ssh/authorized_keys

	RUN mkdir /var/run/sshd 

	RUN echo "root:123456"|chpasswd
	EXPOSE 22
	
	CMD ["/usr/sbin/sshd","-D"]

4、使用docker build生成镜像文件

	docker build -t centos-sshd:1.0 .


5、运行Docker

	docker run -d -p 10022:22 centos-sshd:1.0


6、登录查看，启动的Docker

	ssh localhost -p 10022