within AixLib.Fluid.Movers.PumpsPolynomialBased.Examples;
model PumpHeadControlled "testing the head controlled pump model."
  extends Modelica.Icons.Example;

  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  .AixLib.Fluid.Movers.PumpsPolynomialBased.PumpHeadControlled pump(
    m_flow_nominal=m_flow_nominal,
    calculatePower=true,
    calculateEfficiency=true,
    redeclare package Medium = Medium,
    pumpParam=DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_8_V9())
               annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  Modelica.Blocks.Sources.Ramp rampValvePosition(
    offset=0.5,
    height=0.5,
    duration(displayUnit="s") = 120,
    startTime(displayUnit="min") = 120)
    annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
  AixLib.Fluid.Sources.Boundary_pT vessle(
    redeclare package Medium = Medium, nPorts=2)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-36,20})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.1 "Nominal mass flow rate";
  Modelica.Blocks.Sources.BooleanPulse    PumpOn1(period=600, width=500/600*100,
    startTime=0)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.Ramp rampPumpDp(
    height=2,
    offset=2,
    duration(displayUnit="s") = 100,
    startTime(displayUnit="s") = 100)
    annotation (Placement(transformation(extent={{46,30},{26,50}})));
  BaseClasses.PumpBus                                          pumpBus
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Actuators.Valves.TwoWayLinear             simpleValve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=6.3,
    dpFixed_nominal=1000)
    annotation (Placement(transformation(extent={{-20,-20},{-40,-40}})));
equation
  connect(PumpOn1.y, pumpBus.onSet) annotation (Line(points={{-49,40},{-28,40},{
          -28,40},{-14,40},{-14,40.05},{0.05,40.05}}, color={255,0,255}), Text(
      string="%second",
      index=2,
      extent={{6,3},{6,3}}));
  connect(pumpBus, pump.pumpBus) annotation (Line(
      points={{0,40},{0,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(rampPumpDp.y, pumpBus.dpSet) annotation (Line(points={{25,40},{12,40},
          {12,40.05},{0.05,40.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pump.port_b, simpleValve.port_a) annotation (Line(points={{10,10},{40,
          10},{40,-30},{-20,-30}}, color={0,127,255}));
  connect(vessle.ports[1], pump.port_a)
    annotation (Line(points={{-34,10},{-10,10}}, color={0,127,255}));
  connect(simpleValve.port_b, vessle.ports[2]) annotation (Line(points={{-40,-30},
          {-60,-30},{-60,10},{-38,10}}, color={0,127,255}));
  connect(rampValvePosition.y, simpleValve.y)
    annotation (Line(points={{-21,-60},{-30,-60},{-30,-42}}, color={0,0,127}));
  annotation (
      experiment(
      StopTime=600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
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
  <li>2018-02-01 by Peter Matthes<br/>
    Switches pump off near end of simulation to check for handling of
    power and efficiency calculation. Improves plot script.
  </li>
  <li>2018-01-29 by Peter Matthes:<br/>
    * Removes parameter useABCformula in pump model and changes pump
    record to Stratos_Pico_25_1_6.<br/>
    * The selectable function for efficiency calculation could be
    removed from the parameter dialog.
  </li>
  <li>2018-01-26 by Peter Matthes:<br/>
    Changes parameter name n_start into Nstart in the pump models.
  </li>
  <li>2017-11-22 by Peter Matthes<br/>
    Implemented
  </li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/Movers/PumpsPolynomialBased/Examples/PumpHeadControlled.mos"
        "Simulate and plot"));
end PumpHeadControlled;
