within AixLib.Utilities.Examples;
model HeatTransfer_test "Test routine for heat transfer models"
  extends Modelica.Icons.Example;
  HeatTransfer.HeatConv heatConv(hCon=2, A=16) annotation (Placement(transformation(extent={{-10,38},{10,58}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor load(C = 1000 * 1600 * 16 * 0.2) annotation(Placement(transformation(extent = {{-10, 20}, {10, 40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatCond(G = 16 * 2.4 / 0.1) annotation(Placement(transformation(extent = {{-10, 2}, {10, 22}})));
  HeatTransfer.HeatConvInside heatConv_inside(
    A=16,
    hCon_const=2,
    surfaceOrientation=2,
    calcMethod=1) annotation (Placement(transformation(extent={{-10,-18},{10,2}})));
  HeatTransfer.HeatConvOutside heatTransfer_Outside(
    calcMethod=1,
    A=16,
    hCon_const=25,
    surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()) annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatTrans(G = 16 * 1.5) annotation(Placement(transformation(extent = {{-10, -56}, {10, -36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TempOutside annotation(Placement(transformation(extent = {{-80, 0}, {-60, 20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TempInside annotation(Placement(transformation(extent = {{80, 0}, {60, 20}})));
  Modelica.Blocks.Sources.Sine sineWindSpeed(amplitude=10, f=0.5)
    annotation (Placement(transformation(extent={{-34,-24},{-24,-14}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow[6] annotation(Placement(transformation(extent = {{76, 50}, {94, 68}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=15,
    f=1/3600/12,
    offset=273.15 + 15)
    annotation (Placement(transformation(extent={{-100,-20},{-86,-6}})));
  Modelica.Blocks.Sources.Constant constTempInside(k=273.15 + 20)
                                                            annotation(Placement(transformation(extent = {{7, -7}, {-7, 7}}, origin = {93, -15})));
equation
  //Connecting the Heat Flow Output, models as stated below in source code
  Q_flow[1] = heatConv.port_b.Q_flow;
  Q_flow[2] = load.port.Q_flow;
  Q_flow[3] = heatCond.port_b.Q_flow;
  Q_flow[4] = heatConv_inside.port_b.Q_flow;
  Q_flow[5] = heatTransfer_Outside.port_b.Q_flow;
  Q_flow[6] = heatTrans.port_b.Q_flow;
  connect(TempOutside.port, load.port) annotation(Line(points = {{-60, 10}, {-40, 10}, {-40, 20}, {0, 20}}, color = {191, 0, 0}));
  connect(TempOutside.port, heatCond.port_a) annotation(Line(points = {{-60, 10}, {-40, 10}, {-40, 12}, {-10, 12}}, color = {191, 0, 0}));
  connect(TempOutside.port, heatConv_inside.port_a) annotation (Line(
      points={{-60,10},{-40,10},{-40,-8},{-10,-8}},
      color={191,0,0}));
  connect(heatConv.port_b, TempInside.port) annotation(Line(points = {{10, 48}, {46, 48}, {46, 10}, {60, 10}}, color = {191, 0, 0}));
  connect(heatCond.port_b, TempInside.port) annotation(Line(points = {{10, 12}, {46, 12}, {46, 10}, {60, 10}}, color = {191, 0, 0}));
  connect(heatConv_inside.port_b, TempInside.port) annotation (Line(
      points={{10,-8},{46,-8},{46,10},{60,10}},
      color={191,0,0}));
  connect(sineWindSpeed.y, heatTransfer_Outside.WindSpeedPort) annotation(Line(points = {{-23.5, -19}, {-18, -19}, {-18, -35.2}, {-9.2, -35.2}}, color = {0, 0, 127}));
  connect(TempOutside.port, heatConv.port_a) annotation(Line(points = {{-60, 10}, {-40, 10}, {-40, 48}, {-10, 48}}, color = {191, 0, 0}));
  connect(sine.y, TempOutside.T) annotation (Line(points={{-85.3,-13},{-82,-13},{-82,10}}, color={0,0,127}));
  connect(constTempInside.y, TempInside.T) annotation(Line(points = {{85.3, -15}, {84, -15}, {84, -16}, {84, -16}, {84, 10}, {82, 10}}, color = {0, 0, 127}));
  connect(TempOutside.port, heatTrans.port_a) annotation(Line(points = {{-60, 10}, {-40, 10}, {-40, -46}, {-10, -46}}, color = {191, 0, 0}));
  connect(heatTrans.port_b, TempInside.port) annotation(Line(points = {{10, -46}, {46, -46}, {46, 10}, {60, 10}}, color = {191, 0, 0}));
  connect(heatTransfer_Outside.port_a, TempOutside.port) annotation(Line(points = {{-10, -28}, {-40, -28}, {-40, 10}, {-60, 10}}, color = {191, 0, 0}));
  connect(heatTransfer_Outside.port_b, TempInside.port) annotation(Line(points = {{10, -28}, {46, -28}, {46, 10}, {60, 10}}, color = {191, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Text(extent = {{14, 46}, {26, 36}}, lineColor = {0, 0, 255}, textString = "1"), Text(extent = {{14, 30}, {26, 20}}, lineColor = {0, 0, 255}, textString = "2"), Text(extent = {{14, 10}, {26, 0}}, lineColor = {0, 0, 255}, textString = "3"), Text(extent = {{14, -10}, {26, -20}}, lineColor = {0, 0, 255}, textString = "4"), Text(extent = {{14, -30}, {26, -40}}, lineColor = {0, 0, 255}, textString = "5"), Text(extent = {{14, -48}, {26, -58}}, lineColor = {0, 0, 255}, textString = "6")}), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Test routine to check simple heat transfer models with a maximum of 2
  temperature connectors.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Simple test to calculate the heat flux through the different
  conduction and convection models.
</p>
<p>
  Boundary conditions can be given by 2 different temperatur values on
  each side of the model. Models with additional inputs (e.g. variable
  thermal conductivity, wind speed, ...) will be given preferably
  alternating input values, for example customized sine values.
</p>
<ul>
  <li>September 25, 2015 by Marcus Fuchs:<br/>
    Fixed unknown variable problem for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/115\">#115</a>
  </li>
  <li>April 16, 2013, by Ole Odendahl:<br/>
    Implemented, added documentation and formatted appropriately
  </li>
</ul>
</html>
 "), experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end HeatTransfer_test;
