## What is it?
This config files are neccessary for gitlab CI.
## What is implemented?
### AutoMergeRequest.sh 
This file is used for the automatic creation of a merge request. 
After the tests have been successfully completed, a Merge Request is automatically generated and the user can manually merge into his current branch. 

	Open_Merge_Request:
		stage: openMR
		only:
			- /^feature\/*/
		services:
			-  docker
		before_script:
			- sudo apt-get install jq -y
		script:
		   - sudo chmod +x bin/06_Configfiles/autoMergeRequest.sh
		   - git config --global user.email "${GITLAB_USER_EMAIL}"
		   - git config --global user.name  "${GITLAB_USER_NAME}" 
		   - bin/06_Configfiles/autoMergeRequest.sh
		  
		only: 
		   variables:
			- $CI_COMMIT_MESSAGE =~ /Correct HTML Code/
            - $CI_COMMIT_MESSAGE =~ /Correct HTML Code again/
 




### exit.sh
This file contains only the content exit 0 or exit 1, which is rewritten with the HTML check on each pass. 

Hereby the CI automatically determines whether a new branch must be created to correct the incorrect HTML code, which can later be merged back into the original branch. 

### checkVariables.sh
This file check if all neccessary variables are sets and include the following variables
	
	- $GL_TOKEN
	- $GITHUB_API_TOKEN
	- $Github_Repository
	- $GITHUB_PRIVATE_KEY


## What is done?
- create a GitLab merge request via command line
- Create a new branch in after_script