within AixLib.Systems.HydraulicModules;
model Throttle "Throttle circuit with two way valve"
  extends AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule;

  Fluid.Actuators.Valves.TwoWayTable         valve(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    final allowFlowReversal=allowFlowReversal,
    Kv=Kv,
    order=1,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    flowCharacteristics=Fluid.Actuators.Valves.Data.Linear())
           annotation (Dialog(enable=true, group="Actuators"), Placement(
        transformation(extent={{-12,10},{8,30}})));
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
      Placement(transformation(extent={{-60,30},{-40,10}})));

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
      Placement(transformation(extent={{40,30},{60,10}})));

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
      Placement(transformation(extent={{10,-70},{-10,-50}})));


equation
  connect(valve.port_b, pipe2.port_a)
    annotation (Line(points={{8,20},{40,20}}, color={0,127,255}));
  connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-2,32},{-2,
          100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{3,27},
          {3,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe3.port_a, senT_a2.port_b)
    annotation (Line(points={{10,-60},{72,-60}}, color={0,127,255}));
  connect(pipe1.port_a, senT_a1.port_b)
    annotation (Line(points={{-60,20},{-88,20}}, color={0,127,255}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-50,
          10},{-50,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe2.heatPort, prescribedTemperature.port)
    annotation (Line(points={{50,10},{50,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe3.heatPort, prescribedTemperature.port)
    annotation (Line(points={{0,-50},{0,-20},{32,-20}}, color={191,0,0}));
  connect(pipe1.port_b, valve.port_a)
    annotation (Line(points={{-40,20},{-12,20}}, color={0,127,255}));
  connect(pipe2.port_b, senT_b1.port_a)
    annotation (Line(points={{60,20},{88,20}}, color={0,127,255}));
  connect(pipe3.port_b, senT_b2.port_a)
    annotation (Line(points={{-10,-60},{-78,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
        Polygon(
          points={{-20,50},{-20,70},{0,60},{-20,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,50},{20,70},{0,60},{20,50}},
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
          extent={{-56,60},{-40,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{38,60},{54,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{-8,-40},{8,-58}},
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
  Throttle circuit with a valve for the distribution of hot or cold
  water. All sensor and actor values are connected to the hydraulic
  bus.
</p>
<h4>
  <span style=\"color: #008c48\">Characteristics</span>
</h4>
<p>
  The volume flow depends on the valve opening. If the valve is
  completly closed, there is no volume flow (except leackage).
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects.
</p>
</html>"));
end Throttle;
