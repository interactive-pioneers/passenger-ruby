FROM  phusion/passenger-ruby21

MAINTAINER Ain Tohvri <at@interactive-pioneers.de>

ENV HOME /root

RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libapr1-dev \
  libaprutil1-dev \
  libxml2-dev \
  libxslt1-dev \
  rsync \
  phantomjs \
  libmysqlclient-dev \
  mysql-client \
  libpq-dev \
  postgresql-client \
  nodejs \
  npm \
  imagemagick

RUN gem install bundler --no-ri --no-rdoc

RUN npm install -g webpack bower

# Enable nginx
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default

# Cleanup
RUN apt-get autoremove -y

EXPOSE 80 443
WORKDIR /home/app

CMD ["/sbin/my_init"]
