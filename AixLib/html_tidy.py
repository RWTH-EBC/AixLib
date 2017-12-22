import tidylib
import os
import io
import argparse
import shutil
import os.path as path

# todo: tutorial oder bash script schreiben, dass tidylib unter windows installiert

def run_files(rootDir, correct_overwrite, correct_backup, log):
    # Make sure that the parameter rootDir points to a Modelica package.
    topPackage = os.path.join(rootDir, "package.mo")
    errMsg = list()
    if not os.path.isfile(topPackage):
        raise ValueError("Argument rootDir=%s is not a \
    Modelica package. Expected file '%s'."
                         % (rootDir, topPackage))
    file_counter=0
    for root, _, files in os.walk(rootDir):
        for moFil in files:
            # find the .mo files
            if moFil.endswith('.mo'):
                file_counter +=1
                moFulNam = os.path.join(root, moFil)
                err = _validateHTML(moFulNam)[1]
                document_corr = _validateHTML(moFulNam)[0]
                if len(err) > 0:
                    # write error to error message
                    errMsg.append("[-- %s ]\n%s" % (moFulNam, err))
                if correct_backup:
                    _backup_old_files(rootDir, moFulNam, document_corr, file_counter)
                if correct_overwrite:
                    _correct_overwrite(moFulNam, document_corr)
    if log:
        _return_logfile(rootDir, errMsg)
        print("you can find your logfile under " + rootDir + "logfile.txt")
    return errMsg

def _correct_overwrite(moFulNam, document_corr):
    """
    This function overwrites the old modeilca files with
    the corrected files
    """
    os.remove(moFulNam)
    newfile = open(moFulNam, "w")
    newfile.write(document_corr.encode("utf-8-sig"))


def _backup_old_files(rootDir, moFulNam, document_corr, file_counter):
    """
    This function backups the root folder and creates
    the corrected files
    """
    # todo: richtigen error einfuegen
    if os.path.exists(rootDir + "_backup") is False and file_counter == 1:
        shutil.copytree(rootDir, rootDir + "_backup")
        print("you can find your backup under " + rootDir + "_backup")
    print(moFulNam)
    os.remove(moFulNam)
    newfile = open(moFulNam, "w")
    newfile.write(document_corr.encode("utf-8-sig"))


def _return_logfile(rootDir, errMsg):
    """
    This function creates the logfile
    """
    logfile = open("logfile.txt", "w")
    for line in errMsg:
        logfile.write(line+'\n')


def _getInfoRevisionsHTML(moFile):
    """
    This function returns a list that contain the html code of the
    info and revision sections. Each element of the list
    is a string.

    :param moFile: The name of a Modelica source file.
    :return: list The list of strings of the info and revisions
             section.
    """
    # Open file.
    with io.open(moFile, mode="r", encoding="utf-8-sig") as f:
        lines = f.readlines()
    nLin = len(lines)
    isTagClosed = True
    entries = list()
    findCounter = 0
    htmlStart = [None] * 2  # begin of html in modelica code (line and index)
    htmlEnd = [None] * 2  # end of html in modelica code (line and index)
    for i in range(nLin):
        if isTagClosed:
            # search for opening tag
            idxO = lines[i].find("<html>")
            if idxO > -1:
                # search for closing tag on same line as opening tag
                findCounter += 1
                if findCounter == 1:
                    htmlStart[1] = idxO + 6
                    htmlStart[0] = i
                idxC = lines[i].find("</html>")
                if idxC > -1:
                    entries.append(lines[i][idxO + 6:idxC])
                    isTagClosed = True
                    htmlEnd[1] = idxC
                    htmlEnd[0] = i
                else:
                    entries.append(lines[i][idxO + 6:])
                    isTagClosed = False
        else:
            # search for closing tag
            idxC = lines[i].find("</html>")
            if idxC == -1:
                # closing tag not found, copy full line
                # remove level of development because it's not used anymore in AixLib
                if not "Level of Development" in lines[i] and not "HVAC/Images/stars" in lines[i]:
                    entries.append(lines[i])
            else:
                # found closing tag, copy beginning of line only
                htmlEnd[1] = idxC
                htmlEnd[0] = i
                entries.append(lines[i][0:idxC])
                isTagClosed = True
                if findCounter < 2:
                    # TODO: split up into two parts before and after revisions
                    entries.append("Revisions\n")
                # search for opening tag on same line as closing tag
                idxO = lines[i].find("<html>")
                if idxO > -1:
                    entries.append(lines[i][idxO + 6:])
                    isTagClosed = False
    return entries, lines, htmlStart, htmlEnd


def _validateHTML(moFile):
    """
    This function validates the file ``moFile`` for correct html syntax.

    :param moFile: The name of a Modelica source file.
    :return: (str, str) The tidied markup [0] and warning/error
             messages[1]. Warnings and errors are returned
             just as tidylib returns them.

    """
    from tidylib import tidy_document

    htmlCode = _getInfoRevisionsHTML(moFile)[0]
    wholeCodeList = _getInfoRevisionsHTML(moFile)[1]
    htmlStart = _getInfoRevisionsHTML(moFile)[2]
    htmlEnd = _getInfoRevisionsHTML(moFile)[3]

    body = ""
    for line in htmlCode:
        body += line + '\n'

    # Validate the string
    document, errors = tidy_document(r"%s" % body,
                                     options={'doctype': 'omit', 'show-body-only': 1, 'numeric-entities': 1})
    replacements = {
        '"\&quot;': '\\"',
        '\&quot;"': '\\"',
        '"/&quot;': '\\"',
        '&quot;/"': '\\"',
        '/&quot;"': '\\"',
        '<br>': '<br/>',
        'Revisions': '</html>",revisions="<html>'
    }
    document_corr = document
    for old, new in replacements.iteritems():
        document_corr = document_corr.replace(old, new)

    # replace old html code with corrected one
    # check if there is any html code
    if htmlStart[0] > 0:
        CodeBeforeHTML = [None] * len(wholeCodeList)
        for line, x in enumerate(wholeCodeList):
            # remove everything in the first html line behind the html opening tag
            if line == htmlStart[0]:
                wholeCodeList[line] = wholeCodeList[line][:htmlStart[1]]
            # remove everything in the last html line before the html close tag
            if line == htmlEnd[0]:
                wholeCodeList[line] = wholeCodeList[line][htmlEnd[1]:]
        # remove all lines between the line after the first and before the last html tag
        CodeBeforeHTML = wholeCodeList[:htmlStart[0] + 1]
        CodeAfterHTML = wholeCodeList[htmlEnd[0]:]
        del wholeCodeList[htmlStart[0] + 1:htmlEnd[0]]

        finalcode = ""
        for line in CodeBeforeHTML:
            finalcode += line + '\n'
        finalcode += document_corr + '\n'
        for line in CodeAfterHTML:
            finalcode += line + '\n'
            # print("________________________")
            # print(finalcode)
    else:
        finalcode = ""

    return (finalcode, errors)


if __name__ == '__main__':
    # todo: set environment variables with something like:
    #    # Set environment variables
    # if platform.system() == "Windows":
    #    _setEnvironmentVariables("PATH",
    #                             os.path.join(os.path.abspath('.'),
    #                                          "Resources", "Library", "win32"))

    parser = argparse.ArgumentParser(description='Run HTML correction on files, print found errors or backup old files'
                                                 ' before correction')
    parser.add_argument("--correct-overwrite", action="store_true", default=False, help="correct html code in modelica "
                                                                                        "files and overwrite old files")
    parser.add_argument("--correct-backup", action="store_true", default=False, help="correct html code in modelica "
                                                                                     "files and backup old files")
    parser.add_argument("--log", action="store_true", default=False, help="print logfile of errors found")
    args = parser.parse_args()
    if args.correct_overwrite is False and args.correct_backup is False and args.log is False:
        print("please use -h or --help for help")
    else:
        run_files(os.getcwd(), args.correct_overwrite, args.correct_backup, args.log)