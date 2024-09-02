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
    from vclibpy.utils.nominal_design import nominal_hp_design
    from vclibpy import Inputs
    nominal_design = nominal_hp_design(
        heat_pump=heat_pump,
        fluid=fluid,
        inputs=Inputs(T_con_in=273.15 + 47, T_eva_in=271.15, n=0.8, dT_eva_superheating=5, dT_con_subcooling=0),
        dT_eva=5,
        dT_con=8
    )
    heat_pump.terminate()
    utils.full_factorial_map_generation(
        heat_pump=heat_pump,
        save_path=working_dir,
        T_con_ar=T_con_ar,
        T_eva_in_ar=T_eva_in_ar,
        n_ar=n_ar,
        use_multiprocessing=True,
        save_plots=False,
        m_flow_con=nominal_design["m_flow_con"],
        m_flow_eva=nominal_design["m_flow_eva"],
        dT_eva_superheating=5,
        dT_con_subcooling=0,
    )


def create_model(fluid, flowsheet):
    model_name = f"VCLib{flowsheet}{fluid}"
    description = f"Map based on VCLib with {flowsheet} and {fluid}"
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


def compare_old_to_new():
    from vclibpy.utils.sdf_ import sdf_to_csv
    base_path = pathlib.Path(r"D:\00_temp\compare")
    os.makedirs(base_path.joinpath("old"), exist_ok=True)
    os.makedirs(base_path.joinpath("new"), exist_ok=True)

    sdf_to_csv(
        filepath=base_path.joinpath("VCLibMap_old.sdf"),
        save_path=base_path.joinpath("old")
    )
    sdf_to_csv(
        filepath=base_path.joinpath("VaporInjectionPhaseSeparator_Propane.sdf"),
        save_path=base_path.joinpath("new")
    )

    df_old = pd.read_csv(base_path.joinpath("old", "VIPhaseSeparatorFlowsheet_Propane.csv"), index_col=0)
    df_new = pd.read_csv(base_path.joinpath("new", "VaporInjectionPhaseSeparator_Propane.csv"), index_col=0)

    def remove_unit(df):
        columns = {col: col.split(" ")[0] for col in df.columns}
        return df.rename(columns=columns)
    # New / old
    scaling_factor = 9300 / 4050.15977812231
    df_old = remove_unit(df_old)
    df_old = df_old.rename(columns={
        "Q_con": "Q_con_outer",
        "eva_err_ntu": "error_eva",
        "con_err_ntu": "error_con",
        "p_1": "p_eva",
        "p_2": "p_con"
    })
    df_old.loc[:, "Q_con_outer"] *= scaling_factor
    df_old.loc[:, "m_flow_ref"] *= scaling_factor
    df_old.loc[:, "P_el"] = df_old.loc[:, "Q_con_outer"] / df_old.loc[:, "COP"]
    df_new = remove_unit(df_new)
    assert np.all(df_old["n"] == df_new["n"]), "n does not match"
    assert np.all(df_old["T_eva_in"] == df_new["T_eva_in"]), "T_eva_in does not match"
    assert np.all(df_old["T_con_in"] == df_new["T_con_in"]), "T_con_in does not match"
    import matplotlib.pyplot as plt
    variables = ["Q_con_outer", "P_el", "m_flow_ref", "p_eva", "p_con", "error_eva", "error_con"]
    fig, ax = plt.subplots(len(variables), 1)
    for idx, var in enumerate(variables):
        ax[idx].plot([df_old[var].min(), df_old[var].max()], [df_old[var].min(), df_old[var].max()], color="black")
        ax[idx].scatter(df_old[var], df_new[var])
        ax[idx].set_ylabel(f"{var} new")
        ax[idx].set_xlabel(f"{var} old")
    fig2, ax2 = plt.subplots(len(variables), 1)
    for idx, var in enumerate(variables):
        ax2[idx].scatter(df_old["n"], df_old[var] - df_new[var])
        ax2[idx].set_ylabel(f"{var} old-new")
        ax2[idx].set_xlabel(f"n")
    fig3, ax3 = plt.subplots(len(variables), 1)
    for idx, var in enumerate(variables):
        ax3[idx].scatter(df_old["T_con_in"], df_old[var] - df_new[var])
        ax3[idx].set_ylabel(f"{var} old-new")
        ax3[idx].set_xlabel(f"T_con_in")
    fig4, ax4 = plt.subplots(len(variables), 1)
    for idx, var in enumerate(variables):
        ax4[idx].scatter(df_old["T_eva_in"], df_old[var] - df_new[var])
        ax4[idx].set_ylabel(f"{var} old-new")
        ax4[idx].set_xlabel(f"T_eva_in")
    plt.show()
    raise Exception


if __name__ == "__main__":
    import logging
    logging.basicConfig(level="INFO")
    #compare_old_to_new()
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
