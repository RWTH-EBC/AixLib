within AixLib.Systems.EONERC_MainBuilding;
model HighTemperatureSystem
  "High temperature generation system of the E.ON ERC main building"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start = 60
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_amb "Ambient temperature";
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Top-flange secondary circuit" annotation (Placement(
        transformation(extent={{110,50},{130,70}}), iconTransformation(extent={{
            110,50},{130,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Bottom-flange secondary circuit" annotation (Placement(
        transformation(extent={{110,10},{130,30}}), iconTransformation(extent={{
            110,10},{130,30}})));
  HydraulicModules.Admix admix2(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    parameterPipe=DataBase.Pipes.Copper.Copper_66_7x1_2(),
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    T_amb=T_amb,
    length=1,
    Kv=25,
    valve(order=1),
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,3.55271e-15})));
  HydraulicModules.Admix admix1(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    parameterPipe=DataBase.Pipes.Copper.Copper_66_7x1_2(),
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    T_amb=T_amb,
    length=1,
    Kv=25,
    valve(order=1),
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,3.55271e-15})));
  HydraulicModules.ThrottlePump throttlePump(
    redeclare package Medium = Medium,
    parameterPipe=DataBase.Pipes.Copper.Copper_42x1(),
    allowFlowReversal=allowFlowReversal,
    T_start=T_start,
    T_amb=T_amb,
    m_flow_nominal=m_flow_nominal,
    length=3,
    Kv=25,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)),
    valve(order=1),
    pipe4(length=9)) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-100,0})));
  Fluid.BoilerCHP.BoilerNoControl boiler2(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(Q_nom=120000,
        Q_min=40000))
    annotation (Placement(transformation(extent={{-8,-72},{-32,-48}})));
  Fluid.BoilerCHP.BoilerNoControl boiler1(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(Q_nom=120000,
        Q_min=40000))
    annotation (Placement(transformation(extent={{72,-72},{48,-48}})));
  Fluid.BoilerCHP.CHPNoControl
                      cHPNoControl(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    param=DataBase.CHP.CHPDataSimple.CHP_Cleanergy_C9G(),
    minCapacity=0)
    annotation (Placement(transformation(extent={{-88,-72},{-112,-48}})));
  BaseClasses.HighTempSystemBus hTCBus annotation (Placement(transformation(
          extent={{-18,82},{18,116}}), iconTransformation(extent={{-14,84},{16,
            114}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        T_amb)
    annotation (Placement(transformation(extent={{-58,-72},{-46,-60}})));

  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(extent={{80,36},{100,56}})));
  Modelica.Blocks.Math.Gain kWToW1(k=1)    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=180,
        origin={-125,-45})));
  Modelica.Blocks.Math.Gain kWToW2(k=1)    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=180,
        origin={-125,-37})));
  Modelica.Blocks.Math.Gain kWToW3(k=1)    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=180,
        origin={-125,-29})));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of mass balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=T_amb)
    annotation (Placement(transformation(extent={{26,-72},{38,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T=T_amb)
    annotation (Placement(transformation(extent={{-132,-72},{-120,-60}})));
protected
  Fluid.Sensors.TemperatureTwoPort senT_a(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{100,54},{112,66}})));
  Fluid.Sensors.TemperatureTwoPort senT_b(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{112,14},{100,26}})));
equation
  connect(boiler1.port_a, admix1.port_b1)
    annotation (Line(points={{72,-60},{72,-20}}, color={0,127,255}));
  connect(boiler1.port_b, admix1.port_a2)
    annotation (Line(points={{48,-60},{48,-20}}, color={0,127,255}));
  connect(boiler2.port_a, admix2.port_b1)
    annotation (Line(points={{-8,-60},{-8,-20}}, color={0,127,255}));
  connect(boiler2.port_b, admix2.port_a2)
    annotation (Line(points={{-32,-60},{-32,-20}}, color={0,127,255}));
  connect(throttlePump.port_b1, cHPNoControl.port_a)
    annotation (Line(points={{-88,-20},{-88,-60}}, color={0,127,255}));
  connect(cHPNoControl.port_b, throttlePump.port_a2)
    annotation (Line(points={{-112,-60},{-112,-20}}, color={0,127,255}));
  connect(admix1.hydraulicBus, hTCBus.admixBus1) annotation (Line(
      points={{80,0},{154,0},{154,99.085},{0.09,99.085}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admix2.hydraulicBus, hTCBus.admixBus2) annotation (Line(
      points={{0,0},{0.09,0},{0.09,99.085}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(throttlePump.hydraulicBus, hTCBus.throttlePumpBus) annotation (Line(
      points={{-80,0},{-68,0},{-68,99.085},{0.09,99.085}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiler1.u_rel, hTCBus.uRelBoiler1Set) annotation (Line(points={{68.4,-51.6},
          {154,-51.6},{154,99.085},{0.09,99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiler2.u_rel, hTCBus.uRelBoiler2Set) annotation (Line(points={{-11.6,
          -51.6},{26,-51.6},{26,99.085},{0.09,99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiler1.fuelPower, hTCBus.fuelPowerBoiler1Mea) annotation (Line(
        points={{51.36,-46.8},{154,-46.8},{154,98},{0.09,98},{0.09,99.085}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiler2.fuelPower, hTCBus.fuelPowerBoiler2Mea) annotation (Line(
        points={{-28.64,-46.8},{-70,-46.8},{-70,-84},{-138,-84},{-138,99.085},{
          0.09,99.085}},
                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(fixedTemperature.port, boiler2.T_amb) annotation (Line(points={{-46,-66},
          {-28.16,-66}},                 color={191,0,0}));
  connect(senT_a.T, hTCBus.T_out) annotation (Line(points={{106,66.6},{106,99.085},
          {0.09,99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senT_b.T, hTCBus.T_in) annotation (Line(points={{106,26.6},{154,26.6},
          {154,99.085},{0.09,99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_b, senT_a.port_b)
    annotation (Line(points={{120,60},{112,60}}, color={0,127,255}));
  connect(port_a, senT_b.port_a)
    annotation (Line(points={{120,20},{112,20}}, color={0,127,255}));
  connect(admix1.port_a1, senT_b.port_b) annotation (Line(points={{72,20},{72,
          30},{100,30},{100,20}}, color={0,127,255}));
  connect(admix2.port_a1, senT_b.port_b) annotation (Line(points={{-8,20},{-10,
          20},{-10,30},{100,30},{100,20}}, color={0,127,255}));
  connect(throttlePump.port_a1, senT_b.port_b) annotation (Line(points={{-88,20},
          {-88,30},{100,30},{100,20}}, color={0,127,255}));
  connect(senT_a.port_a, admix1.port_b2)
    annotation (Line(points={{100,60},{48,60},{48,20}}, color={0,127,255}));
  connect(senT_a.port_a, admix2.port_b2)
    annotation (Line(points={{100,60},{-32,60},{-32,20}}, color={0,127,255}));
  connect(senT_a.port_a, throttlePump.port_b2) annotation (Line(points={{100,60},
          {-112,60},{-112,20}}, color={0,127,255}));
  connect(senT_b.port_b, vol.ports[1]) annotation (Line(points={{100,20},{94,20},
          {94,36},{88,36}}, color={0,127,255}));
  connect(vol.ports[2], senT_a.port_a) annotation (Line(points={{92,36},{96,36},
          {96,60},{100,60}}, color={0,127,255}));
  connect(cHPNoControl.fuelInput, kWToW1.u) annotation (Line(points={{-102.4,-49.2},
          {-102.4,-45},{-121.4,-45}}, color={0,0,127}));
  connect(cHPNoControl.thermalPower, kWToW2.u) annotation (Line(points={{-97.6,
          -49.2},{-97.6,-37},{-121.4,-37}}, color={0,0,127}));
  connect(kWToW2.y, hTCBus.thermalPowerChpMea) annotation (Line(points={{-128.3,
          -37},{-138,-37},{-138,99.085},{0.09,99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPNoControl.electricalPower, kWToW3.u) annotation (Line(points={{-94,
          -49.2},{-94,-29},{-121.4,-29}}, color={0,0,127}));
  connect(kWToW3.y, hTCBus.electricalPowerChpMea) annotation (Line(points={{
          -128.3,-29},{-138,-29},{-138,99.085},{0.09,99.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(kWToW1.y, hTCBus.fuelPowerChpMea) annotation (Line(points={{-128.3,
          -45},{-138,-45},{-138,99.085},{0.09,99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPNoControl.u_rel, hTCBus.uRelChpSet) annotation (Line(points={{-91.6,
          -67.2},{-82,-67.2},{-82,-84},{-138,-84},{-138,99.085},{0.09,99.085}},
                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fixedTemperature1.port, boiler1.T_amb)
    annotation (Line(points={{38,-66},{51.84,-66}}, color={191,0,0}));
  connect(fixedTemperature2.port, cHPNoControl.T_amb)
    annotation (Line(points={{-120,-66},{-108.16,-66}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
            {120,100}}), graphics={
        Rectangle(
          extent={{-140,100},{120,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{40,-20},{80,-80}}, lineColor={0,0,0}),
        Rectangle(extent={{-20,-20},{20,-80}}, lineColor={0,0,0}),
        Rectangle(extent={{-120,-20},{-60,-60}}, lineColor={0,0,0}),
        Text(
          extent={{-76,-48},{-102,-32}},
          lineColor={0,0,0},
          textString="CHP"),
        Text(
          extent={{14,-58},{-12,-42}},
          lineColor={0,0,0},
          textString="Boiler1"),
        Text(
          extent={{74,-60},{48,-44}},
          lineColor={0,0,0},
          textString="Boiler2"),
        Line(points={{-110,-20},{-110,60},{110,60}},color={28,108,200}),
        Line(points={{-70,-20},{-70,20},{112,20}},color={28,108,200}),
        Line(points={{-12,-20},{-12,60}}, color={28,108,200}),
        Line(points={{12,-20},{12,20}}, color={28,108,200}),
        Line(points={{50,-20},{50,60}}, color={28,108,200}),
        Line(points={{74,-20},{74,20}}, color={28,108,200}),
        Ellipse(
          extent={{-14,62},{-10,58}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{48,62},{52,58}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{10,22},{14,18}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{72,22},{76,18}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{120,100}})));
end HighTemperatureSystem;
