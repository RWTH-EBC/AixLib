within AixLib.BoundaryConditions.GroundTemperature.Examples;
model ExampleSanFran
  extends Modelica.Icons.Example;
  Real T_max(start=0) "Keeps track of the maximum air temperature";
  Real T_min(start=300) "Keeps track of the minimum air temperature";


  AixLib.BoundaryConditions.WeatherData.Bus    weaBus "Component to supply air
  temperature" annotation (Placement(
        transformation(extent={{-90,54},{-50,94}}), iconTransformation(extent={{
            -168,6},{-148,26}})));
  Modelica.Blocks.Interfaces.RealOutput T_air "Output to show air temperature"
    annotation (Placement(transformation(extent={{98,62},{118,82}})));
  Modelica.Blocks.Continuous.Integrator integrator "Integrates air temperature
  to compute average air temperature"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.Division division "Division for average air temperature"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Sources.RealExpression timeSource(y=time) "Denominator for
  average air temperature"
    annotation (Placement(transformation(extent={{-40,-18},{-20,2}})));
  Modelica.Blocks.Interfaces.RealOutput T_mean "Output of average air
  temperature since beginning of simulation"
    annotation (Placement(transformation(extent={{98,20},{118,40}})));
  Modelica.Blocks.Math.Max denominatorTmean
    "Max-function to prevent division by 0 at time=0"
    annotation (Placement(transformation(extent={{10,-12},{30,8}})));
  Modelica.Blocks.Sources.RealExpression denominatorAtTimeZero(y=1) "Real source
  to prevent division by 0 at time=0"
    annotation (Placement(transformation(extent={{-40,4},{-20,24}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3    weaDat(
      computeWetBulbTemperature=false, filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
                                       "File reader that reads weather data"
    annotation (Placement(transformation(extent={{-40,78},{-20,98}})));
  GroundTemperatureKusuda groundTemperatureKusuda(
    t_shift=23,
    alpha=0.039,
    D=1,
    T_amp=15.49,
    T_mean=286.95) "Undisturbed ground temperature model"
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_ground "Output to show ground
  temperature"
    annotation (Placement(transformation(extent={{98,-60},{118,-40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    "Sensor to show ground temperature"
    annotation (Placement(transformation(extent={{74,-60},{94,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_amp
    "Keeps track of the amplitude of the air temperature"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
equation

 T_max=max(T_max, T_air);
 T_min=min(T_min, T_air);
 T_amp = (T_max-T_min)/2;
  connect(T_air, weaBus.TDryBul) annotation (Line(points={{108,72},{-70,72},{
          -70,74}},
                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(integrator.u, T_air) annotation (Line(points={{-2,50},{-14,50},{-14,
          72},{108,72}}, color={0,0,127}));
  connect(integrator.y, division.u1) annotation (Line(points={{21,50},{30,50},{30,
          36},{38,36}}, color={0,0,127}));
  connect(division.y, T_mean)
    annotation (Line(points={{61,30},{108,30}}, color={0,0,127}));
  connect(division.u2, denominatorTmean.y)
    annotation (Line(points={{38,24},{31,24},{31,-2}}, color={0,0,127}));
  connect(denominatorTmean.u2, timeSource.y)
    annotation (Line(points={{8,-8},{-19,-8}}, color={0,0,127}));
  connect(denominatorAtTimeZero.y, denominatorTmean.u1)
    annotation (Line(points={{-19,14},{2,14},{2,4},{8,4}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-20,88},{-16,88},{-16,86},{-10,86},{-10,74},{-70,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(groundTemperatureKusuda.port, temperatureSensor.port) annotation (
      Line(points={{59.4,-55},{70,-55},{70,-50},{74,-50}}, color={191,0,0}));
  connect(temperatureSensor.T, T_ground) annotation (Line(points={{94,-50},{108,
          -50}},                     color={0,0,127}));
  connect(T_mean, T_mean)
    annotation (Line(points={{108,30},{108,30}}, color={0,0,127}));
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>May 2017</i>, by Felix Buenning: Updated documentation, added
    T_amp as output
  </li>
  <li>
    <i>October 2016</i>, by Felix Buenning: Developed and implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Example to test and tune Kusuda ground temperature model with the
  weather model from the Modelica Buildings Library.
</p>
<p>
  The outputs T, T<sub>amp</sub> and T<sub>mean</sub> in the top of the
  model can be used to determine the parameters t<sub>shift</sub> (day
  of the coldest air temperature in the year), T<sub>mean</sub>
  (average air temperature in the year) and T<sub>amp</sub> (amplitude
  of the air temperature) for the Kusuda ground temperature model.
</p>
<p>
  The output T<sub>ground</sub> constitutes the main result of this
  example and shows the trajectory of the ground temperature over the
  year.
</p>
</html>"), experiment(
      StopTime=3.1536e+007,
      __Dymola_NumberOfIntervals=10000,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end ExampleSanFran;
