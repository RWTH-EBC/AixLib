within AixLib.Fluid.Chillers.ModularReversible.Data.TableDataSDF;
record GenericVCLibPy "Generic record for VCLibPy data for chillers"
  extends GenericChiller(
    final devIde="VCLib_" + flowsheet + "_" + refrigerant,
    final dataUnitQEva_flow="W",
    final datasetQEva_flow="/" + flowsheet + "/" + refrigerant + "/Q_eva_outer",
    use_TConOutForTab=false,
    use_TEvaOutForTab=false,
    final dataUnitPEle="W",
    final datasetPEle="/" + flowsheet + "/" + refrigerant + "/P_el",
    final facGai=fill(1, nDim));
  parameter String flowsheet "Name of the flowsheet";
  parameter String refrigerant "Name of the fluid";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GenericVCLibPy;
