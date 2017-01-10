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
  imagemagick \
  libmagickwand-dev \
  graphviz \
  wget

RUN bash -lc "rvm uninstall 2.1.9 && rvm install 2.1.5"

RUN gem install bundler --no-ri --no-rdoc

# Enable nginx
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default

# Cleanup
RUN apt-get autoremove -y

EXPOSE 80 443
WORKDIR /home/app

CMD ["/sbin/my_init"]
