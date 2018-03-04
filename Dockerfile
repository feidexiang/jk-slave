FROM jenkinsci/jnlp-slave:latest
ENV MAVEN_VERSION 3.5.2
ENV JAVA_HOME /usr/java/jdk1.8.0_162
ENV MAVEN_HOME /opt/maven/apache-maven-${MAVEN_VERSION}
ENV CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
 
# build java
COPY ./jdk1.8.0_121 ${JAVA_HOME}
COPY ./libltdl.so.7 /usr/lib/libltdl.so.7
 
# build maven
COPY apache-maven-${MAVEN_VERSION}-bin.tar.gz /tmp/maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz
COPY settings.xml /tmp/maven/settings.xml
USER root:root
RUN mkdir -p /opt/maven/repository \
    && cd /opt/maven \
    && tar -zxvf /tmp/maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz  \
    && cp /tmp/maven/settings.xml ${MAVEN_HOME}/conf/settings.xml \
    && rm -rf /tmp/maven \
    && apt-get -yq update  \
    && apt-get -yq --no-install-recommends --no-install-suggests install sshpass \
    && apt-get clean -y
 
ENV PATH ${MAVEN_HOME}/bin:${PATH}
