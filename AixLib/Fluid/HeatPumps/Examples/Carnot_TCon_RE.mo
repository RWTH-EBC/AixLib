within AixLib.Fluid.HeatPumps.Examples;
model Carnot_TCon_RE
  "Test model for heat pump based on Carnot efficiency and condenser outlet temperature control signal"
  extends Modelica.Icons.Example;
  package Medium1 = AixLib.Media.Water "Medium model";
  package Medium2 = AixLib.Media.Water "Medium model";

  parameter Modelica.SIunits.TemperatureDifference dTEva_nominal=-5
    "Temperature difference evaporator inlet-outlet";
  parameter Modelica.SIunits.TemperatureDifference dTCon_nominal=10
    "Temperature difference condenser outlet-inlet";
  parameter Modelica.SIunits.HeatFlowRate QCon_flow_nominal = 100E3
    "Evaporator heat flow rate";
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal=
    QCon_flow_nominal/dTCon_nominal/4200 "Nominal mass flow rate at condenser";

  Carnot_TCon_RE_Jonas               heaPum(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m2_flow_nominal=0.2,
    dTEva_nominal=dTEva_nominal,
    dTCon_nominal=dTCon_nominal,
    m1_flow_nominal=m1_flow_nominal,
    show_T=true,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.3,
    QCon_flow_nominal=QCon_flow_nominal,
    dp1_nominal=6000,
    dp2_nominal=6000,
    Q_heating_nominal=200,
    Q_cooling_nominal=-200)
                      "Heat pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,34})));
  AixLib.Fluid.Sources.MassFlowSource_T sou1(
    redeclare package Medium = Medium1,
    use_m_flow_in=true,
    m_flow=m1_flow_nominal,
    use_T_in=true,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={48,12})));
  AixLib.Fluid.Sources.MassFlowSource_T sou2(
    redeclare package Medium = Medium2,
    use_T_in=true,
    use_m_flow_in=true,
    T=288.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-48,40})));
  AixLib.Fluid.Sources.Boundary_pT sin2(
    redeclare package Medium = Medium2, nPorts=1)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={80,40})));
  AixLib.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = Medium1, nPorts=1)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-48,14})));

  final parameter Modelica.SIunits.SpecificHeatCapacity cp2_default=
    Medium2.specificHeatCapacityCp(Medium2.setState_pTX(
      Medium2.p_default,
      Medium2.T_default,
      Medium2.X_default))
    "Specific heat capacity of medium 2 at default medium state";

  Modelica.Blocks.Logical.GreaterThreshold c(threshold=10)
    "if theres a cold demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-38,-40},{-18,-20}})));
  Modelica.Blocks.Sources.TimeTable cold_demand(table=[0,0; 600,1000; 1200,3000;
        1800,0; 2400,0; 3000,500; 3600,4000])
    annotation (Placement(transformation(extent={{-74,-40},{-54,-20}})));
  Modelica.Blocks.Sources.RealExpression m_flow_2(y=0.4) annotation (Placement(
        transformation(
        extent={{-9,-10},{9,10}},
        rotation=0,
        origin={-87,54})));
  Modelica.Blocks.Sources.RealExpression T_network(y=273.15 + 20) annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-87,30})));
  Modelica.Blocks.Sources.RealExpression m_flow_1(y=0.4) annotation (Placement(
        transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={87,16})));
  Modelica.Blocks.Sources.RealExpression T_RL(y=273.15 + 25) annotation (
      Placement(transformation(
        extent={{11,-10},{-11,10}},
        rotation=0,
        origin={83,-14})));
  Modelica.Blocks.Sources.RealExpression T_VL(y=273.15 + 15) annotation (
      Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={-5,-2})));
  Modelica.Blocks.Math.Division dT_cold annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={4,-60})));
  Modelica.Blocks.Math.Add T_cold_return(k1=-1)
    annotation (Placement(transformation(extent={{38,-36},{58,-56}})));
  Modelica.Blocks.Sources.RealExpression m_flow_11(y=m_flow_1.y)
    annotation (Placement(transformation(extent={{-96,-96},{-72,-72}})));
  Modelica.Blocks.Math.Gain cp_dT1(k=4180)
    annotation (Placement(transformation(extent={{-50,-94},{-30,-74}})));
equation
  connect(cold_demand.y, c.u)
    annotation (Line(points={{-53,-30},{-40,-30}}, color={0,0,127}));
  connect(sou2.ports[1], heaPum.port_a2)
    annotation (Line(points={{-38,40},{-10,40}}, color={0,127,255}));
  connect(heaPum.port_b2, sin2.ports[1])
    annotation (Line(points={{10,40},{70,40}}, color={0,127,255}));
  connect(heaPum.port_a1, sou1.ports[1]) annotation (Line(points={{10,28},{26,
          28},{26,12},{38,12}}, color={0,127,255}));
  connect(heaPum.port_b1, sin1.ports[1]) annotation (Line(points={{-10,28},{-24,
          28},{-24,14},{-38,14}}, color={0,127,255}));
  connect(c.y, heaPum.is_cooling) annotation (Line(points={{-17,-30},{34,-30},{
          34,31.8},{11,31.8}}, color={255,0,255}));
  connect(m_flow_2.y, sou2.m_flow_in) annotation (Line(points={{-77.1,54},{-68,
          54},{-68,48},{-60,48}}, color={0,0,127}));
  connect(T_network.y, sou2.T_in) annotation (Line(points={{-74.9,30},{-68,30},
          {-68,44},{-60,44}}, color={0,0,127}));
  connect(m_flow_1.y, sou1.m_flow_in) annotation (Line(points={{77.1,16},{72,16},
          {72,20},{60,20}}, color={0,0,127}));
  connect(T_VL.y, heaPum.TSet) annotation (Line(points={{7.1,-2},{22,-2},{22,25},
          {12,25}}, color={0,0,127}));
  connect(m_flow_11.y, cp_dT1.u)
    annotation (Line(points={{-70.8,-84},{-52,-84}}, color={0,0,127}));
  connect(cold_demand.y, dT_cold.u1) annotation (Line(points={{-53,-30},{-46,
          -30},{-46,-54},{-8,-54}}, color={0,0,127}));
  connect(cp_dT1.y, dT_cold.u2) annotation (Line(points={{-29,-84},{-20,-84},{
          -20,-66},{-8,-66}}, color={0,0,127}));
  connect(T_VL.y, T_cold_return.u2) annotation (Line(points={{7.1,-2},{22,-2},{
          22,-40},{36,-40}}, color={0,0,127}));
  connect(dT_cold.y, T_cold_return.u1) annotation (Line(points={{15,-60},{26,
          -60},{26,-52},{36,-52}}, color={0,0,127}));
  connect(T_cold_return.y, sou1.T_in) annotation (Line(points={{59,-46},{68,-46},
          {68,16},{60,16}}, color={0,0,127}));
  annotation (experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/Carnot_TCon.mos"
        "Simulate and plot"),
    Documentation(
info="<html>
<p>
Example that simulates a chiller whose efficiency is scaled based on the
Carnot cycle.
The chiller takes as an input the evaporator leaving water temperature.
The condenser mass flow rate is computed in such a way that it has
a temperature difference equal to <code>dTEva_nominal</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
May 2, 2019, by Jianjun Hu:<br/>
Replaced fluid source. This is for 
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1072\"> #1072</a>.
</li>
<li>
November 25, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Carnot_TCon_RE;
