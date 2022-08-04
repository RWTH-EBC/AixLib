# What is it?
### setting_check

Checks if all necessary variables and files are set or exist.
The test is performed by the commit `git commit -m "ci_setting"`.
# How to implement?
	image: registry.git.rwth-aachen.de/ebc/ebc_intern/dymola-docker:miniconda-latest
	stages:
		- check_setting
	include:
		- 'bin/templates/03_ci_templates/04_CleanUpScript/ci_setting.gitlab-ci.yml'  




