## What is it?
In this folder are the Whitelist for the CI Tests. 

## What is implemented? 

#### HTML_IBPSA_Whitelist.txt
This list contains all IBPSA models. These models will not test with HTML check.
In order to keep the whitelist up to date, it should be rewritten regularly. 

Use the following command:

	- python bin/02_CITests/SyntaxTests/html_tidy_errors.py --WhiteList

#### WhiteList_CheckModel.txt
This list contains all IBPSA models that have not passed the check test. These are therefore not taken into account during the check. 

Use the following command:

	- python bin/02_CITests/UnitTests/CheckPackages/validatetest.py .s AixLib -p AixLib/package.mo --WhiteList

## What is done?
- Clone the Repository and Write a Whitelist
- Push the Whitelist to the AixLib
