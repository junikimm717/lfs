#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.."
docker compose exec builder ash -c 'eval "$(/workspace/tools/env.sh)"; exec ash'
