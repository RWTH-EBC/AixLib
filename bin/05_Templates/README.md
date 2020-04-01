## What is it?
The folder contains the following templates:

	- check_model.gitlab-ci.yml: ceck models 
	- check_simulate.gitlab-ci.yml: simulate models 
	- regression_test.gitlab-ci.yml regression test 
	- html_check.gitlab-ci.yml: html check and overwrite the corrected html code
	- style_check.gitlab-ci.yml:  style check of modelica models

The templates are in this [Repository](https://git.rwth-aachen.de/EBC/EBC_all/gitlab_ci/templates) implemented.
## What is implemented? 
Add the following lines to your gitlab.ci.yml:
 

	#!/bin/bash
	image: registry.git.rwth-aachen.de/ebc/ebc_intern/dymola-docker:miniconda-latest

	stages:
		- build
		- HTMLCheck
		- openMR
		- deploy
		- StyleCheck
		- Check
		- Simulate
		- RegressionTest

	include:
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/CheckConfiguration/check_settings.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/SyntaxTests/html_check.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/SyntaxTests/style_check.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/UnitTests/check_model.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/UnitTests/regression_test.gitlac-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'ci-tests/UnitTests/simulate_model.gitlab-ci.yml'

## What is done?
- Simulate and check models
- Regressiontest
- Check and correct the html code
- Check the style of the models in AixLib
