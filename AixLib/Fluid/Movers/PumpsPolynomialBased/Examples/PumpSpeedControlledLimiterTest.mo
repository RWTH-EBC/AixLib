within AixLib.Fluid.Movers.PumpsPolynomialBased.Examples;
model PumpSpeedControlledLimiterTest
  "Testing the pump speed algorithm with the new \"one record\" pump model that bounds speed instead of pump head."
  extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system(
    p_ambient=300000,
    T_ambient=293.15,
    m_flow_start=pump.m_flow_start,
    T_start=293.15,
    m_flow_small=pump.m_flow_start*1e-2)
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));

  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater;

  PumpSpeedControlled pump(
    calculatePower=true,
    calculateEfficiency=true,
    redeclare function efficiencyCharacteristic =
        AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency,
    redeclare package Medium = Medium,
    pumpParam=DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4())
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumpBus
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Sources.BooleanConstant PumpOn
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.CombiTimeTable tablePumpSpeed(
    startTime(displayUnit="s"),
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0.0,pump.pumpParam.nMin*0.75; 30,pump.pumpParam.nMin*0.75; 60,pump.pumpParam.nMax
        *1.25; 90,pump.pumpParam.nMax*1.25; 120,pump.pumpParam.nMin*0.75; 150,
        pump.pumpParam.nMin*0.75])
                annotation (Placement(transformation(extent={{46,30},{26,50}})));
  AixLib.Fluid.Actuators.Valves.SimpleValve simpleValve(
    redeclare package Medium = Medium,
    Kvs=system.m_flow_nominal*3600/995/sqrt(system.g*pump.Hnom/1e5*1000),
    m_flow_start=system.m_flow_start,
    m_flow_small=system.m_flow_small,
    dp_start=pump.p_b_start - pump.p_a_start)
    annotation (Placement(transformation(extent={{-20,-20},{-40,-40}})));

  Modelica.Blocks.Sources.CombiTimeTable tableValvePosition(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    startTime(displayUnit="s"),
    table=[0,0.75; 10,0.75; 20,0.02; 30,0.02; 40,0.75; 50,0.75])
    annotation (Placement(transformation(extent={{0,-72},{-20,-52}})));
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
  connect(simpleValve.port_b, vessle.ports[1]) annotation (Line(points={{-40,-30},
          {-52,-30},{-52,10},{-34,10}}, color={0,127,255}));
  connect(vessle.ports[2], pump.port_a)
    annotation (Line(points={{-38,10},{-10,10}}, color={0,127,255}));
  connect(pump.port_b, simpleValve.port_a) annotation (Line(points={{10,10},{48,
          10},{48,-30},{-20,-30}}, color={0,127,255}));
  connect(tableValvePosition.y[1], simpleValve.opening)
    annotation (Line(points={{-21,-62},{-30,-62},{-30,-38}}, color={0,0,127}));
  connect(tablePumpSpeed.y[1], pumpBus.rpmSet) annotation (Line(points={{25,40},
          {12,40},{12,40.05},{0.05,40.05}}, color={0,0,127}), Text(
      string="%second",
      index=2,
      extent={{6,3},{6,3}}));
  annotation (
    experiment(StopTime=200),
    Documentation(revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and restructuring.
  </li>
  <li>2018-05-08 by Peter Matthes:<br/>
    Removes most advanced Dymola settings from plot script. This fixes
    a situation when Dymola didn't display anything in the plot windows
    and it removed the variables tree.
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Adjusted parameter settings. From pump model removed m_flow_start
    (should be used as output from pump rather than a setting). Changed
    setting of system.m_flow_start to become pump.m_flow_start.
  </li>
  <li>2018-01-29 by Peter Matthes:<br/>
    * The selectable function for efficiency calculation could be
    removed from the parameter dialog.<br/>
    * Increases simulation time and table time settings.
  </li>
  <li>2017-12-06 by Peter Matthes<br/>
    Switches to useABCformulas=false since the Pico 1-4 data set does
    not contain usable ABC coefficients.
  </li>
  <li>2017-12-01 by Peter Matthes<br/>
    Implemented. Plot script needed updating due to name changes in
    pump model.
  </li>
</ul>
</html>", info="<html>
<p>
  Tests the pump model with single parameter record that also uses the
  limitiation of the pump speed (<i>pumpParam.maxMinSpeedCurves</i>)
  instead of the pump head limitation (<i>maxMinHead</i>).
</p>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Fluid/Movers/PumpsPolynomialBased/Examples/PumpSpeedControlledLimiterTest.mos"
        "Simulate and plot"),
    Diagram(graphics={Text(
          extent={{-82,94},{80,66}},
          lineColor={100,100,100},
          horizontalAlignment=TextAlignment.Left,
          textString="* Tests PumpPhysicsN model (speed control)
* Tests pump speed change (table)
* Tests speed bounding function (n > nMax, n < nMin)
* Tests system pressure drop change (table)")}));
end PumpSpeedControlledLimiterTest;
