import os

image_name = 'registry.git.rwth-aachen.de/ebc/ebc_intern/dymola-docker:miniconda-latest' # image_name
variable_main_list = ['Github_Repository: RWTH-EBC/AixLib', 'GITLAB_Page: https://ebc.pages.rwth-aachen.de/EBC_all/github_ci/AixLib']
base_branch = "development"


#[Whitelist files]
ch_file = f'bin{os.sep}Configfiles{os.sep}ci_changed_model_list.txt'
exit_file = f'bin{os.sep}Configfiles{os.sep}exit.sh'
eof_file = f'bin{os.sep}Configfiles{os.sep}EOF.sh'
new_ref_file = f'bin{os.sep}Configfiles{os.sep}ci_new_created_reference.txt'
ref_file = f'bin{os.sep}Configfiles{os.sep}ci_reference_list.txt'

artifacts_dir = f'bin{os.sep}templates{os.sep}04_artifacts'
wh_file = f'bin{os.sep}ci_whitelist{os.sep}model_whitelist.txt'
ref_whitelist_file = f'bin{os.sep}ci_whitelist{os.sep}reference_check_whitelist.txt'
html_wh_file = f'bin{os.sep}ci_whitelist{os.sep}html_whitelist.txt'
show_ref_file = f'bin{os.sep}interact_CI{os.sep}show_ref.txt'
update_ref_file = f'bin{os.sep}interact_CI{os.sep}update_ref.txt'

# Ci Templates
reg_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}02_UnitTests{os.sep}regression_test.txt'
write_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}02_UnitTests{os.sep}check_model.txt'
sim_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}02_UnitTests{os.sep}simulate_model.txt'
page_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}01_deploy{os.sep}gitlab_pages.txt'
ibpsa_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}01_deploy{os.sep}IBPSA_Merge.txt'
style_check_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}03_SyntaxTest{os.sep}style_check.txt'
html_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}03_SyntaxTest{os.sep}html_check.txt'
main_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}gitlab-ci.txt'
setting_temp_file = f'bin{os.sep}templates{os.sep}03_ci_templates{os.sep}04_CleanUpScript{os.sep}ci_setting.txt'
main_yml_file = f'.gitlab-ci.yml'

temp_dir = f'bin{os.sep}templates{os.sep}03_ci_templates'

# Charts
chart_temp_file = f'bin{os.sep}templates{os.sep}01_google_templates{os.sep}google_chart.txt'
index_temp_file = f'bin{os.sep}templates{os.sep}01_google_templates{os.sep}index.txt'
layout_temp_file = f'bin{os.sep}templates{os.sep}01_google_templates{os.sep}layout_index.txt'

chart_dir = f'bin{os.sep}templates{os.sep}02_charts'

# Reference files
ref_file_dir = f'Resources{os.sep}ReferenceResults{os.sep}Dymola'
resource_dir = f'Resources{os.sep}Scripts{os.sep}Dymola'

# Setting file
setting_file = f'bin{os.sep}Setting{os.sep}CI_setting_template.txt'


stage_list = ["check_setting", "build_templates", "Ref_Check", "build", "HTML_Check", "IBPSA_Merge", "create_html_whitelist", "Update_WhiteList", "Release", "StyleCheck", "check", "openMR", "post", "create_whitelist", "simulate", "RegressionTest", "Update_Ref", "plot_ref", "prepare", "deploy"]


gitlab_ci_variables = ["GITHUB_API_TOKEN", "GITHUB_PRIVATE_KEY", "GL_TOKEN"]  # Set these Token with this name in your gitlab ci under CI/Variables



