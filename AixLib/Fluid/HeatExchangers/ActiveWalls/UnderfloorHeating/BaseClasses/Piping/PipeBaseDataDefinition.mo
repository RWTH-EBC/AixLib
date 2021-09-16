within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping;
record PipeBaseDataDefinition "Pipe base data definition"
  extends Modelica.Icons.Record;

  parameter Integer n(min = 1)
    "Number of pipe layers"
    annotation(Dialog(tab = "Pipe", group = "Pipe parameters"));
  parameter Modelica.SIunits.Diameter d[n]
    "Diameter of pipe layers"
    annotation(Dialog(tab = "Pipe", group = "Pipe parameters"));
  parameter Modelica.SIunits.Length t[n]
    "Thickness of pipe layers"
    annotation(Dialog(tab = "Pipe", group = "Pipe parameters"));
  parameter Modelica.SIunits.ThermalConductivity lambda[n]
    "Thermal conductivity of pipe layers"
    annotation(Dialog(tab = "Pipe", group = "Pipe parameters"));
end PipeBaseDataDefinition;
