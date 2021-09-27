import os
from pathlib import Path


def read_wh(path): # Read whitelist and return a list
    wh = open(path,"r")
    wl = wh.readlines()
    wh.close()
    return wl


def sort_list(mo_li): # Sort List of models
    list = []
    for i in mo_li:
        if len(i) == 1:
            continue
        if i.find("package.mo") > -1 :
            continue
        if i.find("package.order") > -1 :
            continue
        if i.find("UsersGuide") > -1:
            continue
        i = i.replace("IBPSA","AixLib")
        numb = i.count(".")
        mo = i.replace(".",os.sep,numb-1)
        mo = mo.lstrip()
        mo = mo.strip()
        list.append(mo)
    return list


def add_icon(mo_li): # Add ibpsa icon and search a suitable line
    entry = "  extends AixLib.Icons.ibpsa;"
    for i in mo_li:
        if (exist_file(i)) == True:
            print(i)
            f = open(i,"r+")
            lines = f.readlines()
            f.close()
            mo = i[i.rfind(os.sep)+1:i.rfind(".mo")]
            y = []
            c = 0
            num = 0
            semi = 0
            ano = 0
            for t in lines:
                c = c + 1
                if t.find(mo) > -1:  #ModelName == Zeile Mit Modelname
                    if len(y) == 0:
                        if t.find("type ") > -1:
                            y = []
                            break
                        if t.find("function ") > -1:
                            y = []
                            break
                        if t.find("record ") > -1:
                            y = []
                            break
                        if t.find("package ") > -1:
                            y = []
                            break
                        if t.find("=") > -1:
                            y = []
                            break
                        else:
                            if t.count('"') == 2:
                                y.append(c)
                                continue
                            else:
                                ano = 1
                                y.append(c)
                                continue
                if len(y) == 1 and ano == 1:
                        if t.count('"') == 2:
                            y.append(c)
                            continue
                if t.find(";")> -1 and semi == 1:
                    y.append(c)
                    semi = 0
                    continue
                if t.find("parameter") > -1:
                    break
                if t.find("annotation")> -1 :
                    break
                if t.find("extends") > -1:
                    num = 1
                    if t.find("extends AixLib.Icons.ibpsa;") == -1:
                        if t.find(";") > -1:
                            y.append(c)
                            continue
                        else:
                            semi = 1
                            y.append(c)

                if t.find("extends AixLib.Icons.ibpsa;") > -1:
                        y = []
                        break
                if num == 1:
                    if len(t) == 0:
                        y.append(c)
                        break
            if len(y)==0:
                continue
            else:
                lines.insert(y[len(y)-1] , "\n" + entry +  "\n")
                f = open(i, "w")
                f.writelines(lines)
                f.close()
        else:
            print("\n************************************")
            print(i)
            print("File does not exist.")

def exist_file(file): # File exist
    f = Path(file)
    if f.is_file():
        return True
    else:
        return False

def lock(mo_li): # lock ibpsa models
    entry = '   __Dymola_LockedEditing="ibpsa");'
    old_text = '</html>"));'
    new_text = '</html>"), ' +"\n" + entry
    replacements = {old_text : new_text}
    lines = []
    for model in mo_li:

        if exist_file(model) == True:
            print("lock object: "+model)
            infile = open(model).read()
            outfile = open(model, 'w')

            for i in replacements.keys():
                infile = infile.replace(i, replacements[i])
            outfile.write(infile)
            outfile.close

        else:
            print("\n************************************")
            print(model)
            print("File does not exist.")
            continue
if __name__ == '__main__':
    path = "bin"+os.sep+"03_WhiteLists"+os.sep+"HTML_IBPSA_WhiteList.txt"
    mo_li = read_wh(path)
    mo_li = sort_list(mo_li)
    #add_icon(mo_li)
    lock(mo_li)
