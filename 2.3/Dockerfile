FROM phusion/passenger-ruby23

MAINTAINER Ain Tohvri <at@interactive-pioneers.de>

ENV HOME /root

RUN apt-get update && apt-get install -y \
  libxml2-dev \
  libxslt1-dev \
  libpcre3-dev \
  libcurl4-gnutls-dev \
  libgmp3-dev \
  libmysqlclient-dev \
  mysql-client \
  libpq-dev \
  postgresql-client \
  ruby2.3-dev \
  nodejs \
  npm

RUN cd /tmp \
  && curl -O http://www.imagemagick.org/download/ImageMagick.tar.gz \
  && tar -xzvf ImageMagick.tar.gz \
  && cd ImageMagick* \
  && ./configure \
  && make \
  && make install \
  && ldconfig /usr/local/lib

RUN gem install bundler --no-ri --no-rdoc

RUN npm install -g webpack bower

# Enable nginx
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default

# Cleanup
RUN apt-get autoremove -y

EXPOSE 80 443
WORKDIR /home/app

CMD ["/sbin/my_init"]
