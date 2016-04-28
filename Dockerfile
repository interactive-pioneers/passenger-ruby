FROM phusion/passenger-ruby22

MAINTAINER Ain Tohvri <at@interactive-pioneers.de>

ENV HOME /root

RUN apt-get update && apt-get install -y \
  libxml2-dev \
  libxslt1-dev \
  imagemagick \
  libpcre3-dev \
  libcurl4-gnutls-dev \
  libgmp3-dev \
  ruby2.3

RUN ruby-switch --set ruby2.3

# Enable nginx
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default

# Cleanup
RUN apt-get autoremove -y

EXPOSE 80 443
WORKDIR /home/app

CMD ["/sbin/my_init"]
