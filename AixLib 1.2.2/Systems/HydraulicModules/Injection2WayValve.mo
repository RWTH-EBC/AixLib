within AixLib.Systems.HydraulicModules;
model Injection2WayValve
  "Injection circuit with pump and two way valve"
  extends AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule;


  parameter Modelica.Units.SI.Volume vol=0.0005 "Mixing Volume"
    annotation (Dialog(tab="Advanced"));


  Fluid.Actuators.Valves.TwoWayTable  valve(
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    Kv=Kv,
    order=1,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    flowCharacteristics=Fluid.Actuators.Valves.Data.Linear())
           annotation (Dialog(enable=true, group="Actuators"), Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-42,-60})));
      replaceable BaseClasses.BasicPumpInterface PumpInterface(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)    "Needs to be redeclared" annotation (
    Dialog(group="Actuators"),
    choicesAllMatching=true,
    Placement(transformation(extent={{42,12},{58,28}})));
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
        group="Pipes"), Placement(transformation(extent={{-40,28},{-24,12}})));
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
        group="Pipes"), Placement(transformation(extent={{16,28},{32,12}})));

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
        group="Pipes"), Placement(transformation(extent={{68,28},{84,12}})));
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
        group="Pipes"), Placement(transformation(extent={{60,-68},{44,-52}})));
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
        group="Pipes"), Placement(transformation(extent={{-4,-68},{-20,-52}})));

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
        group="Pipes"), Placement(transformation(extent={{-58,-68},{-74,-52}})));
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
        group="Pipes"), Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={6,-20})));

   Fluid.MixingVolumes.MixingVolume junc3v6(
    redeclare package Medium = Medium,
    final massDynamics=massDynamics,
    final T_start=T_start,
    final V=vol,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{0,-60},{12,-72}})));



protected
  Fluid.MixingVolumes.MixingVolume juncjp6(
    redeclare package Medium = Medium,
    final massDynamics=massDynamics,
    final V=vol,
    final T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{0,20},{12,32}})));

equation

  connect(PumpInterface.port_b, pipe3.port_a)
    annotation (Line(points={{58,20},{68,20}}, color={0,127,255}));

  connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{50,28},{50,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe5.port_a, junc3v6.ports[1])
    annotation (Line(points={{-4,-60},{4.4,-60}},
                                                color={0,127,255}));
  connect(valve.port_b, pipe6.port_a)
    annotation (Line(points={{-50,-60},{-58,-60}}, color={0,127,255}));
  connect(juncjp6.ports[1], pipe2.port_a)
    annotation (Line(points={{4.4,20},{16,20}}, color={0,127,255}));
  connect(senT_a1.port_b, pipe1.port_a)
    annotation (Line(points={{-88,20},{-40,20}}, color={0,127,255}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-32,
          12},{-32,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe2.heatPort, prescribedTemperature.port)
    annotation (Line(points={{24,12},{24,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe7.heatPort, prescribedTemperature.port)
    annotation (Line(points={{-2,-20},{20,-20},{20,-20},{32,-20}},
                                                 color={191,0,0}));
  connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{76,
          12},{78,12},{78,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{-12,
          -52},{-12,-46},{32,-46},{32,-20}}, color={191,0,0}));
  connect(pipe6.heatPort, prescribedTemperature.port) annotation (Line(points={{-66,
          -52},{-66,-46},{32,-46},{32,-20}}, color={191,0,0}));
  connect(pipe4.heatPort, prescribedTemperature.port) annotation (Line(points={{52,
          -52},{52,-46},{32,-46},{32,-20}}, color={191,0,0}));
  connect(pipe4.port_a, senT_a2.port_b)
    annotation (Line(points={{60,-60},{72,-60}}, color={0,127,255}));
  connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-42,-69.6},
          {-42,-80},{-122,-80},{-122,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-46,
          -65.6},{-46,-80},{-122,-80},{-122,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe1.port_b, juncjp6.ports[2])
    annotation (Line(points={{-24,20},{6,20}}, color={0,127,255}));
  connect(pipe2.port_b, PumpInterface.port_a)
    annotation (Line(points={{32,20},{42,20}}, color={0,127,255}));
  connect(pipe3.port_b, senT_b1.port_a)
    annotation (Line(points={{84,20},{88,20}}, color={0,127,255}));
  connect(pipe4.port_b, junc3v6.ports[2])
    annotation (Line(points={{44,-60},{6,-60}}, color={0,127,255}));
  connect(pipe7.port_b, juncjp6.ports[3])
    annotation (Line(points={{6,-12},{6,20},{7.6,20}}, color={0,127,255}));
  connect(pipe7.port_a, junc3v6.ports[3])
    annotation (Line(points={{6,-28},{7.6,-28},{7.6,-60}}, color={0,127,255}));
  connect(pipe5.port_b, valve.port_a)
    annotation (Line(points={{-20,-60},{-34,-60}}, color={0,127,255}));
  connect(pipe6.port_b, senT_b2.port_a)
    annotation (Line(points={{-74,-60},{-78,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
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
        Line(
          points={{-4,60},{-4,-58}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{-6,62},{-2,58}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,-58},{-2,-62}},
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
        Text(
          extent={{-40,60},{-24,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{76,60},{92,42}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{32,-42},{48,-60}},
          lineColor={135,135,135},
          textString="4"),
        Text(
          extent={{-92,-42},{-76,-60}},
          lineColor={135,135,135},
          textString="6"),
        Text(
          extent={{0,10},{16,-8}},
          lineColor={135,135,135},
          textString="7"),
        Text(
          extent={{-20,-42},{-4,-60}},
          lineColor={135,135,135},
          textString="5"),
        Text(
          extent={{0,60},{16,42}},
          lineColor={135,135,135},
          textString="2")}),    Diagram(coordinateSystem(extent={{-120,-120},{120,
            120}}, initialScale=0.1)),
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
  the primary hydronic circuit (port_a1, port_b2) whereas when the
  valve is fully closed, the consumer is isolated from the primary
  hydronic circuit. The primary needs a supply pump or a pressure
  difference.
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects
</p>
<ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>June 30, 2018, by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>"));
end Injection2WayValve;
