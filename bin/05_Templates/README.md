## What is it?
The folder contains the following templates:

	- check_model.gitlab-ci.yml: Checkt die Modelle 
	- check_simulate.gitlab-ci.yml: Simuliert die Modelle 
	- regression_test.gitlab-ci.yml Regression Test der Modelle
	- html_check.gitlab-ci.yml: HTML und Korrektur des Modelica Code der AixLib
	- style_check.gitlab-ci.yml: Check des Style der AixLib

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
		- file: 'bin/05_Templates/check_model.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'bin/05_Templates/check_simulate.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'bin/05_Templates/regression_test.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'bin/05_Templates/html_check.gitlab-ci.yml'
		- project: 'EBC/EBC_all/gitlab_ci/templates'
		- file: 'bin/05_Templates/style_check.gitlab-ci.yml'

## What is done?
- Simulate and check models
- Regressiontest
- Check and correct the html code
- Check the style of the models in AixLib
