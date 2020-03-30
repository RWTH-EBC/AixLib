#!/usr/bin/env bash
set -e

if [ -z "$GL_TOKEN" ]; then
  echo "GL_TOKEN not set"
  echo "Please set the GitLab Private Token as GL_TOKEN"
  exit 1
fi

echo "GL_TOKEN is set"
  
# Extract the host where the server is running, and add the URL to the APIs
[[ $CI_PROJECT_URL =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

# Look which is the default branch
#TARGET_BRANCH=`curl --silent "${HOST}${CI_PROJECT_ID}" --header "PRIVATE-TOKEN:${GL_TOKEN}" | jq --raw-output '.default_branch'`;
#TARGET_BRANCH =  $TARGET_BRANCH       


# The description of our new MR, we want to remove the branch after the MR has
# been closed
BODY="{
    \"id\": ${CI_PROJECT_ID},
    \"source_branch\": \"${Newbranch}\",
    \"target_branch\": \"${TARGET_BRANCH}\",
    \"remove_source_branch\": true,
    \"title\": \"WIP: ${CI_COMMIT_REF_NAME}\",
    \"assignee_id\":\"${GITLAB_USER_ID}\"
}";
echo "$BODY"
echo 
# Require a list of all the merge request and take a look if there is already
# one with the same source branch
LISTMR=`curl --silent "${HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${GL_TOKEN}"`;
echo "$LISTMR"
COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"${Newbranch}\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;
#COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;

echo "$COUNTBRANCHES"
# No MR found, let's create a new one
if [ ${COUNTBRANCHES} -eq "0" ]; then
    echo "No merge request is open";
    exit 0;
fi

echo "Merge Request ist already open. No new merge request opened";
exit 1