#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.." || exit 1
docker compose exec builder ash -c 'eval "$(/workspace/tools/env.sh)"; exec ash'
