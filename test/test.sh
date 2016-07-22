#!/bin/bash

set -e

echo "Testing version 2.3"
docker-compose exec web23 bundle
components="mysql psql npm node webpack bower convert"
for component in $components
do
  if [[ -z  $(docker-compose exec web23 which $component) ]]; then
    echo "$component not found! Test failed."
    exit 1
  fi
done
echo "2.3 test complete. All components identified."

echo "Testing version 2.1"
docker-compose exec web21 bundle
components="psql npm node webpack bower convert"
for component in $components
do
  if [[ -z  $(docker-compose exec web21 which $component) ]]; then
    echo "$component not found! Test failed."
    exit 1
  fi
done
echo "2.1 test complete. All components identified."
