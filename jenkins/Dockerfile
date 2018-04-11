FROM centos:7 
MAINTAINER qinzhiming
RUN yum -y install wget git
RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
	echo "Asia/Shanghai" > /etc/timezone ;\
	cd /opt;
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
RUN wget http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.5.30/bin/apache-tomcat-8.5.30.tar.gz
RUN tar -xvf jdk-8u131-linux-x64.tar.gz -C /opt/
RUN tar -xvf apache-maven-3.5.3-bin.tar.gz -C /opt/
RUN tar -xvf apache-tomcat-8.5.30.tar.gz -C /opt
ENV JAVA_HOME /opt/jdk1.8.0_131
ENV MAVEN_HOME /opt/apache-maven-3.5.3
ENV CLASSPATH .:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH
RUN wget -P /opt/apache-tomcat-8.5.30/webapps http://mirrors.jenkins-ci.org/war/latest/jenkins.war
RUN yum clean all;\
	rm -rf jdk-8u131-linux-x64.tar.gz;\
	rm -rf apache-maven-3.5.3-bin.tar.gz;\
	rm -rf apache-tomcat-8.5.30.tar.gz;
CMD /opt/apache-tomcat-8.5.30/bin/catalina.sh run
EXPOSE 8080


