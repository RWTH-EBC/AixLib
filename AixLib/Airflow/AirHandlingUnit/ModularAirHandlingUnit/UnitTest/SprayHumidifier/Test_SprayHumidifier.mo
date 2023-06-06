within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SprayHumidifier;
model Test_SprayHumidifier
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SprayHumidifier
    sprayHumidifier(simplify_m_wat_flow=false,
      redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple,
    k=500000)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

  Modelica.Blocks.Sources.Ramp m_airIn_equation(
    height=0,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Constant T_wat(k=283.15)
    annotation (Placement(transformation(extent={{36,-70},{16,-50}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    use_Xi_in=true,
    X={0.01,1 - 0.01},
    nPorts=1) annotation (Placement(transformation(extent={{-14,36},{6,56}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{98,80},{78,102}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{46,36},{66,56}})));
  AixLib.Fluid.Sensors.MassFractionTwoPort X_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{74,36},{94,56}})));

  Modelica.Blocks.Sources.Constant X_in(k=0.003)
    annotation (Placement(transformation(extent={{-100,-68},{-80,-48}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=10,
    duration=600,
    offset=283.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
  Modelica.Blocks.Sources.Constant m_wat_flow(k=0.002)
    annotation (Placement(transformation(extent={{70,-14},{50,6}})));
  Fluid.Humidifiers.Humidifier_u hum(
    redeclare package Medium = Media.Air,
    m_flow_nominal=2000/3600*1.18,
    show_T=true,
    dp_nominal=0,
    mWat_flow_nominal=0.006)
    annotation (Placement(transformation(extent={{22,36},{42,56}})));
  Modelica.Blocks.Sources.Constant humPowerSet(k=1)
    annotation (Placement(transformation(extent={{-20,68},{0,88}})));
equation
  connect(m_airIn_equation.y, sprayHumidifier.m_flow_airIn) annotation (Line(
        points={{-79,30},{-58,30},{-58,-2},{-21,-2}}, color={0,0,127}));
  connect(T_wat.y, sprayHumidifier.T_watIn)
    annotation (Line(points={{15,-60},{-13,-60},{-13,-19.4}},
                                                            color={0,0,127}));
  connect(T_airOut_fluid.port_b, X_airOut_fluid.port_a)
    annotation (Line(points={{66,46},{74,46}},   color={0,127,255}));
  connect(m_airIn_equation.y, boundary.m_flow_in) annotation (Line(points={{-79,30},
          {-58,30},{-58,54},{-16,54}},    color={0,0,127}));
  connect(bou.ports[1], X_airOut_fluid.port_b) annotation (Line(points={{78,91},
          {62,91},{62,68},{96,68},{96,46},{94,46}}, color={0,127,255}));
  connect(T_airIn.y, sprayHumidifier.T_airIn) annotation (Line(points={{-79,-18},
          {-50,-18},{-50,-5},{-21,-5}}, color={0,0,127}));
  connect(X_in.y, sprayHumidifier.X_airIn) annotation (Line(points={{-79,-58},{
          -42,-58},{-42,-8},{-21,-8}}, color={0,0,127}));
  connect(X_in.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-58},{-42,
          -58},{-42,42},{-16,42}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,-18},{-50,-18},
          {-50,50},{-16,50}}, color={0,0,127}));
  connect(m_wat_flow.y, sprayHumidifier.u) annotation (Line(points={{49,-4},{38,
          -4},{38,-78},{-16,-78},{-16,-19.4}}, color={0,0,127}));
  connect(boundary.ports[1], hum.port_a)
    annotation (Line(points={{6,46},{22,46}}, color={0,127,255}));
  connect(hum.port_b, T_airOut_fluid.port_a) annotation (Line(points={{42,46},{
          44,46},{44,46},{46,46}}, color={0,127,255}));
  connect(humPowerSet.y, hum.u) annotation (Line(points={{1,78},{16,78},{16,52},
          {21,52}}, color={0,0,127}));
  annotation (experiment(
      StopTime=8000,
      __Dymola_NumberOfIntervals=8000,
      __Dymola_Algorithm="Dassl"),
   Documentation(info="<html><p>
  In this model the spray humidifier <a href=
  \"modelica://SimpleAHU.Components.SprayHumidifier\">SimpleAHU.Components.SprayHumidifier</a>
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
    experiment(StopTime=31536000),
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
end Test_SprayHumidifier;
