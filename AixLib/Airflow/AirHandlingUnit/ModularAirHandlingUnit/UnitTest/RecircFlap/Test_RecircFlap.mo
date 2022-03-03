within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.RecircFlap;
model Test_RecircFlap
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.RecircFlap
    recircFlap(exponential=false,
               redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.Constant T_OdaIn(k=273.15)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant X_OdaIn(k=0.002)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant X_airInEta(k=0.01)
    annotation (Placement(transformation(extent={{100,0},{80,20}})));
  Modelica.Blocks.Sources.Ramp m_flow_airInEta(
    height=1000/3600*1.18,
    duration=600,
    startTime=1800,
    offset=4000/3600*1.18)
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Modelica.Blocks.Sources.Ramp T_airInEta(
    height=5,
    duration=600,
    offset=283.15,
    startTime=3000)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  Modelica.Blocks.Sources.Constant m_flow_air(k=3000/3600*1.18)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.Ramp flapPos(
    height=0.5,
    duration=600,
    offset=0,
    startTime=600)
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,273.15,0.002; 600,
        273.15,0.002; 1200,277.166,0.0052; 1800,277.166,0.0052; 2400,277.712,0.00563;
        3000,277.712,0.00563; 3600,279.993,0.00563; 3601,279.993,0.00563])
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(m_flow_airInEta.y, recircFlap.m_flow_airInEta) annotation (Line(
        points={{79,90},{38,90},{38,38},{1,38}}, color={0,0,127}));
  connect(T_airInEta.y, recircFlap.T_airInEta) annotation (Line(points={{79,50},
          {58,50},{58,35},{1,35}}, color={0,0,127}));
  connect(X_airInEta.y, recircFlap.X_airInEta) annotation (Line(points={{79,10},
          {64,10},{64,32},{1,32}}, color={0,0,127}));
  connect(X_OdaIn.y, recircFlap.X_airInOda) annotation (Line(points={{-79,10},{
          -62,10},{-62,28},{-21,28}}, color={0,0,127}));
  connect(T_OdaIn.y, recircFlap.T_airInOda) annotation (Line(points={{-79,-30},
          {-58,-30},{-58,25},{-21,25}}, color={0,0,127}));
  connect(m_flow_air.y, recircFlap.m_flow_airInOda) annotation (Line(points={{
          -79,-70},{-54,-70},{-54,22},{-21,22}}, color={0,0,127}));
  connect(flapPos.y, recircFlap.flapPosition)
    annotation (Line(points={{19,-10},{-15,-10},{-15,20}}, color={0,0,127}));
  annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html><p>
  Simple test of the modell <a href=
  \"modelica://SimpleAHU.Components.RecircFlap\">SimpleAHU.Components.RecircFlap</a>.
</p>
<p>
  Flap position, incoming exhaust temperature and massfraction are
  changed over time.
</p>
<p>
  The simulation results of temperature and massfraction are then
  compared with the results in <a href=
  \"modelica://Modelica.Blocks.Sources.CombiTimeTable\">Modelica.Blocks.Sources.CombiTimeTable</a>.
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
end Test_RecircFlap;
