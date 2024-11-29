within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_SpeedControlledFan_Nrpm
  Components.SpeedControlledFan_Nrpm speedControlledFan_Nrpm(
    use_WeatherData=true,
    use_inputFilter=true,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.TopS25slash10 per)
    annotation (Placement(transformation(extent={{-14,26},{20,60}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=12000/3600*1.18,
    duration=5,
    offset=2000/3600*1.18,
    startTime(displayUnit="d") = 13824000)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Modelica.Blocks.Sources.Ramp n(
    height=5,
    duration=5,
    offset=5,
    startTime(displayUnit="d") = 13824000)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
equation
  connect(weaDat.weaBus, speedControlledFan_Nrpm.weaBus) annotation (Line(
      points={{-80,90},{-54,90},{-54,58.3},{-14,58.3}},
      color={255,204,51},
      thickness=0.5));
  connect(n.y, speedControlledFan_Nrpm.n_in) annotation (Line(points={{-79,50},{
          -48,50},{-48,49.8},{-16.38,49.8}}, color={0,0,127}));
  connect(m_flow.y, speedControlledFan_Nrpm.m_flow_in) annotation (Line(points={
          {-79,10},{-70,10},{-70,43},{-16.38,43}}, color={0,0,127}));
annotation (experiment(StopTime=31536000, Interval=1800),Documentation(info="<html><p>
  Testing modell <a href=
  \"modelica://SimpleAHU.Components.SpeedControlledFan_Nrpm\">SimpleAHU.Components.SpeedControlledFan_Nrpm</a>
  using weater data.
</p>
<p>
  Incoming pressure rise and massflow increase over time.
</p>
</html>", revisions="<html>

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
