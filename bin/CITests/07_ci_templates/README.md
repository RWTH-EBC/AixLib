## Create your own templates

### Created the templates interactively with queries 
 
Execute the `python bin/CITests/07_ci_templates/ci_templates.py` command in the root directory of your repository. 
The script will then ask you which tests and packages to check, adapting to your library. 

Also the variables in the `bin/CiTests/_config.py` should be checked before. 
Important are the variables `image_name` and `variable_main_list`. These must be adapted to the current repo. The settings are then stored under `bin\Setting\CI_setting.toml`. 

### Create templates based on the toml file

Before templates are to be created based on toml, the toml file must be created first. This is done with the command `python bin/CITests/07_ci_templates/ci_templates.py`.

Now changes can be made in the toml file.

If changes should be made in the settings, these can be made in the `bin\Setting\CI_setting.toml`. 
Then execute the command `python bin/CITests/07_ci_templates/ci_templates.py --setting`. 
The templates are recreated with the information from the toml file
