import requests
import json
import argparse
import os
import sys


class Pull_Request_Github(object):

    def __init__(self, github_repo, working_branch, owner, github_token):
        self.github_repo = github_repo
        self.working_branch = working_branch
        self.github_token = github_token
        self.owner = owner

    def post_pull_request(self):
        url = f'https://api.github.com/repos/{self.GITHUB_REPOSITORY}/pulls'
        payload = '{\n    \"title\": \"IBPSA Merge ' + self.Working_Branch + '\",\n    \"body\": \"###Following you will find the instructions for the IBPSA merge:\n  1. Please pull this branch IBPSA_Merge to your local repository.\n 2. As an additional saftey check please open the AixLib library in dymola and check whether errors due to false package orders may have occurred. You do not need to translate the whole library or simulate any models. This was already done by the CI.\n    3. If you need to fix bugs or perform changes to the models of the AixLib, push these changes using this commit message to prevent to run the automatic IBPSA merge again: **`fix errors manually`**. \n  4. You can also output the different reference files between the IBPSA and the AixLib using the CI or perform an automatic update of the referent files which lead to problems. To do this, use one of the following commit messages \n  **`Trigger CI - give different reference results`** \n * **`Trigger CI - Update reference results`** \n The CI outputs the reference files as artifacts in GitLab. To find them go to the triggered pipeline git GitLab and find the artifacts as download on the right site. \n 5. If the tests in the CI have passed successfully, merge the branch IBPSA_Merge to development branch. **Delete** the Branch ' + self.Correct_Branch + '\",\n    \"head\": \"' + self.OWNER + ':' + self.Correct_Branch + '\",\n    \"base\": \"' + self.Working_Branch + '\"\n  \n}'
        headers = {
            'Authorization': 'Bearer ' + self.GITHUB_TOKEN,
            'Content-Type': 'application/json'
        }
        response = requests.request("POST", url, headers=headers, data=payload)
        print(response.text.encode('utf8'))
        return response

    def get_pull_request_number(self, pull_request_response):
        pull_request_number = pull_request_response.json()
        pull_request_number = pull_request_number["number"]
        print(pull_request_number)
        return pull_request_number

    def update_pull_request_assignees(self, pull_request_number, assignees_owner):
        url = "https://api.github.com/repos/" + self.GITHUB_REPOSITORY + "/issues/" + str(pull_request_number)

        payload = '{ \"assignees\": [\r\n    \"' + assignees_owner + '\"\r\n  ],\r\n    \"labels\": [\r\n    \"CI\", \r\n    \"IBPSA_Merge\"\r\n    \r\n  ]\r\n}'

        headers = {
            'Authorization': 'Bearer ' + self.GITHUB_TOKEN,
            'Content-Type': 'application/json'
        }

        response = requests.request("PATCH", url, headers=headers, data=payload)

        print("User " + assignees_owner + " assignee to pull request Number " + str(pull_request_number))

    def _get_pull_branch(Working_branch, GITHUB_REPOSITORY):
        url = "https://api.github.com/repos/"+GITHUB_REPOSITORY+"/pulls"
        payload = {}
        headers = {
             'Content-Type': 'application/json'
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        pull_request_json = response.json()
        for i in pull_request_json:
            name = (i["head"])
            name = (name.get("ref"))
            if name == Working_branch:
                print(name)
                return (i["number"])

    def update_pull_request_assignees(self, pull_request_number):
        url = "https://api.github.com/repos/" + self.GITHUB_REPOSITORY + "/issues/" + str(pull_request_number)

        payload="\"body\": \"Please pull these awesome changes in!\""

        headers = {
            'Authorization': 'Bearer ' + GITHUB_TOKEN,
            'Content-Type': 'application/json'
        }

        response = requests.request("PATCH", url, headers=headers, data=payload)
        print("User " + assignees_owner + " assignee to pull request Number " + str(pull_request_number))

    def post_comment(pr_number, page_url, GITHUB_TOKEN , GITHUB_REPOSITORY):
        url = "https://api.github.com/repos/" + GITHUB_REPOSITORY + "/issues/" + str(pr_number)+"/comments"

        payload="{\"body\":\"Errors in regression test. Compare the results on the following page "+ page_url +"\"}"
        headers = {
          'Authorization': 'Bearer ' + GITHUB_TOKEN,
          'Content-Type': 'application/json'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        print(response.text)

if  __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Set Github Environment Variables")  # Configure the argument parser
    check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
    check_test_group.add_argument("-GR", "--GITHUB-REPOSITORY", default="RWTH-EBC/AixLib",
                                  help="Environment Variable owner/RepositoryName")
    check_test_group.add_argument('-WB', "--Working-Branch", default="${TARGET_BRANCH}",
                                  help="Your current working Branch")
    check_test_group.add_argument('-GT', "--GITHUB-TOKEN", default="${GITHUB_API_TOKEN}", help="Your Set GITHUB Token")
    check_test_group.add_argument('-GP', "--GITLAB-Page", default="${GITLAB_Page}", help="Set your gitlab page url")
    args = parser.parse_args()  # Parse the arguments

    page_url = f'{args.GITLAB_Page}/{args.Working_Branch}/plots'
    print(f'Setting page url: {page_url}')
    pr_number = _get_pull_branch(args.Working_Branch, args.GITHUB_REPOSITORY)
    print(f'Setting Pull Request Number: {pr_number}')



    post_comment(pr_number, page_url, args.GITHUB_TOKEN, args.GITHUB_REPOSITORY)
