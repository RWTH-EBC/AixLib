within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_FlowControlled_dp
  Components.FlowControlled_dp flowControlled_dp(
    use_WeatherData=true,
    use_inputFilter=true,
    m_flow_nominal=2000/3600*1.18,
    redeclare AixLib.Fluid.Movers.Data.Generic per)
    annotation (Placement(transformation(extent={{-20,22},{20,62}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=12000/3600*1.18,
    duration=5,
    offset=2000/3600*1.18,
    startTime(displayUnit="d") = 13824000)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Ramp dp(
    height=40,
    duration(displayUnit="s") = 5,
    offset=20,
    startTime(displayUnit="d") = 13824000)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

equation
  connect(dp.y, flowControlled_dp.dp_in)
    annotation (Line(points={{-79,50},{-22.8,50}}, color={0,0,127}));
  connect(m_flow.y, flowControlled_dp.m_flow_in) annotation (Line(points={{-79,10},
          {-64,10},{-64,42},{-22.8,42}}, color={0,0,127}));
  connect(weaDat.weaBus, flowControlled_dp.weaBus) annotation (Line(
      points={{-80,90},{-68,90},{-68,60},{-20,60}},
      color={255,204,51},
      thickness=0.5));
 annotation (experiment(StopTime=31536000, Interval=1800),Documentation(info="<html><p>
  Testing modell <a href=
  \"modelica://SimpleAHU.Components.FlowControlled_dp\">SimpleAHU.Components.FlowControlled_dp</a>
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
end Test_FlowControlled_dp;
