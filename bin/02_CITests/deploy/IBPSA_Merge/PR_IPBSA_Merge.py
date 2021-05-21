import requests
import json
import argparse
import os
import sys 


class GET_API_GITHUB(object):

	def  __init__(self,Correct_Branch,GITHUB_REPOSITORY, Working_Branch):
		self.GITHUB_REPOSITORY = GITHUB_REPOSITORY
		self.Correct_Branch = Correct_Branch
		self.Working_Branch = Working_Branch

	def jprint(self):
		# create a formatted string of the Python JSON object
		text = json.dumps(obj, sort_keys=True, indent=4)
		print(type(text))
		print(text)

	def get_GitHub_Username(self):
		url = "https://api.github.com/repos/"+self.GITHUB_REPOSITORY+"/branches/"+self.Correct_Branch
		print(url)
		payload = {}
		headers= {}

		response = requests.request("GET", url, headers=headers, data = payload)
		print(response)
		branch = response.json()
		print(branch)
		commit = branch["commit"]
		author = commit["author"]
		login = author["login"]
		return login

	def return_owner(self):
		owner = self.GITHUB_REPOSITORY
		owner = owner.split("/")
		print(owner[0])
		return owner[0]	
		
class PULL_REQUEST_GITHUB(object):
	
	def  __init__(self,Correct_Branch,GITHUB_REPOSITORY, Working_Branch, OWNER,  GITHUB_TOKEN):
		self.GITHUB_REPOSITORY = GITHUB_REPOSITORY
		self.Correct_Branch = Correct_Branch
		self.Working_Branch = Working_Branch
		self.GITHUB_TOKEN = GITHUB_TOKEN
		self.OWNER = OWNER
	
	def post_pull_request(self):
		
		url = "https://api.github.com/repos/"+self.GITHUB_REPOSITORY+"/pulls"
		payload = '{\n    \"title\": \"IBPSA Merge '+self.Working_Branch+'\",\n    \"body\": \"###Following you will find the instructions for the IBPSA merge:\n  1. Please pull this branch IBPSA_Merge to your local repository.\n 2. As an additional saftey check please open the AixLib library in dymola and check whether errors due to false package orders may have occurred. You do not need to translate the whole library or simulate any models. This was already done by the CI.\n    3. If you need to fix bugs or perform changes to the models of the AixLib, push these changes using this commit message to prevent to run the automatic IBPSA merge again: **`fix errors manually`**. \n  4. You can also output the different reference files between the IBPSA and the AixLib using the CI or perform an automatic update of the referent files which lead to problems. To do this, use one of the following commit messages \n  **`Trigger CI - give different reference results`** \n * **`Trigger CI - Update reference results`** \n The CI outputs the reference files as artifacts in GitLab. To find them go to the triggered pipeline git GitLab and find the artifacts as download on the right site. \n 5. If the tests in the CI have passed successfully, merge the branch IBPSA_Merge to development branch. **Delete** the Branch ' +self.Correct_Branch+ '\",\n    \"head\": \"'+self.OWNER+':'+self.Correct_Branch+'\",\n    \"base\": \"'+self.Working_Branch+'\"\n  \n}'
		headers = {
			'Authorization': 'Bearer '+self.GITHUB_TOKEN,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data = payload)
		print(response.text.encode('utf8'))
		return response

		
	def get_pull_request_number(self, pull_request_response):
		pull_request_number = pull_request_response.json()
		pull_request_number = pull_request_number["number"]
		print(pull_request_number)
		return pull_request_number
	
	
	def update_pull_request_assignees(self,pull_request_number,assignees_owner):
		
		url = "https://api.github.com/repos/"+self.GITHUB_REPOSITORY+"/issues/"+str(pull_request_number)

		payload = '{ \"assignees\": [\r\n    \"'+assignees_owner+'\"\r\n  ],\r\n    \"labels\": [\r\n    \"CI\", \r\n    \"IBPSA_Merge\"\r\n    \r\n  ]\r\n}'
		
		headers = {
		  'Authorization': 'Bearer '+self.GITHUB_TOKEN,
		  'Content-Type': 'application/json'
		}

		response = requests.request("PATCH", url, headers=headers, data = payload)

		print("User "+assignees_owner+" assignee to pull request Number "+str(pull_request_number))

	

	


if  __name__ == '__main__':
	# GITHUB_REPOSITORY
	# python api.py --GITHUB-REPOSITORY SvenHinrichs/GitLabCI --Working-Branch master
	"""Parser"""
	# Configure the argument parser
	parser = argparse.ArgumentParser(description = "Set Github Environment Variables")
	check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
	check_test_group.add_argument("-CB", "--Correct-Branch", default ="${Newbranch}", help="Branch to correct your Code")
	check_test_group.add_argument("-GR", "--GITHUB-REPOSITORY", default="RWTH-EBC/AixLib", help="Environment Variable owner/RepositoryName" )
	check_test_group.add_argument('-WB',"--Working-Branch",default="${TARGET_BRANCH}", help="Your current working Branch")
	check_test_group.add_argument('-GT',"--GITHUB-TOKEN",default="${GITHUB_API_TOKEN}", help="Your Set GITHUB Token")
	
	# Parse the arguments
	args = parser.parse_args()
	
	
	GET_API_DATA = GET_API_GITHUB(GITHUB_REPOSITORY = args.GITHUB_REPOSITORY, Correct_Branch = args.Correct_Branch, Working_Branch = args.Working_Branch)
	owner = GET_API_DATA.return_owner()
	#print("USERNAME is "+ Username)
	#sys.stdout.write(Username)
	#sys.exit(0)					
	
	PULL_REQUEST = PULL_REQUEST_GITHUB(GITHUB_REPOSITORY = args.GITHUB_REPOSITORY, Correct_Branch = args.Correct_Branch, Working_Branch = args.Working_Branch, GITHUB_TOKEN = args.GITHUB_TOKEN, OWNER = owner)
	pull_request_response = PULL_REQUEST.post_pull_request()
	pull_request_number = PULL_REQUEST.get_pull_request_number(pull_request_response)
	
	assignees_owner = GET_API_DATA.get_GitHub_Username()
	PULL_REQUEST.update_pull_request_assignees(pull_request_number,assignees_owner)
	print("Pull Request")
	exit(0)
	
