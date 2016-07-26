#!/bin/bash

set -e

# Universal tests
function test {
  version=$1
  container=$2
  components=$3
  printf "\nTesting version $version\n"
  docker-compose exec $container bundle
  for component in $components
  do
    if [[ -z  $(docker-compose exec $container bash -lc "which $component") ]]; then
      printf "\n$component not found! Test failed.\n"
      exit 1
    fi
  done
  printf "\n$version test complete. All components identified.\n"
}

dependencies="mysql psql npm node webpack bower convert ruby"

test 2.1.5-rvm web215rvm "$dependencies rvm"
test 2.1 web21 $dependencies
test 2.3 web23 $dependencies
