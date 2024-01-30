within AixLib.Systems.HydraulicModules;
model ThrottlePump "Throttle circuit with pump and two way valve"
  extends AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule;



  Fluid.Actuators.Valves.TwoWayTable         valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    final allowFlowReversal=allowFlowReversal,
    Kv=Kv,
    order=1,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    flowCharacteristics=Fluid.Actuators.Valves.Data.Linear())
           annotation (Dialog(enable=true, group="Actuators"), Placement(
        transformation(extent={{-36,10},{-16,30}})));
  replaceable BaseClasses.BasicPumpInterface PumpInterface(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)    "Needs to be redeclared" annotation (
    Dialog(group="Actuators"),
    choicesAllMatching=true,
    Placement(transformation(extent={{32,12},{48,28}})));
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
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
      Placement(transformation(extent={{-80,30},{-60,10}})));

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
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
      Placement(transformation(extent={{0,30},{20,10}})));

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
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
      Placement(transformation(extent={{60,30},{80,10}})));
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
    final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
      Placement(transformation(extent={{20,-70},{0,-50}})));


equation
  connect(valve.port_b, pipe2.port_a)
    annotation (Line(points={{-16,20},{0,20}}, color={0,127,255}));
  connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-26,32},{-26,
          100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PumpInterface.port_b, pipe3.port_a)
    annotation (Line(points={{48,20},{60,20}}, color={0,127,255}));
  connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-21,
          27},{-21,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{40,28},{40,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_a1.port_b, pipe1.port_a)
    annotation (Line(points={{-88,20},{-80,20}}, color={0,127,255}));
  connect(pipe4.port_a, senT_a2.port_b)
    annotation (Line(points={{20,-60},{72,-60}}, color={0,127,255}));
  connect(pipe2.heatPort, prescribedTemperature.port)
    annotation (Line(points={{10,10},{10,-20},{32,-20}}, color={191,0,0}));
  connect(pipe4.heatPort, prescribedTemperature.port)
    annotation (Line(points={{10,-50},{10,-20},{32,-20}}, color={191,0,0}));
  connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{70,
          10},{70,-2},{10,-2},{10,-20},{32,-20}}, color={191,0,0}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-70,10},
          {-70,-2},{10,-2},{10,-20},{32,-20}},     color={191,0,0}));
  connect(pipe1.port_b, valve.port_a)
    annotation (Line(points={{-60,20},{-36,20}}, color={0,127,255}));
  connect(pipe2.port_b, PumpInterface.port_a)
    annotation (Line(points={{20,20},{32,20}}, color={0,127,255}));
  connect(pipe3.port_b, senT_b1.port_a)
    annotation (Line(points={{80,20},{88,20}}, color={0,127,255}));
  connect(pipe4.port_b, senT_b2.port_a)
    annotation (Line(points={{0,-60},{-78,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
        Ellipse(
          extent={{10,80},{50,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{30,80},{50,60},{30,40}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-50,50},{-50,70},{-30,60},{-50,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,50},{-10,70},{-30,60},{-10,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,70},{-60,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-92,60},{-76,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{-6,60},{10,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{50,60},{66,42}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{-8,-42},{8,-60}},
          lineColor={135,135,135},
          textString="4")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
          initialScale=0.1)),
    Documentation(revisions="<html><ul>
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
  <li>2017-06 by Alexander Kümpel:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Throttle circuit with a replaceable pump model and a valve for the
  distribution of hot or cold water. All sensor and actor values are
  connected to the hydraulic bus.
</p>
<h4>
  <span style=\"color: #008c48\">Characteristics</span>
</h4>
<p>
  The volume flow depends on the valve opening and the pump speed. If
  the pump is switched of or the valve is completly closed, there is no
  volume flow (except leackage).
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects.
</p>
</html>"));
end ThrottlePump;
