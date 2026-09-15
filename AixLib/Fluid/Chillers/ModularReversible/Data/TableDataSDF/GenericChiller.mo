within AixLib.Fluid.Chillers.ModularReversible.Data.TableDataSDF;
record GenericChiller "Partial n-dimensional chiller data"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.Generic;

  parameter String datasetQEva_flow "Dataset name for useful cooling capacity"
    annotation (Dialog(group="Evaporator heat flow"));
  parameter String dataUnitQEva_flow "Data unit for useful cooling capacity"
    annotation (Dialog(group="Evaporator heat flow"));
  parameter String scaleUnitsQEva_flow[nDim] "Scale units for useful cooling capacity"
    annotation (Dialog(group="Evaporator heat flow"));
  annotation (Documentation(info="<html>
<p>
  Record for n-dimensional chiller performance data, enabling
  a selection for cooling only data.
</p>
</html>"));
end GenericChiller;
