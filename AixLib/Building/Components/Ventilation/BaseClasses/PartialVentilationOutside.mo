within AixLib.Building.Components.Ventilation.BaseClasses;
partial model PartialVentilationOutside
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"  annotation (choicesAllMatching = true);
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  inner Modelica.Fluid.System system;
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  Modelica.Blocks.Interfaces.RealInput WindDirectionPort annotation (Placement(transformation(extent={{-126,-60},{-86,-20}})));
protected
  Medium.ThermodynamicState state_b "state for medium inflowing through port_b";
equation
  // medium states
  state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialVentilationOutside;
