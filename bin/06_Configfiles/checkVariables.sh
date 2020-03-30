#!/usr/bin/env bash

set -e
echo "Check Variables"

if [ -z "$GL_TOKEN" ]; then
  echo "GL_TOKEN not set"
  echo "Please set the GitLab Private Token as GL_TOKEN"
  exit 1
fi
echo "GL_TOKEN is set"


if [ -z "$TARGET_BRANCH " ]; then
  echo "TARGET_BRANCH  not set"
  echo "Please set your current branch in .gitlab-ci.yml "
  exit 1
fi
echo "Your current branch is $TARGET_BRANCH"
echo "Variable TARGET_BRANCH is set"
echo "All required Variables are set. CI-Tests can run. "
exit 0