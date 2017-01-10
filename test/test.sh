#!/bin/bash

set -e

# Universal tests
function test {

  service=$1
  version=$2
  container=$3

  printf "\nTesting $service\n "

  docker-compose exec $container bash -lc "bundle"

  printf "\nChecking dependencies...\n"
  for dependency in "${dependencies[@]}"
  do
    docker-compose exec $container bash -lc "which $dependency" || (printf "\n$dependency not found! Test failed."; exit 1)
  done

  printf "\n\nChecking filepaths...\n"
  for filepath in "${filepaths[@]}"
  do
    docker-compose exec $container test -e $filepath \
      && printf "\n$filepath found." \
      || (printf "\n$filepath not found! Test failed."; exit 1)
  done

  printf "\n\nChecking HTTP response..."
  response=$(docker-compose exec $container curl -I http://localhost 2>/dev/null | head -n 1 | cut -d$' ' -f2)
  [ "$response" == "200" ] && printf "\nResponse OK" || (printf "\nResponse failure ($response)! Test failed.\n"; exit 1)

  printf "\nChecking Ruby...\n"
  docker-compose run $container bash -lc "rvm use $version" || (printf "\nRuby $version not found! Test failed.\n"; exit 1)

  printf "\n$service test complete. All tests successful.\n"
}

declare -a dependencies=(psql npm node convert ruby wget rvm bundle dot)
declare -a filepaths=(/etc/apache2/sites-enabled/test.conf /docker/Gemfile)

test 2.1.5-p4a2 2.1.5 web215p4a2

declare -a dependencies=(mysql psql npm node convert ruby wget rvm bundle dot)
declare -a filepaths=(/etc/nginx/sites-enabled/test.conf /home/app/Gemfile)

test 2.1 2.1.9 web21
test 2.3 2.3.3 web23
test 2.2 2.2.5 web22
test 2.1.5 2.1.5 web215
