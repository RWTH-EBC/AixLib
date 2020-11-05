within AixLib.Fluid.Movers.PumpsPolynomialBased.Examples;
model PumpSpeedControlledTest
  "Testing the pump speed algorithm with the new \"one record\" pump model."
  extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system(
    m_flow_small=pump.Qnom*995/3600*1e-2,
    m_flow_start=pump.m_flow_start,
    p_ambient=300000,
    T_ambient=293.15,
    allowFlowReversal=true,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));

  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  PumpSpeedControlled pump(
    pumpParam=DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4(),
    calculatePower=true,
    calculateEfficiency=true,
    redeclare function efficiencyCharacteristic =
        AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency,
    redeclare package Medium = Medium,
    T_start=system.T_start)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumpBus
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Sources.BooleanPulse    PumpOn(period=600, width=500/600*100)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.Ramp rampPumpSpeed(
    height=pump.pumpParam.nMax - pump.pumpParam.nMin,
    offset=pump.pumpParam.nMin,
    duration(displayUnit="s") = 100,
    startTime(displayUnit="s") = 100)
    annotation (Placement(transformation(extent={{46,30},{26,50}})));
  AixLib.Fluid.Actuators.Valves.SimpleValve simpleValve(
    redeclare package Medium = Medium,
    Kvs=system.m_flow_nominal*3600/995/sqrt(system.g*pump.Hnom/1e5*1000),
    m_flow_start=system.m_flow_start,
    m_flow_small=system.m_flow_small,
    dp_start=pump.p_b_start - pump.p_a_start)
    annotation (Placement(transformation(extent={{-20,-20},{-40,-40}})));

  Modelica.Blocks.Sources.Ramp rampValvePosition(
    offset=0.5,
    height=-0.48,
    duration(displayUnit="s") = 100,
    startTime(displayUnit="s") = 300)
    annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
  AixLib.Fluid.Sources.Boundary_pT vessle(
    redeclare package Medium = Medium,
    p=system.p_start,
    T=system.T_start,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-36,20})));
equation
  connect(pumpBus, pump.pumpBus) annotation (Line(
      points={{0,40},{0,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(PumpOn.y, pumpBus.onSet) annotation (Line(points={{-49,40},{-28,40},{
          -28,40},{-14,40},{-14,40.05},{0.05,40.05}}, color={255,0,255}), Text(
      string="%second",
      index=2,
      extent={{6,3},{6,3}}));
  connect(rampPumpSpeed.y, pumpBus.rpmSet) annotation (Line(points={{25,40},{
          0.05,40},{0.05,40.05}}, color={0,0,127}), Text(
      string="%second",
      index=2,
      extent={{6,3},{6,3}}));
  connect(rampValvePosition.y, simpleValve.opening)
    annotation (Line(points={{-21,-60},{-30,-60},{-30,-38}}, color={0,0,127}));
  connect(simpleValve.port_b, vessle.ports[1]) annotation (Line(points={{-40,-30},
          {-52,-30},{-52,10},{-34,10}}, color={0,127,255}));
  connect(vessle.ports[2], pump.port_a)
    annotation (Line(points={{-38,10},{-10,10}}, color={0,127,255}));
  connect(pump.port_b, simpleValve.port_a) annotation (Line(points={{10,10},{48,
          10},{48,-30},{-20,-30}}, color={0,127,255}));
  annotation (
    experiment(StopTime=600),
    Documentation(revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and restructuring.
  </li>
  <li>2018-05-08 by Peter Matthes:<br/>
    * Updates plot script with a view of pump head calculation from
    \"headUnbound\" to the final \"head\".<br/>
    * Sets energy- and massDynamics parameters to it's default
    \"SteadyState\".
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Adjusted parameter settings. From pump model removed Nstart (became
    Nnom in pump model) and m_flow_start (should be used as output from
    pump rather than a setting). Changed setting of system.m_flow_start
    to become pump.m_flow_start.
  </li>
  <li>2018-02-01 by Peter Matthes<br/>
    Switches pump off near end of simulation to check for handling of
    power and efficiency calculation. Improves plot script.
  </li>
  <li>2018-01-29 by Peter Matthes<br/>
    Removes parameter useABCformulas changes pump class to
    PumpPhysicsNbound as the speed controll should be testet.
  </li>
  <li>2017-11-22 by Peter Matthes<br/>
    Renaming to testPumpPhysicsNsetControl. Adds new plot script for
    the test.
  </li>
  <li>2017-11-21 by Peter Matthes<br/>
    Implemented
  </li>
</ul>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Fluid/Movers/PumpsPolynomialBased/Examples/PumpSpeedControlledTest.mos"
        "Simulate and plot"),
    Diagram(graphics={Text(
          extent={{-82,94},{80,66}},
          lineColor={100,100,100},
          horizontalAlignment=TextAlignment.Left,
          textString="* Tests PumpPhysicsN model (speed control)
* Tests pump speed increase (ramp)
* Tests pump off-switch
* Tests system pressure drop change (ramp)")}));
end PumpSpeedControlledTest;
