## What is it?
The folder contains the following templates:

	- check_model.gitlab-ci.yml: check models 
	- check_simulate.gitlab-ci.yml: simulate models 
	- regression_test.gitlab-ci.yml regression test 
	- html_check.gitlab-ci.yml: html check and overwrite the corrected html code
	- style_check.gitlab-ci.yml:  style check of modelica models

The templates are in [Repository](https://git.rwth-aachen.de/EBC/EBC_all/gitlab_ci/templates) implemented.
## What is implemented? 
Add the following lines to your gitlab.ci.yml:
 
```
#!/bin/bash
image: registry.git.rwth-aachen.de/ebc/ebc_intern/dymola-docker:miniconda-latest

stages:
    - deleteBranch
    - SetSettings
    - CheckSettings
    - build
    - HTMLCheck
    - deploy
    - openMR
    - post
    - StyleCheck
    - Check
    - Simulate
    - RegressionTest
 
variables:
    Praefix_Branch: "Correct_HTML_"
    TARGET_BRANCH: $CI_COMMIT_REF_NAME
    Newbranch: ${Praefix_Branch}${CI_COMMIT_REF_NAME}
    StyleModel: AixLib.Airflow.Multizone.DoorDiscretizedOpen
    Github_Repository : RWTH-EBC/AixLib
    
include:
  - project: 'EBC/EBC_all/gitlab_ci/templates'
    file:  'modelica-ci-tests/CheckConfiguration/check_settings.gitlab-ci.yml'
  - project: 'EBC/EBC_all/gitlab_ci/templates'
    file:  'modelica-ci-tests/SyntaxTests/html_check.gitlab-ci.yml'
  - project: 'EBC/EBC_all/gitlab_ci/templates'
    file:  'modelica-ci-tests/SyntaxTests/style_check.gitlab-ci.yml'
  - project: 'EBC/EBC_all/gitlab_ci/templates'
    file: 'modelica-ci-tests/UnitTests/check_model.gitlab-ci.yml'
  - project: 'EBC/EBC_all/gitlab_ci/templates'
    file: 'modelica-ci-tests/UnitTests/regression_test.gitlac-ci.yml'
  - project: 'EBC/EBC_all/gitlab_ci/templates'
    file: 'modelica-ci-tests/UnitTests/simulate_model.gitlab-ci.yml'

```
## What is done?
- Simulate and check models
- Regressiontest
- Check and correct the html code
- Check the style of the models in AixLib
