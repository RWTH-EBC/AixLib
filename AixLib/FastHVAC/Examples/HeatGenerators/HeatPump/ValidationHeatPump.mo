within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model ValidationHeatPump

  extends Modelica.Icons.Example;
  FastHVAC.Components.Sinks.Vessel vessel_co
    annotation (Placement(transformation(extent={{64,-40},{86,-22}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{32,-40},{50,-22}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource(medium=
        FastHVAC.Media.WaterSimple())
    annotation (Placement(transformation(extent={{-56,-70},{-36,-50}})));
  FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump1(
    Pel_ouput=true,
    CoP_output=false,
    cap_calcType=2,
    medium_ev=FastHVAC.Media.WaterSimple(),
    medium_co=FastHVAC.Media.WaterSimple(),
    corrFlowCo=true,
    corrFlowEv=true)
    annotation (Placement(transformation(extent={{-10,-78},{20,-58}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,-78})));
  FastHVAC.Components.Sinks.Vessel vessel_ev annotation (Placement(
        transformation(
        extent={{-11,-9},{11,9}},
        rotation=180,
        origin={-43,-93})));
  Modelica.Fluid.Sources.MassFlowSource_T source_ev(
    use_m_flow_in=true,
    m_flow=1,
    T(displayUnit="K") = 333,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-56,36},{-36,56}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient,
      p_ambient(displayUnit="Pa"))
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.FixedBoundary sink_co(
      nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={87,67})));
  Modelica.Blocks.Sources.Constant dotm_ev1(k=0.5)
    annotation (Placement(transformation(extent={{-100,44},{-80,64}})));

  Fluid.HeatPumps.HeatPumpDetailed            heatPump(
    CorrFlowCo=true,
    CorrFlowEv=true,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-16,30},{14,50}})));

  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    startTime=1000,
    height=25,
    offset=278,
    duration=36000)
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
  Modelica.Blocks.Sources.BooleanPulse    booleanConstant(period=10000)
    annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
  Modelica.Fluid.Sources.FixedBoundary sink_ev(           nPorts=1, redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-47,19})));
  Modelica.Fluid.Sources.MassFlowSource_T source_co(
    use_m_flow_in=true,
    T(displayUnit="degC") = 308.15,
    m_flow=0.5,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,20})));
  Modelica.Blocks.Sources.Constant T1(k=308.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,34})));
  Modelica.Blocks.Sources.Constant dotm_co1(k=0.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,18})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{30,74},{50,94}})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp1(
    startTime=1000,
    height=25,
    offset=278,
    duration=36000)
    annotation (Placement(transformation(extent={{-98,-62},{-78,-42}})));
  Modelica.Blocks.Sources.BooleanPulse    booleanConstant1(
                                                          period=10000)
    annotation (Placement(transformation(extent={{-98,-34},{-78,-14}})));
  Modelica.Blocks.Sources.Constant dotm_ev2(k=0.5)
    annotation (Placement(transformation(extent={{-98,-96},{-78,-76}})));
  Modelica.Blocks.Sources.Constant T2(k=308.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,-86})));
  Modelica.Blocks.Sources.Constant dotm_co2(k=0.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,-54})));
equation
  connect(T1.y, source_co.T_in) annotation (Line(
      points={{47,34},{42,34},{42,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_co1.y, source_co.m_flow_in) annotation (Line(
      points={{75,18},{62,18},{62,12},{40,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureSensor.enthalpyPort_b,vessel_co. enthalpyPort_a)
    annotation (Line(
      points={{49.1,-31.09},{67.55,-31.09},{67.55,-31},{67.3,-31}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(vessel_ev.enthalpyPort_a,heatPump1. enthalpyPort_outEv)
    annotation (Line(
      points={{-35.3,-93},{-7.4,-93},{-7.4,-76.2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(fluidSource.enthalpyPort_b,heatPump1. enthalpyPort_inEv)
    annotation (Line(
      points={{-36,-59},{-7,-59},{-7,-59.8},{-7.4,-59.8}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(heatPump1.enthalpyPort_outCo,temperatureSensor. enthalpyPort_a)
    annotation (Line(
      points={{17.2,-59.6},{17.2,-31.09},{33.08,-31.09}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(heatPump1.enthalpyPort_inCo,fluidSource1. enthalpyPort_b)
    annotation (Line(
      points={{17.6,-76.2},{17.6,-79},{30,-79}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_ev2.y, fluidSource.dotm) annotation (Line(
      points={{-77,-86},{-66,-86},{-66,-62.6},{-54,-62.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TsuSourceRamp1.y, fluidSource.T_fluid) annotation (Line(
      points={{-77,-52},{-66,-52},{-66,-55.8},{-54,-55.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanConstant1.y, heatPump1.onOff_in) annotation (Line(
      points={{-77,-24},{0,-24},{0,-59}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(T2.y, fluidSource1.T_fluid) annotation (Line(
      points={{75,-86},{66,-86},{66,-82.2},{48,-82.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_co2.y, fluidSource1.dotm) annotation (Line(
      points={{75,-54},{66,-54},{66,-75.4},{48,-75.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(source_ev.ports[1], heatPump.port_evaIn)
    annotation (Line(points={{-36,46},{-14,46},{-14,47}}, color={0,127,255}));
  connect(heatPump.port_evaOut, sink_ev.ports[1]) annotation (Line(points={{-14,
          33},{-16,33},{-16,20},{-36,20},{-36,19}}, color={0,127,255}));
  connect(booleanConstant.y, heatPump.onOff_in) annotation (Line(points={{-77,
          84},{-44,84},{-6,84},{-6,49}}, color={255,0,255}));
  connect(temperature.port, heatPump.port_conOut) annotation (Line(points={{40,
          74},{40,62},{12,62},{12,47}}, color={0,127,255}));
  connect(sink_co.ports[1], heatPump.port_conOut) annotation (Line(points={{76,
          67},{62,67},{62,54},{12,54},{12,47}}, color={0,127,255}));
  connect(source_co.ports[1], heatPump.port_conIn) annotation (Line(points={{20,
          20},{16,20},{16,33},{12,33}}, color={0,127,255}));
  connect(dotm_ev1.y, source_ev.m_flow_in)
    annotation (Line(points={{-79,54},{-56,54}}, color={0,0,127}));
  connect(TsuSourceRamp.y, source_ev.T_in) annotation (Line(points={{-79,24},{
          -72,24},{-72,50},{-58,50}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{-100,-2},{100,-100}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,-2},{24,-16}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="FastHVAC"),
        Rectangle(
          extent={{-100,100},{100,2}},
          lineColor={170,213,255},
          fillPattern=FillPattern.Solid,
          fillColor={170,213,255}),
        Text(
          extent={{-28,98},{20,84}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="HVAC")}),
    experiment(StopTime=72000, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end ValidationHeatPump;
