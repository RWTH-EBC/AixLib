within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData3D;
record GenericHeatPump "Partial n-dimensional heat pump data"
  extends Generic;

  parameter String datasetQCon_flow "Dataset name for useful heat flow rate"
    annotation (Dialog(group="Condenser heat flow"));
  parameter String dataUnitQCon_flow "Data unit for useful heat flow rate"
    annotation (Dialog(group="Condenser heat flow"));
  parameter String scaleUnitsQCon_flow[nDim] "Scale units for useful heat flow rate"
    annotation (Dialog(group="Condenser heat flow"));
end GenericHeatPump;
