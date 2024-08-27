import logging
import os
import pathlib
import shutil
from random import random

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from vclibpy import datamodels
from vclibpy import utils
from vclibpy.components.compressors import RotaryCompressor
from vclibpy.components.expansion_valves import Bernoulli
from vclibpy.components.heat_exchangers import heat_transfer
from vclibpy.components.heat_exchangers import moving_boundary_ntu
from vclibpy.components.heat_exchangers.economizer import VaporInjectionEconomizerNTU
from vclibpy.flowsheets import StandardCycle, VaporInjectionEconomizer, VaporInjectionPhaseSeparator


def _load_flowsheet(fluid: str, flowsheet: str = None):
    flowsheets = {
        "Standard": StandardCycle,
        "VaporInjectionPhaseSeparator": VaporInjectionPhaseSeparator,
        "VaporInjectionEconomizer": VaporInjectionEconomizer
    }
    N_max = 125
    V_h = 19e-6
    compressor = RotaryCompressor(
        N_max=N_max,
        V_h=V_h
    )
    condenser = moving_boundary_ntu.MovingBoundaryNTUCondenser(
        A=5,
        secondary_medium="water",
        flow_type="counter",
        ratio_outer_to_inner_area=1,
        two_phase_heat_transfer=heat_transfer.constant.ConstantTwoPhaseHeatTransfer(alpha=5000),
        gas_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=5000),
        wall_heat_transfer=heat_transfer.wall.WallTransfer(lambda_=236, thickness=2e-3),
        liquid_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=5000),
        secondary_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=5000)
    )
    evaporator = moving_boundary_ntu.MovingBoundaryNTUEvaporator(
        A=15,
        secondary_medium="air",
        flow_type="counter",
        ratio_outer_to_inner_area=1,
        two_phase_heat_transfer=heat_transfer.constant.ConstantTwoPhaseHeatTransfer(alpha=5000),
        gas_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=5000),
        wall_heat_transfer=heat_transfer.wall.WallTransfer(lambda_=236, thickness=2e-3),
        liquid_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=5000),
        secondary_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=5000)
    )
    economizer = VaporInjectionEconomizerNTU(
        A=2,
        two_phase_heat_transfer=heat_transfer.constant.ConstantTwoPhaseHeatTransfer(alpha=50000),
        gas_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=50000),
        wall_heat_transfer=heat_transfer.wall.WallTransfer(lambda_=236, thickness=2e-3),
        liquid_heat_transfer=heat_transfer.constant.ConstantHeatTransfer(alpha=50000),
    )
    expansion_valve = Bernoulli(A=0.1)  # Should not matter
    kwargs = dict(
        evaporator=evaporator,
        condenser=condenser,
        fluid=fluid
    )
    if flowsheet == "Standard":
        kwargs.update(dict(
            expansion_valve=expansion_valve,
            compressor=compressor
        ))
    else:
        kwargs.update(dict(
            high_pressure_compressor=compressor,
            low_pressure_compressor=compressor,
            high_pressure_valve=expansion_valve,
            low_pressure_valve=expansion_valve
        ))
    if flowsheet == "VaporInjectionEconomizer":
        kwargs.update(dict(
            economizer=economizer
        ))
    return flowsheets[flowsheet](**kwargs)


def _regression_of_examples(working_dir: pathlib.Path, flowsheet: str, fluid: str):
    # Select the settings / parameters of the hp:
    kwargs = {"max_err_ntu": 0.5,
              "max_err_dT_min": 0.1,
              "show_iteration": False,
              "max_num_iterations": 5000}

    T_eva_in_ar = np.arange(-20, 20.1, 5) + 273.15
    T_con_ar = np.arange(30, 70.1, 5) + 273.15
    n_ar = np.arange(0.3, 1.01, 0.1)

    os.makedirs(working_dir, exist_ok=True)

    kwargs["save_path_plots"] = pathlib.Path(working_dir).joinpath("plots")
    os.makedirs(pathlib.Path(working_dir).joinpath("plots"), exist_ok=True)

    heat_pump = _load_flowsheet(
        fluid=fluid,
        flowsheet=flowsheet
    )

    nominal_mass_flow_rates = {
        'Propane_Standard': {
            'm_flow_con': 0.13170689122288656,
            'm_flow_eva': 0.4698166163310231
        },
        'Propane_VaporInjectionEconomizer': {
            'm_flow_con': 0.12221246255424453,
            'm_flow_eva': 0.5072144808237113
        },
        'Propane_VaporInjectionPhaseSeparator': {
            'm_flow_con': 0.12236052958964315,
            'm_flow_eva': 0.5062971789448456
        },
        'R32_VaporInjectionEconomizer': {
            'm_flow_con': 0.2335750652761698,
            'm_flow_eva': 0.9552806559898083
        },
        'R32_VaporInjectionPhaseSeparator': {
            'm_flow_con': 0.23509023365071813,
            'm_flow_eva': 0.9530536567212923
        },
        'R134a_Standard': {
            'm_flow_con': 0.09171901398866596,
            'm_flow_eva': 0.2861170780547123
        },
        'R134a_VaporInjectionEconomizer': {
            'm_flow_con': 0.08105962488829771,
            'm_flow_eva': 0.32805139387751864
        },
        'R134a_VaporInjectionPhaseSeparator': {
            'm_flow_con': 0.0809824183319496,
            'm_flow_eva': 0.3263759809952493
        },
        'R152a_Standard': {
            'm_flow_con': 0.08988153310572121,
            'm_flow_eva': 0.29967632922744786
        },
        'R152a_VaporInjectionEconomizer': {
            'm_flow_con': 0.0806911349331151,
            'm_flow_eva': 0.33180010105593655
        },
        'R152a_VaporInjectionPhaseSeparator': {
            'm_flow_con': 0.08073631246873691,
            'm_flow_eva': 0.33155683191906166
        },
        'R410A_Standard': {
            'm_flow_con': 0.2262470533626624,
            'm_flow_eva': 0.7710796852952025
        },
        'R410A_VaporInjectionEconomizer': {
            'm_flow_con': 0.2011073496768124,
            'm_flow_eva': 0.8250453656014359
        },
        'R410A_VaporInjectionPhaseSeparator': {
            'm_flow_con': 0.20346259433325997,
            'm_flow_eva': 0.8179198444245127
        }
    }

    utils.full_factorial_map_generation(
        heat_pump=heat_pump,
        save_path=working_dir,
        T_con_ar=T_con_ar,
        T_eva_in_ar=T_eva_in_ar,
        n_ar=n_ar,
        use_multiprocessing=True,
        save_plots=False,
        m_flow_con=nominal_mass_flow_rates[f"{fluid}_{flowsheet}"]["m_flow_con"],
        m_flow_eva=nominal_mass_flow_rates[f"{fluid}_{flowsheet}"]["m_flow_eva"],
        dT_eva_superheating=5,
        dT_con_subcooling=0,
    )


def create_model(fluid, flowsheet):
    model_name = f"VCLib{flowsheet}{fluid}"
    description = f"Map based on VCLib with {flowsheet.lower()} and {fluid}"
    filename = f"modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/VCLibMap/{flowsheet}_{fluid}.sdf"

    model = f"""
record {model_name}
  "{description}"
  extends Generic(
    refrigerant="{fluid}",
    flowsheet="{flowsheet}",
    filename="{filename}");
end {model_name};
"""
    return model.strip()


def print_package(fluids, flowsheets):
    # Generate models for each combination
    models = []
    for fluid in FLUIDS:
        for flowsheet in FLOWSHEETS:
            models.append(create_model(fluid, flowsheet))

    # Print all generated models
    for model in models:
        print(model)
        print()  # Add an empty line between models for readability


if __name__ == "__main__":
    import logging
    logging.basicConfig(level="INFO")
    from vclibpy.media import set_global_media_properties
    from vclibpy.media import RefProp
    set_global_media_properties(RefProp)
    os.environ["RPPREFIX"] = r"T:\cho\REFPROP"

    FLUIDS = [
        "R410A",
        "R152a",
        "R134a",
        "Propane"
    ]
    FLOWSHEETS = [
        "Standard",
        "VaporInjectionPhaseSeparator",
    ]
    print_package(FLUIDS, FLOWSHEETS)

    for FLUID in FLUIDS:
        for FLOWSHEET in FLOWSHEETS:
            _regression_of_examples(
                working_dir=pathlib.Path(r"D:\00_temp\AixLibVCLibCreation"),
                flowsheet=FLOWSHEET,
                fluid=FLUID
            )
