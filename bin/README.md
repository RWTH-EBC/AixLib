# Here you find the Documentation für CI Tests with AixLib
## What is CI?

Continuous integration is a term from software development that describes the process of continuously assembling components to form an application. 
The goal of continuous integration is to increase software quality.
Typical actions are translating and linking the application parts, but in principle any other operations to generate derived information are performed. 
Usually, not only the entire system is rebuilt, but also automated tests are performed and software metrics are created to measure software quality. 
The whole process is automatically triggered by checking into the version control system.


## CI commands and ci [lists](08_interact_CI)

- `git commit -m "ci_update_ref"` 			# Update referencefiles for all models that are added in file bin/08_interact_CI/update_ref.txt  
- `git commit -m "ci_show_ref"`	  			# plot all referencefiles that are added in file bin/08_interact_CI/show_ref.txt [only as pull_request]
- `git commit -m "ci_correct_html"`     	# CI bot message: correct html syntax
- `git commit -m "ci_create_whitelist"` 	# create a new whitelist for the model check
- `git commit -m "ci_create_html_whitelist"`# create a new html whitelist for the html check
- `git commit -m "ci_simulate"` 	  		# Simulate all examples
- `git commit -m "ci_check"` 		  		# Check all models
- `git commit -m "ci_regression_test"` 		# Start the regression test [only as pull_request]
- `git commit -m "ci_html"` 				# Test only the html of models

## Libraries that need to be installed
`pip install mako pandas toml matplotlib argparse`
  

## What CI Tests are implement?
#### Check, Simulate and Regressiontest: [UnitTests](02_CITests/02_UnitTests)

With these tests, models are validated or simulated or models will  compared and evaluated with stored values by means of a unit test.

#### Correct HTML and Style Check: [SyntaxTest](02_CITests/03_SyntaxTests)

The html code (documentation) is tested and corrected if necessary. Thus the deposited HTML code is checked for correctness and corrected.

With the ModelManagement library in dymola the style of the models is checked. 

#### IBPSA Merge(02_CITests/06_deploy/IBPSA_Merge)
This template performs an automatic IBPSA merge into AixLib. The models of the IBPSA are copied into the AixLib, a new conversion script is created based on the IBPSA and integrated into the AixLib as well as the whitelists are created.

## Folder 
The folder contains the subfolder 01_BaseFunction, 02_CITests, 03_ci_whitelist, 04_Documentation, 06_Configfiles, 07_templates, 08_interact_CI and 09_Setting. 

### 01_BaseFunction
This folder contains tests and functions that are builded for the CI Tests. 

### 02_CITests
This folder contains all CI tests for AixLib in GitLab with unitTests, syntaxTest and cleanUpScripts
For more information view this [CI Tests](02_CITests).

### 03_ci_whitelist
This folder contains models in [WhiteLists](03_ci_whitelist), which will not test in the CITests.

### 04_Documentation
This folder contains [documentation](04_Documentation) for CI, e.g. how new tests can be integrated or relevant commands for the CI 

### 06_Configfiles

This folder contains [Config files](06_Configfiles) which are used for the CI. 

### 07_templates
This folder contains [Templates](07_templates/03_ci_templates) for the CI tests implemented so far. The following example can be used to implement the tests in the CI. 
			
		image: registry.git.rwth-aachen.de/ebc/ebc_intern/dymola-docker:miniconda-latest
		stages:
			- check_setting
			- build_templates
			- Ref_Check
			- build
			- HTML_Check
			- IBPSA_Merge
			- create_html_whitelist
			- Update_WhiteList
			- Release
			- StyleCheck
			- check
			- openMR
			- post
			- create_whitelist
			- simulate
			- RegressionTest
			- Update_Ref
			- plot_ref
			- prepare
			- deploy
		variables:
			Github_Repository: RWTH-EBC/AixLib
			GITLAB_Page: https://ebc.pages.rwth-aachen.de/EBC_all/github_ci/AixLib
		include:
			- 'bin/07_templates/03_ci_templates/01_deploy/gitlab_pages.gitlab-ci.yml'  
			- 'bin/07_templates/03_ci_templates/01_deploy/IBPSA_Merge.gitlab-ci.yml'  
			- 'bin/07_templates/03_ci_templates/02_UnitTests/check_model.gitlab-ci.yml'  
			- 'bin/07_templates/03_ci_templates/02_UnitTests/regression_test.gitlab-ci.yml'  
			- 'bin/07_templates/03_ci_templates/02_UnitTests/simulate_model.gitlab-ci.yml'  
			- 'bin/07_templates/03_ci_templates/03_SyntaxTest/html_check.gitlab-ci.yml'  
			- 'bin/07_templates/03_ci_templates/03_SyntaxTest/style_check.gitlab-ci.yml' 
			- 'bin/07_templates/03_ci_templates/04_CleanUpScript/ci_setting.gitlab-ci.yml'

### [08_interact_CI](08_interact_CI)

This folder is contains CI commands. 

`show_ref.txt`: If certain models are visualized on the basis of the reference files, these must be entered line by line in the text file show_ref.txt. Afterwards the file must be pushed with the command `git commit -m "ci_show_ref"`
 
`update_ref.txt`: If the reference files are to be updated for certain models, the reference files must be entered line by line in the text file update_ref.txt. Afterwards the file must be pushed with the CI commands command `git commit -m "ci_update_ref"`

### [09_Setting](09_Setting)

This folder contains settings for the CI. The CI_setting.toml file contains the variables for the CI. Changes can be made in the toml file. The templates are then updated with the command `python bin/02_CITests/07_ci_templates/ci_templates.py --setting`.
