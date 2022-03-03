within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SpeedControlledFan_Nrpm;
model Test_SpeedControlledFan_Nrpm
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SpeedControlledFan_Nrpm
    speedControlledFan_Nrpm(use_inputFilter=true,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.TopS25slash10 per)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant T_airIn(k=298.15)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant X_airIn(k=0.005)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=12000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Ramp n(
    height=5,
    duration=600,
    offset=5,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    m_flow=1,
    use_T_in=true,
    T=298.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOutOda_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{12,-72},{32,-52}})));
  AixLib.Fluid.Sensors.MassFractionTwoPort X_airOutOda_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  AixLib.Fluid.Movers.SpeedControlled_Nrpm pump(
    redeclare package Medium = AixLib.Media.Air,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.TopS25slash10 per,
    addPowerToMedium=true,
    use_inputFilter=true)
    annotation (Placement(transformation(extent={{-24,-72},{-4,-52}})));

equation
  connect(m_flow.y, speedControlledFan_Nrpm.m_flow_in)
    annotation (Line(points={{-79,50},{-21.4,50}}, color={0,0,127}));
  connect(T_airIn.y, speedControlledFan_Nrpm.T_airIn) annotation (Line(points={{
          -79,10},{-66,10},{-66,46},{-21.4,46}}, color={0,0,127}));
  connect(X_airIn.y, speedControlledFan_Nrpm.X_airIn) annotation (Line(points={{
          -79,-30},{-58,-30},{-58,42},{-21.4,42}}, color={0,0,127}));
  connect(n.y, speedControlledFan_Nrpm.n_in) annotation (Line(points={{-79,90},{
          -54,90},{-54,54},{-21.4,54}}, color={0,0,127}));
  connect(X_airOutOda_fluid.port_b, bou.ports[1]) annotation (Line(points={{60,-30},
          {66,-30},{66,-50},{80,-50}}, color={0,127,255}));
  connect(T_airOutOda_fluid.port_b, X_airOutOda_fluid.port_a) annotation (Line(
        points={{32,-62},{34,-62},{34,-30},{40,-30}}, color={0,127,255}));
  connect(pump.port_b, T_airOutOda_fluid.port_a)
    annotation (Line(points={{-4,-62},{12,-62}}, color={0,127,255}));
  connect(boundary.ports[1], pump.port_a)
    annotation (Line(points={{-44,-62},{-24,-62}}, color={0,127,255}));
  connect(X_airIn.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-30},{-76,
          -30},{-76,-66},{-66,-66}}, color={0,0,127}));
  connect(boundary.T_in, T_airIn.y) annotation (Line(points={{-66,-58},{-76,-58},
          {-76,10},{-79,10}}, color={0,0,127}));
  connect(boundary.m_flow_in, m_flow.y) annotation (Line(points={{-66,-54},{-70,
          -54},{-70,50},{-79,50}}, color={0,0,127}));
  connect(n.y, pump.Nrpm) annotation (Line(points={{-79,90},{-54,90},{-54,-28},{
          -14,-28},{-14,-50}}, color={0,0,127}));
   annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html><p>
  Simple test of the modell <a href=
  \"modelica://SimpleAHU.Components.SpeedControlledFan_Nrpm\">SimpleAHU.Components.SpeedControlledFan_Nrpm</a>.
</p>
<p>
  Rotational speed and massflowrate are changed over time.
</p>
<p>
  The simulation results can be compared to <a href=
  \"modelica://AixLib.Fluid.Movers.SpeedControlled_Nrpm\">AixLib.Fluid.Movers.SpeedControlled_Nrpm</a>.
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
end Test_SpeedControlledFan_Nrpm;
