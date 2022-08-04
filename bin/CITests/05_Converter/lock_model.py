import os
from pathlib import Path
import argparse
import sys

class Lock_model(object):

    def __init__(self,  library, wh_library):
        self.library = library
        self.wh_library = wh_library
        sys.path.append('bin/CITests')
        from _config import html_wh_file
        self.html_wh_file = html_wh_file

    def _read_wh(self):  # Read whitelist and return a list
        wh = open(self.html_wh_file, "r")
        wl_lines = wh.readlines()
        wh.close()
        return wl_lines

    def _sort_list(self, wl_lines):  # Sort List of models
        model_list = []
        for line in wl_lines:
            if len(line) == 1:
                continue
            if line.find("package.mo") > -1:
                continue
            if line.find("package.order") > -1:
                continue
            if line.find("UsersGuide") > -1:
                continue
            else:
                line = line.replace(self.wh_library, self.library)
                mo = line.replace(".", os.sep, line.count(".")-1)
                mo = mo.lstrip()
                mo = mo.strip()
                model_list.append(mo)
        return model_list

    def _exist_file(self, file):  # File exist
        f = Path(file)
        if f.is_file():
            return True
        else:
            return False

    def get_last_line(self, model):
        flag = '__Dymola_LockedEditing="Model from IBPSA");'
        model_part = []
        flag_tag = False
        if Lock_model._exist_file(self, model) is True:
            infile = open(model, "r")
            for lines in infile:
                model_part.append(lines)
                if lines.find(flag) > -1:
                    flag_tag = True
            infile.close()
            return model_part, flag_tag
        else:
            print(f'\n************************************{model}\nFile does not exist.')


    def lock_model(self, model, content):
        mo = model[model.rfind(os.sep) + 1:model.rfind(".mo")]

        last_entry = content[len(content) - 1]
        flag = '   __Dymola_LockedEditing="Model from IBPSA");'
        old_html_flag = '</html>"));'
        new_html_flag = '</html>"),  \n' + flag
        old = ');'
        new = ', \n' + flag
        replacements = {old_html_flag: new_html_flag, old: new}

        if last_entry.find(mo) > -1 and last_entry.find("end") > -1:
            flag_lines = content[len(content) - 2]
            if flag_lines.isspace() == True:
                flag_lines = content[len(content) - 3]
                del content[len(content) - 2]
            if flag_lines.find(old_html_flag) > -1:
                flag_lines = flag_lines.replace(old_html_flag, new_html_flag)
            elif flag_lines.find(old) > -1:
                flag_lines = flag_lines.replace(old, new)
            del content[len(content) - 2]
            content.insert(len(content) - 1, flag_lines)
            return content
        else:
            flag_lines = content[len(content) - 1]
            if flag_lines.find(old_html_flag) > -1:
                flag_lines = flag_lines.replace(old_html_flag, new_html_flag)
            elif flag_lines.find(old) > -1:
                flag_lines = flag_lines.replace(old, new)
            del content[len(content) - 1]
            content.insert(len(content), flag_lines)
            return content

    def write_lock_model(self, model, new_content):
        print("lock object: " + model)
        outfile = open(model, 'w')
        new_content = (' '.join(new_content))
        outfile.write(new_content)
        outfile.close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Lock models.')
    unit_test_group = parser.add_argument_group("arguments to run class Lock_model")
    unit_test_group.add_argument("-L", "--library", default="AixLib", help="Library to test")
    unit_test_group.add_argument("-wh-l", "--wh-library", help="Library to test")
    args = parser.parse_args()

    from lock_model import Lock_model
    lock = Lock_model(library=args.library, wh_library=args.wh_library)

    wl_lines = lock._read_wh()  # read html whitelist (models from IBPSA)
    mo_li = lock._sort_list(wl_lines)  # Sort list of IPBSA Models
    for model in mo_li:
        if lock._exist_file(model) == True:
            result = lock.get_last_line(model)
            content = result[0]
            if len(content) == 0:
                continue
            flag = result[1]
            if flag == False:
                new_content = lock.lock_model(model, content)
                lock.write_lock_model(model, new_content)
            else:
                print(f'Already locked: {model}')
                continue
        else:
            print(f'************************************\n{model}\nFile does not exist.')
            continue
