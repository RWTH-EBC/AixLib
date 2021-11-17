
## CI commands and CI list

These lists should create a link between the CI and the user. If certain models are displayed graphically or certain reference files are created or updated, these are to be written into the files "show_ref.txt" or "update_ref.txt" line by line. 

show_ref : Lists all mentioned reference results graphically.  
update_ref : Updates the model and the whole package in which the model is located.

## Command list
- update_ref_commit = "ci_update_ref" # Update referencefiles for all models in file  bin/08_interact_CI/update_ref.txt y [immer]
- show_ref_commit = "ci_show_ref"	# plot all referencifiles in file bin/08_interact_CI/show_ref.txt [nur pull_request]
- dif_ref_commit = "ci_dif_ref" [nicht implementiert]
- html_commit = "ci_correct_html"  y
- create_wh_commit = "ci_create_whitelist" y
- create_html_wh_commit = "ci_create_html_whitelist"  y
- simulate_commit = "ci_simulate" y
- check_commit = "ci_check" y
- regression_test_commit = "ci_regression_test" [nur als pull_request] y
- ci_html_commit = "ci_html" y


## Create yaml templates
- python bin/02_CITests/07_ci_templates/ci_templates.py
## Check files and paths in _config.py
- python bin/02_CITests/01_CleanUp/setting_check.py

- CI_Regressiontest xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y
- CI_create_plots xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y


- Regressiontest_job
- Regression_overall_coverage
- prepare_create_plots
- Regressiontest_changed_Job
- Changed_create_plots
- RegressionTest_Check_References
- Update_Regression_Results xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 
- plot_reference_results xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 

- check_model_job
- check_changed_models_job
- CI_check_model_job xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 
- whitelist_job xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 

- CI_simulate_model_job xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 
- simulate_model_job
- simulate_changed_models_job

- trigger_check_HTML
- HTML_Merge_Checks
- HTML_Check
- CI_HTML_Check
- Open_Pull_Request
- htmL_whitelist_job  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 


- Style_Check_AixLib
- Style_Check_ChangedModel

- IBPSA 	 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 
- WhiteList	 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 
- IBPSA_Pull_Request	 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 

- pages	 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx y 