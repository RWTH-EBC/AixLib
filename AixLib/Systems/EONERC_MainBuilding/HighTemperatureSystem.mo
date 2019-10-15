within AixLib.Systems.EONERC_MainBuilding;
model HighTemperatureSystem
  "High temperature generation system of the E.ON ERC main building"
   replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
  Fluid.MixingVolumes.HydraulicSeparator hydraulicSeparator(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    pumpMaxVolumeFlow=0.01,
    DFlange=0.1,
    T_top=T_start,
    T_bottom=T_start)
    annotation (Placement(transformation(extent={{76,28},{98,54}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)                                "Top-flange secondary circuit"
    annotation (Placement(transformation(extent={{110,50},{130,70}}),
        iconTransformation(extent={{110,50},{130,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Bottom-flange secondary circuit"
    annotation (Placement(transformation(extent={{110,10},{130,30}}),
        iconTransformation(extent={{110,10},{130,30}})));
  HydraulicModules.Admix admix2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    T_amb=T_amb,
    dIns=0.01,
    kIns=0.02,
    d=0.65,
    length=1,
    Kv=25,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))
                                annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,3.55271e-15})));
  HydraulicModules.Admix admix1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    T_amb=T_amb,
    dIns=0.01,
    kIns=0.02,
    d=0.65,
    length=1,
    Kv=25,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))
                                annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,3.55271e-15})));
  HydraulicModules.ThrottlePump throttlePump(
    redeclare package Medium = Medium,
    T_start=T_start,
    T_amb=T_amb,
    m_flow_nominal=m_flow_nominal,
    dIns=0.01,
    kIns=0.02,
    d=0.4,
    length=3,
    Kv=25,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)),
    pipe4(length=9))                         annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-100,0})));
  Fluid.BoilerCHP.BoilerNoControl boiler2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(Q_nom=120000,
        Q_min=40000))
    annotation (Placement(transformation(extent={{-8,-72},{-32,-48}})));
  Fluid.BoilerCHP.BoilerNoControl boiler1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(Q_nom=120000,
        Q_min=40000))
    annotation (Placement(transformation(extent={{72,-72},{48,-48}})));
  Fluid.BoilerCHP.CHP cHP(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    param=DataBase.CHP.CHPDataSimple.CHP_Cleanergy_C9G(),
    minCapacity=0.3)
    annotation (Placement(transformation(extent={{-88,-72},{-112,-48}})));
  BaseClasses.HighTemperatureSystemBus hTCBus annotation (Placement(
        transformation(extent={{-18,82},{18,116}}), iconTransformation(extent={{
            -14,84},{16,114}})));
  parameter Modelica.SIunits.Temperature T_amb "Ambient temperature";
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        T_amb)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start
    "Initial or guess value of output (= state)";
protected
  Fluid.Sensors.TemperatureTwoPort senT_a(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=true)
    annotation (Placement(transformation(extent={{100,54},{112,66}})));
  Fluid.Sensors.TemperatureTwoPort senT_b(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=true)
    annotation (Placement(transformation(extent={{112,14},{100,26}})));
equation
  connect(admix1.port_a1, hydraulicSeparator.port_b_primary)
    annotation (Line(points={{72,20},{72,34.5},{76,34.5}},
                                                       color={0,127,255}));
  connect(admix2.port_a1, hydraulicSeparator.port_b_primary)
    annotation (Line(points={{-8,20},{-8,34.5},{76,34.5}},
                                                       color={0,127,255}));
  connect(admix1.port_b2, hydraulicSeparator.port_a_primary)
    annotation (Line(points={{48,20},{48,47.5},{76,47.5}},
                                                       color={0,127,255}));
  connect(admix2.port_b2, hydraulicSeparator.port_a_primary)
    annotation (Line(points={{-32,20},{-32,47.5},{76,47.5}},
                                                         color={0,127,255}));
  connect(throttlePump.port_a1, hydraulicSeparator.port_b_primary)
    annotation (Line(points={{-88,20},{-88,34.5},{76,34.5}},
                                                         color={0,127,255}));
  connect(throttlePump.port_b2, hydraulicSeparator.port_a_primary)
    annotation (Line(points={{-112,20},{-112,47.5},{76,47.5}},
                                                         color={0,127,255}));
  connect(boiler1.port_a, admix1.port_b1)
    annotation (Line(points={{72,-60},{72,-20}}, color={0,127,255}));
  connect(boiler1.port_b, admix1.port_a2)
    annotation (Line(points={{48,-60},{48,-20}}, color={0,127,255}));
  connect(boiler2.port_a, admix2.port_b1)
    annotation (Line(points={{-8,-60},{-8,-20}}, color={0,127,255}));
  connect(boiler2.port_b, admix2.port_a2)
    annotation (Line(points={{-32,-60},{-32,-20}}, color={0,127,255}));
  connect(throttlePump.port_b1, cHP.port_a)
    annotation (Line(points={{-88,-20},{-88,-60}}, color={0,127,255}));
  connect(cHP.port_b, throttlePump.port_a2) annotation (Line(points={{-112,-60},
          {-112,-50},{-116,-50},{-116,-20},{-112,-20}}, color={0,127,255}));
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
        points={{-28.64,-46.8},{-46,-46.8},{-46,-96},{-138,-96},{-138,99.085},{0.09,
          99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.TSet, hTCBus.TChpSet) annotation (Line(points={{-91.6,-67.2},{-84,
          -67.2},{-84,-88},{-138,-88},{-138,99.085},{0.09,99.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cHP.on, hTCBus.onOffChpSet) annotation (Line(points={{-103.6,-70.8},{-103.6,
          -76},{-138,-76},{-138,100},{0.09,100},{0.09,99.085}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.electricalPower, hTCBus.electricalPowerChpMea) annotation (Line(
        points={{-94,-49.2},{-94,-44},{-138,-44},{-138,99.085},{0.09,99.085}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.thermalPower, hTCBus.thermalPowerChpMea) annotation (Line(points={
          {-97.6,-49.2},{-97.6,-44},{-138,-44},{-138,99.085},{0.09,99.085}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.fuelInput, hTCBus.fuelPowerChpMea) annotation (Line(points={{-102.4,
          -49.2},{-102.4,-44},{-138,-44},{-138,100},{0.09,100},{0.09,99.085}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(fixedTemperature.port, boiler2.T_amb) annotation (Line(points={{20,-90},
          {0,-90},{0,-66},{-28.16,-66}}, color={191,0,0}));
  connect(fixedTemperature.port, boiler1.T_amb) annotation (Line(points={{20,-90},
          {34,-90},{34,-66},{51.84,-66}}, color={191,0,0}));
  connect(senT_a.T, hTCBus.T_out) annotation (Line(points={{106,66.6},{106,
          99.085},{0.09,99.085}},                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senT_b.T, hTCBus.T_in) annotation (Line(points={{106,26.6},{154,26.6},
          {154,99.085},{0.09,99.085}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_b, senT_a.port_b)
    annotation (Line(points={{120,60},{112,60}}, color={0,127,255}));
  connect(port_a, senT_b.port_a)
    annotation (Line(points={{120,20},{112,20}}, color={0,127,255}));
  connect(senT_b.port_b, hydraulicSeparator.port_a_secondary) annotation (Line(
        points={{100,20},{100,34.5},{98,34.5}}, color={0,127,255}));
  connect(senT_a.port_a, hydraulicSeparator.port_b_secondary) annotation (Line(
        points={{100,60},{100,47.5},{98,47.5}}, color={0,127,255}));
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
        Rectangle(extent={{86,72},{96,6}}, lineColor={28,108,200}),
        Line(points={{-110,-20},{-110,60},{86,60}}, color={28,108,200}),
        Line(points={{-70,-20},{-70,20},{86,20}}, color={28,108,200}),
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
          fillPattern=FillPattern.Solid),
        Line(points={{96,60},{110,60}}, color={28,108,200}),
        Line(points={{96,20},{110,20}}, color={28,108,200})}),   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{120,100}})));
end HighTemperatureSystem;
