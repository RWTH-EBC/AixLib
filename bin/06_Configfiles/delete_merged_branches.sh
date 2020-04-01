#!/usr/bin/env bash

#Note: 	DELETE /projects/:id/repository/branches/:branch
#$CI_API_V4_URL="https://git.rwth-aachen.de/api/v4"
# curl --request DELETE --header "PRIVATE-TOKEN: <your_access_token>" https://gitlab.example.com/api/v4/projects/5/repository/branches/newbranch
echo "Delete merged Branch ${Newbranch}"

set -e


curl --request DELETE --header "PRIVATE-TOKEN:${GL_TOKEN}"	$CI_API_V4_URL/projects/${CI_PROJECT_ID}/repository/branches/${Newbranch}

echo "Branch ${Newbranch} was deleted"