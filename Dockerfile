FROM ubuntu:trusty
MAINTAINER Cameron Moon <cameron@cameronmoon.com>

# Install required software
RUN apt-get update && \
    apt-get install -y git nginx npm ruby-dev 
RUN npm install -g github-webhook
RUN gem install jekyll rouge

# Configure installed software
RUN sudo ln -s /usr/bin/nodejs /usr/bin/node && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

# Add configuration files & scripts
COPY * /
RUN mkdir /source /site && \
    chmod +x /*.sh

EXPOSE 80
CMD ["/run.sh"]

