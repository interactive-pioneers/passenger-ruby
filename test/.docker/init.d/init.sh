#!/bin/bash

if [[ $RAILS_ENV == 'development' ]]; then
  echo "Adjusting uid/gid for local development..."
  usermod -u 1000 app
  usermod -G staff app
fi

sudo service apache2 start
