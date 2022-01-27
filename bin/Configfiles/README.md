## What is it?
This config files are neccessary for gitlab CI.
## What is implemented?


### exit.sh
This file contains only the content exit 0 or exit 1, which is rewritten with the HTML check on each pass. 

Hereby the CI automatically determines whether a new branch must be created to correct the incorrect HTML code, which can later be merged back into the original branch. 

### ci_changed_model_list.txt
List files that changed with the last push. 

### ci_difference_result.txt 
List reference files with difference results.

### ci_new_created_reference.txt
List new created/updated reference files by the CI.

### ci_reference_list.txt
List missing reference files. 



