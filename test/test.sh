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
  host=$(docker-compose port $container 80)
  http=$(curl -I http://$host 2>/dev/null | head -n 1 | cut -d$' ' -f2)
  [ "$http" == "200" ] && printf "\nResponse OK" || (printf "\nResponse failure ($http)!"; exit 1)

  printf "\n\n$version test complete. All tests successful.\n"
}

declare -a dependencies=(mysql psql npm node webpack bower convert ruby wget rvm)
declare -a filepaths=(/etc/nginx/sites-enabled/test.conf /home/app/Gemfile)

test 2.1 web21
test 2.3 web23
test 2.2 web22
test 2.1.5 web215
