## Create your own templates

Execute the `python bin/02_CITests/07_ci_templates/ci_templates.py` command in the root directory of your repository. 
The script will then ask you which tests and packages to check, adapting to your library. 
Also the variables in the `bin\02_CiTests\_config.py` should be checked before. 
Important are the variables `image_name` and `variable_main_list`. These must be adapted to the current repo. The settings are then stored under `bin\09_Setting\CI_setting.toml`. 
If changes should be made in the settings, these can be made in the toml file. 
Then the command `python bin/02_CITests/07_ci_templates/ci_templates.py --setting` must be executed. 

