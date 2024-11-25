#!/bin/bash

TESTS_DIR=${1:-sipssert}
test -n "$1" && shift

docker run --rm -t \
    --env-file .env \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v "$(pwd)/${TESTS_DIR}":"$(pwd)/${TESTS_DIR}" \
	-v "$(pwd)/run.yml":"$(pwd)/run.yml" \
	-w "$(pwd)/${TESTS_DIR}" \
	opensips/sipssert -c "$(pwd)/run.yml" . $@
