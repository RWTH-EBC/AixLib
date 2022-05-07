within AixLib.Systems.HydraulicModules;
model Admix "Admix circuit with three way valve and pump"
  extends AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule;

  parameter Modelica.Units.SI.Volume vol=0.0005 "Mixing Volume"
    annotation (Dialog(tab="Advanced"));

  parameter Fluid.Actuators.Valves.Data.GenericThreeWay valveCharacteristic "Valve characteristic of three way valve"
    annotation (choicesAllMatching=true,Placement(transformation(extent={{-120,-120},{-100,-100}})),Dialog(group="Actuators"));
                                                                           // = AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage()

  Fluid.Actuators.Valves.ThreeWayTable                 valve(
    final massDynamics=massDynamics,
    order=1,
    init=Modelica.Blocks.Types.Init.InitialState,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    redeclare package Medium = Medium,
    T_start=T_start,
    y_start=0,
    tau=0.2,
    final m_flow_nominal=m_flow_nominal,
    final energyDynamics=energyDynamics,
    Kv=Kv,
    dpFixed_nominal={10,10},
    final flowCharacteristics1=valveCharacteristic.a_ab,
    final flowCharacteristics3=valveCharacteristic.b_ab)
                                 annotation (Dialog(enable=true, group="Actuators"),
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,20})));
  Fluid.FixedResistances.GenericPipe  pipe1(
    redeclare final package Medium = Medium,
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
        group="Pipes"), Placement(transformation(extent={{-78,28},{-62,12}})));
  Fluid.FixedResistances.GenericPipe  pipe2(
    redeclare final package Medium = Medium,
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
        group="Pipes"), Placement(transformation(extent={{-8,28},{8,12}})));
  Fluid.FixedResistances.GenericPipe  pipe3(
    redeclare final package Medium = Medium,
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
        group="Pipes"), Placement(transformation(extent={{60,28},{76,12}})));
  Fluid.FixedResistances.GenericPipe  pipe4(
    redeclare final package Medium = Medium,
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
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={32,-60})));
  Fluid.FixedResistances.GenericPipe  pipe5(
    redeclare final package Medium = Medium,
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
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-58,-60})));
  Fluid.FixedResistances.GenericPipe  pipe6(
    redeclare final package Medium = Medium,
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
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={-30,-20})));
  Fluid.MixingVolumes.MixingVolume junc456(
    redeclare package Medium = Medium,
    final massDynamics=massDynamics,
    T_start=T_start,
    nPorts=3,
    final m_flow_nominal=m_flow_nominal,
    final V=vol,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{-38,-60},{-22,-76}})));
  replaceable BaseClasses.BasicPumpInterface PumpInterface(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)     "Needs to be redeclared" annotation (
    Dialog(group="Actuators"),
    choicesAllMatching=true,
    Placement(transformation(extent={{22,12},{38,28}})));


equation

  connect(const.y, prescribedTemperature.T)
    annotation (Line(points={{55.2,-20},{49.6,-20}}, color={0,0,127}));
  connect(valve.port_2, pipe2.port_a)
    annotation (Line(points={{-20,20},{-8,20}}, color={0,127,255}));
  connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-30,32},{-30,
          100},{-14,100},{-14,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-25,
          27},{-25,100.5},{0.1,100.5},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe5.port_a,junc456. ports[1])
    annotation (Line(points={{-50,-60},{-32.1333,-60}}, color={0,127,255}));
  connect(pipe6.port_a,junc456. ports[2]) annotation (Line(points={{-30,-28},{
          -30,-44},{-30,-60},{-30,-60}},
                           color={0,127,255}));
  connect(pipe4.port_a, senT_a2.port_b)
    annotation (Line(points={{40,-60},{72,-60}}, color={0,127,255}));
  connect(pipe6.heatPort, prescribedTemperature.port)
    annotation (Line(points={{-22,-20},{32,-20}}, color={191,0,0}));
  connect(pipe2.heatPort, prescribedTemperature.port)
    annotation (Line(points={{0,12},{0,-4},{0,-20},{32,-20}}, color={191,0,0}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-70,12},
          {-70,6},{0,6},{0,-20},{32,-20}},     color={191,0,0}));
  connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{68,
          12},{68,6},{0,6},{0,-20},{32,-20}}, color={191,0,0}));
  connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{-58,-52},
          {-58,-48},{0,-48},{0,-20},{32,-20}},
                                             color={191,0,0}));
  connect(pipe4.heatPort, prescribedTemperature.port) annotation (Line(points={{32,
          -52},{32,-48},{0,-48},{0,-20},{32,-20}}, color={191,0,0}));
  connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{30,28},{30,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PumpInterface.port_b, pipe3.port_a)
    annotation (Line(points={{38,20},{60,20}}, color={0,127,255}));
  connect(senT_a1.port_b,pipe1. port_a)
    annotation (Line(points={{-88,20},{-78,20}}, color={0,127,255}));
  connect(pipe1.port_b, valve.port_1)
    annotation (Line(points={{-62,20},{-40,20}}, color={0,127,255}));
  connect(pipe4.port_b, junc456.ports[3])
    annotation (Line(points={{24,-60},{-27.8667,-60}}, color={0,127,255}));
  connect(pipe5.port_b, senT_b2.port_a)
    annotation (Line(points={{-66,-60},{-78,-60}}, color={0,127,255}));
  connect(pipe2.port_b, PumpInterface.port_a) annotation (Line(points={{8,20},{
          16,20},{16,20},{22,20}}, color={0,127,255}));
  connect(pipe3.port_b, senT_b1.port_a)
    annotation (Line(points={{76,20},{88,20}}, color={0,127,255}));
  connect(pipe6.port_b, valve.port_3)
    annotation (Line(points={{-30,-12},{-30,10}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(initialScale=0.1), graphics={
        Polygon(
          points={{-60,70},{-60,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,80},{46,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{26,80},{46,60},{26,40}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-52,50},{-52,70},{-32,60},{-52,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,50},{-12,70},{-32,60},{-12,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,-10},{-10,-10},{0,10},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-32,50},
          rotation=0),
        Line(
          points={{-32,40},{-32,-58}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{-34,-58},{-30,-62}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-92,60},{-76,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{-12,60},{4,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{48,60},{64,42}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{18,-42},{34,-60}},
          lineColor={135,135,135},
          textString="4"),
        Text(
          extent={{-60,-42},{-44,-60}},
          lineColor={135,135,135},
          textString="5"),
        Text(
          extent={{-34,10},{-18,-8}},
          lineColor={135,135,135},
          textString="6")}),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)),
    Documentation(info="<html><p>
  Admix circuit with a replaceable pump model for the distribution of
  hot or cold water. All sensor and actor values are connected to the
  hydraulic bus.
</p>
<h4>
  Characteristics
</h4>
<p>
  There is a connecting pipe between distributer and collector of
  manifold so that the pressure difference between them becomes
  insignificant. The main pump only works against the resistance in the
  main circuit.
</p>
<p>
  The mass flow in primary and secondary circuits stay constant.
</p>
<p>
  The scondary circuits do not affect each other when switching
  operational modes.
</p>
<ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>July 25, 2017 by Peter Matthes:<br/>
    Renames sensors and introduces PT1 behavior for temperature
    sensors. Adds sensors to icon.
  </li>
  <li>February 6, 2016, by Peter Matthes:<br/>
    First implementation
  </li>
</ul>
</html>"));
end Admix;
