FROM ubuntu:16.04
MAINTAINER yaiceltg@gmail.com

# define open-vidu-server 
ENV VERSION=2.6.0

# Install Java, supervisor and netstat
RUN apt-get update && apt-get install -y \
  openjdk-8-jre \
  supervisor \
&& rm -rf /var/lib/apt/lists/*

# Configure supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy OpenVidu Server
RUN wget https://github.com/OpenVidu/openvidu/releases/download/v{VERSION}/openvidu-server-{VERSION}.jar -o /openvidu-server.jar

EXPOSE 4443

# Exec supervisord
CMD ["/usr/bin/supervisord"]