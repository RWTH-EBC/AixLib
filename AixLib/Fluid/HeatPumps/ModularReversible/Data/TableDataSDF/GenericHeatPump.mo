within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF;
record GenericHeatPump "Partial n-dimensional heat pump data"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.Generic;

  parameter String datasetQCon_flow "Dataset name for useful heat flow rate"
    annotation (Dialog(group="Condenser heat flow"));
  parameter String dataUnitQCon_flow "Data unit for useful heat flow rate"
    annotation (Dialog(group="Condenser heat flow"));
  parameter String scaleUnitsQCon_flow[nDim] "Scale units for useful heat flow rate"
    annotation (Dialog(group="Condenser heat flow"));
  annotation (Documentation(info="<html>
<p>
  Record for n-dimensional heat pump performance data, enabling
  a selection for heating only data.
</p>
</html>"));
end GenericHeatPump;
