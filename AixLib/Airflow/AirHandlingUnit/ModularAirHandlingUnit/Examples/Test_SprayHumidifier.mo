within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_SprayHumidifier
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp m_air_in(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.006)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Ramp T_air_in(
    height=10,
    duration=600,
    offset=273.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Ramp T_wat_in(
    duration=600,
    startTime=3600,
    height=10,
    offset=283.15)
    annotation (Placement(transformation(extent={{60,-68},{40,-48}})));
  Modelica.Blocks.Sources.Ramp m_wat_in(
    duration=600,
    startTime=4800,
    height=-10/3600,
    offset=10/3600)
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
  Components.SprayHumidifier sprayHumidifier(redeclare model
      PartialPressureDrop = Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-32,-34},{42,34}})));
equation
  connect(m_air_in.y, sprayHumidifier.m_flow_airIn) annotation (Line(points={{
          -79,60},{-66,60},{-66,27.2},{-35.7,27.2}}, color={0,0,127}));
  connect(T_air_in.y, sprayHumidifier.T_airIn) annotation (Line(points={{-79,20},
          {-64,20},{-64,17},{-35.7,17}}, color={0,0,127}));
  connect(X_in.y, sprayHumidifier.X_airIn) annotation (Line(points={{-79,-20},{
          -66,-20},{-66,6.8},{-35.7,6.8}}, color={0,0,127}));
  connect(T_wat_in.y, sprayHumidifier.T_watIn) annotation (Line(points={{39,-58},
          {-6.1,-58},{-6.1,-37.4}}, color={0,0,127}));
  connect(m_wat_in.y, sprayHumidifier.m_flow_watIn) annotation (Line(points={{
          -49,-60},{-17.2,-60},{-17.2,-37.4}}, color={0,0,127}));
   annotation (experiment(StopTime=7200, __Dymola_NumberOfIntervals=7200),
 Documentation(info="<html><p>
  Testing <a href=
  \"modelica://SimpleAHU.Components.SprayHumidifier\">SimpleAHU.Components.SprayHumidifier</a>
  with changing massflow and temperature of incoming air and
  waterdrops.
</p>
</html>"), Icon(graphics={
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
