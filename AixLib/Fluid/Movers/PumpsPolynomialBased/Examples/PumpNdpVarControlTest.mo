within AixLib.Fluid.Movers.PumpsPolynomialBased.Examples;
model PumpNdpVarControlTest
  "testing the pump dp-var algorithm with the new \"one record\" pump model with internal speed limitation (instead of pump head limitation)."
  extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system(
    allowFlowReversal=false,
    p_ambient=300000,
    T_ambient=293.15,
    m_flow_start=pump.m_flow_start,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));

  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  PumpSpeedControlled                                                    pump(
    calculatePower=true,
    calculateEfficiency=true,
    redeclare package Medium = Medium,
    pumpParam=DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4())
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  Modelica.Blocks.Sources.BooleanPulse PumpOn(period=600, width=500/600*100)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  AixLib.Fluid.Actuators.Valves.SimpleValve simpleValve(
    redeclare package Medium = Medium,
    m_flow_start=system.m_flow_start,
    m_flow_small=system.m_flow_small,
    Kvs=system.m_flow_nominal*3600/995/sqrt(system.g*2*pump.Hnom/1e5*1000),
    dp_start=pump.p_b_start - pump.p_a_start)
    annotation (Placement(transformation(extent={{-20,-20},{-40,-40}})));

  Modelica.Blocks.Sources.Ramp rampValvePosition(
    offset=0.5,
    height=-0.48,
    duration(displayUnit="s") = 120,
    startTime(displayUnit="min") = 120)
    annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
  AixLib.Fluid.Sources.Boundary_pT vessle(
    redeclare package Medium = Medium,
    p=system.p_start,
    T=system.T_start,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-36,20})));
  Controls.CtrlDpVarN ctrlDpVarN(pumpParam=
        DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4())
    annotation (Placement(transformation(extent={{-10,26},{10,46}})));
  BaseClasses.PumpBus pumpControllerBus1 annotation (Placement(transformation(
          extent={{-10,50},{10,70}}), iconTransformation(extent={{-24,34},{-4,
            54}})));
equation
  connect(rampValvePosition.y, simpleValve.opening)
    annotation (Line(points={{-21,-60},{-30,-60},{-30,-38}}, color={0,0,127}));
  connect(simpleValve.port_b, vessle.ports[1]) annotation (Line(points={{-40,
          -30},{-52,-30},{-52,10},{-34,10}}, color={0,127,255}));
  connect(vessle.ports[2], pump.port_a)
    annotation (Line(points={{-38,10},{-10,10}}, color={0,127,255}));
  connect(pump.port_b, simpleValve.port_a) annotation (Line(points={{10,10},{48,
          10},{48,-30},{-20,-30}}, color={0,127,255}));
  connect(pump.pumpBus, ctrlDpVarN.pumpBus) annotation (Line(
      points={{0,20},{0,26}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrlDpVarN.pumpControllerBus, pumpControllerBus1) annotation (Line(
      points={{0,46},{0,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(PumpOn.y, pumpControllerBus1.onSet) annotation (Line(points={{-59,50},
          {-30,50},{-30,60.05},{0.05,60.05}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
      experiment(StopTime=600),
    Documentation(revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and restructuring.
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Adjusted parameter settings. From pump model removed Nstart (became
    Nnom in pump model) and m_flow_start (should be used as output from
    pump rather than a setting). Changed setting of system.m_flow_start
    to become pump.m_flow_start.
  </li>
  <li>2018-02-01 by Peter Matthes:<br/>
    Switches pump off near end of simulation to check for handling of
    power and efficiency calculation. Improves plot script.
  </li>
  <li>2018-01-29 by Peter Matthes:<br/>
    * Removes parameter useABCformula in pump model and changes pump
    record to Stratos_Pico_25_1_6.<br/>
    * The selectable function for efficiency calculation could be
    removed from the parameter dialog.<br/>
    * Changes Nnom parameter into Nstart as Nnom has been removed.
  </li>
  <li>2017-12-06 by Peter Matthes:<br/>
    Implemented and added new plot script.
  </li>
</ul>
</html>", info="<html>
<h4>
  What the test does
</h4>
<ul>
  <li>Tests PumpN model (speed controlled pump with controller block)
  </li>
  <li>Tests dp-var control (PumpN version, \"dynamic\" calculation)
  </li>
  <li>Tests system pressure drop change (ramp)
  </li>
  <li>Tests pump off-switch
  </li>
</ul>
<h4>
  Annotations
</h4>
<p>
  Always make sure that the pump data (coefficient matrices, table of
  maxMin pump speed, etc.) suite your pump. You can use the test cases
  in <a href=
  \"Zugabe.Zugabe_DB.Pump.Examples\">Zugabe.Zugabe_DB.Pump.Examples</a>
  to check that. Especially if you decide to use the simpler ABC
  coefficients c[2,0], c[1,1] and c[0,2] make sure that they yield
  similar results as the complete set of coefficients. Otherwise the
  result of pump head calculation will be (too) wrong and consequently,
  pump speed might be bound to its limits only.
</p>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Fluid/Movers/PumpsPolynomialBased/Examples/PumpNdpVarControlTest.mos"
        "Simulate and plot"),
    Diagram(graphics={Text(
          extent={{-82,94},{80,66}},
          lineColor={100,100,100},
          horizontalAlignment=TextAlignment.Left,
          textString="* Tests PumpN model (speed controlled pump with controller block)
* Tests dp-var control (PumpN version, \"dynamic\" calculation)
* Tests system pressure drop change (ramp)
* Tests pump off-switch")}));
end PumpNdpVarControlTest;
