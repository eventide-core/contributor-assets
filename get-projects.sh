#!/usr/bin/env bash

set -eu -o pipefail

source ./utilities/run-cmd.sh
source ./projects/projects.sh

echo
echo "Get Projects"
echo "= = ="
echo

if [ -z ${ESC_HOME:-} ]; then
  echo "ESC_HOME is not set; aborting"
  echo
  exit 1
fi

if [ ! -z ${GIT_AUTHORITY_PATH:-} ]; then
  echo "The GIT_AUTHORITY_PATH environment variable is set: $GIT_AUTHORITY_PATH. It will be used for this script."
  remote_authority_path=$GIT_AUTHORITY_PATH
else
  remote_authority_path="git@github.com:esc-rb"
fi

if [ ! -z ${GIT_REMOTE_NAME:-} ]; then
  echo "The GIT_REMOTE_NAME environment variable is set: $GIT_REMOTE_NAME. It will be used for this script."
  remote_name=$GIT_REMOTE_NAME
else
  remote_name=origin
fi

function clone-project {
  name=$1
  branch=${2:-main}
  authority=${3:-$remote_authority_path}

  remote_repository_url="$authority/$name.git"

  echo "Cloning: $remote_repository_url"

  clone_cmd="git -C $ESC_HOME clone -b $branch $remote_repository_url"

  run-cmd "$clone_cmd"
}

function pull-project {
  name=$1
  branch=${2:-main}
  authority=${3:-$remote_authority_path}

  echo "Pulling: $name ($branch branch only)"

  current_branch=$(git -C $ESC_HOME/$name symbolic-ref --short HEAD)

  if [ $current_branch = $branch ]; then
    run-cmd "git -C $ESC_HOME/$name pull --rebase $remote_name $branch"
  else
    run-cmd "git -C $ESC_HOME/$name fetch $remote_name $branch:$branch"
  fi
}

function get-project {
  name=$1

  echo $name
  echo "- - -"

  dir="$ESC_HOME/$name"

  if [ ! -d "$dir/.git" ]; then
    clone-project $@
  else
    pull-project $@
  fi

  echo
}

echo
echo "Getting MRuby"
echo "- - -"
echo

get-project "mruby" "stable" "git@github.com:mruby"

echo
echo "Getting code from $remote_authority_path ($remote_name)"
echo "= = ="
echo

for project in "${projects[@]}"; do
  get-project $project
done
