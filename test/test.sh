#!/bin/bash

set -e

docker-compose exec web bundle

components="mysql psql npm node webpack bower convert"

for component in $components
do
  docker-compose -f ./test/docker-compose.yml exec web which $component
done

exit 0
