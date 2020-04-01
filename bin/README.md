# Here you find the Documentation für CI Tests with AixLib
## What is CI?

Continuous integration is a term from software development that describes the process of continuously assembling components to form an application. 
The goal of continuous integration is to increase software quality.
Typical actions are translating and linking the application parts, but in principle any other operations to generate derived information are performed. 
Usually, not only the entire system is rebuilt, but also automated tests are performed and software metrics are created to measure software quality. 
The whole process is automatically triggered by checking into the version control system.

### How we use CI?
In our case we mirror a github repository in GitLab. This way the repository can be tested and corrected with the CI in Gitlab. 
We also use the Docker service to create an image containing Dymola and thus be able to simulate models in Dymola.

For more information read the [General Documentation](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/blob/master/bin/04_Documentation/Documentation_GitLab.md) and the Repository [Dymola-Docker](https://git.rwth-aachen.de/EBC/EBC_intern/dymola-docker)
![E.ON EBC RWTH Aachen University](04_Documentation/Images/GITLABCI.png)


## What CI Tests are implement?
#### Check, Simulate and Regressiontest: [UnitTests](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/02_CITests/UnitTests)

With these tests, models are validated or simulated or models will  compared and evaluated with stored values by means of a unit test.

#### Correct HTML and Style Check: [SyntaxTest](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/02_CITests/SyntaxTests)

The html code (documentation) is tested and corrected if necessary. Thus the deposited HTML code is checked for correctness and correct

With the ModelManagement library in dymola the style of the models is checked. 

#### Clean the Modelica [CleanUpSkripts](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/02_CITests/CleanUpSkripts)
Removes any files that were created when running simulations in Dymola, such as *.mat or dymola.log 

## Folder 
The folder contains the subfolder 01_BaseFunction, 02_CITests, 03_Whitelists, 04_Documentation, 05_Templates and 06_Configfiles. 

### 1 BaseFunction
This folder contains tests and functions that are builded for the CI Tests. 

### 2 CITests
This folder contains all CI tests for AixLib in GitLab with unitTests, syntaxTest and cleanUpScripts
For more information view this [CI Tests](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/02_CITests).

### 3 WhiteLists
This folder contains models in [WhiteLists](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/03_WhiteLists), which will not test in the CITests.


### 4 Documentation
This folder contains [documentation](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/04_Documentation) for CI, e.g. how new tests can be integrated or relevant commands for the CI 

### 5 Templates
This folder contains [Templates](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/05_Templates) for the CI tests implemented so far. The following example can be used to implement the tests in the CI. 



	#!/bin/bash
	image: registry.git.rwth-aachen.de/ebc/ebc_intern/dymola-docker:miniconda-latest
	
	stages:
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
		TARGET_BRANCH: master
		Newbranch: "Correct_HTML_$TARGET_BRANCH"
		StyleModel: AixLib.Airflow.Multizone.DoorDiscretizedOpen
	
	

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
		

The templates are also implemented under the following repository [Templates](https://git.rwth-aachen.de/EBC/EBC_all/gitlab_ci/templates)

### 6 Configfiles

This folder contains [Config files](https://git.rwth-aachen.de/sven.hinrichs/GitLabCI/tree/master/bin/06_Configfiles) which are used for the CI. 

For question ask [Sven Hinrichs](https://git.rwth-aachen.de/sven.hinrichs)

# How Configure the CI Tests

## Configure Variables

### Protected Branches: 
Wildcards "issue *": Will push all branches to Github with the namespace issue* . This is necessaryto push the corrected code to the Github 
repository.

### TARGET-Branches: 
Your current working branch. 

### StyleModel:

This variable is necessary for the StyleCheck und will check the Style of a modelica model (e.g. "StyleModel: AixLib.Airflow.Multizone.DoorDiscretizedOpen")


### Push - Mirroring
All protected branches in gitlab will push to github. This included all branches with namespace *issue. 

### Pull - Mirroring 
Pull all branches from github to gitlab. 

### GITHUB_API_TOKEN

### GL_TOKEN

## Test CI Setting
To test if all necessary variables are set push your Code with the commit "Check Settings". 




# To Do

- Add Gitlab Page
- Slack Notification in case of merge request in gitlab
- Add a gitlab bot
- Add $GL_Token
- Add label CI and fix HTML code
- Add Wildcard for protected branches with issue*