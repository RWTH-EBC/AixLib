within AixLib.Fluid.BoilerCHP;
model ModularCHPNotManufacturer
   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = Media.Water,m_flow_nominal=m_flow_nominalCC);


  parameter Modelica.SIunits.Power PelNom=200000 "Nominal electrical power";

  parameter Modelica.SIunits.TemperatureDifference deltaTHeatingCircuit=20 "Nominal temperature difference heat circuit";

  parameter Modelica.SIunits.Temperature THotCoolingWaterMax=273.15+95 "Max. water temperature THot heat circuit";

  parameter Real PLRMin=0.5;

  parameter Modelica.SIunits.Temperature TStart=273.15+20 "T start"
   annotation (Dialog(tab="Advanced"));


  CHPNotManufacturer cHPNotManufacturer(
    m_flow_nominal=m_flow_nominalCC,
    T_start=TStart,
    PLRMin=PLRMin,
    redeclare package Medium = Media.Water,
    PelNom=PelNom)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{100,20},{120,40}})));

  Sensors.TemperatureTwoPort THotHeatCircuit(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{58,-82},{78,-62}})));
  HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = Media.Water,
    redeclare package Medium2 = Media.Water,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    m1_flow_nominal=m_flow_nominalHC,
    m2_flow_nominal=m_flow_nominalCC,
    from_dp1=true,
    dp1_nominal=2500,
    linearizeFlowResistance1=true,
    from_dp2=true,
    dp2_nominal=2500,
    linearizeFlowResistance2=true,
    configuration=AixLib.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    use_Q_flow_nominal=true,
    Q_flow_nominal=(1.3423*PelNom/1000 + 17.681)*1000,
    T_a1_nominal=333.15,
    T_a2_nominal=359.41,
    r_nominal=1)
    annotation (Placement(transformation(extent={{-8,-56},{12,-76}})));
  Sensors.TemperatureTwoPort TColdHeatCircuit(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{-56,-82},{-36,-62}})));
  Sensors.TemperatureTwoPort TColdCoolingWater(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart)
    annotation (Placement(transformation(extent={{-12,-68},{-28,-52}})));
  Sensors.TemperatureTwoPort THotCoolingWater(
    redeclare package Medium = Media.Water,
    m_flow_nominal=m_flow_nominalCC,
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
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-62,22},{-42,42}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=THotCoolingWaterMax)
    annotation (Placement(transformation(extent={{-134,14},{-102,34}})));
  Sources.Boundary_pT bou(
    p=100000,
    use_T_in=false,
    redeclare package Medium = Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-54},{-40,-34}})));
  Movers.FlowControlled_m_flow fan(redeclare package Medium = Media.Water,
    p_start=100000,
      m_flow_nominal=m_flow_nominalCC) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,-14})));
  Movers.FlowControlled_m_flow fan1(redeclare package Medium = Media.Water,
      m_flow_nominal=m_flow_nominalCC) annotation (Placement(transformation(
        extent={{10,-8},{-10,8}},
        rotation=90,
        origin={-92,-46})));
protected
  parameter Modelica.SIunits.Temperature TMinCoolingWater=354.15;
  parameter Modelica.SIunits.TemperatureDifference deltaTCoolingWater=3.47;
  parameter Modelica.SIunits.Temperature THotHeatCircuitMax=92+273.15;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalCC=0.0641977628513021*PelNom/1000 + 0.5371814977365220;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalHC=0.0173378319083308*PelNom/1000 + 0.1278781340675630;


   replaceable package MediumHCCC =Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));


 parameter Modelica.SIunits.Pressure dp_nominal=2500;
 parameter Modelica.SIunits.VolumeFlowRate V_flow_CC=m_flow_nominalCC/MediumHCCC.d_const;
 parameter Modelica.SIunits.VolumeFlowRate V_flow_HC=m_flow_nominalHC/MediumHCCC.d_const;


//  zeta=a/8*(Modelica.Constants.pi^2)/Medium.d_const,

equation


//   if fromKelvin1.Celsius > THotHeatCircuitMax or  fromKelvin2.Celsius > THotCoolingWaterMax then
//     Shutdown=true;
//   else
//      Shutdown=false;
//   end if;


  connect(hex.port_b1,THotHeatCircuit. port_a)
    annotation (Line(points={{12,-72},{58,-72}},         color={0,127,255}));
  connect(TColdHeatCircuit.port_b,hex. port_a1)
    annotation (Line(points={{-36,-72},{-8,-72}},  color={0,127,255}));
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
  connect(THotHeatCircuit.port_b, port_b) annotation (Line(points={{78,-72},{86,
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
  connect(cHPNotManufacturer.THotEngine, greater.u1) annotation (Line(points={{
          0,-11},{0,-28},{-72,-28},{-72,32},{-64,32}}, color={0,0,127}));
  connect(realExpression1.y, greater.u2)
    annotation (Line(points={{-100.4,24},{-64,24}}, color={0,0,127}));
  connect(greater.y, switch3.u2) annotation (Line(points={{-41,32},{28,32},{28,
          74},{5,74},{5,55.8}}, color={255,0,255}));
  connect(greater.y, controlCHPNotManufacturer.shutdown) annotation (Line(
        points={{-41,32},{-32,32},{-32,48},{-164,48},{-164,-49},{-152,-49}},
        color={255,0,255}));
  connect(pLRMin.y, controlCHPNotManufacturer.PLROff) annotation (Line(points={{-65,68},
          {-60,68},{-60,86},{-168,86},{-168,-52},{-152,-52}},          color={
          255,0,255}));
  connect(cHPNotManufacturer.port_b, THotCoolingWater.port_a)
    annotation (Line(points={{10,0},{30,0},{30,-60}}, color={0,127,255}));
  connect(THotCoolingWater.port_b, hex.port_a2)
    annotation (Line(points={{16,-60},{12,-60}}, color={0,127,255}));
  connect(hex.port_b2, TColdCoolingWater.port_a)
    annotation (Line(points={{-8,-60},{-12,-60}}, color={0,127,255}));
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
  connect(cHPNotManufacturer.THotEngine, cHPControlBus.TVolume) annotation (
      Line(points={{0,-11},{2,-11},{2,-34},{132,-34},{132,102.1},{0.1,102.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fan.port_b, cHPNotManufacturer.port_a)
    annotation (Line(points={{-32,-4},{-32,0},{-10,0}}, color={0,127,255}));
  connect(fan.port_a, TColdCoolingWater.port_b) annotation (Line(points={{-32,
          -24},{-32,-60},{-28,-60}}, color={0,127,255}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{-40,-44},{-32,-44},
          {-32,-24}}, color={0,127,255}));
  connect(controlCHPNotManufacturer.mFlowCC, fan.m_flow_in) annotation (Line(
        points={{-129,-40},{-114,-40},{-114,-14},{-44,-14}}, color={0,0,127}));
  connect(fan1.port_a, port_a)
    annotation (Line(points={{-92,-36},{-92,0},{-100,0}}, color={0,127,255}));
  connect(controlCHPNotManufacturer.mFlowRelHC, fan1.m_flow_in) annotation (
      Line(points={{-129,-47},{-114,-47},{-114,-46},{-101.6,-46}}, color={0,0,
          127}));
  connect(fan1.port_b, TColdHeatCircuit.port_a) annotation (Line(points={{-92,
          -56},{-92,-72},{-56,-72}}, color={0,127,255}));
  connect(THotHeatCircuit.T, controlCHPNotManufacturer.THot) annotation (Line(
        points={{68,-61},{68,-48},{124,-48},{124,-84},{-210,-84},{-210,-45},{
          -152,-45}}, color={0,0,127}));
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