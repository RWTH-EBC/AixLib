﻿within AixLib.Systems.HydraulicModules;
model Injection "Injection circuit with pump and three way valve"
  extends AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule;

  parameter Fluid.Actuators.Valves.Data.GenericThreeWay valveCharacteristic "Valve characteristic of three way valve"
    annotation (choicesAllMatching=true,Placement(transformation(extent={{-120,-120},{-100,-100}})),Dialog(group="Actuators"));


  parameter Modelica.Units.SI.Volume vol=0.0005 "Mixing Volume"
    annotation (Dialog(tab="Advanced"));


  Fluid.Actuators.Valves.ThreeWayTable valve(
    order=1,
    init=Modelica.Blocks.Types.Init.InitialState,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    redeclare package Medium = Medium,
    T_start=T_start,
    tau=0.2,
    final m_flow_nominal=m_flow_nominal,
    final energyDynamics=energyDynamics,
    y_start=0,
    Kv=Kv,
    dpFixed_nominal={10,10},
    flowCharacteristics1=valveCharacteristic.a_ab,
    flowCharacteristics3=valveCharacteristic.b_ab) annotation (Dialog(enable=
          true, group="Actuators"), Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-40,-60})));

  Fluid.FixedResistances.GenericPipe  pipe1(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-80,28},{-66,12}})));

  Fluid.FixedResistances.GenericPipe  pipe2(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{7,-8},{-7,8}},
        rotation=180,
        origin={-23,20})));
  Fluid.FixedResistances.GenericPipe  pipe3(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{6,-8},{-6,8}},
        rotation=180,
        origin={30,20})));

  Fluid.FixedResistances.GenericPipe  pipe4(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{74,28},{86,12}})));
  Fluid.FixedResistances.GenericPipe  pipe5(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{60,-68},{40,-52}})));
    Fluid.FixedResistances.GenericPipe  pipe6(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{0,-68},{-20,-52}})));

  Fluid.FixedResistances.GenericPipe  pipe7(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-60,-68},{-74,-52}})));
  Fluid.FixedResistances.GenericPipe  pipe8(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)     annotation (Dialog(enable=true, group=
          "Pipes"), Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-40,-20})));
  Fluid.FixedResistances.GenericPipe  pipe9(
    redeclare package Medium = Medium,
    pipeModel=pipeModel,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    length=length,
    parameterPipe=parameterPipe,
    parameterIso=parameterIso,
    final hCon=hCon,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={16,-20})));

  Fluid.MixingVolumes.MixingVolume junc3v6(
    redeclare package Medium = Medium,
    final massDynamics=massDynamics,
    final T_start=T_start,
    final V=vol,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{12,-60},{20,-68}})));


  replaceable BaseClasses.BasicPumpInterface PumpInterface(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics)           "Needs to be redeclared" annotation (
    Dialog(group="Actuators"),
    choicesAllMatching=true,
    Placement(transformation(extent={{48,12},{64,28}})));




protected
  Fluid.Sensors.VolumeFlowRate          VFSen_injection(redeclare package
      Medium = Medium, final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal)
    "Volume flow in injection line" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={0,20})));
  Fluid.MixingVolumes.MixingVolume junc15j(
    redeclare package Medium = Medium,
    final massDynamics=massDynamics,
    final V=vol,
    final T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{-44,20},{-36,28}})));
  Fluid.MixingVolumes.MixingVolume juncjp6(
    redeclare package Medium = Medium,
    final massDynamics=massDynamics,
    final V=vol,
    final T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{12,20},{20,28}})));

equation
  connect(pipe7.port_a, valve.port_2)
    annotation (Line(points={{-60,-60},{-48,-60}}, color={0,127,255}));

  connect(PumpInterface.port_b, pipe4.port_a)
    annotation (Line(points={{64,20},{74,20}}, color={0,127,255}));
  connect(VFSen_injection.V_flow, hydraulicBus.VF_injection) annotation (Line(
        points={{0,28.8},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{56,28},{56,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe8.heatPort, pipe9.heatPort)
    annotation (Line(points={{-32,-20},{8,-20}},  color={191,0,0}));
  connect(pipe2.port_a, junc15j.ports[1])
    annotation (Line(points={{-30,20},{-41.0667,20}},
                                                   color={0,127,255}));
  connect(VFSen_injection.port_b, juncjp6.ports[1])
    annotation (Line(points={{8,20},{14.9333,20}},
                                              color={0,127,255}));
  connect(pipe6.port_a, junc3v6.ports[1])
    annotation (Line(points={{0,-60},{14.9333,-60}},
                                                color={0,127,255}));
  connect(juncjp6.ports[2], pipe3.port_a)
    annotation (Line(points={{16,20},{24,20}},   color={0,127,255}));
  connect(senT_a1.port_b, pipe1.port_a)
    annotation (Line(points={{-88,20},{-80,20}}, color={0,127,255}));
  connect(pipe5.port_a, senT_a2.port_b)
    annotation (Line(points={{60,-60},{72,-60}}, color={0,127,255}));
  connect(prescribedTemperature.port, pipe3.heatPort)
    annotation (Line(points={{32,-20},{30,-20},{30,12}},
                                                color={191,0,0}));
  connect(pipe1.heatPort, pipe3.heatPort) annotation (Line(points={{-73,12},{
          -73,2},{30,2},{30,12}},
                              color={191,0,0}));
  connect(pipe2.heatPort, pipe3.heatPort) annotation (Line(points={{-23,12},{
          -23,2},{30,2},{30,12}},
                              color={191,0,0}));
  connect(pipe4.heatPort, pipe3.heatPort)
    annotation (Line(points={{80,12},{80,2},{30,2},{30,12}}, color={191,0,0}));
  connect(pipe7.heatPort, prescribedTemperature.port) annotation (Line(points={{-67,-52},
          {-67,-46},{30,-46},{30,-20},{32,-20}},
                                             color={191,0,0}));
  connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{50,-52},
          {50,-46},{30,-46},{30,-20},{32,-20}},
                                            color={191,0,0}));
  connect(pipe6.heatPort, prescribedTemperature.port) annotation (Line(points={{-10,-52},
          {-10,-46},{30,-46},{30,-20},{32,-20}},
                                            color={191,0,0}));
  connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-40,-69.6},
          {-40,-82},{-122,-82},{-122,100},{-60,100},{-60,100.1},{0.1,100.1}},
                                                          color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-44,
          -65.6},{-44,-82},{-122,-82},{-122,100},{-60,100},{-60,100.1},{0.1,
          100.1}},                                               color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe1.port_b, junc15j.ports[2])
    annotation (Line(points={{-66,20},{-40,20}},   color={0,127,255}));
  connect(pipe2.port_b, VFSen_injection.port_a)
    annotation (Line(points={{-16,20},{-8,20}}, color={0,127,255}));
  connect(pipe3.port_b, PumpInterface.port_a)
    annotation (Line(points={{36,20},{48,20}}, color={0,127,255}));
  connect(pipe5.port_b, junc3v6.ports[2])
    annotation (Line(points={{40,-60},{16,-60}}, color={0,127,255}));
  connect(pipe6.port_b, valve.port_1)
    annotation (Line(points={{-20,-60},{-32,-60}}, color={0,127,255}));
  connect(pipe7.port_b, senT_b2.port_a)
    annotation (Line(points={{-74,-60},{-78,-60}}, color={0,127,255}));
  connect(pipe8.port_b, valve.port_3)
    annotation (Line(points={{-40,-28},{-40,-52}}, color={0,127,255}));
  connect(pipe9.port_b, juncjp6.ports[3]) annotation (Line(points={{16,-12},{16,
          20},{17.0667,20}},     color={0,127,255}));
  connect(pipe9.port_a, junc3v6.ports[3]) annotation (Line(points={{16,-28},{16,
          -60},{17.0667,-60}},       color={0,127,255}));
  connect(pipe4.port_b, senT_b1.port_a)
    annotation (Line(points={{86,20},{88,20}}, color={0,127,255}));
  connect(pipe8.port_a, junc15j.ports[3]) annotation (Line(points={{-40,-12},{
          -40,20},{-38.9333,20}}, color={0,127,255}));
  connect(pipe9.heatPort, prescribedTemperature.port) annotation (Line(points={
          {8,-20},{8,-34},{30,-34},{30,-20},{32,-20}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(initialScale=0.1), graphics={
        Line(
          points={{-40,60},{-40,-40}},
          color={0,128,255},
          thickness=0.5),
        Polygon(
          points={{-66,-50},{-66,-50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-70},{-60,-50},{-40,-60},{-60,-70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-70},{-20,-50},{-40,-60},{-20,-70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,10},{-10,10},{0,-10},{10,10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-40,-50},
          rotation=0),
        Ellipse(
          extent={{-42,62},{-38,58}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{2,60},{2,-58}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{0,62},{4,58}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-58},{4,-62}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,80},{58,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{38,80},{58,60},{38,40}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-64,70},{-64,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-28,68},{-12,52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-28,68},{-12,52}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Text(
          extent={{-64,60},{-48,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{76,60},{92,42}},
          lineColor={135,135,135},
          textString="4"),
        Text(
          extent={{32,-42},{48,-60}},
          lineColor={135,135,135},
          textString="5"),
        Text(
          extent={{-92,-42},{-76,-60}},
          lineColor={135,135,135},
          textString="7"),
        Text(
          extent={{-42,10},{-26,-8}},
          lineColor={135,135,135},
          textString="8"),
        Text(
          extent={{0,10},{16,-8}},
          lineColor={135,135,135},
          textString="9"),
        Text(
          extent={{-16,60},{0,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{-20,-42},{-4,-60}},
          lineColor={135,135,135},
          textString="6"),
        Text(
          extent={{6,60},{22,42}},
          lineColor={135,135,135},
          textString="3")}),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)),
    Documentation(info="<html><p>
  Injection circuit with a replaceable pump model for the distribution
  of hot or cold water. All sensor and actor values are connected to
  the hydraulic bus.
</p>
<h4>
  <span style=\"color: #008000\">Characteristics</span>
</h4>
<p>
  When the valve is fully opened, the consumer module is plugged into
  the primary hydronic circuit whereas when the valve is fully closed,
  the consumer is isolated from the primary hydronic circuit
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects
</p>
</html>", revisions="<html>
<ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>Mai 30, 2018, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>2017-07-25 by Peter Matthes:<br/>
    Renames sensors and introduces PT1 behavior for temperature
    sensors. Adds sensors to icon.
  </li>
  <li>
    <i>March,2016&#160;</i> by Rohit Lad:<br/>
    Implemented
  </li>
</ul>
</html>"));
end Injection;
