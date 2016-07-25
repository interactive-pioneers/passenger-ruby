#!/bin/bash

set -e


function test {
  version=$1
  container=$2
  printf "\nTesting version $version\n"
  docker-compose exec $container bundle
  for component in $components
  do
    if [[ -z  $(docker-compose exec $container which $component) ]]; then
      printf "\n$component not found! Test failed.\n"
      exit 1
    fi
  done
  printf "\n$version test complete. All components identified.\n"
}

components="mysql psql npm node webpack bower convert"

test 2.1 web21
test 2.3 web23
