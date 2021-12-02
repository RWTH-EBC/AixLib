## What is it?
In this folder are the Whitelist for the CI Tests. 

## What is implemented? 

#### html_whitelist.txt
This list contains all IBPSA models. These models will not test with HTML check.
In order to keep the whitelist up to date, it should be rewritten regularly. 

Use the following command:

`python bin/02_CITests/03_SyntaxTests/html_tidy_errors.py --WhiteList --git-url https://github.com/ibpsa/modelica-ibpsa.git --wh-library IBPSA`		

#### model_whitelist.txt
This list contains all IBPSA models that have not passed the check test. These are therefore not taken into account during the check. 

Use the following command:

`python bin/02_CITests/02_UnitTests/CheckPackages/validatetest.py -DS 2020 --repo-dir IBPSA --git-url https://github.com/ibpsa/modelica-ibpsa.git  --library AixLib --wh-library IBPSA --whitelist`

### reference_check_whitelist.txt
Packages, that should be ignored when creating new reference files. 

## What is done?
- Clone the Repository and Write a Whitelist
- Push the Whitelist to the AixLib
