within AixLib.PlugNHarvest.Components.Ventilation.BaseClasses;
partial model PartialVentilationOutside
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"  annotation (choicesAllMatching = true);
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  inner Modelica.Fluid.System system;
protected
  Medium.ThermodynamicState state_b "state for medium inflowing through port_b";
public
  Modelica.Blocks.Interfaces.RealInput Toutside(unit="K")
    "temperature of outside air"
    annotation (Placement(transformation(extent={{-128,62},{-88,102}})));
  Modelica.Blocks.Interfaces.RealInput XoutsideAir[Medium.nX](unit="kg/kg")
    "composition of outside air air,water"
    annotation (Placement(transformation(extent={{-128,30},{-88,70}})));
equation
  // medium states
  state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialVentilationOutside;
