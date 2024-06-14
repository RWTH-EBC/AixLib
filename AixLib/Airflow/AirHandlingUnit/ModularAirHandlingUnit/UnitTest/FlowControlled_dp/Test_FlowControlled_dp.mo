within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.FlowControlled_dp;
model Test_FlowControlled_dp
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.FlowControlled_dp
    flowControlled_dp(
      use_WeatherData=false,
      use_inputFilter=true,
      m_flow_nominal=2000/3600*1.18,
      use_defaultElectricalPower=false)
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Blocks.Sources.Constant T_airIn(k=298.15)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant X_airIn(k=0.005)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  AixLib.Fluid.Movers.FlowControlled_dp fan(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{102,20},{82,40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOutOda_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{26,20},{46,40}})));
  AixLib.Fluid.Sensors.MassFractionTwoPort X_airOutOda_fluid(redeclare package
      Medium =         AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{54,50},{74,70}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=12000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Ramp dp(
    height=40,
    duration=600,
    offset=20,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(T_airIn.y, flowControlled_dp.T_airIn) annotation (Line(points={{-79,
          10},{-60,10},{-60,56},{-31.4,56}}, color={0,0,127}));
  connect(X_airIn.y, flowControlled_dp.X_airIn) annotation (Line(points={{-79,
          -30},{-56,-30},{-56,52},{-31.4,52}}, color={0,0,127}));
  connect(boundary.ports[1], fan.port_a) annotation (Line(points={{-20,10},{
          -4,10},{-4,30},{0,30}}, color={0,127,255}));
  connect(fan.port_b, T_airOutOda_fluid.port_a)
    annotation (Line(points={{20,30},{26,30}}, color={0,127,255}));
  connect(X_airOutOda_fluid.port_b, bou.ports[1]) annotation (Line(points={{
          74,60},{80,60},{80,30},{82,30}}, color={0,127,255}));
  connect(T_airOutOda_fluid.port_b, X_airOutOda_fluid.port_a) annotation (
      Line(points={{46,30},{48,30},{48,60},{54,60}}, color={0,127,255}));
  connect(X_airIn.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-30},{
          -50,-30},{-50,6},{-42,6}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,10},{-54,10},
          {-54,14},{-42,14}}, color={0,0,127}));
  connect(m_flow.y, flowControlled_dp.m_flow_in) annotation (Line(points={{
          -79,50},{-70,50},{-70,60},{-31.4,60}}, color={0,0,127}));
  connect(boundary.m_flow_in, m_flow.y) annotation (Line(points={{-42,18},{
          -70,18},{-70,50},{-79,50}}, color={0,0,127}));
  connect(dp.y, flowControlled_dp.dp_in) annotation (Line(points={{-79,90},{
          -68,90},{-68,64},{-31.4,64}}, color={0,0,127}));
  connect(dp.y, fan.dp_in)
    annotation (Line(points={{-79,90},{10,90},{10,42}}, color={0,0,127}));
   annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html><p>
  Simple test of the modell <a href=
  \"modelica://SimpleAHU.Components.FlowControlled_dp\">SimpleAHU.Components.FlowControlled_dp</a>.
</p>
<p>
  Pressure rise and massflowrate are changed over time.
</p>
<p>
  The simulation results can be compared to <a href=
  \"modelica://AixLib.Fluid.Movers.FlowControlled_dp\">AixLib.Fluid.Movers.FlowControlled_dp</a>.
</p>
</html>", revisions="<html>
<ul>
  <li>November, 2019, by Ervin Lejlic:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    experiment(StopTime=7000),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}));
end Test_FlowControlled_dp;
