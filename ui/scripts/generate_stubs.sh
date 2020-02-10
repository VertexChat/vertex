#! /bin/sh

tmp_dir=$(mktemp -d)
branch=$(git rev-parse --abbrev-ref HEAD)

git switch -c generate_stubs
docker run --rm -it --mount type=bind,source="$(pwd)"/../../docs/OpenAPI.yaml,target=/OpenAPI.yaml,readonly -v $tmp_dir:/out  openapitools/openapi-generator-cli generate -i /OpenAPI.yaml -g dart -o /out
mkdir -p ../lib/src/services/client_stubs
cp -r -v $tmp_dir/* ../lib/src/services/client_stubs
git add ../lib/src/services/client_stubs
git commit -m "Generate stubs"

git checkout $branch
git merge generate_stubs --squash
