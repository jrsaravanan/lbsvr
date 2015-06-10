FROM ubuntu:latest

MAINTAINER Saravanan Renganathan



# Required packages
RUN apt-get -qq update && apt-get -qq -y install software-properties-common curl

RUN /usr/bin/add-apt-repository ppa:webupd8team/java 2> /dev/null &&\
    apt-get update -qq

# Accept oracle-java7 license
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

# Install java7 + mysql
RUN apt-get install -qq -y oracle-java7-installer 2> /dev/null


# Set Standard settings
ENV MYSQL_HOST 127.0.0.1
ENV MYSQL_PORT 3306

    
# Tomcat Version
ENV TOMCAT_VERSION_MAJOR 7
ENV TOMCAT_VERSION_FULL  7.0.57

# Download and install tomcat
RUN curl -kLO https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz &&\
    tar -xzf apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz -C /opt &&\
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION_FULL} /opt/tomcat &&\
    rm apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz &&\
    rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs


# Configure users for tomcat manager and host-manager
ADD conf/tomcat-users.xml /opt/tomcat/conf/

ADD conf/person.properties /var/opt/properties/person/person.properties
ADD war/person.war /opt/tomcat/webapps/person.war

#RUN echo "jdbc.url=jdbc:mysql://'$DB_PORT_8080_TCP_ADDR':3306/test" >> /var/opt/properties/person/person.properties

#jdbc.url=jdbc:mysql://${DB_PORT_8080_TCP_ADDR}:3306/test

# Set CATALINA_HOME
ENV CATALINA_HOME /opt/tomcat
EXPOSE 8080


# Launch Tomcat on startup
CMD ${CATALINA_HOME}/bin/startup.sh && tail -f ${CATALINA_HOME}/logs/catalina.out



