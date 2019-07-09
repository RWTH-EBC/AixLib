within AixLib.Fluid.HeatPumps.Examples;
model Carnot_RE
  "Test model for chiller based on Carnot efficiency and evaporator outlet temperature control signal"
  extends Modelica.Icons.Example;
 package Medium1 = AixLib.Media.Water "Medium model";
 package Medium2 = AixLib.Media.Water "Medium model";

  parameter Modelica.SIunits.TemperatureDifference dTEva_nominal=-10
    "Temperature difference evaporator outlet-inlet";
  parameter Modelica.SIunits.TemperatureDifference dTCon_nominal=10
    "Temperature difference condenser outlet-inlet";
  parameter Real COPc_nominal = 3 "Chiller COP";
  parameter Modelica.SIunits.HeatFlowRate QEva_flow_nominal = -100E3
    "Evaporator heat flow rate";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=
    QEva_flow_nominal/dTEva_nominal/4200
    "Nominal mass flow rate at chilled water side";

  AixLib.Fluid.Sources.MassFlowSource_T sou1(
    redeclare package Medium = Medium1,
    use_T_in=false,
    use_m_flow_in=true,
    T=298.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-56,-36},{-36,-16}})));
  AixLib.Fluid.Sources.MassFlowSource_T sou2(
    redeclare package Medium = Medium2,
    m_flow=m2_flow_nominal,
    use_T_in=false,
    T=295.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{44,42},{24,62}})));
  AixLib.Fluid.Sources.FixedBoundary sin1(
    redeclare package Medium = Medium1, nPorts=1)
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        origin={70,30})));
  AixLib.Fluid.Sources.FixedBoundary sin2(
    redeclare package Medium = Medium2, nPorts=1)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-16,2})));
  Modelica.Blocks.Sources.Ramp TEvaLvg(
    duration=60,
    startTime=1800,
    offset=273.15 + 6,
    height=10) "Control signal for evaporator leaving temperature"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Math.Gain mCon_flow(k=-1/cp1_default/dTEva_nominal)
    "Condenser mass flow rate"
    annotation (Placement(transformation(extent={{-80,4},{-60,24}})));
  Modelica.Blocks.Math.Add QCon_flow(k2=-1) "Condenser heat flow rate"
    annotation (Placement(transformation(extent={{48,-50},{68,-30}})));

  final parameter Modelica.SIunits.SpecificHeatCapacity cp1_default=
    Medium1.specificHeatCapacityCp(Medium1.setState_pTX(
      Medium1.p_default,
      Medium1.T_default,
      Medium1.X_default))
    "Specific heat capacity of medium 1 at default medium state";
  Carnot_TCon_RE heaPum(
   redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    dTEva_nominal=dTEva_nominal,
    dTCon_nominal=dTCon_nominal,
    m2_flow_nominal=m2_flow_nominal,
    show_T=true,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.3,
    dp1_nominal=6000,
    dp2_nominal=6000,
    Q_cooling_nominal=QEva_flow_nominal,
    m1_flow_nominal=2,
    Q_heating_nominal=1000)
    annotation (Placement(transformation(extent={{6,-2},{26,18}})));
equation
  connect(QCon_flow.y, mCon_flow.u) annotation (Line(points={{69,-40},{80,-40},
          {80,-60},{-92,-60},{-92,14},{-82,14}},color={0,0,127}));
  connect(mCon_flow.y, sou1.m_flow_in)
    annotation (Line(points={{-59,14},{-56,14},{-56,-18},{-58,-18}},
                                                          color={0,0,127}));
  connect(TEvaLvg.y, heaPum.TSet)
    annotation (Line(points={{-39,50},{4,50},{4,17}}, color={0,0,127}));
  connect(sou2.ports[1], heaPum.port_a1) annotation (Line(points={{24,52},{12,52},
          {12,56},{-6,56},{-6,14},{6,14}}, color={0,127,255}));
  connect(heaPum.port_b1, sin1.ports[1]) annotation (Line(points={{26,14},{30,14},
          {30,30},{60,30},{60,30}}, color={0,127,255}));
  connect(sou1.ports[1], heaPum.port_a2) annotation (Line(points={{-36,-26},{6,-26},
          {6,-10},{36,-10},{36,2},{26,2}}, color={0,127,255}));
  connect(sin2.ports[1], heaPum.port_b2)
    annotation (Line(points={{-6,2},{6,2}}, color={0,127,255}));
  connect(heaPum.P, QCon_flow.u1) annotation (Line(points={{27,8},{36,8},{36,-34},
          {46,-34}}, color={0,0,127}));
  connect(heaPum.QEva_flow, QCon_flow.u2)
    annotation (Line(points={{27,-1},{27,-46},{46,-46}}, color={0,0,127}));
  annotation (experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Chillers/Examples/Carnot_TEva.mos"
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
November 25, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Carnot_RE;
