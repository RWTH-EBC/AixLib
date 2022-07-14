within AixLib.Fluid.Movers.PumpsPolynomialBased.Examples;
model PumpSpeedControlled "Testing the pump speed controlled model."
  extends Modelica.Icons.Example;

  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  .AixLib.Fluid.Movers.PumpsPolynomialBased.PumpSpeedControlled pump(
    m_flow_nominal=m_flow_nominal,
    pumpParam=DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4(),
    calculatePower=true,
    calculateEfficiency=true,
    redeclare function efficiencyCharacteristic =
        AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumpBus
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Sources.BooleanPulse    PumpOn(period=600, width=500/600*100)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.Ramp rampPumpSpeed(
    height=pump.pumpParam.nMax - pump.pumpParam.nMin + 200,
    offset=pump.pumpParam.nMin - 100,
    duration(displayUnit="s") = 100,
    startTime(displayUnit="s") = 100)
    annotation (Placement(transformation(extent={{46,30},{26,50}})));

  Modelica.Blocks.Sources.Ramp rampValvePosition(
    offset=0.5,
    height=0.48,
    duration(displayUnit="s") = 100,
    startTime(displayUnit="s") = 300)
    annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
  AixLib.Fluid.Sources.Boundary_pT vessle(
    redeclare package Medium = Medium, nPorts=2)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-36,20})));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  Actuators.Valves.TwoWayLinear             simpleValve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=1000)
    annotation (Placement(transformation(extent={{-20,-20},{-40,-40}})));
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
  connect(simpleValve.y, rampValvePosition.y)
    annotation (Line(points={{-30,-42},{-30,-60},{-21,-60}}, color={0,0,127}));
  connect(pump.port_b, simpleValve.port_a) annotation (Line(points={{10,10},{40,
          10},{40,-30},{-20,-30}}, color={0,127,255}));
  connect(simpleValve.port_b, vessle.ports[1]) annotation (Line(points={{-40,-30},
          {-60,-30},{-60,10},{-34,10}}, color={0,127,255}));
  connect(vessle.ports[2], pump.port_a)
    annotation (Line(points={{-38,10},{-10,10}}, color={0,127,255}));
  annotation (
    experiment(Tolerance=1e-6,StopTime=600),
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
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/Movers/PumpsPolynomialBased/Examples/PumpSpeedControlled.mos"
        "Simulate and plot"));
end PumpSpeedControlled;
