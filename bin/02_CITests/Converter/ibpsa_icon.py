#Reihenfolge:
# ######## Local ###############
# Ibpsa_modelle in eine Liste schreiben
# Neues Icon Pack mit einbinden
# Dateien überschreiben
# ### Github #########
#Überarbeitete Version pushen
# Tests durchführen
# In Ibpsa_Merge einfügen und testen
import os
from pathlib import Path

# Read whitelist and return a list
def read_wh(path):
    wh = open(path,"r")
    wl = wh.readlines()
    wh.close()
    return wl

## Sort List of models
def sort_list(mo_li):
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

## Add ibpsa icon and search a suitable line
def add_icon(mo_li):
    entry = "  extends AixLib.Icons.ibpsa;"
    for i in mo_li:
        if (exist_file(i)) == True:
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
                #ModelName == Zeile Mit Modelname
                c = c + 1
                if t.find(mo) > -1:
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

# File exist
def exist_file(file):
    f = Path(file)
    if f.is_file():
        return True
    else:
        return False

if __name__ == '__main__':
    path = "bin"+os.sep+"03_WhiteLists"+os.sep+"HTML_IBPSA_WhiteList.txt"
    mo_li = read_wh(path)
    mo_li = sort_list(mo_li)
    add_icon(mo_li)
