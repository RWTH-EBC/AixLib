within AixLib.Fluid.FixedResistances.Examples;
model PerformanceHydraulicResistance2
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
          {-4,-3.36456e-22},{-4,6.10623e-16},{-5.55112e-16,6.10623e-16}}, color=
         {0,127,255}));
  connect(sou1.ports[1], HR.port_a) annotation (Line(points={{-50,38},{-38,38},
          {-38,6.10623e-016},{-28,6.10623e-016}}, color={0,127,255}));
  connect(sin1.ports[1], masFlo2.port_b) annotation (Line(
      points={{60,38},{52,38},{52,6.10623e-016},{20,6.10623e-016}},
      color={0,127,255}));
    annotation (experiment(StopTime=10000),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FixedResistances/Examples/FixedResistancesParallel.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput,
    Diagram(graphics={Text(
          extent={{-72,-60},{80,-74}},
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
href=\"AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>.
Use the second test <a
href=\"AixLib.Fluid.FixedResistances.Examples.PerformanceHydraulicResistance1\">PerformanceHydraulicResistance1</a>
to test the speed of <a
href=\"AixLib.Fluid.FixedResistances.FixedResistanceDpM\">FixedResistanceDpM</a>.
</p>
<h4>Speed Comparison</h4>
<p>During the test the pressure difference will go up and down to test all flow
regimes. Especially low pressure differences and mass flow rates will be hard
for the solver. A simulation time of 10000 s was chosen to have a sufficiently
long time for measurment but avoiding extreme simulation times. On an Intel Xeon
E5-2667 @ 2.90 GHz the total simulation time will be around 1.21 s.</p> <p>The
FixedResistanceDpM model (0.72 s) needs only around 60 &#37; of the simulation
time of the HydraulicResistance model (1.21 s). The following graph showes the
time comparion for a longer simulation time:</p> <p><img
src=\"modelica://AixLib/Resources/Images/Fluid/FixedResistances/Compare_FixedResistances_HydraulicResitance_sim_speed_single_models.png\"
alt=\"Comparison of Simulation Speed for Both Models\"/></p>
<p>Running both models in parallel (<a
href=\"AixLib.Fluid.FixedResistances.Examples.CompareFixedResistances\">Examples.CompareFixedResistances</a>)
will not add equally to the total simulation time as can be seen in the dotted
green line.</p>
<h4>Reformulation of Pressure Loss Equation</h4>
<p>The equation for the pressure loss has been changed from</p>
<p><img src=\"modelica://AixLib/Resources/Images/equations/equation-Fluid_FixedResistance_old.png\" alt=\"dp = sign(m_flow) * 8 * zeta / (Modelica.Constants.pi ^ 2 * D ^ 4 * rho) * m_flow^2\" /></p>
<p>to</p>
<p><img src=\"modelica://AixLib/Resources/Images/equations/equation-Fluid_FixedResistance_new.png\" alt=\"dp = sign(m_flow) * 8 * zeta / (Modelica.Constants.pi * Modelica.Constants.pi * D * D * D * D * rho) * m_flow * m_flow\"/></p>
<p>to avoid exponential terms for Pi, D and m_flow as that showed speed improvements and more stable simulation in a weather model some years ago. However, this did not result in speedups for this model and Dymola 2017 as shown in the following graph:</p>
<p><img src=\"modelica://AixLib/Resources/Images/Fluid/FixedResistances/Compare_FixedResistances_HydraulicResitance_simulation_speed.png\"
alt=\"Comparison of Simulation Speed for Different Formulation of Flow Equation\"/></p>
</html>"));
end PerformanceHydraulicResistance2;
