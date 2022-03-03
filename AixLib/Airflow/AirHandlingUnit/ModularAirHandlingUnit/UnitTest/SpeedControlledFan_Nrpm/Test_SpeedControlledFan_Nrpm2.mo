within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SpeedControlledFan_Nrpm;
model Test_SpeedControlledFan_Nrpm2
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-80,36},{-40,76}}), iconTransformation(extent={{-220,20},
            {-200,40}})));
  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-92,-100},{-72,-80}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SpeedControlledFan_Nrpm
    speedControlledFan_Nrpm(
      use_WeatherData=true,
      use_inputFilter=true,
      redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.TopS25slash10 per)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    m_flow=1,
    use_T_in=true,
    T=298.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-54,-72},{-34,-52}})));
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
    annotation (Placement(transformation(extent={{-14,-72},{6,-52}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=2000/3600*1.18,
    duration=5,
    offset=2000/3600*1.18,
    startTime(displayUnit="d") = 13824000)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp n(
    height=5,
    duration(displayUnit="d") = 13824000,
    offset=5,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,90},{-60,90},{-60,56}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum,x_pTphi. phi) annotation (Line(
      points={{-60,56},{-100,56},{-100,-96},{-94,-96}},
      color={255,204,51},
      thickness=0.5));
  connect(X_airOutOda_fluid.port_b,bou. ports[1]) annotation (Line(points={{60,-30},
          {66,-30},{66,-50},{80,-50}}, color={0,127,255}));
  connect(T_airOutOda_fluid.port_b,X_airOutOda_fluid. port_a) annotation (Line(
        points={{32,-62},{34,-62},{34,-30},{40,-30}}, color={0,127,255}));
  connect(pump.port_b,T_airOutOda_fluid. port_a)
    annotation (Line(points={{6,-62},{12,-62}},  color={0,127,255}));
  connect(boundary.ports[1],pump. port_a)
    annotation (Line(points={{-34,-62},{-14,-62}}, color={0,127,255}));
  connect(m_flow.y, boundary.m_flow_in) annotation (Line(points={{-79,-30},{-74,
          -30},{-74,-54},{-56,-54}}, color={0,0,127}));
  connect(weaBus.TDryBul, boundary.T_in) annotation (Line(
      points={{-60,56},{-60,-28},{-68,-28},{-68,-58},{-56,-58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.X[1], boundary.Xi_in[1]) annotation (Line(points={{-71,-90},{-66,
          -90},{-66,-66},{-56,-66}}, color={0,0,127}));
  connect(weaBus.pAtm, x_pTphi.p_in) annotation (Line(
      points={{-60,56},{-100,56},{-100,-84},{-94,-84}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, x_pTphi.T) annotation (Line(
      points={{-60,56},{-100,56},{-100,-90},{-94,-90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(n.y, pump.Nrpm)
    annotation (Line(points={{-79,30},{-4,30},{-4,-50}}, color={0,0,127}));
  connect(weaDat.weaBus, speedControlledFan_Nrpm.weaBus) annotation (Line(
      points={{-80,90},{-34,90},{-34,59},{-20,59}},
      color={255,204,51},
      thickness=0.5));
  connect(n.y, speedControlledFan_Nrpm.n_in) annotation (Line(points={{-79,30},{
          -34,30},{-34,54},{-21.4,54}}, color={0,0,127}));
  connect(m_flow.y, speedControlledFan_Nrpm.m_flow_in) annotation (Line(points={
          {-79,-30},{-32,-30},{-32,50},{-21.4,50}}, color={0,0,127}));
 annotation (experiment(StopTime=31536000, Interval=1800),
   Documentation(info="<html><p>
  Testing modell <a href=
  \"modelica://SimpleAHU.Components.SpeedControlledFan_Nrpm\">SimpleAHU.Components.SpeedControlledFan_Nrpm</a>
  with weather data.
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
end Test_SpeedControlledFan_Nrpm2;
