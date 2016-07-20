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
  openjdk-6-jdk \
  phantomjs \
  postgresql-client

RUN apache2ctl start

USER deploy

ENV PASSENGER_VERSION 4.0.57
ENV RACK_VERSION 1.4.7

# Install core Ruby gems incl. Passenger and its Apache module
RUN bash -lc "gem install rack --version $RACK_VERSION --no-ri --no-rdoc \
  && gem install passenger --version $PASSENGER_VERSION --no-ri --no-rdoc \
  && passenger-install-apache2-module --auto"

# Install Node.js and basic dependencies
RUN bash -lc "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
  && source $HOME/.nvm/nvm.sh \
  && nvm install 5.10.1 \
  && npm install -g webpack bower"

USER root

RUN echo "<IfModule mod_passenger.c>\n \
  PassengerRoot $HOME/.rvm/gems/ruby-$RUBY_VERSION/gems/passenger-$PASSENGER_VERSION\n \
  PassengerDefaultRuby $HOME/.rvm/gems/ruby-$RUBY_VERSION/wrappers/ruby\n \
</IfModule>" > /etc/apache2/mods-available/passenger.conf
RUN echo "LoadModule passenger_module $HOME/.rvm/gems/ruby-$RUBY_VERSION/gems/passenger-$PASSENGER_VERSION/buildout/apache2/mod_passenger.so" > /etc/apache2/mods-available/passenger.load
RUN a2enmod passenger \
  && a2dissite 000-default \
  && apache2ctl stop

# Cleanup
RUN apt-get autoremove -y

EXPOSE 80

USER deploy
WORKDIR /docker

CMD ["sudo", "service", "apache2", "start"]
