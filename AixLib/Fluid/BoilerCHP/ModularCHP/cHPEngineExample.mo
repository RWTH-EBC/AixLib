within AixLib.Fluid.BoilerCHP.ModularCHP;
model cHPEngineExample
  CHPGasolineEngine1412Experimental      cHPGasolineEngineDynamicLinked(
    redeclare package Medium1 = MediumGasoline,
    redeclare package Medium2 = MediumAir,
    redeclare package Medium3 = MediumExhaust,
    T_Amb=system.T_ambient,
    exhaustFlow(use_T_in=false, T=873.15))
    annotation (Placement(transformation(extent={{-28,-22},{28,34}})));
  Modelica.Blocks.Sources.RealExpression massFlowGas(y=
        cHPGasolineEngineDynamicLinked.m_Fue)
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  Modelica.Blocks.Sources.RealExpression massFlowAir(y=
        cHPGasolineEngineDynamicLinked.m_Air)
    annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                        inletGasoline(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = MediumGasoline,
    T=system.T_ambient)
    annotation (Placement(transformation(extent={{-68,30},{-52,46}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                        inletAir(
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=false,
    redeclare package Medium = MediumAir,
    T=system.T_ambient)
    annotation (Placement(transformation(extent={{-68,2},{-52,18}})));
  Modelica.Fluid.Sources.FixedBoundary boundaryGasoline(
    nPorts=1,
    redeclare package Medium = MediumExhaust,
    p=system.p_ambient,
    T=system.T_ambient)
             annotation (Placement(transformation(extent={{82,16},{64,36}})));
  replaceable package MediumGasoline =
      DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeH;
  replaceable package MediumAir =
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir;
  replaceable package MediumExhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus;
  inner Modelica.Fluid.System system(T_ambient=298.15)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
  ASM_CHPGenerator                                   aSM_CHPGenerator
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-26,80})));
equation
  connect(inletGasoline.m_flow_in,massFlowGas. y) annotation (Line(points={{-68,
          44.4},{-76,44.4},{-76,44},{-79,44}}, color={0,0,127}));
  connect(massFlowAir.y,inletAir. m_flow_in) annotation (Line(points={{-79,16},
          {-76,16},{-76,16.4},{-68,16.4}},  color={0,0,127}));
  connect(inletGasoline.ports[1], cHPGasolineEngineDynamicLinked.port_Gasoline)
    annotation (Line(points={{-52,38},{-42,38},{-42,27.84},{-28,27.84}}, color=
          {0,127,255}));
  connect(inletAir.ports[1], cHPGasolineEngineDynamicLinked.port_Air)
    annotation (Line(points={{-52,10},{-42,10},{-42,19.44},{-28,19.44}}, color=
          {0,127,255}));
  connect(cHPGasolineEngineDynamicLinked.port_Exhaust, boundaryGasoline.ports[1])
    annotation (Line(points={{27.44,26.16},{42.72,26.16},{42.72,26},{64,26}},
        color={0,127,255}));
  connect(aSM_CHPGenerator.flange, cHPGasolineEngineDynamicLinked.flange_a)
    annotation (Line(points={{-12,80},{0,80},{0,34}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end cHPEngineExample;
