within AixLib.Fluid.HeatExchangers.Examples;
model PlateHeatExchanger
  "Example for the model of the plate heat exchanger"
   extends Modelica.Icons.Example;
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    use_T_in=true,
    m_flow=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-92,70},{-72,90}})));
  AixLib.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary1(
    m_flow=1,
    T=273.15 + 35,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={122,20})));

  AixLib.Fluid.Sources.Boundary_pT bou1(
      nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={120,80})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(m_flow_nominal=1, redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(m_flow_nominal=1, redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
                                                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,20})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem2(
      m_flow_nominal=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem3(
      m_flow_nominal=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={70,80})));
  inner Modelica.Fluid.System system(
      m_flow_small=1e-4, energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
                        annotation (Placement(transformation(extent={{-8,86},
            {12,106}},  rotation=0)));
  Modelica.Blocks.Sources.Ramp   cosine(
    offset=278.15,
    height=10,
    duration=20,
    startTime=50)
    annotation (Placement(transformation(extent={{-132,76},{-112,96}})));
  AixLib.Fluid.HeatExchangers.PlateHeatExchanger plateHeatExchanger(
    k=4000,
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp1_nominal(displayUnit="Pa") = 200000,
    dp2_nominal(displayUnit="Pa") = 200000,
    V_ColdCircuit=5/1000,
    V_WarmCircuit=5/1000,
    m_flow1_nominal=1,
    m_flow2_nominal=1,
    A=4)                    annotation (Placement(transformation(
        extent={{30,-30},{-30,30}},
        rotation=90,
        origin={10,50})));
equation
  connect(bou.ports[1], senTem1.port_b) annotation (Line(points={{-80,20},{
          -62,20},{-60,20}}, color={0,127,255}));
  connect(boundary.ports[1], senTem.port_a)
    annotation (Line(points={{-72,80},{-60,80}}, color={0,127,255}));
  connect(senTem2.port_a, boundary1.ports[1])
    annotation (Line(points={{80,20},{80,20},{112,20}}, color={0,127,255}));
  connect(senTem3.port_b, bou1.ports[1])
    annotation (Line(points={{80,80},{92,80},{110,80}}, color={0,127,255}));
  connect(cosine.y, boundary.T_in) annotation (Line(points={{-111,86},{-102,
          86},{-102,84},{-94,84}}, color={0,0,127}));
  connect(senTem.port_b, plateHeatExchanger.port_a1) annotation (Line(points={{-40,80},
          {-26,80},{-8,80}},                        color={0,127,255}));
  connect(senTem1.port_a, plateHeatExchanger.port_b1) annotation (Line(points={{-40,20},
          {-8,20}},                            color={0,127,255}));
  connect(senTem2.port_b, plateHeatExchanger.port_a2) annotation (Line(points={{60,20},
          {28,20}},                         color={0,127,255}));
  connect(senTem3.port_a, plateHeatExchanger.port_b2) annotation (Line(points={{60,80},
          {38,80},{28,80}},                         color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-140,0},{160,100}},
          preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>2017-04-25 by Peter Matthes:<br>Adaptes the example to work with the changes in the heat exchanger model (parameter). Also reduced default values for A and k to have a more reasonable setup. Also exchanged the sinus temperature input on the cold side to a ramp function to make the model behavior more apprehensible. </li>
</ul>
</html>", info="<html>
<p>The model simulates but seems to some issues. The following list contains dubious behavior: </p>
<ul>
<li>In the cP_DH model is a hack to override the temperature difference at start for a given amount of time. This led to simulation error as the heat flow on DH side was completely wrong.</li>
<li>The computation of heat flow (Q_HS, Q_DH) depends on temperature difference of the in- and outflowing medium. At simulation start the heat flow is constant (see plot script) but temperature difference is not. This seems to be wrong.</li>
<li>The dimensionless figures P, R and NTU stay always constant in the example. This will be due to the use of &QUOT;contantPropertiesLiquidWater&QUOT;.</li>
</ul>
<p>The model requires to provide A and k (average coefficient of heat transfer of heat exchanger). Normally, we do not know k and k will not be a parameter but a function of temperature, mass flow rate and heat exchanger geometry. Therefore, the model must be parameterized by using measurment data for a small operational range. Thus it will be hard to parameterize the model under normal circumstances.</p>
</html>"),
    experiment(StopTime=100));
end PlateHeatExchanger;
