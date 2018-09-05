FROM  hub.c.163.com/zhengqingzhao/base:v2

ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
ENV CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH
ENV PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH


ENV JAVA_OPTS=-Xmx512m
ADD http://zqz-b1.nos-eastchina1.126.net/settings.xml /root/.m2/settings.xml
#RUN ["git", "clone", "https://qingzhao198%40126.com:1725jjz@git.coding.net/sharry198/petclinc.git","/spring-petclinic"]
#RUN /bin/sh -c "git clone https://qingzhao198%40126.com:1725jjz@git.coding.net/sharry198/petclinc.git /spring-petclinic"
RUN /bin/sh -c "git clone https://qingzhao198%40126.com:1725jjz@github.com/qingzhao/spring-petclinic.git /spring-petclinic"



RUN /bin/sh -c "cd /spring-petclinic && mvn package -PMySQL -Dmaven.test.skip=true && cp ./target/petclinic.war /var/lib/tomcat7/webapps " 



ENTRYPOINT     /etc/init.d/tomcat7 start && /usr/sbin/sshd -D
