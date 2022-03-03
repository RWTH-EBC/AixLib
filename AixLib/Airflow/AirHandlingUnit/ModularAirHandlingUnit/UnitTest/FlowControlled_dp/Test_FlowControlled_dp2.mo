within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.FlowControlled_dp;
model Test_FlowControlled_dp2
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.FlowControlled_dp
    flowControlled_dp(
      use_WeatherData=true,
      use_inputFilter=true,
      m_flow_nominal=2000/3600*1.18,
      use_defaultElectricalPower=false)
    annotation (Placement(transformation(extent={{-30,-22},{-10,-2}})));
  AixLib.Fluid.Movers.FlowControlled_dp fan(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-28,-72},{-8,-52}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{102,-52},{82,-32}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOutOda_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{26,-52},{46,-32}})));
  AixLib.Fluid.Sensors.MassFractionTwoPort X_airOutOda_fluid(redeclare package
      Medium =         AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{54,-22},{74,-2}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=1000/3600*1.18,
    duration=5,
    offset=2000/3600*1.18,
    startTime(displayUnit="d") = 14256000)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp dp(
    height=50,
    duration=5,
    offset=50,
    startTime(displayUnit="d") = 13824000)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-64,-98},{-44,-78}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-80,36},{-40,76}}), iconTransformation(extent={{-220,20},
            {-200,40}})));
equation
  connect(boundary.ports[1], fan.port_a) annotation (Line(points={{-8,-62},{
          -4,-62},{-4,-42},{0,-42}}, color={0,127,255}));
  connect(fan.port_b, T_airOutOda_fluid.port_a)
    annotation (Line(points={{20,-42},{26,-42}}, color={0,127,255}));
  connect(X_airOutOda_fluid.port_b, bou.ports[1]) annotation (Line(points={{
          74,-12},{80,-12},{80,-42},{82,-42}}, color={0,127,255}));
  connect(T_airOutOda_fluid.port_b, X_airOutOda_fluid.port_a) annotation (
      Line(points={{46,-42},{48,-42},{48,-12},{54,-12}}, color={0,127,255}));
  connect(m_flow.y, flowControlled_dp.m_flow_in) annotation (Line(points={{
          -79,-30},{-70,-30},{-70,-12},{-31.4,-12}}, color={0,0,127}));
  connect(boundary.m_flow_in, m_flow.y) annotation (Line(points={{-30,-54},{
          -70,-54},{-70,-30},{-79,-30}}, color={0,0,127}));
  connect(dp.y, flowControlled_dp.dp_in) annotation (Line(points={{-79,10},{
          -68,10},{-68,-8},{-31.4,-8}}, color={0,0,127}));
  connect(dp.y, fan.dp_in)
    annotation (Line(points={{-79,10},{10,10},{10,-30}}, color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,90},{-60,90},{-60,56}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.pAtm,x_pTphi. p_in) annotation (Line(
      points={{-60,56},{-72,56},{-72,-82},{-66,-82}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul,x_pTphi. T) annotation (Line(
      points={{-60,56},{-72,56},{-72,-88},{-66,-88}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum,x_pTphi. phi) annotation (Line(
      points={{-60,56},{-72,56},{-72,-94},{-66,-94}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, flowControlled_dp.weaBus) annotation (Line(
      points={{-80,90},{-44,90},{-44,-3},{-30,-3}},
      color={255,204,51},
      thickness=0.5));
  connect(x_pTphi.X[1], boundary.Xi_in[1]) annotation (Line(points={{-43,-88},
          {-38,-88},{-38,-66},{-30,-66}}, color={0,0,127}));
  connect(weaBus.TDryBul, boundary.T_in) annotation (Line(
      points={{-60,56},{-60,-58},{-30,-58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
    annotation (experiment(StopTime=31536000, Interval=1800),
   Documentation(info="<html><p>
  Testing modell <a href=
  \"modelica://SimpleAHU.Components.FlowControlled_dp\">SimpleAHU.Components.FlowControlled_dp</a>
  with weather data.
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
end Test_FlowControlled_dp2;
