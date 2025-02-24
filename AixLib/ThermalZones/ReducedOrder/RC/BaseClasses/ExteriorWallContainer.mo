within AixLib.ThermalZones.ReducedOrder.RC.BaseClasses;
model ExteriorWallContainer
  "container for exterior wall RC element that has the option for a pass-through"
  parameter Integer n(min = 1) "Number of RC elements";
  parameter Modelica.Units.SI.ThermalResistance RExt[n](
    each min=Modelica.Constants.small)
    "Vector of resistors, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.Units.SI.ThermalResistance RExtRem(
    min=Modelica.Constants.small)
    "Resistance of remaining resistor RExtRem between capacitor n and port_b"
     annotation(Dialog(group="Thermal mass"));
  parameter Modelica.Units.SI.HeatCapacity CExt[n](
    each min=Modelica.Constants.small)
    "Vector of heat capacities, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.Units.SI.Temperature T_start
    "Initial temperature of capacities"
    annotation(Dialog(group="Thermal mass"));

  parameter Boolean pasThr=false
    "If true, there is no RC element and heat flow is passed through";

  AixLib.ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall extWalRC(
    n=n,
    RExt=RExt,
    RExtRem=RExtRem,
    CExt=CExt,
    T_start=T_start) if not pasThr
    "RC element that may be conditionally removed by pass-through option"
    annotation (Placement(transformation(extent={{-10,-10},{10,12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a "interior port"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
    iconTransformation(extent={{-110,-10},{-90,10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b "exterior port"
      annotation (Placement(transformation(extent={{90,-10},{110,10}}),
      iconTransformation(extent={{90,-10},{110,10}})));

equation
  if pasThr then
    port_a.Q_flow = -port_b.Q_flow;
    0 = port_a.T - port_b.T;
  else
    connect(port_a, extWalRC.port_a)
      annotation (Line(points={{-100,0},{-10,0}}, color={191,0,0}));
    connect(extWalRC.port_b, port_b)
      annotation (Line(points={{10,0},{100,0}}, color={191,0,0}));
  end if;
  annotation(defaultComponentName = "extWalRC",
  Diagram(coordinateSystem(preserveAspectRatio = false, extent=
  {{-100, -100}, {100, 120}})),           Documentation(info="<html>
   <p><code>ExteriorWall</code> represents heat conduction and heat storage
   within walls. It links a variable number <code>n</code> of thermal resistances
   and capacities to a series connection. <code>n</code> thus defines the spatial
   discretization of thermal effects within the wall. All effects are considered
   as one-dimensional normal to the wall&apos;s surface. This model is thought
   for exterior wall elements that contribute to heat transfer to the outdoor.
   The RC-chain is defined via a vector of capacities <code>CExt[n]</code> and a
   vector of resistances <code>RExt[n]</code>. Resistances and capacities are
   connected alternately, starting with the first resistance <code>RExt[1]</code>,
   from heat <code>port_a</code> to heat <code>port_b</code>. <code>RExtRem</code>
   is the resistance between the last capacity <code>CExt[end]</code> and the
   heat <code>port_b</code>. In this model, the variable <code>pass_through</code>
  defines if the RC is installed or not.</p>
   <p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/RC/BaseClasses/ExtMassVarRC/ExtMassVarRC.png\" alt=\"image\"/> </p>
   </html>", revisions="<html>
   <ul>
 <li>
 April 20, 2023, by Philip Groesdonk:<br/>
 First Implementation. This is for AixLib issue
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1080\">#1080</a>.
 </li>
   </ul>
   </html>"), Icon(coordinateSystem(preserveAspectRatio=false,  extent=
  {{-100,-100},{100,120}}), graphics={  Rectangle(extent = {{-86, 60}, {-34, 26}},
   fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-28, 60}, {26, 26}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{32, 60}, {86, 26}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{0, 20}, {54, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-60, 20}, {-6, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, -20}, {-34, -54}}, fillColor = {255, 213, 170},
   fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-28, -20}, {26, -54}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{32, -20}, {86, -54}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-60, -60}, {-6, -94}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{0, -60}, {54, -94}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-60, 100}, {-6, 66}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{0, 100}, {54, 66}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{60, -60}, {86, -92}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{60, 20}, {86, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{60, 100}, {86, 66}}, fillColor = {255, 213, 170},
   fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, -60}, {-66, -94}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, 20}, {-66, -14}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
    extent = {{-86, 100}, {-66, 66}}, fillColor = {255, 213, 170},
   fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}),
   Line(points = {{-90, 0}, {90, 0}}, color = {0, 0, 0}, thickness = 0.5,
   smooth = Smooth.None), Rectangle(extent = {{-74, 12}, {-26, -10}},
   lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid), Rectangle(extent = {{28, 12}, {76, -10}},
   lineColor = {0, 0, 0}, lineThickness =  0.5, fillColor = {255, 255, 255},
   fillPattern = FillPattern.Solid), Line(points = {{-1, 0}, {-1, -32}},
   color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None),
   Line(points = {{-18, -32}, {16, -32}}, pattern = LinePattern.None,
   thickness = 0.5, smooth = Smooth.None), Line(points = {{-18, -44}, {16, -44}},
   pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None),
   Text(
     extent = {{-90, 142}, {90, 104}},
     textColor = {0, 0, 255},
     textString = "%name"),
   Line(points = {{18, -32}, {-20, -32}}, color = {0, 0, 0}, thickness = 0.5,
   smooth = Smooth.None),
   Line(points = {{14, -44}, {-15, -44}}, color = {0, 0, 0}, thickness = 0.5,
   smooth = Smooth.None)}));
end ExteriorWallContainer;
