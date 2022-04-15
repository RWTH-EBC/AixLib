#!/usr/bin/env bash

set -e
echo "Check Variables"

if [ -z "$GL_TOKEN" ]; then
  echo "GL_TOKEN not set"
  echo "Please set the GitLab Private Token as GL_TOKEN"
  exit 1
fi


echo "GL_TOKEN is set"



if [ -z "$GITHUB_API_TOKEN" ]; then
  echo "GITHUB_API_TOKEN not set"
  echo "Please set the GitHub Private Token as GITHUB_API_TOKEN"
  exit 1
fi

echo "GITHUB_API_TOKEN is set"

if [ -z "$Github_Repository" ]; then
  echo "Github_Repository not set"
  echo "Please set your Token (e.g. owner/project) as Github_Repository"
  exit 1
fi

echo "Github_Repository is set"

if [ -z "$GITHUB_PRIVATE_KEY" ]; then
  echo "GITHUB_PRIVATE_KEY not set"
  echo "Please set the Github private ssh-Token as GITHUB_PRIVATE_KEY"
  exit 1
fi

echo "GITHUB_PRIVATE_KEY is set"

echo "Configurations are correct."

exit 0 