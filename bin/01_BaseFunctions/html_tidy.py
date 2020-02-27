import os
import io
import argparse
import shutil

# todo: tutorial oder bash script schreiben, dass tidylib unter windows installiert
# todo: add flag for removing "level of development"


def run_files(rootDir, correct_overwrite, correct_backup, log):
    # Make sure that the parameter rootDir points to a Modelica package.
    topPackage = os.path.join(rootDir, "package.mo")
    errMsg = list()
    if not os.path.isfile(topPackage):
        raise ValueError("Argument rootDir=%s is not a \
    Modelica package. Expected file '%s'."
                         % (rootDir, topPackage))
    file_counter = 0
    for root, _, files in os.walk(rootDir, topdown=True):
        for moFil in files:
            # find the .mo files
            if moFil.endswith('.mo'):
                file_counter += 1
                moFulNam = os.path.join(root, moFil)
                results = _CheckFile(moFulNam)
                document_corr = results[0]
                err = results[1]
                if err is not "":
                    # write error to error message
                    errMsg.append("[-- %s ]\n%s" % (moFulNam, err))
                if correct_backup:
                    _backup_old_files(rootDir, moFulNam,
                                      document_corr, file_counter)
                if correct_overwrite:
                    _correct_overwrite(moFulNam, document_corr)
    if log:
        _return_logfile(rootDir, errMsg)
        print("##########################################################")
        print("you can find your logfile under " + rootDir + os.sep+"logfile.txt")


def _correct_overwrite(moFulNam, document_corr):
    """
    This function overwrites the old modeilca files with
    the corrected files
    """
    os.remove(moFulNam)
    # todo: uncode##print(moFulNam)
    newfile = open(moFulNam, "w+b")
    newfile.write(document_corr.encode("utf-8"))


def _backup_old_files(rootDir, moFulNam, document_corr, file_counter):
    """
    This function backups the root folder and creates
    the corrected files
    """
    # todo: richtigen error einfuegen
    if os.path.exists(rootDir + "_backup") is False and file_counter == 1:
        shutil.copytree(rootDir, rootDir + "_backup")
        print("you can find your backup under " + rootDir + "_backup")
    # todo unconde ##print(moFulNam)
    os.remove(moFulNam)
    newfile = open(moFulNam, "w+b")
    newfile.write(document_corr.encode("utf-8"))


def _return_logfile(rootDir, errMsg):
    """
    This function creates the logfile
    """
    File = rootDir+os.sep+"HTML-logfile.txt"
    print(File)
    logfile = open(File, "w")

    if len(errMsg) >= 0:
        for line in errMsg:
            logfile.write(line+'\n')


def _CheckFile(moFile):
    """
    This function returns a list that contain the html code of the
    info and revision sections. Each element of the list
    is a string.

    :param moFile: The name of a Modelica source file.
    :return: list The list of strings of the info and revisions
             section.
    """
    # Open file.
    # print(moFile)
    with io.open(moFile, mode="r", encoding="utf-8-sig") as f:
        lines = f.readlines()
    nLin = len(lines)
    isTagClosed = True
    code = list()
    htmlCode = list()
    errors = list()
    for i in range(nLin):
        if isTagClosed:
            # search for opening tag
            idxO = lines[i].find("<html>")
            if idxO > -1:
                # if found opening tag insert everything up to opening tag into the code list
                code.append(lines[i][:idxO+6])
                # search for closing tag on same line as opening tag
                # check for both, correct and incorrect html tags, because dymola except also <\html>
                idxC1 = lines[i].find("</html>")
                idxC2 = lines[i].find("<\html>")
                if idxC1 > -1:
                    idxC = idxC1
                elif idxC2 > -1:
                    idxC = idxC2
                else:
                    idxC = -1
                if idxC > -1:
                    htmlCode.append(lines[i][idxO:idxC+6])
                    code.append(_htmlCorrection(htmlCode)[0])
                    errors.append(_htmlCorrection(htmlCode)[1])
                    code.append(lines[i][idxC:])
                    # clear htmlcode list
                    htmlCode = list()
                    isTagClosed = True
                else:
                    htmlCode.append(lines[i][idxO+6:])
                    isTagClosed = False
            else:
                code.append(lines[i])
                isTagClosed = True
        else:
            # check for both, correct and incorrect html tags, because dymola except also <\html>
            idxC1 = lines[i].find("</html>")
            idxC2 = lines[i].find("<\html>")
            if idxC1 > -1:
                idxC = idxC1
            elif idxC2 > -1:
                idxC = idxC2
            else:
                idxC = -1
            if idxC > -1:
                htmlCode.append(lines[i][idxO:idxC + 6])
                code.append(_htmlCorrection(htmlCode)[0])
                errors.append(_htmlCorrection(htmlCode)[1])
                code.append(lines[i][idxC:])
                # clear htmlcode list
                htmlCode = list()
                # check if there is a new opening tag on the same line
                idxO = lines[i].find("<html>")
                if idxO > -1:
                    isTagClosed = False
                else:
                    isTagClosed = True
            else:
                htmlCode.append(lines[i])
                isTagClosed = False

    document_corr = ""
    if len(code) > 0:
        for lines in code:
            document_corr += lines
    errors_string = ""
    if len(errors) > 0:
        for lines in errors:
            errors_string += lines

    # correct img attribute and closing tag
    document_corr_img = ""
    CloseFound = True
    for line in document_corr.splitlines():
        line, CloseFound = correct_img_atr(line, CloseFound)
        document_corr_img += line + '\n'
    return document_corr_img, errors_string


def correct_img_atr(line, CloseFound):
    # check for missing alt attributed
    if CloseFound == True:
        imgTag = line.encode("utf-8").find(b"img")
        if imgTag > -1:
            imgCloseTagIndex = line.find(">", imgTag)
            imgAltIndex = line.find("alt", imgTag)
            # if close tag exists but no alt attribute, insert alt attribute and change > to />
            if imgCloseTagIndex > -1 and imgAltIndex == -1:
                line = line[:imgTag] + \
                    line[imgTag:].replace(">", ' alt="" />', 1)
                CloseFound = True
            # if close tag exists and alt attribute exists, only change > to />
            elif imgCloseTagIndex > -1 and imgAltIndex > -1:
                line = line[:imgTag] + line[imgTag:].replace(">", ' />', 1)
                CloseFound = True
            # if close tag is not in the same line
            elif imgCloseTagIndex == -1:
                line = line
                CloseFound = False
    else:
        # if no close tag was found in previous line, but opening tag found search for close on this line with same
        # procedure
        imgCloseTagIndex = line.find(">")
        imgAltIndex = line.find("alt")
        if imgCloseTagIndex > -1 and imgAltIndex == -1:
            line = line[:imgCloseTagIndex] + \
                line[imgCloseTagIndex:].replace(">", ' alt="" />', 1)
            CloseFound = True
        elif imgCloseTagIndex > -1 and imgAltIndex > -1:
            line = line[:imgCloseTagIndex] + \
                line[imgCloseTagIndex:].replace(">", ' />', 1)
            CloseFound = True
        elif imgCloseTagIndex == -1:
            CloseFound = False
            line = line
    return line, CloseFound


def _htmlCorrection(htmlCode):
    from tidylib import tidy_document

    body = ""
    for line in htmlCode:
        body += line + '\n'
    body = body.replace('\\"', '"')
    print(body)
    # Validate the string
    htmlCorrect, errors = tidy_document(r"%s" % body, options={'doctype': 'omit', 'show-body-only': 1,
                                                               'numeric-entities': 1,
                                                               'output-html': 1,  'wrap': 72, 'alt-text': '', })
    replacements = {
        '"': '\\"',
        '<br>': '<br/>',
		'align=':'style="text-align:'
    }

    document_corr = htmlCorrect
    for old, new in replacements.items():
        document_corr = document_corr.replace(old, new)
    return document_corr, errors


if __name__ == '__main__':
    # todo: maybe set environment variables with something like:
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
    parser.add_argument("--log", action="store_true",
                        default=False, help="print logfile of errors found")
    parser.add_argument('-s', "--single-package", metavar="AixLib.Package",
                        help="Test only the Modelica package AixLib.Package")

    args = parser.parse_args()
    if args.correct_overwrite is False and args.correct_backup is False and args.log is False:
        print("please use -h or --help for help")
    elif args.correct_backup is True:
        run_files(args.single_package, False, args.correct_backup, args.log)
    else:
        run_files(args.single_package, args.correct_overwrite,
                  args.correct_backup, args.log)
    #run_files(os.getcwd(), True, False, True)
