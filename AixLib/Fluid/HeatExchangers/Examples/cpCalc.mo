within AixLib.Fluid.HeatExchangers.Examples;
model cpCalc "Example for the calculation of cp"
   extends Modelica.Icons.Example;

  Utilities.cpCalc cpCalc
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.Ramp   cosine(
    height=10,
    duration=20,
    startTime=50,
    offset=4000)
    annotation (Placement(transformation(extent={{-68,90},{-48,110}})));
  Modelica.Blocks.Sources.Ramp   cosine1(
    height=10,
    duration=20,
    startTime=50,
    offset=3000)
    annotation (Placement(transformation(extent={{-68,62},{-48,82}})));
  Modelica.Blocks.Sources.Ramp   cosine2(
    offset=278.15,
    height=10,
    duration=20,
    startTime=50)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.Ramp   cosine3(
    offset=278.15,
    height=10,
    duration=20,
    startTime=50)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
equation
  connect(cosine.y, cpCalc.h_out) annotation (Line(points={{-47,100},{-20,100},
          {-20,66},{-10,66}}, color={0,0,127}));
  connect(cosine1.y, cpCalc.h_in) annotation (Line(points={{-47,72},{-28,72},{
          -28,62},{-10,62}}, color={0,0,127}));
  connect(cosine2.y, cpCalc.T_out) annotation (Line(points={{-49,40},{-28,40},{
          -28,58},{-10,58}}, color={0,0,127}));
  connect(cosine3.y, cpCalc.T_in) annotation (Line(points={{-49,10},{-20,10},{
          -20,54},{-10,54}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-140,0},{160,100}},
          preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>2017-04-25 by Peter Matthes:<br>Adaptes the example to work with the changes in the heat exchanger model (parameter). Also reduced default values for A and k to have a more reasonable setup. Also exchanged the sinus temperature input on the cold side to a ramp function to make the model behavior more apprehensible. </li>
</ul>
</html>", info="<html>
<p>The model simulates but seems to some issues. The following list contains dubious behavior: </p>
<ul>
<li>In the cP_DH model is a hack to override the temperature difference at start for a given amount of time. This led to simulation error as the heat flow on DH side was completely wrong.</li>
<li>The computation of heat flow (Q_HS, Q_DH) depends on temperature difference of the in- and outflowing medium. At simulation start the heat flow is constant (see plot script) but temperature difference is not. This seems to be wrong.</li>
<li>The dimensionless figures P, R and NTU stay always constant in the example. This will be due to the use of &QUOT;contantPropertiesLiquidWater&QUOT;.</li>
</ul>
<p>The model requires to provide A and k (average coefficient of heat transfer of heat exchanger). Normally, we do not know k and k will not be a parameter but a function of temperature, mass flow rate and heat exchanger geometry. Therefore, the model must be parameterized by using measurment data for a small operational range. Thus it will be hard to parameterize the model under normal circumstances.</p>
</html>"),
    experiment(StopTime=100, __Dymola_NumberOfIntervals=20),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/HeatExchangers/PlateHeatExchanger/PlateHeatExchangerSimpleTest.mos"
        "simulate & plot"));
end cpCalc;
