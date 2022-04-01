import requests
import json
import argparse
import os
import sys 
import time

class GET_API_GITHUB(object):

	def __init__(self, github_repo, working_branch):
		self.github_repo = github_repo
		self.working_branch = working_branch

	def _get_pr_number(self):
		url = f'https://api.github.com/repos/{self.github_repo}/pulls'
		payload = {}
		headers = {
			'Content-Type': 'application/json'
		}
		response = requests.request("GET", url, headers=headers, data=payload)
		pull_request_json = response.json()
		for pull in pull_request_json:
			name = pull["head"].get("ref")
			if name == self.working_branch:
				return pull["number"]

	def _get_github_username(self):
		branch = self.working_branch.replace("Correct_HTML_", "")
		url = f'https://api.github.com/repos/{self.github_repo}/branches/{branch}'
		payload = {}
		headers = {}
		response = requests.request("GET", url, headers=headers, data=payload)
		branch = response.json()
		commit = branch["commit"]
		commit = commit["commit"]
		committer = commit["committer"]
		name = committer["name"]
		if name is not None:
			return name

	def return_owner(self):
		owner = self.github_repo.split("/")
		return owner[0]

class PULL_REQUEST_GITHUB(object):
	
	def __init__(self, github_repo, working_branch, github_token):
		self.github_repo = github_repo
		self.working_branch = working_branch
		self.github_token = github_token
		self.correct_branch = f'Correct_HTML_{self.working_branch}'
	
	def _post_comment_IBPSA_merge(self, owner, base_branch):
		url = f'https://api.github.com/repos/{self.github_repo}/pulls'
		title = f'\"title\": \"IBPSA Merge into {base_branch}\"'
		body = f'\"body\":\"**Following you will find the instructions for the IBPSA merge:**\\n  1. Please pull this branch IBPSA_Merge to your local repository.\\n 2. As an additional saftey check please open the AixLib library in dymola and check whether errors due to false package orders may have occurred. You do not need to translate the whole library or simulate any models. This was already done by the CI.\\n 3. If you need to fix bugs or perform changes to the models of the AixLib, push these changes using this commit message to prevent to run the automatic IBPSA merge again: **`fix errors manually`**. \\n  4. You can also output the different reference files between the IBPSA and the AixLib using the CI or perform an automatic update of the referent files which lead to problems. To do this, use one of the following commit messages \\n  **`ci_show_ref`** \\n  **`ci_update_ref`** \\n The CI outputs the reference files as artifacts in GitLab. To find them go to the triggered pipeline git GitLab and find the artifacts as download on the right site. \\n 5. If the tests in the CI have passed successfully, merge the branch IBPSA_Merge to development branch. **Delete** the Branch {self.working_branch}\"'
		head = f'\"head\":\"{owner}:{self.working_branch}\"'
		base = f'\"base\": \"{base_branch}\"'
		message = f'\n	{title},\n	{body},\n	{head},\n	{base}\n'
		payload = "{" + message + "}"
		headers = {
			'Authorization': 'Bearer '+self.github_token,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data=payload)
		return response

	def _post_pr_correct_html(self, owner):
		branch = self.working_branch.replace("Correct_HTML_", "")
		title = f'\"title\":\"Corrected HTML Code in branch {self.working_branch}\"'
		body = f'\"body\":\"Merge the corrected HTML Code. After confirm the pull request, **pull** your branch to your local repository. **Delete** the Branch {self.working_branch}\"'
		head = f'\"head\":\"{owner}:{self.working_branch}\"'
		base = f'\"base\":\"{branch}\"'
		message = f'\n	{title},\n	{body},\n	{head},\n	{base}\n'
		url = f'https://api.github.com/repos/{self.github_repo}/pulls'
		payload = "{"+message+"}"
		headers = {
			'Authorization': 'Bearer ' + self.github_token,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data=payload)
		return response

	def _update_pr_assignees_correct_html(self, pr_number, assignees_owner):
		url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}'
		assignees = f'\"assignees\":[\"{assignees_owner}\"]'
		labels = f'\"labels\":[\"CI\", \"Correct HTML\"]'
		payload = "{\r\n" + assignees + ",\r\n" + labels + "\r\n}"
		headers = {
			'Authorization': 'Bearer ' + self.github_token,
			'Content-Type': 'application/json'
		}
		response = requests.request("PATCH", url, headers=headers, data=payload)
		print(response.text.encode('utf8'))
		print("User " + assignees_owner + " assignee to pull request Number " + str(pr_number))

	def _update_pr_assignees_IPBSA_Merge(self, pr_number, assignees_owner):
		url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}'
		assignees = f'\"assignees\":[\"{assignees_owner}\"]'
		labels = f'\"labels\":[\"CI\", \"IBPSA_Merge\"]'
		payload = "{\r\n" + assignees + ",\r\n" + labels + "\r\n}"
		headers = {
		  'Authorization': 'Bearer ' + self.github_token,
		  'Content-Type': 'application/json'
		}
		response = requests.request("PATCH", url, headers=headers, data=payload)
		print(f'User {assignees_owner} assignee to pull request Number {str(pr_number)}')


	def _post_comment_regression(self, pr_number, page_url):
		url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}/comments'
		message = f'Errors in regression test. Compare the results on the following page\\n {page_url} \\n \\n To only check reference results, push your new changes by commiting \\n git commit -m "ci_regression_test" # Start the regression test [only as pull_request] \\n \\n To update the reference results, add the models to the file bin/08_interact_CI/update_ref.txt and commit using \\n git commit -m "ci_update_ref"'
		body = f'\"body\":\"{message}\"'
		payload = "{"+body+"}"
		headers = {
			'Authorization': 'Bearer ' + self.github_token,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data=payload)
		print(response.text)

	def _post_comment_show_plots(self, pr_number, page_url):
		url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}/comments'
		message = f'Reference results have been displayed graphically and are created under the following page {page_url}'
		payload = "{\"body\":\"" + message + "\"}"
		headers = {
			'Authorization': 'Bearer ' + self.github_token,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data=payload)
		print(response.text)


if  __name__ == '__main__':
	parser = argparse.ArgumentParser(description="Set Github Environment Variables")  # Configure the argument parser
	check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
	check_test_group.add_argument("-CB", "--correct-branch", default ="${Newbranch}", help="Branch to correct your Code")
	check_test_group.add_argument("-GR", "--github-repo", default="RWTH-EBC/AixLib", help="Environment Variable owner/RepositoryName" )
	check_test_group.add_argument('-WB', "--working-branch", default="${TARGET_BRANCH}", help="Your current working Branch")
	check_test_group.add_argument("--base-branch", default="master",
								  help="your base branch (master or develpment)")
	check_test_group.add_argument('-GT', "--github-token", default="${GITHUB_API_TOKEN}", help="Your Set GITHUB Token")
	check_test_group.add_argument("--prepare-plot", help="Plot new models with new created reference files", action="store_true")
	check_test_group.add_argument("--show-plot", help="Plot new models with new created reference files",
								  action="store_true")
	check_test_group.add_argument("--post-pr-comment", help="Plot new models with new created reference files",
								  action="store_true")
	check_test_group.add_argument("--create-pr", help="Plot new models with new created reference files",
								  action="store_true")
	check_test_group.add_argument("--correct-html", help="Plot new models with new created reference files",
								  action="store_true")
	check_test_group.add_argument("--ibpsa-merge", help="Plot new models with new created reference files",
								  action="store_true")
	check_test_group.add_argument("--merge-request", help="Comment for a IBPSA Merge request",  action="store_true")
	check_test_group.add_argument('-GP', "--gitlab-page", default="${GITLAB_Page}", help="Set your gitlab page url")
	args = parser.parse_args()  # Parse the arguments

	from api_github import GET_API_GITHUB
	from api_github import PULL_REQUEST_GITHUB

	if args.post_pr_comment is True:
		get_api = GET_API_GITHUB(github_repo=args.github_repo, working_branch=args.working_branch)
		pr_number = get_api._get_pr_number()
		print(f'Setting pull request number: {pr_number}')
		page_url = f'{args.gitlab_page}/{args.working_branch}/plots'
		print(f'Setting gitlab page url: {page_url}')
		pull_request = PULL_REQUEST_GITHUB(github_repo=args.github_repo, working_branch=args.working_branch,
										   github_token=args.github_token)
		if args.prepare_plot is True:
			pull_request._post_comment_regression(pr_number, page_url)
		if args.show_plot is True:
			pull_request._post_comment_show_plots(pr_number, page_url)
	if args.create_pr is True:
		if args.correct_html is True:
			pull_request = PULL_REQUEST_GITHUB(github_repo=args.github_repo, working_branch=args.working_branch,
											   github_token=args.github_token)
			get_api = GET_API_GITHUB(github_repo=args.github_repo, working_branch=args.working_branch)
			owner = get_api.return_owner()
			pr_response = pull_request._post_pr_correct_html(owner)
			time.sleep(3)
			pr_number = get_api._get_pr_number()
			print(f'Setting pull request number: {pr_number}')
			assignees_owner = get_api._get_github_username()
			if assignees_owner is not None:
				print(f'Setting login name: {assignees_owner}')
			else:
				assignees_owner = "ebc-aixlib-bot"
				print(f'Setting login name: {assignees_owner}')
			pull_request._update_pr_assignees_correct_html(pr_number, assignees_owner)
			exit(0)
		if args.ibpsa_merge is True:
			pull_request = PULL_REQUEST_GITHUB(github_repo=args.github_repo, working_branch=args.working_branch,
											   github_token=args.github_token)
			get_api = GET_API_GITHUB(github_repo=args.github_repo, working_branch=args.working_branch)
			owner = get_api.return_owner()
			base_branch = args.base_branch
			pr_response = pull_request._post_comment_IBPSA_merge(owner, base_branch)
			time.sleep(3)
			pr_number = get_api._get_pr_number()
			print(f'Setting pull request number: {pr_number}')
			assignees_owner = get_api._get_github_username()
			if assignees_owner is not None:
				print(f'Setting login name: {assignees_owner}')
			else:
				assignees_owner = "ebc-aixlib-bot"
				print(f'Setting login name: {assignees_owner}')
			pull_request._update_pr_assignees_IPBSA_Merge(pr_number, assignees_owner)
			exit(0)