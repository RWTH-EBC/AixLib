within AixLib.Fluid.BoilerCHP;
model ModularCHPNotManufacturer
   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = Media.Water,m_flow_nominal=0.0438
        *PelNom/1000 + 0.3603);


  parameter Modelica.SIunits.Power PelNom=200000 "Nominal electrical power";

  parameter Modelica.SIunits.TemperatureDifference deltaTHeatingCircuit=20 "Nominal temperature difference heat circuit";

  parameter Modelica.SIunits.Temperature THotCoolingWaterMax=273.15+95 "Max. water temperature THot heat circuit";

  parameter Real PLRMin=0.5;

  parameter Modelica.SIunits.Temperature TStart=273.15+20 "T start"
   annotation (Dialog(tab="Advanced"));


Boolean Shutdown=false;


  CHPNotManufacturer cHPNotManufacturer(
    T_start=TStart,
    PLRMin=PLRMin,
    redeclare package Medium = Media.Water,
    m_flow_nominal=0.0438*PelNom/1000 + 0.3603,
    PelNom=PelNom)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T_in=false,
    nPorts=1)                         annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-52,-42})));

  Sensors.TemperatureTwoPort THotHeatCircuit(
    redeclare package Medium = Media.Water,
    m_flow_nominal=0.0203*PelNom/1000 + 0.0246,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{40,-82},{60,-62}})));
  HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = Media.Water,
    redeclare package Medium2 = Media.Water,
    allowFlowReversal1=false,
    allowFlowReversal2=true,
    m1_flow_nominal=m_flow_nominalHC,
    m2_flow_nominal=m_flow_nominalCC,
    from_dp1=true,
    dp1_nominal=2500,
    from_dp2=true,
    dp2_nominal=2500,
    configuration=AixLib.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    use_Q_flow_nominal=true,
    Q_flow_nominal=(1.3423*PelNom/1000 + 17.681)*1000,
    T_a1_nominal=333.15,
    T_a2_nominal=359.41,
    r_nominal=1)
    annotation (Placement(transformation(extent={{-8,-56},{12,-76}})));
  Sensors.TemperatureTwoPort TColdHeatCircuit(
    redeclare package Medium = Media.Water,
    m_flow_nominal=0.0203*PelNom/1000 + 0.0246,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
  Sensors.TemperatureTwoPort TColdCoolingWater(
    redeclare package Medium = Media.Water,
    m_flow_nominal=0.0438*PelNom/1000 + 0.3603,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{-12,-68},{-28,-52}})));
  Sensors.TemperatureTwoPort THotCoolingWater(
    redeclare package Medium = Media.Water,
    m_flow_nominal=0.0438*PelNom/1000 + 0.3603,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{30,-68},{16,-52}})));

  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{60,58},{46,78}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=270,
        origin={5,45})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-19,67})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{-86,58},{-66,78}})));
  Controls.Interfaces.CHPControlBus cHPControlBus
    annotation (Placement(transformation(extent={{-20,82},{20,122}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{50,0},{70,20}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{40,30},{60,50}})));

  BaseClasses.Controllers.ControlCHPNotManufacturer controlCHPNotManufacturer(
    PelNom=PelNom,
    deltaTHeatingCircuit=deltaTHeatingCircuit,
    THotCoolingWaterMax=THotCoolingWaterMax)
    annotation (Placement(transformation(extent={{-150,-50},{-130,-30}})));
  Movers.SpeedControlled_y fan3(
    redeclare package Medium = Media.Water,
    allowFlowReversal=true,
    m_flow_small=0.001,
    per(pressure(V_flow={0,m_flow_nominalHC/1000,m_flow_nominalHC/500}, dp={
            2500/0.8,2500,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-88,-46})));
  Movers.SpeedControlled_y fan1(
    redeclare package Medium = Media.Water,
    allowFlowReversal=true,
    m_flow_small=0.001,
    per(pressure(V_flow={0,m_flow_nominalCC/1000,m_flow_nominalCC/500}, dp={
            2500/0.8,2500,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{9,9},{-9,-9}},
        rotation=270,
        origin={-33,-15})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-62,22},{-42,42}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=THotCoolingWaterMax)
    annotation (Placement(transformation(extent={{-134,14},{-102,34}})));
protected
  parameter Modelica.SIunits.ThermodynamicTemperature TMinCoolingWater=354.15;
  parameter Modelica.SIunits.TemperatureDifference deltaTCoolingWater=3.47;
  parameter Modelica.SIunits.ThermodynamicTemperature THotHeatCircuitMax=92;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalCC=0.0641977628513021*PelNom/1000 + 0.5371814977365220;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalHC=0.0173378319083308*PelNom/1000 + 0.1278781340675630;





equation


//   if fromKelvin1.Celsius > THotHeatCircuitMax or  fromKelvin2.Celsius > THotCoolingWaterMax then
//     Shutdown=true;
//   else
//      Shutdown=false;
//   end if;


  connect(hex.port_b1,THotHeatCircuit. port_a)
    annotation (Line(points={{12,-72},{40,-72}},         color={0,127,255}));
  connect(TColdHeatCircuit.port_b,hex. port_a1)
    annotation (Line(points={{-50,-72},{-8,-72}},  color={0,127,255}));
  connect(pLRMin.y, switch4.u2) annotation (Line(points={{-65,68},{-29.8,68},{
          -29.8,67}},                 color={255,0,255}));
  connect(switch3.y, cHPNotManufacturer.PLR) annotation (Line(points={{5,35.1},
          {5,14},{-20,14},{-20,6.6},{-12,6.6}},color={0,0,127}));
  connect(realExpression.y, switch3.u1) annotation (Line(points={{45.3,68},{12,68},
          {12,60},{12.2,60},{12.2,55.8}}, color={0,0,127}));
  connect(switch4.y, switch3.u3) annotation (Line(points={{-9.1,67},{-2,67},{-2,
          55.8},{-2.2,55.8}}, color={0,0,127}));

  connect(realExpression.y, switch4.u1) annotation (Line(points={{45.3,68},{36,
          68},{36,82},{-44,82},{-44,74.2},{-29.8,74.2}},             color={0,0,
          127}));
  connect(THotHeatCircuit.port_b, port_b) annotation (Line(points={{60,-72},{86,
          -72},{86,0},{100,0}}, color={0,127,255}));
  connect(cHPControlBus.PLR, switch4.u3) annotation (Line(
      points={{0.1,102.1},{2,102.1},{2,88},{-54,88},{-54,59.8},{-29.8,59.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus.PLR, pLRMin.u) annotation (Line(
      points={{0.1,102.1},{0.1,92},{-104,92},{-104,68},{-88,68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPNotManufacturer.PowerDemand, integrator.u) annotation (Line(points={{11,-4},
          {42,-4},{42,10},{48,10}},             color={0,0,127}));
  connect(cHPNotManufacturer.Pel, integrator1.u) annotation (Line(points={{11,8},{
          38,8},{38,40}},                   color={0,0,127}));
  connect(cHPNotManufacturer.THotEngine, controlCHPNotManufacturer.TVolume)
    annotation (Line(points={{0,-11},{0,-28},{-160,-28},{-160,-37},{-152,-37}},
        color={0,0,127}));
  connect(port_a, fan3.port_a)
    annotation (Line(points={{-100,0},{-88,0},{-88,-36}}, color={0,127,255}));
  connect(fan3.port_b, TColdHeatCircuit.port_a) annotation (Line(points={{-88,
          -56},{-88,-72},{-70,-72}}, color={0,127,255}));
  connect(controlCHPNotManufacturer.mFlowRel, fan3.y) annotation (Line(points={
          {-129,-47},{-116,-47},{-116,-46},{-100,-46}}, color={0,0,127}));
  connect(cHPNotManufacturer.THotEngine, greater.u1) annotation (Line(points={{
          0,-11},{0,-28},{-72,-28},{-72,32},{-64,32}}, color={0,0,127}));
  connect(realExpression1.y, greater.u2)
    annotation (Line(points={{-100.4,24},{-64,24}}, color={0,0,127}));
  connect(greater.y, switch3.u2) annotation (Line(points={{-41,32},{28,32},{28,
          74},{5,74},{5,55.8}}, color={255,0,255}));
  connect(greater.y, controlCHPNotManufacturer.shutdown) annotation (Line(
        points={{-41,32},{-32,32},{-32,48},{-164,48},{-164,-43},{-152,-43}},
        color={255,0,255}));
  connect(pLRMin.y, controlCHPNotManufacturer.PLROff) annotation (Line(points={{-65,68},
          {-60,68},{-60,86},{-168,86},{-168,-48},{-152,-48}},          color={
          255,0,255}));
  connect(boundary2.ports[1], fan1.port_a) annotation (Line(points={{-44,-42},{
          -33,-42},{-33,-24}}, color={0,127,255}));
  connect(fan1.port_b, cHPNotManufacturer.port_a)
    annotation (Line(points={{-33,-6},{-33,0},{-10,0}}, color={0,127,255}));
  connect(cHPNotManufacturer.port_b, THotCoolingWater.port_a)
    annotation (Line(points={{10,0},{30,0},{30,-60}}, color={0,127,255}));
  connect(THotCoolingWater.port_b, hex.port_a2)
    annotation (Line(points={{16,-60},{12,-60}}, color={0,127,255}));
  connect(hex.port_b2, TColdCoolingWater.port_a)
    annotation (Line(points={{-8,-60},{-12,-60}}, color={0,127,255}));
  connect(TColdCoolingWater.port_b, fan1.port_a) annotation (Line(points={{-28,
          -60},{-33,-60},{-33,-24}}, color={0,127,255}));
  connect(integrator.y, cHPControlBus.EnergyConsumption) annotation (Line(
        points={{71,10},{92,10},{92,100},{0.1,100},{0.1,102.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator1.y, cHPControlBus.ElectricEnergy) annotation (Line(points=
          {{61,40},{80,40},{80,102.1},{0.1,102.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(controlCHPNotManufacturer.mFlowRel, fan1.y) annotation (Line(points={
          {-129,-47},{-116,-47},{-116,-15},{-43.8,-15}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5000,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Model of a CHP-module with an inner cooling circuit and a control unit. Heat circuit and cooling circuit are connected with a heat exchanger. Further informations are given in the submodel discribtion.</p>
</html>"));
end ModularCHPNotManufacturer;
