within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SteamHumidifier;
model Test_SteamHumidifier2
  Modelica.Blocks.Sources.Ramp m_airIn_equation(
    height=0,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant T_steam(k=383.15)
    annotation (Placement(transformation(extent={{38,-74},{18,-54}})));
  Modelica.Blocks.Sources.Ramp X_set(
    height=0.003,
    duration(displayUnit="s") = 600,
    offset=0.012,
    startTime(displayUnit="s") = 3600)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.01,1 - 0.01},
    use_Xi_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-12,34},{8,54}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{80,78},{100,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{64,34},{84,54}})));
  AixLib.Fluid.Sensors.MassFractionTwoPort X_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{92,34},{112,54}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SteamHumidifier
    steamHumidifier(use_X_set=true,
      redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-24,-30},{-4,-10}})));

  Fluid.Humidifiers.SteamHumidifier_X hum(
    redeclare package Medium = Media.Air,
    m_flow_nominal=2000/3600*1.18,
    show_T=true,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{26,34},{46,54}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.003)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=10,
    duration=600,
    offset=283.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(T_airOut_fluid.port_b, X_airOut_fluid.port_a)
    annotation (Line(points={{84,44},{92,44}},   color={0,127,255}));
  connect(m_airIn_equation.y, steamHumidifier.m_flow_airIn) annotation (Line(
        points={{-79,10},{-52,10},{-52,-12},{-25,-12}}, color={0,0,127}));
  connect(steamHumidifier.T_steamIn, T_steam.y) annotation (Line(points={{-17,
          -29.4},{-17,-64},{17,-64}}, color={0,0,127}));
  connect(m_airIn_equation.y, boundary.m_flow_in) annotation (Line(points={{-79,10},
          {-52,10},{-52,52},{-14,52}},    color={0,0,127}));
  connect(X_airOut_fluid.port_b, bou.ports[1]) annotation (Line(points={{112,44},
          {120,44},{120,89},{100,89}}, color={0,127,255}));
  connect(X_set.y, steamHumidifier.X_set) annotation (Line(points={{-39,90},{
          -26,90},{-26,-9.8},{-14,-9.8}},  color={0,0,127}));
  connect(hum.port_b, T_airOut_fluid.port_a)
    annotation (Line(points={{46,44},{64,44}}, color={0,127,255}));
  connect(boundary.ports[1], hum.port_a)
    annotation (Line(points={{8,44},{26,44}}, color={0,127,255}));
  connect(X_set.y, hum.X_w) annotation (Line(points={{-39,90},{18,90},{18,50},{
          24,50}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,-30},{-42,-30},
          {-42,48},{-14,48}}, color={0,0,127}));
  connect(T_airIn.y, steamHumidifier.T_airIn) annotation (Line(points={{-79,-30},
          {-42,-30},{-42,-15},{-25,-15}}, color={0,0,127}));
  connect(X_in.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-70},{-42,
          -70},{-42,40},{-14,40}}, color={0,0,127}));
  connect(X_in.y, steamHumidifier.X_airIn) annotation (Line(points={{-79,-70},{
          -42,-70},{-42,-18},{-25,-18}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, Interval=1799.99712),
   Documentation(info="<html><p>
  In this model the massfraction of the model <a href=
  \"modelica://SimpleAHU.Components.SteamHumidifier\">SimpleAHU.Components.SteamHumidifier</a>
  is set.
</p>
<p>
  The results are then compared to <a href=
  \"modelica://AixLib.Fluid.HeatExchangers.PrescribedOutlet\">AixLib.Fluid.HeatExchangers.PrescribedOutlet</a>
  (boundary conditions are consistent).
</p>
</html>", revisions="<html>
<ul>
  <li>December, 2019, by Ervin Lejlic:<br/>
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
end Test_SteamHumidifier2;
