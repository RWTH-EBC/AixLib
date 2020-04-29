import requests
import json
import argparse
import os
import sys 

#url = "https://api.github.com/repos/SvenHinrichs/GitLabCI/branches/master"

#url = "https://api.github.com/repos/RWTH-EBC/AixLib/branches/issue802_CleanCI_Infrastructure"
#url = "https://api.github.com/repos/RWTH-EBC/AixLib/branches/issue740_Release"



#response = requests.request("GET", url, headers=headers, data = payload)

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
		url = "https://api.github.com/repos/"+self.GITHUB_REPOSITORY+"/branches/"+self.Working_Branch
		payload = {}
		headers= {}

		response = requests.request("GET", url, headers=headers, data = payload)
		branch = response.json()
		commit = branch["commit"]
		author = commit["author"]
		login = author["login"]
		return login

class PULL_REQUEST_GITHUB(object):
	
	def  __init__(self,Correct_Branch,GITHUB_REPOSITORY, Working_Branch, GITHUB_USERNAME, GITHUB_TOKEN):
		self.GITHUB_REPOSITORY = GITHUB_REPOSITORY
		self.Correct_Branch = Correct_Branch
		self.Working_Branch = Working_Branch
		self.GITHUB_USERNAME = GITHUB_USERNAME
		self.GITHUB_TOKEN = GITHUB_TOKEN
	
	def post_pull_request(self):
		url = "https://api.github.com/repos/"+self.GITHUB_REPOSITORY+"/pulls"
		payload = '{\n    \"title\": \"Corrected HTML Code in branch '+self.Working_Branch+'\",\n    \"body\": \"Merge the corrected HTML Code. After confirm the pull request, **pull** your branch to your local repository.\n **Delete** the Branch ' +self.Correct_Branch+ '\",\n    \"head\": \"'+self.GITHUB_USERNAME+":"+self.Correct_Branch+'\",\n    \"base\": \"'+self.Working_Branch+'\"\n  \n}'
		
		headers = {
			'Authorization': 'Bearer '+self.GITHUB_TOKEN,
			'Content-Type': 'application/json'
		}
		response = requests.request("POST", url, headers=headers, data = payload)
		print(response.text.encode('utf8'))



	


if  __name__ == '__main__':
	#GITHUB_REPOSITORY
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
	Username = GET_API_DATA.get_GitHub_Username()
	#print("USERNAME is "+ Username)
	#sys.stdout.write(Username)
	#sys.exit(0)					
	
	PULL_REQUEST = PULL_REQUEST_GITHUB(GITHUB_REPOSITORY = args.GITHUB_REPOSITORY, Correct_Branch = args.Correct_Branch, Working_Branch = args.Working_Branch, GITHUB_TOKEN = args.GITHUB_TOKEN, GITHUB_USERNAME = Username)
	PULL_REQUEST.post_pull_request()
	print("Pull Request")
	exit(0)
	
