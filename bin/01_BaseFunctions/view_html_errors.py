#! /usr/bin/env python3.6
# -*- coding: utf-8 -*-
"""View errors in the HTML code of a Modelica .mo file

Created on Wed May 16 16:24:30 2018

@author: Peter Matthes

Most code is taken from [BuildingsPy's](https://github.com/lbl-srg/BuildingsPy/blob/master/buildingspy/development/validator.py)
validation class and [HTML-Tidy-Modelica](https://github.com/RWTH-EBC/HTML-Tidy-Modelica) 
scritpt.

The script will 

* collect all the HTML code (<html>...</html>) in the Modelica file and
* print out the original code with line numbers as well as 
* the tidy version of the code (with line numbers). 
* tidylib will look for errors and present the respective line numbers. 

You can then inspect the code and make corrections to your Modelica
file by hand. You might want to use the tidy version as produced by
tidylib.

Example
-------
You can use this script on the command line and point it
to your Modelica file::

    $ python viewHTMLerrors.py <file> [file [...]]

Note:
-----
    * This script uses Python 3.6 for printing syntax and
    function parameter annotations.
    * The script assumes that you have installed pytidylib
    
    `$ pip install pytidylib`
    
    * You also need to install the necessary dll's and
    your python interpreter must be able to find the files.
    In case of trouble just put the dll in your working dir.
    
    [http://binaries.html-tidy.org/](http://binaries.html-tidy.org/)
"""

import argparse
import os 

def getInfoRevisionsHTML(moFile):
    """Returns a list that contains the html code
    
    This function returns a list that contain the html code of the
    info and revision sections. Each element of the list
    is a string.
    
    Parameters
    ----------
    moFile : str
        The name of a Modelica source file.
    
    Returns
    -------
    list 
        The list of strings of the info and revisions section.
    """
    # Open file.
    with open(moFile, mode="r", encoding="utf-8-sig") as f:
        lines = f.readlines()

    nLin = len(lines)
    isTagClosed = True
    entries = list()

    for i in range(nLin):
        if isTagClosed:
			print(i)
			print(lines[i])
			print("loop")
            # search for opening tag
            idxO = lines[i].find("<html>")
            if idxO > -1:
                # search for closing tag on same line as opening tag
                idxC = lines[i].find("</html>")
                if idxC > -1:
                    entries.append(lines[i][idxO + 6:idxC]+'\n')
                    isTagClosed = True
                else:
                    entries.append(lines[i][idxO + 6:])
                    isTagClosed = False
        else:
            # search for closing tag
            idxC = lines[i].find("</html>")
            if idxC == -1:
                # closing tag not found, copy full line
                entries.append(lines[i])
            else:
                # found closing tag, copy beginning of line only
                entries.append(lines[i][0:idxC]+'\n')
                isTagClosed = True
                # entries.append("<h4>Revisions</h4>\n")
                # search for opening tag on same line as closing tag
                idxO = lines[i].find("<html>")
                if idxO > -1:
                    entries.append(lines[i][idxO + 6:])
                    isTagClosed = False
    return entries

def make_string_replacements(theString : str, 
                             substitutions_dict : dict = {'\\"': '"'}) -> str:
    """Takes a string and replaces according to a given dictionary
    
    Parameters
    ----------
    theString : str
        The string that contains replaceble text.
    substitutions_dict : dict
        A dictionary with key:value pairs for old and new text.
    
    Returns
    -------
    str 
        The modified string.
    """
    for k, v in substitutions_dict.items():
        theString = theString.replace(k, v)
    
    return theString

def join_body(htmlList : list, substitutions_dict : dict = {'\\"': '"'}) -> str:
    """Joins a list of strings into a single string and makes replacements
        
    Parameters
    ----------
    htmlList : list of str
        The html code - each line a list entry.
    substitutions_dict : dict
        A dictionary with key:value pairs for old and new text.
        The html code is escaped in Modelica. To feed it to tidylib
        we need to remove the escape characters.
    
    Returns
    -------
    str 
        The html code as one string, cleared from escape characters.
    """    
    
    body = ''.join(htmlList)  # just glue it together again
    
    body = make_string_replacements(theString=body,
                                    substitutions_dict={'\\"': '"'})
    
    return body

def number_print_List(htmlList : list, sep : str = '') -> None:
    """Print a list of strings with line numbers
    
    Should be extended by a feature to highlight a given set of line
    numbers. This can help the reader to quickly identify the lines
    with errors.
    
    Parameters
    ----------
    htmlList : list of str
        The html code - each line a list entry.
    sep : str
        String that seperates the line number from the line text.   
    """
    return sep.join(['{0:>5d} {1}'.format(i,line) for i,line in enumerate(htmlList)])

def htmlCorrection(htmlStr : str, 
                   substitutions_dict : dict = {'"': '\\"', '<br>': '<br />',
                                                '<br/>': '<br />'}) -> (str, str):
    """Returns cleaned html code and found errors
    
    Calls tidylib which will produce a clean version of the html code
    and also the errors that it has found.
    
    Parameters
    ----------
    htmlStr : str
        The html code as a single string.
    substitutions_dict : dict
        A dictionary with key:value pairs for old and new text.
        The html code must be escaped in Modelica. Generate properly
        escaped code we need to add the escape characters. All the
        while we can replace html errors that Dymola introduces.
        i.e. '<br>' -> '<br />'
        
    Returns
    -------
    str 
        The tidy html code with escape characters as one string.
    str
        The error messages from tidylib.
    """
    from tidylib import tidy_document

    # Validate the string
    htmlCorrect, errors = tidy_document(f"{htmlStr}", 
        options={'doctype': 'omit', 
                 'show-body-only': 1,
                 'numeric-entities': 1,
                 'output-html': 1,  
                 'wrap': 72, 
                 'alt-text': '',})
    
    document_corr = make_string_replacements(theString=htmlCorrect,
        substitutions_dict=substitutions_dict)
    
    return document_corr, errors


	
def _listAllModel(Package):
		rootdir = Package
		rootdir = rootdir.replace(".",os.sep)
		ModelList = []
		for subdir, dirs, files in os.walk(rootdir):
			for file in files:
				filepath = subdir + os.sep + file
				if filepath.endswith(".mo") and file != "package.mo":
					#model = filepath.replace(os.sep, ".")
					model = filepath
					model = model[model.rfind("AixLib"):]
					ModelList.append(model)
		return ModelList
	
if __name__ == '__main__':    
	parser = argparse.ArgumentParser(description='Process some Dymola HTML code')
	parser.add_argument('files', metavar='f', type=str, nargs='+', help='a file to be processed')
	parser.add_argument('-s',"--single-package",metavar="AixLib.Package", help="Test only the Modelica package AixLib.Package")
	
	args = parser.parse_args()
    
	ModelList = _listAllModel(args.single_package)
	print(ModelList)
	
	
	#for file in args.files:
	for file in ModelList:
		print(f"\nProcessing file {file}\n")
        
		htmlList = getInfoRevisionsHTML(moFile=file)
		htmlStr = join_body(htmlList=htmlList,substitutions_dict={'\\"': '"'})
		print("\n-------- HTML Code --------")
		print(f"\n{number_print_List(htmlList)}")
        
		document_corr, errors = htmlCorrection(htmlStr=htmlStr)
		docCorrStr = number_print_List(document_corr.split('\n'), sep='\n')
        
		print("\n-------- Corrected Code --------")
		print(f"\n{docCorrStr}")
        
		print("\n-------- Errors --------")
		print(f"\n{errors}")
	
		
		
		