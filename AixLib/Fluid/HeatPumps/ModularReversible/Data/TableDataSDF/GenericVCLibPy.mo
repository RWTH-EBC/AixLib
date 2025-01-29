within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF;
record GenericVCLibPy
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.GenericHeatPump(
    final devIde="VCLib_" + flowsheet + "_" + refrigerant,
    final dataUnitQCon_flow="W",
    final datasetQCon_flow="/" + flowsheet + "/" + refrigerant + "/Q_con_outer",
    final use_TConOutForTab=false,
    final use_TEvaOutForTab=false,
    final dataUnitPEle="W",
    final datasetPEle="/" + flowsheet + "/" + refrigerant + "/P_el",
    final facGai=fill(1, nDim));
  parameter String flowsheet "Name of the flowsheet";
  parameter String refrigerant "Name of the fluid";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GenericVCLibPy;
