within AixLib.BoundaryConditions.GroundTemperature.Examples;
model ExampleSanFran
  extends Modelica.Icons.Example;
  Real T_max(start=0);
  Real T_min(start=300);

  AixLib.BoundaryConditions.WeatherData.Bus    weaBus annotation (Placement(
        transformation(extent={{-90,54},{-50,94}}), iconTransformation(extent={{
            -168,6},{-148,26}})));
  Modelica.Blocks.Interfaces.RealOutput T
    annotation (Placement(transformation(extent={{140,62},{160,82}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=time)
    annotation (Placement(transformation(extent={{-22,-18},{-2,2}})));
  Modelica.Blocks.Interfaces.RealOutput T_mean
    annotation (Placement(transformation(extent={{140,20},{160,40}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{10,-12},{30,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
    annotation (Placement(transformation(extent={{-22,-6},{-2,14}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3    weaDat(filNam=
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos",
      computeWetBulbTemperature=false) "File reader that reads weather data"
    annotation (Placement(transformation(extent={{-40,78},{-20,98}})));
  GroundTemperatureKusuda groundTemperatureKasuda(
    T_mean=286.65,
    t_shift=23,
    alpha=0.039,
    D=1,
    T_amp=14.0625)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_ground
    annotation (Placement(transformation(extent={{140,-56},{160,-36}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{74,-60},{94,-40}})));
equation

 T_max= max(T_max,T);
 T_min= min(T_min,T);
  connect(T, weaBus.TDryBul) annotation (Line(points={{150,72},{-70,72},{-70,74}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(integrator.u, T)
    annotation (Line(points={{-2,50},{-14,50},{-14,72},{150,72}},
                                                color={0,0,127}));
  connect(integrator.y, division.u1) annotation (Line(points={{21,50},{30,50},{30,
          36},{38,36}}, color={0,0,127}));
  connect(division.y, T_mean)
    annotation (Line(points={{61,30},{92,30},{150,30}},
                                                color={0,0,127}));
  connect(division.u2, max1.y)
    annotation (Line(points={{38,24},{31,24},{31,-2}}, color={0,0,127}));
  connect(max1.u2, realExpression2.y)
    annotation (Line(points={{8,-8},{4,-8},{-1,-8}}, color={0,0,127}));
  connect(realExpression1.y, max1.u1)
    annotation (Line(points={{-1,4},{8,4}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-20,88},{-16,88},{-16,86},{-10,86},{-10,74},{-70,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(groundTemperatureKasuda.port_a, temperatureSensor.port) annotation (
      Line(points={{59.4,-55},{70,-55},{70,-50},{74,-50}}, color={191,0,0}));
  connect(temperatureSensor.T, T_ground) annotation (Line(points={{94,-50},{110,
          -50},{110,-46},{150,-46}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<p>
<ul>
<li><i>October 2016</i>, by Felix Bünning: Developed and implemented</li>
</ul>
</p>
</html>", info="<html>
Example to test Kusuda ground temperature model with the weather model from the Modelica Buildings Library.
</html>"), experiment(StopTime=3.1536e+007));
end ExampleSanFran;
