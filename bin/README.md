# Here you find the Documentation für CI Tests with AixLib
## What is CI?

Continuous integration is a term from software development that describes the process of continuously assembling components to form an application. 
The goal of continuous integration is to increase software quality.
Typical actions are translating and linking the application parts, but in principle any other operations to generate derived information are performed. 
Usually, not only the entire system is rebuilt, but also automated tests are performed and software metrics are created to measure software quality. 
The whole process is automatically triggered by checking into the version control system.


## CI commands and ci [lists](interact_CI)

- `git commit -m "ci_update_ref"` 			# Update referencefiles for all models that are added in file bin/interact_CI/update_ref.txt  
- `git commit -m "ci_show_ref"`	  			# plot all referencefiles that are added in file bin/interact_CI/show_ref.txt [only as pull_request]
- `git commit -m "ci_create_whitelist"` 	# create a new whitelist for the model check
- `git commit -m "ci_create_html_whitelist"`# create a new html whitelist for the html check
- `git commit -m "ci_simulate"` 	  		# Simulate all examples
- `git commit -m "ci_check"` 		  		# Check all models
- `git commit -m "ci_regression_test"` 		# Start the regression test [only as pull_request]
- `git commit -m "ci_html"` 				# Test only the html of models
- `git commit -m " [skip ci]"` 				# Skip the CI

## [Create your own templates](https://git.rwth-aachen.de/EBC/EBC_all/gitlab_ci/templates)

1. Copy the content of the folder modelica-ci-tests into your repo under the folder "bin/".
2. Execute the `python bin/CITests/07_ci_templates/ci_templates.py` command in the root directory of your repository. Also the variables in the `bin/CITests/_config.py` should be checked before. Important are the variables `image_name` and `variable_main_list`.
3. Now the templates should have been created with the main yaml file in your folder
4. The environment variables "GITHUB_API_TOKEN", "GITHUB_PRIVATE_KEY" and  must be set under Setting/CICD/Variables. For testing the push command `git commit -m "ci_setting"` can be used.
5. If changes are made to the templates (for example, an additional package is to be tested), these can be added to the `bin\Setting\CI_setting.toml` file. Then execute the command `python bin/CITests/07_ci_templates/ci_templates.py --setting`.

## What CI Tests are implement?
#### Check, Simulate and Regressiontest: [UnitTests](CITests/02_UnitTests)

With these tests, models are validated or simulated or models will  compared and evaluated with stored values by means of a unit test.

#### Correct HTML and Style Check: [SyntaxTest](CITests/03_SyntaxTests)

The html code (documentation) is tested and corrected if necessary. Thus the deposited HTML code is checked for correctness and corrected.

With the ModelManagement library in dymola the style of the models is checked. 

#### [IBPSA Merge](CITests/06_deploy/IBPSA_Merge)
This template performs an automatic IBPSA merge into AixLib. The models of the IBPSA are copied into the AixLib, a new conversion script is created based on the IBPSA and integrated into the AixLib as well as the whitelists are created.

## Folder 
The folder contains the subfolder CITests, ci_whitelist,  Configfiles, templates, interact_CI and Setting. 

### CITests
This folder contains all CI tests for AixLib in GitLab with unitTests, syntaxTest and cleanUpScripts
For more information view this [CI Tests](CITests).

### ci_whitelist
This folder contains models in [WhiteLists](ci_whitelist), which will not test in the CITests.


### Configfiles

This folder contains [Config files](Configfiles) which are used for the CI. 

### templates
This folder contains [Templates](templates/03_ci_templates) for the CI tests implemented so far. The following example can be used to implement the tests in the CI. 
			
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
			- 'bin/templates/03_ci_templates/01_deploy/gitlab_pages.gitlab-ci.yml'  
			- 'bin/templates/03_ci_templates/01_deploy/IBPSA_Merge.gitlab-ci.yml'  
			- 'bin/templates/03_ci_templates/02_UnitTests/check_model.gitlab-ci.yml'  
			- 'bin/templates/03_ci_templates/02_UnitTests/regression_test.gitlab-ci.yml'  
			- 'bin/templates/03_ci_templates/02_UnitTests/simulate_model.gitlab-ci.yml'  
			- 'bin/templates/03_ci_templates/03_SyntaxTest/html_check.gitlab-ci.yml'  
			- 'bin/templates/03_ci_templates/03_SyntaxTest/style_check.gitlab-ci.yml' 
			- 'bin/templates/03_ci_templates/04_CleanUpScript/ci_setting.gitlab-ci.yml'

### [interact_CI](interact_CI)

This folder is contains CI commands. 

`show_ref.txt`: If certain models are visualized on the basis of the reference files, these must be entered line by line in the text file show_ref.txt. Afterwards the file must be pushed with the command `git commit -m "ci_show_ref"`
 
`update_ref.txt`: If the reference files are to be updated for certain models, the reference files must be entered line by line in the text file update_ref.txt. Afterwards the file must be pushed with the CI commands command `git commit -m "ci_update_ref"`

### [Setting](Setting)

This folder contains settings for the CI. The CI_setting.toml file contains the variables for the CI. Changes can be made in the toml file. The templates are then updated with the command `python bin/CITests/07_ci_templates/ci_templates.py --setting`.
