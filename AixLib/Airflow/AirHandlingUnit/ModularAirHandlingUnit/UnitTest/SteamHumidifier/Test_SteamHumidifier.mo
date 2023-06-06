within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SteamHumidifier;
model Test_SteamHumidifier
  Modelica.Blocks.Sources.Ramp m_airIn_equation(
    height=0,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant T_steam(k=383.15)
    annotation (Placement(transformation(extent={{36,-70},{16,-50}})));
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
    steamHumidifier(redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-24,-30},{-4,-10}})));

  Modelica.Blocks.Sources.Constant X_in(k=0.003)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=10,
    duration=600,
    offset=283.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Fluid.Humidifiers.GenericHumidifier_u hum1(
    redeclare package Medium = Media.Air,
    m_flow_nominal=2000/3600*1.18,
    show_T=true,
    dp_nominal=0,
    mWat_flow_nominal=0.006,
    TLiqWat_in=293.15,
    steamHumidifier=true,
    TVap=383.15)
    annotation (Placement(transformation(extent={{26,34},{46,54}})));
  Modelica.Blocks.Sources.Constant humPowerSet(k=1)
    annotation (Placement(transformation(extent={{-24,70},{-4,90}})));
  Modelica.Blocks.Sources.Constant m_wat_flow(k=0.006)
    annotation (Placement(transformation(extent={{74,-36},{54,-16}})));
  Utilities.Psychrometrics.Phi_pTX phi
    annotation (Placement(transformation(extent={{14,-34},{26,-22}})));
  Utilities.Psychrometrics.ToTotalAir toTotAir
    annotation (Placement(transformation(extent={{2,-32},{8,-26}})));
protected
  Modelica.Blocks.Sources.Constant p_atm(k=101325)
    annotation (Placement(transformation(extent={{-8,-44},{0,-36}})));
equation
  connect(T_airOut_fluid.port_b, X_airOut_fluid.port_a)
    annotation (Line(points={{84,44},{92,44}},   color={0,127,255}));
  connect(m_airIn_equation.y, steamHumidifier.m_flow_airIn) annotation (Line(
        points={{-79,10},{-52,10},{-52,-12},{-25,-12}}, color={0,0,127}));
  connect(m_airIn_equation.y, boundary.m_flow_in) annotation (Line(points={{-79,10},
          {-52,10},{-52,52},{-14,52}},    color={0,0,127}));
  connect(X_airOut_fluid.port_b, bou.ports[1]) annotation (Line(points={{112,44},
          {120,44},{120,89},{100,89}}, color={0,127,255}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,-30},{-48,-30},
          {-48,48},{-14,48}}, color={0,0,127}));
  connect(T_airIn.y, steamHumidifier.T_airIn) annotation (Line(points={{-79,-30},
          {-48,-30},{-48,-15},{-25,-15}}, color={0,0,127}));
  connect(X_in.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-70},{-48,
          -70},{-48,40},{-14,40}}, color={0,0,127}));
  connect(X_in.y, steamHumidifier.X_airIn) annotation (Line(points={{-79,-70},{
          -48,-70},{-48,-18},{-25,-18}}, color={0,0,127}));
  connect(hum1.port_b, T_airOut_fluid.port_a)
    annotation (Line(points={{46,44},{64,44}}, color={0,127,255}));
  connect(boundary.ports[1], hum1.port_a)
    annotation (Line(points={{8,44},{26,44}}, color={0,127,255}));
  connect(humPowerSet.y, hum1.u) annotation (Line(points={{-3,80},{20,80},{20,
          50},{25,50}}, color={0,0,127}));
  connect(m_wat_flow.y, steamHumidifier.u) annotation (Line(points={{53,-26},{
          42,-26},{42,-80},{-20,-80},{-20,-29.4}}, color={0,0,127}));
  connect(T_steam.y, steamHumidifier.T_watIn) annotation (Line(points={{15,-60},
          {-18,-60},{-18,-29.4},{-17,-29.4}}, color={0,0,127}));
  connect(p_atm.y, phi.p) annotation (Line(points={{0.4,-40},{8,-40},{8,-32.8},
          {13.4,-32.8}}, color={0,0,127}));
  connect(steamHumidifier.T_airOut, phi.T) annotation (Line(points={{-3,-15},{
          5.5,-15},{5.5,-23.2},{13.4,-23.2}}, color={0,0,127}));
  connect(toTotAir.XiTotalAir, phi.X_w) annotation (Line(points={{8.3,-29},{
          11.15,-29},{11.15,-28},{13.4,-28}}, color={0,0,127}));
  connect(steamHumidifier.X_airOut, toTotAir.XiDry) annotation (Line(points={{
          -3,-18},{0,-18},{0,-29},{1.7,-29}}, color={0,0,127}));
  annotation (experiment(
      StopTime=8000,
      __Dymola_NumberOfIntervals=8000,
      __Dymola_Algorithm="Dassl"),
   Documentation(info="<html><p>
  In this model the steam humidifier <a href=
  \"modelica://SimpleAHU.Components.SteamHumidifier\">SimpleAHU.Components.SteamHumidifier</a>
  controls the massfraction of outgoing air with <a href=
  \"modelica://Modelica.Blocks.Continuous.LimPID\">Modelica.Blocks.Continuous.LimPID</a>
</p>
<p>
  The results are then compared to <a href=
  \"modelica://AixLib.Fluid.HeatExchangers.PrescribedOutlet\">AixLib.Fluid.HeatExchangers.PrescribedOutlet</a>
  (boundary conditions are consistent).
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
end Test_SteamHumidifier;
