:: Make sure you have everything installed as in the util scripts:
:: .activate_python_and_install_requirements
:: .custom_install_additional_modelica_libraries
:: .github_ssh_auth

python -m ModelicaPyCI.syntax.html_tidy --filter-whitelist-flag  --correct-view-flag  --log-flag  --whitelist-library IBPSA --library AixLib --packages Airflow BoundaryConditions Controls DataBase Fluid Media Systems ThermalZones Types Utilities 
python -m ModelicaPyCI.syntax.html_tidy --filter-whitelist-flag  --correct-view-flag  --log-flag  --whitelist-library IBPSA --library AixLib --packages Airflow BoundaryConditions Controls DataBase Fluid Media Systems ThermalZones Types Utilities 

python -m ModelicaPyCI.syntax.style_checking --dymola-version 2022 --library AixLib 
python -m ModelicaPyCI.syntax.style_checking --changed-flag  --dymola-version 2022 --library AixLib 

python -m ModelicaPyCI.syntax.naming_guideline --changed-flag  --gitlab-page https://ebc.pages.rwth-aachen.de/EBC_all/github_ci/AixLib --github-token ${GITHUB_API_TOKEN} --working-branch $CI_COMMIT_BRANCH --github-repository RWTH-EBC/AixLib --main-branch main --config bin/ci-tests/naming_guideline.config --library AixLib 

:: Check & Simulate AixLib Airflow on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Airflow
:: Check & Simulate AixLib Airflow on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Airflow
:: Check & Simulate AixLib BoundaryConditions on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages BoundaryConditions
:: Check & Simulate AixLib BoundaryConditions on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages BoundaryConditions
:: Check & Simulate AixLib Controls on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Controls
:: Check & Simulate AixLib Controls on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Controls
:: Check & Simulate AixLib DataBase on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages DataBase
:: Check & Simulate AixLib DataBase on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages DataBase
:: Check & Simulate AixLib Fluid on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Fluid
:: Check & Simulate AixLib Fluid on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Fluid
:: Check & Simulate AixLib Media on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Media
:: Check & Simulate AixLib Media on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Media
:: Check & Simulate AixLib Systems on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Systems
:: Check & Simulate AixLib Systems on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Systems
:: Check & Simulate AixLib ThermalZones on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages ThermalZones
:: Check & Simulate AixLib ThermalZones on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages ThermalZones
:: Check & Simulate AixLib Types on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Types
:: Check & Simulate AixLib Types on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Types
:: Check & Simulate AixLib Utilities on PR
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Utilities
:: Check & Simulate AixLib Utilities on push
python -m ModelicaPyCI.unittest.checkpackages.validatetest --dym-options DYM_SIM DYM_CHECK --changed-flag  --dymola-version 2022 --additional-libraries-to-load  --library AixLib  --packages Utilities
