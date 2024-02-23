within AixLib.Systems.HydraulicModules;
model Pump "Unmixed circuit with pump"
  extends AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule(final Kv = 0);


  replaceable BaseClasses.BasicPumpInterface PumpInterface(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics)    "Needs to be redeclared" annotation (
    Dialog(group="Actuators"),
    choicesAllMatching=true,
    Placement(transformation(extent={{-8,12},{8,28}})));
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
  connect(PumpInterface.port_b, pipe2.port_a)
    annotation (Line(points={{8,20},{40,20}}, color={0,127,255}));
  connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{0,28},{0,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_a1.port_b, pipe1.port_a)
    annotation (Line(points={{-88,20},{-60,20}}, color={0,127,255}));
  connect(pipe3.port_a, senT_a2.port_b)
    annotation (Line(points={{10,-60},{72,-60}}, color={0,127,255}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-50,
          10},{-50,-2},{32,-2},{32,-20}}, color={191,0,0}));
  connect(pipe2.heatPort, prescribedTemperature.port) annotation (Line(points={{50,
          10},{50,-2},{32,-2},{32,-20}}, color={191,0,0}));
  connect(pipe3.heatPort, prescribedTemperature.port)
    annotation (Line(points={{0,-50},{0,-20},{32,-20}}, color={191,0,0}));
  connect(pipe1.port_b, PumpInterface.port_a)
    annotation (Line(points={{-40,20},{-8,20}}, color={0,127,255}));
  connect(pipe2.port_b, senT_b1.port_a)
    annotation (Line(points={{60,20},{88,20}}, color={0,127,255}));
  connect(pipe3.port_b, senT_b2.port_a)
    annotation (Line(points={{-10,-60},{-78,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
        Ellipse(
          extent={{-20,80},{20,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,80},{20,60},{0,40}},
          color={135,135,135},
          thickness=0.5),
        Line(
          points={{-90,-60},{-84,-60},{-84,-60},{84,-60},{84,-60},{90,-60}},
          color={0,128,255},
          thickness=0.5),
        Polygon(
          points={{-60,70},{-60,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{62,68},{78,52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,68},{78,52}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Ellipse(
          extent={{62,84},{78,68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,84},{78,68}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Text(
          extent={{-56,60},{-40,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{40,60},{56,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{-16,-40},{0,-58}},
          lineColor={135,135,135},
          textString="3")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
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
  Simple circuit with a pump for the distribution of hot or cold water.
  All sensor and actor values are connected to the hydraulic bus.
</p>
<h4>
  <span style=\"color: #008c48\">Characteristics</span>
</h4>
<p>
  The volume flow or pressure difference depends on the pump speed.
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects.
</p>
</html>"));
end Pump;
