import os
import sys
import shutil
import glob
import argparse
from natsort import natsorted

def search_aixlib_conversion(aixlib_dir):  # Read the last aixlib mos script
    from natsort import natsorted
    filelist = (glob.glob(aixlib_dir + os.sep + "*.mos"))
    sorted_list = natsorted(filelist)
    last_script = sorted_list[len(sorted_list) - 1]
    return last_script

def create_convert_aixlib(ibpsa_content, last_aixlib_conv):  # change the paths in the script from IBPSA.Package.model -> AixLib.Package.model
    from_numb = last_aixlib_conv[last_aixlib_conv.find("from_") + 5:last_aixlib_conv.rfind("_to_")]
    last_from_numb = int(from_numb[from_numb.rfind(".") + 1]) + 1
    new_from_numb = f'{from_numb[:from_numb.rfind(".")]}.{last_from_numb}'

    to_numb = last_aixlib_conv[last_aixlib_conv.find("_to_") + 4:last_aixlib_conv.rfind(".mos")]
    last_to_numb = int(to_numb[to_numb.rfind(".") + 1]) + 1
    new_to_numb = f'{to_numb[:to_numb.rfind(".")]}.{last_to_numb}'
    new_version_number = f'ConvertAixLib_from_{new_from_numb}_to_{new_to_numb}.mos'
    new_conversion_script = f'{aixlib_dir}{os.sep}{new_version_number}'
    aixlib_conversion = open(new_conversion_script, "w")
    for line in ibpsa_content:
        aixlib_conversion.write(line.replace("IBPSA", "AixLib"))
    aixlib_conversion.close()
    return new_conversion_script


def copy_aixlib_mos(aixlib_mos, aixlib_dir, dst):
    shutil.copy(aixlib_mos, aixlib_dir)
    shutil.rmtree(dst)

def compare_conversions(ibpsa_content, aixlib_content):
    x = 0
    list = []
    if len(ibpsa_content) == len(aixlib_content):
        for i in ibpsa_content:
            i = i.replace("IBPSA", "AixLib")
            if i.find("from:") > -1 and i.find(" Version") > -1:
                x = x + 1
                continue
            if i.find("to") > -1 and i.find(" Version") > -1:
                x = x + 1
                continue
            if i != aixlib_content[x]:
                list.append(i)
                x = x + 1
                continue
            x = x + 1
    else:
        list.append(x)
    if len(list) > 0:
        return False
    if len(list) == 0:
        return True


def _read_package():
    file = open("AixLib" + os.sep + "package.mo", "r")
    list = []
    for line in file:
        if line.find("conversion(from(") > -1:
            list.append(line)
            counter = 1
            continue
        if line.find('.mos")),') > -1 and counter == 1:
            version_number = line[line.find("_to_") + 4:line.find(".mos")]
            return version_number

def add_conv_to_package(aixlib_mos, last_aixlib_conv):
    file = open("AixLib" + os.sep + "package.mo", "r")
    latest_numb = f'{last_aixlib_conv[last_aixlib_conv.rfind(os.sep)+1:last_aixlib_conv.rfind(".mos")]}'
    new_numb = f'{aixlib_mos[aixlib_mos.rfind(os.sep) + 1:aixlib_mos.rfind(".mos")]}'
    #ConvertAixLib_from_0.9.4_to_0.10.0.mos
    version_numb = f'{aixlib_mos[aixlib_mos.rfind("from_") + 5:aixlib_mos.rfind("_to_")]}'
    content_list = []
    version = f'    version="{version_numb}",\n                      script="modelica://{aixlib_mos}")),\n'
    for line in file:
        if line.find(f'{latest_numb}') > -1:
            content_list.append(line.replace("))",""))
            content_list.append(version)
            continue
        else:
            content_list.append(line)
        '''
                if line.find(f'    version="{version_numb}",\n') > -1:
            content_list.remove(version)
        if line.find(f'                      script="modelica://{aixlib_mos}")),\n') > -1:
            content_list.remove(version)
        '''
    file.close()
    file = open("AixLib" + os.sep + "package.mo", "w")
    for line in content_list:
        file.write(line)
    file.close()

def search_ibpsa_conversion(ibpsa_dir):
    file = (glob.glob(ibpsa_dir))
    if len(file) == 0:  # Look which ConvertScript is the latest
        print("Cannot find a Conversion Script in IBPSA Repo")
        exit(0)
    if len(file) > 0:
        sorted_list = natsorted(file)
        last_script = sorted_list[len(sorted_list) - 1]
        return last_script

def read_aixlib_conversion(last_aixlib_conv):
    aixlib_script = open(last_aixlib_conv, "r")
    aixlib_content = aixlib_script.readlines()
    aixlib_script.close()
    return aixlib_content

def read_ibpsa_conversion(last_ibpsa_script):
    ibpsa_script = open(last_ibpsa_script, "r")
    ibpsa_content = ibpsa_script.readlines()
    ibpsa_script.close()
    return ibpsa_content
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Set Github Environment Variables")
    check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
    check_test_group.add_argument("-dst", "--dst", default="Convertmos", help="temp folder")
    check_test_group.add_argument("-ad", "--aixlib-dir", default="AixLib\\Resources\\Scripts",
                                  help="path to the aixlib scripts")
    check_test_group.add_argument('-id', "--ibpsa-dir",
                                  default='modelica-ibpsa\\IBPSA\\Resources\\Scripts\\Dymola\\ConvertIBPSA_*',
                                  help="path to the ibpsa scripts")

    args = parser.parse_args()  # Parse the arguments
    dst = args.dst
    aixlib_dir = args.aixlib_dir
    ibpsa_dir = args.ibpsa_dir
    last_ibpsa_script = search_ibpsa_conversion(ibpsa_dir)  # Search the latest ibpsa conversion script
    print(f'Latest IBPSA Conversion number: {last_ibpsa_script[last_ibpsa_script.rfind(os.sep)+1:last_ibpsa_script.rfind(".mos")]}')
    ibpsa_content = read_ibpsa_conversion(last_ibpsa_script)  # read the latest ibpsa conversion script
    last_aixlib_conv = search_aixlib_conversion(aixlib_dir)  # Search the latest aixlib conversion script
    print(f'Latest AixLib Conversion number: {last_aixlib_conv[last_aixlib_conv.rfind(os.sep)+1:last_aixlib_conv.rfind(".mos")]}')
    aixlib_content = read_aixlib_conversion(last_aixlib_conv)
    result = compare_conversions(ibpsa_content, aixlib_content)  # Compare latest ibpsa and aixlib conversion script
    if result == False:
        aixlib_mos = create_convert_aixlib(ibpsa_content, last_aixlib_conv)
        print(aixlib_mos)
        print(f'New AixLib Conversion number: {aixlib_mos[aixlib_mos.rfind(os.sep)+1:aixlib_mos.rfind(".mos")]}')
        add_conv_to_package(aixlib_mos, last_aixlib_conv)
    else:
        print("The latest conversion script is up to date from the IBPSA")

