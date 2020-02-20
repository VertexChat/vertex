#! /bin/sh

tmp_dir=$(mktemp -d)
branch=$(git rev-parse --abbrev-ref HEAD)

git add ../lib/src/services/client_stubs/
git add ../../docs/OpenAPI.yaml
git commit -m "Pre stubs" --allow-empty

git branch -D generate_stubs

git switch -c generate_stubs
docker run --rm -it --mount type=bind,source="$(pwd)"/../../docs/OpenAPI.yaml,target=/OpenAPI.yaml,readonly -v $tmp_dir:/out  openapitools/openapi-generator-cli generate -i /OpenAPI.yaml -g dart -o /out
mkdir -p ../lib/src/services/client_stubs
/usr/bin/cp -r -v $tmp_dir/* ../lib/src/services/client_stubs

git add ../lib/src/services/client_stubs/
git commit -m "Generate stubs" --allow-empty

git reset --soft HEAD~1
git commit --all --amend --no-edit

git checkout $branch
git reset --soft HEAD~1
git merge generate_stubs --squash

