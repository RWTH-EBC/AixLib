within AixLib.Fluid.HeatPumps.BaseClasses;
model CapacityWithLosses
  "Base model for heat capacity with heat losses depending on ambient conditions"
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCap(final C=C)
    "heat Capacity"
    annotation (Placement(transformation(extent={{-22,-72},{16,-34}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionInn
    "Convection between fluid and solid"
    annotation (Placement(transformation(extent={{26,-80},{42,-64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempCon
    "Foreces heat losses according to ambient temperature"
    annotation (Placement(transformation(extent={{-84,-80},{-68,-64}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionOut
    "Convection between solid and ambient air"
    annotation (Placement(transformation(extent={{-34,-80},{-50,-64}})));
  Modelica.Blocks.Interfaces.RealInput T_amb "Ambient air temperature"
    annotation (Placement(transformation(extent={{-140,-92},{-100,-52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluidPort
    "Port to be connected to the Volume of Heat Exchanger"
    annotation (Placement(transformation(extent={{94,-82},{114,-62}})));
  parameter Modelica.SIunits.HeatCapacity C "Heat capacity of element (= cp*m)";
  Modelica.Blocks.Interfaces.RealInput mFlowOut "Mass flow rate on the outside"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput mFlowInn "Mass flow rate on the inside"
    annotation (Placement(transformation(extent={{140,0},{100,40}})));
equation
  connect(convectionInn.solid, heatCap.port)
    annotation (Line(points={{26,-72},{-3,-72}}, color={191,0,0}));
  connect(varTempCon.port, convectionOut.fluid)
    annotation (Line(points={{-68,-72},{-50,-72}}, color={191,0,0}));
  connect(convectionOut.solid, heatCap.port)
    annotation (Line(points={{-34,-72},{-3,-72}}, color={191,0,0}));
  connect(varTempCon.T, T_amb)
    annotation (Line(points={{-85.6,-72},{-120,-72}}, color={0,0,127}));
  connect(convectionInn.fluid, fluidPort)
    annotation (Line(points={{42,-72},{104,-72}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CapacityWithLosses;
