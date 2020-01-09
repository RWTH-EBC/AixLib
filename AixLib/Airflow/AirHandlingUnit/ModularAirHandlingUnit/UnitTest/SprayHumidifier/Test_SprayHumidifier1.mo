within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SprayHumidifier;
model Test_SprayHumidifier1
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SprayHumidifier
    sprayHumidifier(simplify_m_wat_flow=false,
      use_X_set=true,
      redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet preOut(
    redeclare package Medium = AixLib.Media.Air,
    allowFlowReversal=true,
    m_flow_nominal=2000/3600*1.18,
    dp_nominal=0,
    use_TSet=false)
    annotation (Placement(transformation(extent={{20,36},{40,56}})));
  Modelica.Blocks.Sources.Ramp m_airIn_equation(
    height=0,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Constant T_wat(k=283.15)
    annotation (Placement(transformation(extent={{36,-70},{16,-50}})));
  Modelica.Blocks.Sources.Ramp X_set(
    height=0.003,
    duration(displayUnit="d") = 864000,
    offset=0.012,
    startTime(displayUnit="d") = 13824000)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
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
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-76,-100},{-56,-80}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-94,-82},{-54,-42}}),
                                                    iconTransformation(extent={{-220,20},
            {-200,40}})));
equation
  connect(m_airIn_equation.y, sprayHumidifier.m_flow_airIn) annotation (Line(
        points={{-79,30},{-58,30},{-58,-2},{-21,-2}}, color={0,0,127}));
  connect(T_wat.y, sprayHumidifier.T_watIn)
    annotation (Line(points={{15,-60},{-13,-60},{-13,-21}}, color={0,0,127}));
  connect(boundary.ports[1], preOut.port_a)
    annotation (Line(points={{6,46},{20,46}},  color={0,127,255}));
  connect(preOut.X_wSet, X_set.y) annotation (Line(points={{18,50},{12,50},{12,90},
          {-39,90}},     color={0,0,127}));
  connect(T_airOut_fluid.port_b, X_airOut_fluid.port_a)
    annotation (Line(points={{66,46},{74,46}},   color={0,127,255}));
  connect(preOut.port_b, T_airOut_fluid.port_a)
    annotation (Line(points={{40,46},{46,46}},          color={0,127,255}));
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
  connect(x_pTphi.X[1], sprayHumidifier.X_airIn) annotation (Line(points={{-55,
          -90},{-46,-90},{-46,-8},{-21,-8}}, color={0,0,127}));
  connect(weaBus.TDryBul, sprayHumidifier.T_airIn) annotation (Line(
      points={{-74,-62},{-56,-62},{-56,-5},{-21,-5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, boundary.T_in) annotation (Line(
      points={{-74,-62},{-56,-62},{-56,50},{-16,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(m_airIn_equation.y, boundary.m_flow_in) annotation (Line(points={{-79,30},
          {-58,30},{-58,54},{-16,54}},    color={0,0,127}));
  connect(x_pTphi.X[1], boundary.Xi_in[1]) annotation (Line(points={{-55,-90},{-46,
          -90},{-46,42},{-16,42}},    color={0,0,127}));
  connect(bou.ports[1], X_airOut_fluid.port_b) annotation (Line(points={{78,91},
          {62,91},{62,68},{96,68},{96,46},{94,46}}, color={0,127,255}));
  connect(X_set.y, sprayHumidifier.X_set) annotation (Line(points={{-39,90},{-32,
          90},{-32,20},{-10,20},{-10,1}}, color={0,0,127}));
  annotation (experiment(StopTime=200, Interval=1800),
   Documentation(info="<html>
<p>
In this model the massfraction of the model <a href=\"modelica://SimpleAHU.Components.SprayHumidifier\">
SimpleAHU.Components.SprayHumidifier</a> is set. 
<p>The results are then compared to <a href=\"modelica://AixLib.Fluid.HeatExchangers.PrescribedOutlet\">
AixLib.Fluid.HeatExchangers.PrescribedOutlet</a> (boundary conditions are consistent).
</p>
</html>", revisions="<html>
<ul>
<li>December, 2019, by Ervin Lejlic:<br/>First implementation. </li>
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
end Test_SprayHumidifier1;
