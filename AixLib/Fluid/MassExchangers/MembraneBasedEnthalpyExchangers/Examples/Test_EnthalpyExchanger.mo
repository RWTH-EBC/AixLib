within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.Examples;
model Test_EnthalpyExchanger "example test for enthalpy exchanger"
  extends Modelica.Icons.Example;
  EnthalpyExchanger enthalpyExchanger(
    redeclare package Medium = Media.Air,
    n=15,
    nParallel=184,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    lengthDuct=0.34,
    heightDuct=0.0025,
    widthDuct=0.3,
    couFloArr=false,
    aspRatCroToTot=0.1,
    uniWalTem=true,
    local=true,
    nWidth=30,
    recDuct=true,
    m_flow_nominal=400/3600*1.18,
    dp_nominal(displayUnit="Pa") = 120,
    thicknessMem=110E-6,
    cpMem=1900,
    lambdaMem=0.34,
    rhoMem(displayUnit="kg/m3") = 920,
    p_a1_start=souAirHot.p,
    p_b1_start=sinAirHot.p,
    p_a2_start=souAirCol.p,
    p_b2_start=sinAirCol.p,
    T_start_m=293.15,
    dT_start=10,
    p_start_m(displayUnit="Pa") = 2000,
    dp_start(displayUnit="Pa") = 100)
    annotation (Placement(transformation(extent={{-26,-22},{26,22}})));
  Sources.Boundary_pT souAirHot(
    redeclare package Medium = Media.Air,
    use_p_in=true,
    T=295.15,
    X={0.008,1 - 0.008},
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,52})));
  Sources.Boundary_pT sinAirHot(
    redeclare package Medium = Media.Air,
    p(displayUnit="Pa"),
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,54})));
  Sources.Boundary_pT souAirCol(
    redeclare package Medium = Media.Air,
    use_p_in=true,
    use_T_in=true,
    use_Xi_in=true,
    X={0.008,1 - 0.008},
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={80,-50})));
  Sources.Boundary_pT sinAirCol(
    redeclare package Medium = Media.Air,
    p(displayUnit="Pa"),
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-50})));
  Modelica.Blocks.Sources.Ramp p_in(
    height=-60,
    duration=600,
    offset=101440,
    startTime=3600)
    annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    f=1/3600,
    offset=278.15)
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=0.002,
    f=1/3600,
    offset=0.003)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Sensors.TemperatureTwoPort senTemHotIn(redeclare package Medium = Media.Air,
      m_flow_nominal=400/3600*1.18)
    annotation (Placement(transformation(extent={{-72,6},{-58,20}})));
  Sensors.TemperatureTwoPort senTemHotOut(redeclare package Medium = Media.Air,
      m_flow_nominal=400/3600*1.18)
    annotation (Placement(transformation(extent={{40,6},{54,20}})));
  Sensors.TemperatureTwoPort senTemColIn(redeclare package Medium = Media.Air,
      m_flow_nominal=400/3600*1.18)
    annotation (Placement(transformation(extent={{72,-20},{58,-6}})));
  Sensors.TemperatureTwoPort senTemColOut(redeclare package Medium = Media.Air,
      m_flow_nominal=400/3600*1.18)
    annotation (Placement(transformation(extent={{-36,-20},{-50,-6}})));
  Sensors.MassFractionTwoPort senMasFraHotIn(
    redeclare package Medium = Media.Air,
    m_flow_nominal=400/3600*1.18,
    X_start=0.005)
    annotation (Placement(transformation(extent={{-52,6},{-38,20}})));
  Sensors.MassFractionTwoPort senMasFraHotOut(
    redeclare package Medium = Media.Air,
    m_flow_nominal=400/3600*1.18,
    X_start=0.005)
    annotation (Placement(transformation(extent={{60,6},{74,20}})));
  Sensors.MassFractionTwoPort senMasFraColIn(
    redeclare package Medium = Media.Air,
    m_flow_nominal=400/3600*1.18,
    X_start=0.003)
    annotation (Placement(transformation(extent={{50,-20},{36,-6}})));
  Sensors.MassFractionTwoPort senMasFraColOut(
    redeclare package Medium = Media.Air,
    m_flow_nominal=400/3600*1.18,
    X_start=0.003)
    annotation (Placement(transformation(extent={{-58,-20},{-72,-6}})));
  Modelica.Blocks.Interaction.Show.RealValue realValue
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Interaction.Show.RealValue realValue1
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Sources.RealExpression senEff(
    y=(senTemColOut.T - senTemColIn.T)/max(1E-6, senTemHotIn.T - senTemColIn.T))
    annotation (Placement(transformation(extent={{2,70},{22,90}})));
  Modelica.Blocks.Sources.RealExpression latEff(
    y=(senMasFraColOut.X - senMasFraColIn.X)/
    max(1E-6, senMasFraHotIn.X - senMasFraColIn.X))
    annotation (Placement(transformation(extent={{2,50},{22,70}})));
equation
  connect(p_in.y, souAirHot.p_in)
    annotation (Line(points={{-41,80},{-72,80},{-72,64}}, color={0,0,127}));
  connect(p_in.y, souAirCol.p_in) annotation (Line(points={{-41,80},{-100,80},{-100,
          -100},{88,-100},{88,-62}}, color={0,0,127}));
  connect(sine.y, souAirCol.T_in)
    annotation (Line(points={{21,-80},{84,-80},{84,-62}}, color={0,0,127}));
  connect(sine1.y, souAirCol.Xi_in[1]) annotation (Line(points={{21,-50},{40,-50},
          {40,-72},{76,-72},{76,-62}}, color={0,0,127}));
  connect(souAirHot.ports[1], senTemHotIn.port_a) annotation (Line(points={{-80,
          42},{-80,13.2},{-72,13}}, color={0,127,255}));
  connect(enthalpyExchanger.port_b1, senTemHotOut.port_a)
    annotation (Line(points={{26,13.2},{26,13},{40,13}}, color={0,127,255}));
  connect(souAirCol.ports[1], senTemColIn.port_a)
    annotation (Line(points={{80,-40},{80,-13},{72,-13}}, color={0,127,255}));
  connect(enthalpyExchanger.port_b2, senTemColOut.port_a) annotation (Line(
        points={{-26,-13.2},{-28,-13.2},{-28,-13},{-36,-13}}, color={0,127,255}));
  connect(senTemHotIn.port_b, senMasFraHotIn.port_a)
    annotation (Line(points={{-58,13},{-52,13}}, color={0,127,255}));
  connect(senMasFraHotIn.port_b, enthalpyExchanger.port_a1) annotation (Line(
        points={{-38,13},{-26,13},{-26,13.2}}, color={0,127,255}));
  connect(senTemHotOut.port_b, senMasFraHotOut.port_a) annotation (Line(points={
          {54,13},{58,13},{58,13},{60,13}}, color={0,127,255}));
  connect(senMasFraHotOut.port_b, sinAirHot.ports[1])
    annotation (Line(points={{74,13},{80,13},{80,44}}, color={0,127,255}));
  connect(senTemColIn.port_b, senMasFraColIn.port_a)
    annotation (Line(points={{58,-13},{50,-13}}, color={0,127,255}));
  connect(senMasFraColIn.port_b, enthalpyExchanger.port_a2) annotation (Line(
        points={{36,-13},{26,-13},{26,-13.2}}, color={0,127,255}));
  connect(senTemColOut.port_b, senMasFraColOut.port_a)
    annotation (Line(points={{-50,-13},{-58,-13}}, color={0,127,255}));
  connect(senMasFraColOut.port_b, sinAirCol.ports[1]) annotation (Line(points={{
          -72,-13},{-80,-13},{-80,-40}}, color={0,127,255}));
  connect(senEff.y, realValue.numberPort)
    annotation (Line(points={{23,80},{38.5,80}}, color={0,0,127}));
  connect(latEff.y, realValue1.numberPort)
    annotation (Line(points={{23,60},{38.5,60}}, color={0,0,127}));
  annotation (experiment(StopTime=7200, Interval=1, method="dassl",Tolerance=1E-6),
    __Dymola_Comands(file=
      "modelica://AixLib/Resources/Scripts/Dymola/Fluid/MassExchangers/MembraneBasedEnthalpyExchangers/Examples/Test_EnthalpyExchanger.mos"
        "Simulate and plot"),
    Documentation(info="<html>This example shows the functionality of the membrane-based enthalpy
exchanger. Two characteristic values for enthalpy exchangers, the
latent and sensible efficiency, are calculated.
</html>", revisions="<html>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end Test_EnthalpyExchanger;
