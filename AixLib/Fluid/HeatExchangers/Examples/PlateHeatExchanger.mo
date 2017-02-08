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
  Modelica.Blocks.Sources.Cosine cosine(
    freqHz=1/2,
    amplitude=5,
    offset=278.15)
    annotation (Placement(transformation(extent={{-132,76},{-112,96}})));
  AixLib.Fluid.HeatExchangers.PlateHeatExchanger plateHeatExchanger(
    m1_flow_nominal=10,
    m2_flow_nominal=10,
    A=100,
    k=4000,
    V_ColdCircuit=1,
    V_WarmCircuit=1,
    m_flow_DH_nom=10,
    m_flow_HS_nom=10,
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_DistrictHeating=200000,
    dp_HeatingSystem=200000) annotation (Placement(transformation(
        extent={{29,-26},{-29,26}},
        rotation=90,
        origin={0,49})));
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
          {-26,80},{-15.6,80},{-15.6,73.1667}},     color={0,127,255}));
  connect(senTem1.port_a, plateHeatExchanger.port_b1) annotation (Line(points={{-40,20},
          {-15.6,20},{-15.6,24.8333}},         color={0,127,255}));
  connect(senTem2.port_b, plateHeatExchanger.port_a2) annotation (Line(points={{60,20},
          {15.6,20},{15.6,24.8333}},        color={0,127,255}));
  connect(senTem3.port_a, plateHeatExchanger.port_b2) annotation (Line(points={{60,80},
          {38,80},{15.6,80},{15.6,73.1667}},        color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-140,0},{160,100}},
          preserveAspectRatio=false)));
end PlateHeatExchanger;
