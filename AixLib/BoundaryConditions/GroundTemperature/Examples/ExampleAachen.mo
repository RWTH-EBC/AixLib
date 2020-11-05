within AixLib.BoundaryConditions.GroundTemperature.Examples;
model ExampleAachen "Ground temperature at the site of EBC"
  extends Modelica.Icons.Example;
  GroundTemperatureKusuda groundTemperatureAachen(
    alpha=0.039,
    D=1,
    T_amp=19.25,
    t_shift=3,
    T_mean=283.6)
    "Undisturbed ground temperature model with values for EBC main building"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    "Sensor to show ground temperature"
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  Modelica.Blocks.Interfaces.RealOutput T_ground
    "Output to show ground temperature"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
equation
  connect(groundTemperatureAachen.port, temperatureSensor.port) annotation (
      Line(points={{9.4,-5},{16.7,-5},{16.7,0},{24,0}}, color={191,0,0}));
  connect(temperatureSensor.T, T_ground)
    annotation (Line(points={{44,0},{106,0}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, Interval=3600), Documentation(info="<html><p>
  This example shows the ground temperature at the site of the
  Institute for Energy Efficient Buildings and Indoor Climate at RWTH
  Aachen University's E.ON Energy Research Center (Mathieustr. 10,
  52074 Aachen).
</p>
<p>
  The values are derived from TRY weather data. With free registration,
  the <a href=\"http://www.bbsr.bund.de\">Federal Institute for Research
  on Building, Urban Affairs and Spatial Development</a> and the German
  weather service <a href=
  \"https://www.dwd.de/EN/Home/home_node.html\">Deutscher
  Wetterdienst</a> provide local test reference year weather files at
  <a href=\"https://kunden.dwd.de/obt/\">https://kunden.dwd.de/obt/</a>.
</p>
<p>
  The values used in this example were derived from a TRY file using
  the Python code available at <a href=
  \"https://gist.github.com/marcusfuchs/04977d439077016a1acdca03285ef15e\">
  this Gist</a>.
</p>
<ul>
  <li>April 30, 2018, by Marcus Fuchs:<br/>
    First implementation as part of <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/561\">issue 561</a>.
  </li>
</ul>
</html>"));
end ExampleAachen;
