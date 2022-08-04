
## CI commands and CI list

These lists should create a link between the CI and the user. If certain models are displayed graphically or certain reference files are created or updated, these are to be written into the files "show_ref.txt" or "update_ref.txt" line by line. 

show_ref : Lists all mentioned reference results graphically.  
update_ref : Updates the model and the whole package in which the model is located.

## Command list

- `git commit -m "ci_update_ref"` 			# Update referencefiles for all models that are added in file bin/08_interact_CI/update_ref.txt  
- `git commit -m "ci_show_ref"`	  			# plot all referencefiles that are added in file bin/08_interact_CI/show_ref.txt [only as pull_request]
- `git commit -m "ci_correct_html"`     	# CI bot message: correct html syntax
- `git commit -m "ci_create_whitelist"` 	# create a new whitelist for the model check
- `git commit -m "ci_create_html_whitelist"`# create a new html whitelist for the html check
- `git commit -m "ci_simulate"` 	  		# Simulate all examples
- `git commit -m "ci_check"` 		  		# Check all models
- `git commit -m "ci_regression_test"` 		# Start the regression test [only as pull_request]
- `git commit -m "ci_html"` 				# Test only the html of models


## Create yaml templates
`python bin/CITests/07_ci_templates/ci_templates.py`

## Create yaml templates from toml file 
`python bin/CITests/07_ci_templates/ci_templates.py --setting`

## Check files and paths in _config.py
`python bin/CITests/01_CleanUp/setting_check.py`
