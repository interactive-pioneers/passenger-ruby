#!/bin/bash

set -e

# Universal tests
function test {

  version=$1
  container=$2
  components=$3
  filepaths=$4

  printf "\nTesting version $version\n"

  docker-compose exec $container bundle

  printf "\nChecking components..."
  for component in $components
  do
    if [[ -z  $(docker-compose exec $container bash -lc "which $component") ]]; then
      printf "\n$component not found! Test failed.\n"
      exit 1
    else
      printf "\n$component found."
    fi
  done

  printf "\nChecking filepaths..."
  for filepath in $filepaths
  do
    docker-compose exec $container test -e $filepath \
      && printf "\n$filepath found." \
      || (printf "\n$filepath not found! Test failed.\n"; exit 1)
  done

  printf "\n$version test complete. All tests successful.\n"
}

dependencies="mysql psql npm node webpack bower convert ruby"
files="/etc/nginx/sites-enabled/test.conf /home/app/Gemfile"

test 2.1.5-rvm web215rvm "$dependencies rvm" "$files /root/.bash_profile"
test 2.1 web21 $dependencies $files
test 2.3 web23 $dependencies $files
