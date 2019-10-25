within AixLib.FastHVAC.Pumps.Examples;
model FluidSource
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Constant dotm_source(k=2)
    annotation (Placement(transformation(extent={{-84,-52},{-64,-32}})));
  Modelica.Blocks.Sources.Constant T_source(k=333.15)
    annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
  AixLib.FastHVAC.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-42,-34},{-22,-14}})));
  Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{80,-18},{100,2}})));
  Sinks.Vessel vessel1
    annotation (Placement(transformation(extent={{78,-44},{98,-24}})));
  Valves.Splitter splitterNew(nOut=3, nIn=1)
    annotation (Placement(transformation(extent={{12,-30},{32,-10}})));
  Sinks.Vessel vessel2
    annotation (Placement(transformation(extent={{80,-72},{100,-52}})));
  Sensors.TemperatureSensor temperature
    annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  Sensors.TemperatureSensor temperature1
    annotation (Placement(transformation(extent={{54,-46},{74,-26}})));
  Sensors.TemperatureSensor temperature2
    annotation (Placement(transformation(extent={{54,-72},{74,-52}})));
equation
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(points={{-63,-12},{
          -48,-12},{-48,-19.8},{-40,-19.8}}, color={0,0,127}));
  connect(dotm_source.y, fluidSource.m_flow) annotation (Line(points={{-63,-42},
          {-50,-42},{-50,-26.6},{-40,-26.6}}, color={0,0,127}));
  connect(temperature.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
        points={{69,-10.1},{76.5,-10.1},{76.5,-8},{83,-8}}, color={176,0,0}));
  connect(splitterNew.enthalpyPort_b[1], temperature.enthalpyPort_a)
    annotation (Line(points={{32,-20.6667},{42,-20.6667},{42,-10.1},{51.2,-10.1}},
        color={176,0,0}));
  connect(temperature2.enthalpyPort_b, vessel2.enthalpyPort_a) annotation (Line(
        points={{73,-62.1},{77.5,-62.1},{77.5,-62},{83,-62}}, color={176,0,0}));
  connect(temperature1.enthalpyPort_b, vessel1.enthalpyPort_a) annotation (Line(
        points={{73,-36.1},{77.5,-36.1},{77.5,-34},{81,-34}}, color={176,0,0}));
  connect(splitterNew.enthalpyPort_b[2], temperature1.enthalpyPort_a)
    annotation (Line(points={{32,-20},{44,-20},{44,-36.1},{55.2,-36.1}}, color=
          {176,0,0}));
  connect(splitterNew.enthalpyPort_b[3], temperature2.enthalpyPort_a)
    annotation (Line(points={{32,-19.3333},{44,-19.3333},{44,-62.1},{55.2,-62.1}},
        color={176,0,0}));
  connect(fluidSource.enthalpyPort_b, splitterNew.enthalpyPort_a[1])
    annotation (Line(points={{-23,-22},{-6,-22},{-6,-20},{12,-20}},     color={
          176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{46,40},{-36,-60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,30},{22,22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fontSize=10,
          textString="Fluid source model accepts real input values.
 The output connector creates a fluid with 
the properties temperature [K], mass flow 
rate [kg/s], specific heat capacity [J/kgK] 
and specific enthalpy [J/kg]"),
        Rectangle(
          extent={{100,100},{-100,70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-72,88},{76,80}},
          lineColor={0,0,0},
          textString="Test fluid source model 
(inclusive vessel model and real input values)")}));
end FluidSource;
