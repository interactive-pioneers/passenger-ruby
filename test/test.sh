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
    docker-compose exec $container bash -lc "which $dependency" || (printf "\n$dependency not found! Test failed.\n"; exit 1)
  done

  printf "\nChecking filepaths..."
  for filepath in "${filepaths[@]}"
  do
    docker-compose exec $container test -e $filepath \
      && printf "\n$filepath found." \
      || (printf "\n$filepath not found! Test failed.\n"; exit 1)
  done

  printf "\n$version test complete. All tests successful.\n"
}

declare -a dependencies=(mysql psql npm node webpack bower convert ruby)
declare -a filepaths=(/etc/nginx/sites-enabled/test.conf /home/app/Gemfile)

test 2.1 web21
test 2.3 web23

dependencies+=(rvm)
filepaths+=(/root/.bash_profile)
test 2.1.5-rvm web215rvm
