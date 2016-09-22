FROM ipioneers/docker-ruby:2.1.5

MAINTAINER Ain Tohvri <at@interactive-pioneers.de>

USER root

RUN apt-get update && apt-get install -y \
  apache2 \
  apache2-threaded-dev \
  libcurl4-openssl-dev \
  git \
  libapr1-dev \
  libaprutil1-dev \
  libxml2-dev \
  libxslt1-dev \
  rsync \
  imagemagick \
  libmagickwand-dev \
  openjdk-6-jdk \
  phantomjs \
  postgresql-client \
  nodejs-legacy \
  npm \
  && apt-get autoremove -y

# Initialise Apache
RUN echo 'ServerName passenger-ruby.dev' >> /etc/apache2/apache2.conf \
  && echo 'sudo /usr/sbin/apachectl start' >> /etc/bash.bashrc \
  && apache2ctl start

USER deploy

# Install core Ruby gems incl. Passenger and its Apache module
ENV RACK_VERSION 1.6.4
ENV PASSENGER_VERSION 4.0.57
RUN bash -lc "gem install rack --version $RACK_VERSION --no-ri --no-rdoc \
  && gem install passenger --version $PASSENGER_VERSION --no-ri --no-rdoc \
  && passenger-install-apache2-module --auto"

USER root

# Install Bower
RUN npm i -g bower

# Configure Passenger module, vhosts. RUBY_VERSION inherited from parent image
RUN echo "<IfModule mod_passenger.c>\n \
  PassengerRoot $HOME/.rvm/gems/ruby-$RUBY_VERSION/gems/passenger-$PASSENGER_VERSION\n \
  PassengerDefaultRuby $HOME/.rvm/gems/ruby-$RUBY_VERSION/wrappers/ruby\n \
</IfModule>" > /etc/apache2/mods-available/passenger.conf
RUN echo "LoadModule passenger_module $HOME/.rvm/gems/ruby-$RUBY_VERSION/gems/passenger-$PASSENGER_VERSION/buildout/apache2/mod_passenger.so" > /etc/apache2/mods-available/passenger.load
RUN a2enmod passenger && apache2ctl stop

EXPOSE 80

USER deploy
WORKDIR /docker
CMD ["sudo", "/sbin/my_init"]
