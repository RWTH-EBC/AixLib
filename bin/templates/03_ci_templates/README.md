## How to create your own gitlab CI [templates](../../CITests/07_ci_templates)

Execute the `python bin/CITests/07_ci_templates/ci_templates.py` command in the root directory of your repository

Also the variables in the `bin/CITests/_config.py` should be checked before. Important are the variables `image_name` and `variable_main_list`.

The settings are then stored under `bin/Setting/CI_setting.toml`

Then the command `python bin/CITests/07_ci_templates/ci_templates.py --setting` must be executed.

## Libraries that need to be installed
`pip install mako pandas toml matplotlib argparse`