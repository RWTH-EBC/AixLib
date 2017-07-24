within AixLib.Fluid.Sources.Examples;
model Outside
  "Test model for source and sink with outside weather data"
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Air "Medium model for air";
  AixLib.Fluid.Sources.Outside bou(
   redeclare package Medium = Medium,
   nPorts=1) "Model with outside conditions"
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "modelica://AixLib/Resources/WeatherData/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  AixLib.Fluid.Sources.MassFlowSource_T sin(
    redeclare package Medium = Medium,
    m_flow=-1,
    nPorts=1) "Sink"
    annotation (Placement(transformation(extent={{90,20},{70,40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Medium,
    m_flow_nominal=1) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  AixLib.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(
    redeclare package Medium = Medium,
    m_flow_nominal=1) "Sensor for relative humidity"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  AixLib.Fluid.Sensors.MassFractionTwoPort senMasFra(
    redeclare package Medium = Medium,
    m_flow_nominal=1) "Sensor for mass fraction of water"
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
equation
  connect(weaDat.weaBus, bou.weaBus)      annotation (Line(
      points={{-60,30},{-50,30},{-50,30.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(senTem.port_b, sin.ports[1]) annotation (Line(
      points={{60,30},{70,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senRelHum.port_a, bou.ports[1]) annotation (Line(
      points={{-20,30},{-30,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senRelHum.port_b, senMasFra.port_a) annotation (Line(
      points={{0,30},{10,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFra.port_b, senTem.port_a) annotation (Line(
      points={{30,30},{40,30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
experiment(Tolerance=1e-6, StopTime=3.1536e+07),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Sources/Examples/Outside.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates how to connect fluid flow component to a
boundary condition that has environmental conditions as
obtained from a weather file.
The model draws a constant mass flow rate of outside air through
its components.
</p>
</html>", revisions="<html>
<ul>
<li>
Feb. 9, 2011 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Outside;
