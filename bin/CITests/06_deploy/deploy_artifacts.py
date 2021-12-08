import os
import codecs
import sys
import shutil
import argparse
import glob

class Deploy_Artifacts(object):

    def __init__(self, library):
        self.library = library
        self.folder = 'Referencefiles'

        self.green = '\033[0;32m'
        self.CRED = '\033[91m'
        self.CEND = '\033[0m'

        sys.path.append('bin/CITests')
        from _config import new_ref_file, update_ref_file
        self.new_ref_file = new_ref_file
        self.update_ref_file = update_ref_file

    def _get_changed_ref(self):  # list all changed reference results to a list
        changed_file = codecs.open(self.new_ref_file, "r", encoding='utf8')
        lines = changed_file.readlines()
        changed_ref = []
        for line in lines:
            if line.find("txt") > -1 and line.find("ReferenceResults") > -1 and line.find("Resources") > -1:
                line = line.strip()
                ref = line[line.find(self.library):line.rfind("txt") + 3]
                changed_ref.append(ref)
                continue
            else:
                continue
        changed_file.close()
        return changed_ref

    def _get_update_ref(self):
        updated_file = codecs.open(self.update_ref_file, "r", encoding='utf8')
        lines = updated_file.readlines()
        updated_ref = []
        for line in lines:
            if line.find("txt") > -1:
                line = line.strip()
                updated_ref.append(f'{self.library}{os.sep}Resources{os.sep}ReferenceResults{os.sep}Dymola{os.sep}{line.strip()}')
                continue
            else:
                continue
        updated_file.close()
        return updated_ref

    def copy_txt(self, changed_ref):  # Copy reference results from AixLib\Resources\ReferenceResults\Dymola\* to Referencefiles\\*
        if os.path.exists(self.folder) is False:
            os.mkdir(self.folder)
        else:
            files = os.listdir(self.folder)
            for file in files:
                os.remove(f'{self.folder}{os.sep}{file}')
        for ref in changed_ref:
            destination = self.folder + os.sep + ref[ref.rfind(os.sep):]
            try:
                shutil.copy(ref, destination)
                continue
            except FileNotFoundError:
                print(f'{self.CRED}Cannot find folder:{self.CEND} {destination}')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='deploy artifacts')
    unit_test_group = parser.add_argument_group("arguments to run deploy artifacts")
    unit_test_group.add_argument("-L", "--library", default="AixLib", help="Library to test")
    unit_test_group.add_argument("--ref", help='Deploy new reference files', action="store_true")
    unit_test_group.add_argument("--new-ref",
                                 help="Plot new models with new created reference files",
                                 action="store_true")
    unit_test_group.add_argument("--updated-ref",
                                 help="Plot new models with new created reference files",
                                 action="store_true")
    args = parser.parse_args()
    from deploy_artifacts import Deploy_Artifacts

    if args.ref is True:
        ref_artifact = Deploy_Artifacts(library=args.library)
        if args.new_ref is True:  # python bin/02_CITests/deploy/deploy_artifacts.py --library AixLib --ref --new-ref
            changed_ref = ref_artifact._get_changed_ref()
            ref_artifact.copy_txt(changed_ref)
        if args.updated_ref is True:  # python bin/02_CITests/deploy/deploy_artifacts.py --library AixLib --ref --updated-ref
            updated_ref = ref_artifact._get_update_ref()
            ref_artifact.copy_txt(updated_ref)

