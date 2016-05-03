#!/bin/bash

set -e

docker-compose exec web bundle

components="mysql psql npm node webpack bower convert"

echo "Testing components $components..."

for component in $components
do
  if [[ -z  $(docker-compose exec web which $component) ]]; then
    echo "$component not found! Test failed."
    exit 1
  fi
done

echo "Test complete. All components there."
