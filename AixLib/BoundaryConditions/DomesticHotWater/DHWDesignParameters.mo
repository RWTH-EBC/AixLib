within AixLib.BoundaryConditions.DomesticHotWater;
record DHWDesignParameters
  parameter Modelica.Units.SI.MassFlowRate mDHW_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="DHW Demand"));
  parameter Modelica.Units.SI.HeatFlowRate QDHW_flow_nominal
    "Nominal heat flow rate to DHW" annotation (Dialog(group="DHW Demand"));
  parameter Modelica.Units.SI.Temperature TDHW_nominal
    "Nominal DHW temperature" annotation (Dialog(group="DHW Demand"));
  parameter Modelica.Units.SI.Temperature TDHWCold_nominal
    "Nominal DHW temperature of cold city water"
    annotation (Dialog(group="DHW Demand"));
  parameter Modelica.Units.SI.Volume VDHWDay "Daily volume of DHW tapping"
    annotation (Dialog(group="DHW Demand"));

end DHWDesignParameters;
