FROM phusion/passenger-ruby22

MAINTAINER Ain Tohvri <at@interactive-pioneers.de>

ENV HOME /root

RUN apt-get update && apt-get install -y \
  libpcre3-dev \
  libcurl4-gnutls-dev \
  libgmp3-dev \
  mysql-client \
  postgresql-client \
  npm \
  imagemagick \
  libmagickwand-dev \
  graphviz \
  wget

RUN gem install bundler --no-ri --no-rdoc

# Enable nginx
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default

# Cleanup
RUN apt-get autoremove -y

EXPOSE 80 443
WORKDIR /home/app

CMD ["/sbin/my_init"]
