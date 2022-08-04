within AixLib.Utilities.Examples;
model HeatConv_outside
  extends Modelica.Icons.Example;
  HeatTransfer.HeatConvOutside heatTransfer_Outside(
    calcMethod=3,
    A=16,
    hCon_const=25) annotation (Placement(transformation(extent={{-24,-2},{2,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Tinside annotation(Placement(transformation(extent = {{40, 20}, {20, 40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Toutside annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-50, 30})));
  Modelica.Blocks.Sources.RealExpression Windspeed(y = 4) annotation(Placement(transformation(extent = {{-60, -26}, {-40, -6}})));
  Modelica.Blocks.Sources.Constant const(k = 10 + 273.15) annotation(Placement(transformation(extent = {{-100, 20}, {-80, 40}})));
  Modelica.Blocks.Sources.Constant const1(k = 20 + 273.15) annotation(Placement(transformation(extent = {{80, 20}, {60, 40}})));
  Modelica.Blocks.Sources.RealExpression HeatFlow(y = heatTransfer_Outside.port_b.Q_flow) annotation(Placement(transformation(extent = {{20, -44}, {40, -24}})));
equation
  connect(const.y, Toutside.T) annotation(Line(points = {{-79, 30}, {-70, 30}, {-70, 30}, {-62, 30}, {-62, 30}, {-62, 30}}, color = {0, 0, 127}));
  connect(const1.y, Tinside.T) annotation(Line(points = {{59, 30}, {42, 30}}, color = {0, 0, 127}));
  connect(heatTransfer_Outside.port_a, Toutside.port) annotation(Line(points = {{-24, 11}, {-34, 11}, {-34, 30}, {-40, 30}}, color = {191, 0, 0}));
  connect(heatTransfer_Outside.port_b, Tinside.port) annotation(Line(points = {{2, 11}, {10, 11}, {10, 30}, {20, 30}}, color = {191, 0, 0}));
  connect(Windspeed.y, heatTransfer_Outside.WindSpeedPort) annotation (Line(
      points={{-39,-16},{-36,-16},{-36,1.64},{-22.96,1.64}},
      color={0,0,127}));
  annotation (Documentation(revisions = "<html><ul>
  <li>
    <i>April 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>October 14, 2012&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Plot HeatFlow for the different ways of calcutating the heat transfer
  to see the difference.
</p>
</html>"), experiment(StopTime = 3600, Interval = 60, Algorithm = "Lsodar"));
end HeatConv_outside;
