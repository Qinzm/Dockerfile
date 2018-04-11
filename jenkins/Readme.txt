1.执行生成镜像
docker build -t jenkins:dev .
2.查看生成的镜像
docker images
3.启动镜像
docker run -dit -h jjcc_jenkins --name jjcc_jenkins -p 8000:8080 -v /data/docker/jenkins/plugins:/root/.jenkins/plugins jenkins:dev
4.进入镜像查看密码，如911b82031a7240eb81d8fde78dca57bf
docker exec -it myjenkins /bin/bash
cat /root/.jenkins/secrets/initialAdminPassword
5.访问jenkins路径，输入密码初始化即可
http://192.168.1.11:8000/jenkins




启动命令
/root/.jenkins/plugins


修改默认访问页面
docker exec -it myjenkins /bin/bash

vi /opt/apache-tomcat-8.5.30/conf/server.xml
在<Host> </Host>之间添加一下内容
<Context path="" docBase="/opt/apache-tomcat-8.5.30/webapps/jenkins" debug="0"/>

crtl+D退出，重启 docker restart myjenkins