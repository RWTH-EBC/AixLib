within AixLib.Fluid.FixedResistances.Examples;
model Compare_FixedResistances_HydraulicResitance2
  "Assess simulation speed of HydraulicResistance"
  extends Modelica.Icons.Example;

 package Medium = AixLib.Media.Water;
    Modelica.Blocks.Sources.Constant PAtm(k=101325)
      annotation (Placement(transformation(extent={{66,76},{86,96}})));
    Modelica.Blocks.Sources.Trapezoid
                                 P(
    offset=101325,
    amplitude=12000,
    rising=1,
    width=0.5,
    falling=1,
    period=3)    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  AixLib.Fluid.Sources.Boundary_pT sou1(          redeclare package Medium =
        Medium,
    T=293.15,
    nPorts=1,
    use_p_in=true)        annotation (Placement(transformation(extent={{-70,28},
            {-50,48}})));
  AixLib.Fluid.Sources.Boundary_pT sin1(          redeclare package Medium =
        Medium,
    T=283.15,
    nPorts=1,
    use_p_in=true)        annotation (Placement(transformation(extent={{80,28},
            {60,48}})));
    HydraulicResistance HR(
    redeclare package Medium = Medium,
    zeta=10000/8,
    m_flow_small=0.001,
    dp_start=P.offset - PAtm.k,
    m_flow_start=0,
    D=sqrt(1/(sqrt(995.586)*Modelica.Constants.pi)))
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  AixLib.Fluid.Sensors.MassFlowRate masFlo2(redeclare package Medium = Medium)
    "Mass flow rate sensor" annotation (Placement(transformation(extent={{0,-10},
            {20,10}})));

equation
  connect(PAtm.y, sin1.p_in)
                            annotation (Line(points={{87,86},{94,86},{94,46},{
          82,46}}, color={0,0,127}));
  connect(P.y, sou1.p_in) annotation (Line(points={{-79,80},{-74,80},{-74,46},{
          -72,46}}, color={0,0,127}));
  connect(HR.port_b, masFlo2.port_a) annotation (Line(points={{-8,6.10623e-16},
          {-4,-3.36456e-22},{-4,6.10623e-16},{-5.55112e-16,6.10623e-16}}, color
        ={0,127,255}));
  connect(sou1.ports[1], HR.port_a) annotation (Line(points={{-50,38},{-38,38},
          {-38,6.10623e-016},{-28,6.10623e-016}}, color={0,127,255}));
  connect(sin1.ports[1], masFlo2.port_b) annotation (Line(
      points={{60,38},{52,38},{52,6.10623e-016},{20,6.10623e-016}},
      color={0,127,255}));
    annotation (experiment(StopTime=100000),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FixedResistances/Examples/FixedResistancesParallel.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput);
end Compare_FixedResistances_HydraulicResitance2;
