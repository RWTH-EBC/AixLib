within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_SteamHumidifier "Simple test for steam humidifier"
  extends Modelica.Icons.Example;
  Components.SteamHumidifier steamHumidifier(redeclare model
      PartialPressureDrop = Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-34,-22},{16,30}})));
  Modelica.Blocks.Sources.Ramp m_flow_air(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant T_AirIn(k=278.15)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant X_airIn(k=0.002)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp m_flow_steam(
    height=3/3600,
    duration=600,
    offset=3/3600,
    startTime=1800)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Sources.Constant T_steam(k=383.15)
    annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
equation
  connect(T_AirIn.y, steamHumidifier.T_airIn) annotation (Line(points={{-79,10},
          {-60,10},{-60,17},{-36.5,17}}, color={0,0,127}));
  connect(X_airIn.y, steamHumidifier.X_airIn) annotation (Line(points={{-79,-30},
          {-60,-30},{-60,9.2},{-36.5,9.2}}, color={0,0,127}));
  connect(m_flow_air.y, steamHumidifier.m_flow_airIn) annotation (Line(points={
          {-79,50},{-60,50},{-60,24.8},{-36.5,24.8}}, color={0,0,127}));
  connect(m_flow_steam.y, steamHumidifier.m_flow_steam) annotation (Line(points=
         {{-39,-70},{-24,-70},{-24,-20.44}}, color={0,0,127}));
  connect(T_steam.y, steamHumidifier.T_steamIn) annotation (Line(points={{19,
          -70},{-16.5,-70},{-16.5,-20.44}}, color={0,0,127}));
   annotation (experiment(StopTime=3600, __Dymola_NumberOfIntervals=3600),
 Documentation(info="<html><p>
  Testing <a href=
  \"modelica://SimpleAHU.Components.SteamHumidifier\">SimpleAHU.Components.SteamHumidifier</a>
  with changing massflow and temperature of incoming air and steam.
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
end Test_SteamHumidifier;
