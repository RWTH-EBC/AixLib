import requests
import json
import argparse
import os
import sys 


class GET_API_GITHUB(object):

	def  __init__(self, correct_branch,github_repo, working_branch):
		self.github_repo = github_repo
		self.correct_branch = correct_branch
		self.working_branch = working_branch

	def get_github_username(self):
		url = f'https://api.github.com/repos/{self.github_repo+}/branches/{self.correct_branch}'
		payload = {}
		headers= {}
		response = requests.request("GET", url, headers=headers, data = payload)
		branch = response.json()
		commit = branch["commit"]
		author = commit["commit"]
		author = author["committer"]
		login = author["name"]
		return login

	def return_owner(self):
		owner = self.github_repo
		owner = owner.split("/")
		return owner[0]
		
class PULL_REQUEST_GITHUB(object):
	
	def  __init__(self, github_repo, working_branch, owner, github_token, page_url):
		self.github_repo = github_repo
		self.working_branch = working_branch
		self.github_token = github_token
		self.owner = owner
		self.page_url = page_url
	
	def _post_pull_request(self):
		url = f'https://api.github.com/repos/{self.github_repo}/pulls'
		payload = '{\n    \"title\": \"IBPSA Merge ' + self.Working_Branch + '\",\n    \"body\": \"**Following you will find the instructions for the IBPSA merge:**\\n  1. Please pull this branch IBPSA_Merge to your local repository.\\n 2. As an additional saftey check please open the AixLib library in dymola and check whether errors due to false package orders may have occurred. You do not need to translate the whole library or simulate any models. This was already done by the CI.\\n 3. If you need to fix bugs or perform changes to the models of the AixLib, push these changes using this commit message to prevent to run the automatic IBPSA merge again: **`fix errors manually`**. \\n  4. You can also output the different reference files between the IBPSA and the AixLib using the CI or perform an automatic update of the referent files which lead to problems. To do this, use one of the following commit messages \\n  **`Trigger CI - give different reference results`** \\n  **`Trigger CI - Update reference results`** \\n The CI outputs the reference files as artifacts in GitLab. To find them go to the triggered pipeline git GitLab and find the artifacts as download on the right site. \\n 5. If the tests in the CI have passed successfully, merge the branch IBPSA_Merge to development branch. **Delete** the Branch ' + self.Correct_Branch + '\",\n    \"head\": \"' + self.OWNER + ':' + self.Correct_Branch + '\",\n    \"base\": \"' + self.Working_Branch + '\"\n  \n}'
		headers = {
			'Authorization': 'Bearer '+self.GITHUB_TOKEN,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data = payload)
		return response

		
	def _get_pull_request_number(self, pull_request_response):
		pull_request_number = pull_request_response.json()
		pull_request_number = pull_request_number["number"]
		return pull_request_number
	
	def _update_pull_request_assignees(self,pull_request_number,assignees_owner):
		url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pull_request_number)}'
		payload = '{ \"assignees\": [\r\n    \"'+assignees_owner+'\"\r\n  ],\r\n    \"labels\": [\r\n    \"CI\", \r\n    \"IBPSA_Merge\"\r\n    \r\n  ]\r\n}'
		
		headers = {
		  'Authorization': 'Bearer '+self.github_token,
		  'Content-Type': 'application/json'
		}
		response = requests.request("PATCH", url, headers=headers, data = payload)
		print(f'User {assignees_owner} assignee to pull request Number {str(pull_request_number)}')

	def _post_comment_show_plots(self, pr_number):
		url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}/comments'
		message = f'Reference results have been displayed graphically and are created under the following page {self.page_url}'
		#payload = "{\"body\":\"Errors in regression test. Compare the results on the following page " + page_url + "\"}"
		payload = "{\"body\":\"" + message + "\"}"
		headers = {
			'Authorization': 'Bearer ' + self.github_repo,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data=payload)
		print(response.text)

	


if  __name__ == '__main__':
	parser = argparse.ArgumentParser(description = "Set Github Environment Variables")  # Configure the argument parser
	check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
	check_test_group.add_argument("-CB", "--correct-branch", default ="${Newbranch}", help="Branch to correct your Code")
	check_test_group.add_argument("-GR", "--github-repo", default="RWTH-EBC/AixLib", help="Environment Variable owner/RepositoryName" )
	check_test_group.add_argument('-WB',"--working-branch",default="${TARGET_BRANCH}", help="Your current working Branch")
	check_test_group.add_argument('-GT',"--github-token",default="${GITHUB_API_TOKEN}", help="Your Set GITHUB Token")
	check_test_group.add_argument("--prepare_plots", help="Plot new models with new created reference files", action="store_true")
	check_test_group.add_argument("--show-plots", help="Plot new models with new created reference files",
								  action="store_true")
	check_test_group.add_argument("--merge-request", help="Comment for a IBPSA Merge request",  action="store_true")
	check_test_group.add_argument('-GP', "--gitlab-page", default="${GITLAB_Page}", help="Set your gitlab page url")
	args = parser.parse_args()  # Parse the arguments

	#GET_API_DATA = GET_API_GITHUB(GITHUB_REPOSITORY = args.GITHUB_REPOSITORY, Correct_Branch = args.Correct_Branch, Working_Branch = args.Working_Branch)
	#owner = GET_API_DATA.return_owner()
	#PULL_REQUEST = PULL_REQUEST_GITHUB(GITHUB_REPOSITORY = args.GITHUB_REPOSITORY, Correct_Branch = args.Correct_Branch, Working_Branch = args.Working_Branch, GITHUB_TOKEN = args.GITHUB_TOKEN, OWNER = owner)
	#pull_request_response = PULL_REQUEST.post_pull_request()
	#pull_request_number = PULL_REQUEST.get_pull_request_number(pull_request_response)
	#assignees_owner = GET_API_DATA.get_GitHub_Username()
	#PULL_REQUEST.update_pull_request_assignees(pull_request_number,assignees_owner)
	#print("Pull Request")
	#exit(0)

	GET_API_GITHUB


	if args.prepare_plots is True:
		page_url = f'{args.GITLAB_Page}/{args.working_branch}/plots'
	if args.show_plot is True:



	
