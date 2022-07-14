within AixLib.Utilities.Sensors;
model EnergyMeter
  "\"Integrates power [W] that is connected to input connector\""
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));
  Modelica.Blocks.Interfaces.RealInput p(unit="W") annotation(Placement(transformation(origin={-60,0},    extent={{14,-14},
            {-14,14}},                                                                                                                     rotation = 180),
        iconTransformation(
        extent={{14,-14},{-14,14}},
        rotation=180,
        origin={-56,0})));
  Modelica.Units.NonSI.Energy_kWh q_kWh;
  Modelica.Units.SI.Energy q_joule(
    stateSelect=StateSelect.avoid,
    start=0.0,
    fixed=energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial);
equation
  der(q_joule) = p;
  q_kWh =Modelica.Units.Conversions.to_kWh(q_joule);
  annotation (preferredView = "info", Icon(coordinateSystem(extent={{-60,-80},{
            60,80}}),                      graphics={  Rectangle(extent = {{-40, 66}, {46, -62}}, lineColor = {0, 0, 255}, fillColor = {95, 95, 95},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-20, 38}, {30, 12}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{4, 24}, {4, 14}, {4, 16}}, color = {0, 0, 0}), Line(points = {{14, 24}, {14, 14}, {14, 16}}, color = {0, 0, 0}), Line(points = {{24, 24}, {24, 14}, {24, 16}}, color = {0, 0, 0}), Line(points = {{-6, 24}, {-6, 14}, {-6, 16}}, color = {0, 0, 0}), Line(points = {{-14, 24}, {-14, 14}, {-14, 16}}, color = {0, 0, 0}), Line(points = {{-16, 30}, {28, 30}, {26, 30}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{0, 30}, {10, 30}, {10, 30}}, color = {255, 0, 0}, thickness = 0.5), Text(extent = {{-12, 24}, {-4, 14}}, lineColor = {0, 0, 0}, textString = "1"), Text(extent = {{16, 24}, {24, 14}}, lineColor = {0, 0, 0}, textString = "1"), Text(extent = {{6, 24}, {14, 14}}, lineColor = {0, 0, 0}, textString = "1"), Text(extent = {{-4, 24}, {4, 14}}, lineColor = {0, 0, 0}, textString = "1")}), Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model of an energy meter (integration over time of the Real input
  connector [W]).
</p>
<p>
  <span style=\"font-size: 14pt;\">BE CAREFUL:</span> Model <b>might slow
  down the simulation speed</b> since unnecessaries state events might
  be triggered.
</p>
<p>
  So please check prior whether it is worth to implement the meter.
</p>
<ul>
  <li>
    <i>October 11, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Removed two old models and combined to this one. Give input
    connector unit [W].
  </li>
  <li>
    <i>October 15, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>by Alexander Hoh:<br/>
    implemented
  </li>
</ul>
</html>", revisions="<html>
<ul>
  <li>
    <i>May 5, 2021</i> by Fabian Wüllhorst:<br/>
    Add energyDynamics as parameter (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1093\">#1093</a>)
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-60,-80},{60,80}})));
end EnergyMeter;
