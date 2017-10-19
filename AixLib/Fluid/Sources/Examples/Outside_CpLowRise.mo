within AixLib.Fluid.Sources.Examples;
model Outside_CpLowRise
  "Test model for source and sink with outside weather data and wind pressure"
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Air "Medium model for air";
  AixLib.Fluid.Sources.Outside_CpLowRise west(
    redeclare package Medium = Medium,
    s=5,
    azi=AixLib.Types.Azimuth.W,
    Cp0=0.6) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam="modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  AixLib.Fluid.Sources.Outside_CpLowRise north(
    redeclare package Medium = Medium,
    s=1/5,
    azi=AixLib.Types.Azimuth.N,
    Cp0=0.6) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  AixLib.Fluid.Sources.Outside_CpLowRise south(
    redeclare package Medium = Medium,
    s=1/5,
    azi=AixLib.Types.Azimuth.S,
    Cp0=0.6) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  AixLib.Fluid.Sources.Outside_CpLowRise east(
    redeclare package Medium = Medium,
    s=5,
    azi=AixLib.Types.Azimuth.E,
    Cp0=0.6) "Model with outside conditions"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
equation
  connect(weaDat.weaBus, west.weaBus)     annotation (Line(
      points={{-60,10},{-40,10},{-40,10.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaDat.weaBus, north.weaBus) annotation (Line(
      points={{-60,10},{-50,10},{-50,50.2},{-20,50.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaDat.weaBus, south.weaBus) annotation (Line(
      points={{-60,10},{-50,10},{-50,-29.8},{-20,-29.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaDat.weaBus, east.weaBus) annotation (Line(
      points={{-60,10},{-50,10},{-50,-10},{30,-10},{30,10.2},{40,10.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Sources/Examples/Outside_CpLowRise.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates the use of a source for ambient conditions that computes
the wind pressure on a facade of a low-rise building.
Weather data are used for San Francisco, for a period of a week
where the wind blows primarily from North-West.
The plot shows that the wind pressure on the north- and west-facing
facade is positive,
whereas it is negative for the south- and east-facing facades.
</p>
</html>", revisions="<html>
<ul>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-Buildings/issues/311\">#311</a>.
</li>
<li>
October 26, 2011 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StartTime=1.728e+07,
      StopTime=1.78848e+07,
      Tolerance=1e-6));
end Outside_CpLowRise;
