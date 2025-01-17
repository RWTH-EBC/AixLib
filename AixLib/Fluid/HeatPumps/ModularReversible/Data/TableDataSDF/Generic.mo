within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF;
record Generic
  "Partial n-dimensional data of refrigerant machines"
  parameter String devIde "Name of the device";
  parameter Integer nDim(min=1) "Number of table dimensions";
  parameter String filename "File name of sdf table data"
    annotation (Dialog(loadSelector(filter="SDF Files (*.sdf);;All Files (*.*)", caption="Select SDF file")));
  parameter Real facGai[nDim]=fill(1, nDim)
    "Additional factor for inputs, e.g. scale relative compressor speed to match values in sdf tables";

  parameter String datasetPEle "Dataset name for electrical power"
    annotation (Dialog(group="Electrical Power"));
  parameter String dataUnitPEle "Data unit for electrical power"
    annotation (Dialog(group="Electrical Power"));
  parameter String scaleUnitsPEle[nDim] "Scale units for electrical power"
    annotation (Dialog(group="Electrical Power"));
  parameter Boolean use_TEvaOutForTab
    "=true to use evaporator outlet temperature for table data, false for inlet";
  parameter Boolean use_TConOutForTab
    "=true to use Useful outlet temperature for table data, false for inlet";
  parameter Integer outOrd[nDim]=1:nDim "Change order of inputs";
  annotation (Documentation(info="<html>
<p>
Record for n-dimensional performance data using SDF tables.
To scale the SI-based inputs from Modelica to possibly different
table inputs, use the <code>scaleUnits</code> parameters or 
<code>facGai</code>. 
</p>
</html>"));
end Generic;
