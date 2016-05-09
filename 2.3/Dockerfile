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
  libmysqlclient-dev \
  mysql-client \
  libpq-dev \
  postgresql-client \
  ruby2.3 \
  ruby2.3-dev \
  nodejs

RUN curl -O http://www.imagemagick.org/download/ImageMagick.tar.gz \
  && tar -xzvf ImageMagick.tar.gz /tmp/ImageMagick \
  && cd /tmp/ImageMagick \
  && ./configure \
  && make \
  && make install \
  && ldconfig /usr/local/lib

RUN ruby-switch --set ruby2.3

RUN gem install bundler --no-ri --no-rdoc

RUN npm install -g webpack bower

# Enable nginx
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default

# Cleanup
RUN apt-get autoremove -y

EXPOSE 80 443
WORKDIR /home/app

CMD ["/sbin/my_init"]
