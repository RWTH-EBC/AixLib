# Created January 2017
# TEASER Development Team

"""This module contains an example how to export buildings from a TEASER
project to ready-to-run simulation models for Modelica library AixLib. These
models will only simulate using Dymola, the reason for this are state
machines that are used in one AixLib specific AHU model.
"""

import Testhall_teaser as testhall
import teaser.logic.utilities as utilities
import os


def example_export_aixlib():
    """"This function demonstrates the export to Modelica library AixLib using
    the API function of TEASER"""

    prj = testhall.example_create_building()

    project_path = "D:\\fse-sle\\Repos\\testhall\\Calibration\\Thermalzone"

    prj.dir_reference_results = os.path.abspath(
        os.path.join(project_path,
            "Dymola"))

    print(prj.dir_reference_results)

    prj.used_library_calc = 'AixLib'
    #prj.number_of_elements_calc = 2
    prj.weather_file_path = utilities.get_full_path(
        os.path.join(
            "data",
            "input",
            "inputdata",
            "weatherdata",
            "DEU_BW_Mannheim_107290_TRY2010_12_Jahr_BBSR.mos"))

    prj.calc_all_buildings()
    print(prj.buildings[-1].library_attr.version)

    path = prj.export_aixlib(
        internal_id=None,
        path=None)

    return path


if __name__ == '__main__':

    example_export_aixlib()
