within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VCLibPy;
partial record Generic "Partial record for 3D VCLibPy data for heat pumps"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.Generic(
    final devIde="VCLib_" + flowsheet + "_" + refrigerant,
    final scaleUnitsQCon_flow={"","K","K"},
    final dataUnitQCon_flow="W",
    final datasetQCon_flow="/" + flowsheet + "/" + refrigerant + "/Q_con_outer",
    final outOrd={3,1,2},
    final use_TConOutForTab=false,
    final use_TEvaOutForTab=false,
    final scaleUnitsPEle={"","K","K"},
    final dataUnitPEle="W",
    final datasetPEle="/" + flowsheet + "/" + refrigerant + "/P_el",
    final facGai=fill(1, nDim));
  parameter String flowsheet "Name of the flowsheet";
  parameter String refrigerant "Name of the fluid";
end Generic;
