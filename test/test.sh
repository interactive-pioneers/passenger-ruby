#!/bin/bash

set -e

# Universal tests
function test {

  version=$1
  container=$2

  printf "\nTesting version $version\n "

  docker-compose exec $container bundle

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
  [ "$response" == "200" ] && printf "\nResponse OK" || (printf "\nResponse failure ($response)!\n"; exit 1)

  printf "\nChecking Ruby...\n"
  docker-compose run $container bash -lc "rvm use $version" || (printf "\nRuby $version not found! Test failed.\n"; exit 1)

  printf "\n$version test complete. All tests successful.\n"
}

declare -a dependencies=(mysql psql npm node webpack bower convert ruby wget rvm)
declare -a filepaths=(/etc/nginx/sites-enabled/test.conf /home/app/Gemfile)

test 2.1 web21
test 2.3 web23
test 2.2 web22
test 2.1.5 web215
