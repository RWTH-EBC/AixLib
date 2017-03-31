within AixLib.Fluid.FixedResistances.Examples;
model PerformanceHydraulicResistance1
  "Assess simulation speed of FixedResistancesDpM"
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
  AixLib.Fluid.FixedResistances.PressureDrop FRdp(
    redeclare package Medium = Medium,
    deltaM=0.3,
    linearized=false,
    m_flow_nominal=1,
    dp(start=P.offset - PAtm.k),
    dp_nominal=10000,
    from_dp=false)
    annotation (Placement(transformation(extent={{-28,28},{-8,48}})));
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
  AixLib.Fluid.Sensors.MassFlowRate masFlo1(redeclare package Medium = Medium)
    "Mass flow rate sensor" annotation (Placement(transformation(extent={{20,28},
            {40,48}})));

equation
  connect(PAtm.y, sin1.p_in)
                            annotation (Line(points={{87,86},{94,86},{94,46},{
          82,46}}, color={0,0,127}));
  connect(P.y, sou1.p_in) annotation (Line(points={{-79,80},{-74,80},{-74,46},{
          -72,46}}, color={0,0,127}));
  connect(FRdp.port_b, masFlo1.port_a)
    annotation (Line(points={{-8,38},{-2,38},{6,38},{20,38}},
                                              color={0,127,255}));
  connect(sou1.ports[1],FRdp. port_a) annotation (Line(
      points={{-50,38},{-40,38},{-28,38}},
      color={0,127,255}));
  connect(sin1.ports[1], masFlo1.port_b) annotation (Line(
      points={{60,38},{50,38},{40,38}},
      color={0,127,255}));
    annotation (experiment(StopTime=100000),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FixedResistances/Examples/FixedResistancesParallel.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput,
    Diagram(graphics={Text(
          extent={{-76,-60},{76,-74}},
          lineColor={28,108,200},
          textString="activate time measurement!

OutputCPUtime:=true;")}),
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>Test the simulation time of the resistance model <a
href=\"AixLib.Fluid.FixedResistances.FixedResistanceDpM\">FixedResistanceDpM</a>.
Use the second test <a
href=\"AixLib.Fluid.FixedResistances.Examples.PerformanceHydraulicResistance2\">PerformanceHydraulicResistance2</a>
to test the speed of <a
href=\"AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>.
</p>
<p>During the test the pressure difference will go up and down to test all flow
regimes. Especially low pressure differences and mass flow rates will be hard
for the solver. A simulation time of 10000 s was chosen to have a sufficiently
long time for measurment but avoiding extreme simulation times. On an Intel Xeon
E5-2667 @ 2.90 GHz the total simulation time will be around 0.72 s.</p>
<p>The FixedResistanceDpM model (0.72 s) needs only around 60 &#37; of the
simulation time of the HydraulicResistance model (1.21 s).</p>
</html>"));
end PerformanceHydraulicResistance1;
