within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SteamHumidifier;
model Test_SteamHumidifier
  AixLib.Fluid.HeatExchangers.PrescribedOutlet preOut(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2000/3600*1.18,
    dp_nominal=0,
    use_TSet=true)
    annotation (Placement(transformation(extent={{40,34},{60,54}})));
  Modelica.Blocks.Continuous.LimPID PID(
    k=1,
    Ti=0.5,
    yMax=10,
    yMin=0) annotation (Placement(transformation(extent={{34,4},{54,24}})));
  Modelica.Blocks.Sources.Ramp m_airIn_equation(
    height=0,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant T_steam(k=383.15)
    annotation (Placement(transformation(extent={{36,-70},{16,-50}})));
  Modelica.Blocks.Sources.Ramp X_set(
    height=0,
    duration=600,
    offset=0.012,
    startTime=600)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.01,1 - 0.01},
    nPorts=1,
    use_Xi_in=true)
              annotation (Placement(transformation(extent={{-12,34},{8,54}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{80,78},{100,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{64,34},{84,54}})));
  AixLib.Fluid.Sensors.MassFractionTwoPort X_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{92,34},{112,54}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://SimpleAHU/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-76,-100},{-56,-80}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-94,-82},{-54,-42}}),
                                                    iconTransformation(extent={{-220,20},
            {-200,40}})));
equation
  connect(X_set.y, PID.u_s) annotation (Line(points={{-39,90},{-30,90},{-30,14},
          {32,14}}, color={0,0,127}));
  connect(boundary.ports[1], preOut.port_a)
    annotation (Line(points={{8,44},{40,44}},  color={0,127,255}));
  connect(preOut.X_wSet, X_set.y) annotation (Line(points={{38,48},{32,48},{32,90},
          {-39,90}},     color={0,0,127}));
  connect(T_airOut_fluid.port_b, X_airOut_fluid.port_a)
    annotation (Line(points={{84,44},{92,44}},   color={0,127,255}));
  connect(preOut.port_b, T_airOut_fluid.port_a)
    annotation (Line(points={{60,44},{64,44}},          color={0,127,255}));
  connect(m_airIn_equation.y, steamHumidifier.m_flow_airIn) annotation (Line(
        points={{-79,10},{-52,10},{-52,-12},{-25,-12}}, color={0,0,127}));
  connect(steamHumidifier.T_steamIn, T_steam.y) annotation (Line(points={{-17,-29.4},
          {-17,-60},{15,-60}}, color={0,0,127}));
  connect(PID.y, steamHumidifier.m_flow_steam) annotation (Line(points={{55,14},
          {76,14},{76,-92},{-20,-92},{-20,-29.4}}, color={0,0,127}));
  connect(PID.u_m, steamHumidifier.X_airOut)
    annotation (Line(points={{44,2},{44,-18},{-3,-18}}, color={0,0,127}));
  connect(steamHumidifier.T_airOut, preOut.TSet) annotation (Line(points={{-3,-15},
          {12,-15},{12,64},{30,64},{30,52},{38,52}},      color={0,0,127}));
  connect(m_airIn_equation.y, boundary.m_flow_in) annotation (Line(points={{-79,10},
          {-52,10},{-52,52},{-14,52}},    color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,-30},{-74,-30},{-74,-62}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.pAtm,x_pTphi. p_in) annotation (Line(
      points={{-74,-62},{-92,-62},{-92,-84},{-78,-84}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul,x_pTphi. T) annotation (Line(
      points={{-74,-62},{-92,-62},{-92,-90},{-78,-90}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum,x_pTphi. phi) annotation (Line(
      points={{-74,-62},{-92,-62},{-92,-96},{-78,-96}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, steamHumidifier.T_airIn) annotation (Line(
      points={{-74,-62},{-56,-62},{-56,-15},{-25,-15}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, boundary.T_in) annotation (Line(
      points={{-74,-62},{-60,-62},{-60,48},{-14,48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.X[1], steamHumidifier.X_airIn) annotation (Line(points={{-55,
          -90},{-50,-90},{-50,-18},{-25,-18}}, color={0,0,127}));
  connect(x_pTphi.X[1], boundary.Xi_in[1]) annotation (Line(points={{-55,-90},{-50,
          -90},{-50,40},{-14,40}}, color={0,0,127}));
  connect(X_airOut_fluid.port_b, bou.ports[1]) annotation (Line(points={{112,44},
          {120,44},{120,89},{100,89}}, color={0,127,255}));
  annotation (experiment(StopTime=31536000, Interval=1800),
   Documentation(info="<html>
<p>
In this model the steam humidifier <a href=\"modelica://SimpleAHU.Components.SteamHumidifier\">
SimpleAHU.Components.SteamHumidifier</a> controls the massfraction of outgoing air with <a href=\"modelica://Modelica.Blocks.Continuous.LimPID\">Modelica.Blocks.Continuous.LimPID</a> 
<p>The results are then compared to <a href=\"modelica://AixLib.Fluid.HeatExchangers.PrescribedOutlet\">
AixLib.Fluid.HeatExchangers.PrescribedOutlet</a> (boundary conditions are consistent).
</p>
</html>", revisions="<html>
<ul>
<li>November, 2019, by Ervin Lejlic:<br/>First implementation. </li>
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
