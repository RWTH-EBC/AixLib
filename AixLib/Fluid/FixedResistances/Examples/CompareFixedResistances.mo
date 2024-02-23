within AixLib.Fluid.FixedResistances.Examples;
model CompareFixedResistances
  "Compare models FixedResistancesDpM and HydraulicResistance"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water;
  Modelica.Blocks.Sources.Constant PAtm(k=101325)
    annotation (Placement(transformation(extent={{66,76},{86,96}})));
  Modelica.Blocks.Sources.Trapezoid P(
    rising=1,
    width=0.5,
    falling=1,
    period=3,
    amplitude=-12000,
    offset=101325 + 6000)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  AixLib.Fluid.FixedResistances.PressureDrop FRdp(
    redeclare package Medium = Medium,
    deltaM=0.3,
    linearized=false,
    m_flow_nominal=1,
    dp(start=P.offset - PAtm.k),
    from_dp=true,
    dp_nominal=10000)
    annotation (Placement(transformation(extent={{-28,30},{-8,50}})));
  AixLib.Fluid.Sources.Boundary_pT sou1(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=2,
    use_p_in=true)
    annotation (Placement(transformation(extent={{-70,28},{-50,48}})));
  AixLib.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = Medium,
    T=283.15,
    nPorts=2,
    use_p_in=true)
    annotation (Placement(transformation(extent={{80,28},{60,48}})));
  HydraulicResistance HR(
    redeclare package Medium = Medium,
    dp_start=P.offset - PAtm.k,
    m_flow_start=0,
    diameter=sqrt(1/(sqrt(995.586)*Modelica.Constants.pi)),
    m_flow_nominal=1,
    from_dp=true,
    zeta=10000/8)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  AixLib.Fluid.Sensors.MassFlowRate masFlo2(redeclare package Medium = Medium)
    "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  AixLib.Utilities.Diagnostics.AssertEquality assEqu(message=
        "Inputs differ, check that lossless pipe is correctly implemented.",
      threShold=0.1) "Assert equality of the two mass flow rates"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  AixLib.Fluid.Sensors.MassFlowRate masFlo1(redeclare package Medium = Medium)
    "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{20,30},{40,50}})));

equation
  connect(PAtm.y, sin1.p_in) annotation (Line(points={{87,86},{94,86},{94,46},{
          82,46}}, color={0,0,127}));
  connect(P.y, sou1.p_in) annotation (Line(points={{-79,80},{-74,80},{-74,46},{
          -72,46}}, color={0,0,127}));
  connect(HR.port_b, masFlo2.port_a) annotation (Line(points={{-8,6.10623e-16},
          {-4,-3.36456e-22},{-4,6.10623e-16},{-5.55112e-16,6.10623e-16}}, color=
         {0,127,255}));
  connect(FRdp.port_b, masFlo1.port_a)
    annotation (Line(points={{-8,40},{20,40}}, color={0,127,255}));
  connect(sou1.ports[1], FRdp.port_a)
    annotation (Line(points={{-50,40},{-28,40}}, color={0,127,255}));
  connect(sou1.ports[2], HR.port_a) annotation (Line(points={{-50,36},{-38,36},
          {-38,6.10623e-16},{-28,6.10623e-16}}, color={0,127,255}));
  connect(sin1.ports[1], masFlo1.port_b)
    annotation (Line(points={{60,40},{40,40}}, color={0,127,255}));
  connect(sin1.ports[2], masFlo2.port_b) annotation (Line(points={{60,36},{52,
          36},{52,6.10623e-16},{20,6.10623e-16}}, color={0,127,255}));
  connect(masFlo2.m_flow, assEqu.u1)
    annotation (Line(points={{10,11},{10,76},{38,76}}, color={0,0,127}));
  connect(masFlo1.m_flow, assEqu.u2)
    annotation (Line(points={{30,51},{30,64},{38,64}}, color={0,0,127}));
  annotation (
    experiment(StopTime=3600, Tolerance=1e-06),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FixedResistances/Examples/CompareFixedResistances.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html><p>
  Compares the mass flow rate of the two pressure loss models <a href=
  \"AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>
  and <a href=
  \"AixLib.Fluid.FixedResistances.FixedResistanceDpM\">FixedResistanceDpM</a>.
  For small pressure differences (up to 800 Pa) the flow rate of
  HydraulicResistance will be larger than the flow rate of
  FixedResistanceDpM. The difference is lower than 0.1 kg/s.
</p>
<p>
  The parameters of the two models are chosen in a way to achieve the
  same pressure drop. Results visualize the equation handling near
  zero. Furthermore, the parameter <code>HR.zeta</code> includes the
  denominator 8 due to the calculation of <span style=
  \"font-family:'Courier New,courier'; color:#0000ff;\">final</span>
  <span style=
  \"font-family:'Courier New,courier';\">dp_nominal=8*zeta*...</span> in
  the model <a href=
  \"AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>.
</p>
<p>
  <br/>
  Change parameter <code>HR.from_dp</code> to <code>false</code> and
  the simulation time will increase by about 25 %.
</p>
<p>
  Choosing this parameter depending whether you are using a mass flow
  source or a pressure source might improve the stability of the
  simulation.
</p>
<p>
  Using a mass flow source and <code>HR.from_dp = false</code> shows
  similiar simulation speed as with <code>HR.from_dp = true</code>.
</p>
<ul>
  <li>
    <i>April 27, 2017&#160;</i> by Philipp Mehrfeld:<br/>
    Test incl. reversal mass flow.
  </li>
  <li>
    <i>April 2016&#160;</i> by Peter Matthes:<br/>
    Example after improved formulation of flow equation according to
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/232\">issue
    #232</a>.
  </li>
</ul>
</html>"));
end CompareFixedResistances;
