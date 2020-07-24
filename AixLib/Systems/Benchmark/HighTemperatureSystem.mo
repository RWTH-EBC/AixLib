within AixLib.Systems.Benchmark;
model HighTemperatureSystem
  "Boiler and chp system for high temperature generation"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
    parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start = 303.15
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization"));
        parameter Modelica.SIunits.Temperature T_amb=298.15
    "Ambient temperature of technics room";

  Fluid.BoilerCHP.BoilerNoControl
                   boilerNoControl(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    transferHeat=true,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(),
    TAmb=298.15)
    annotation (Placement(transformation(extent={{28,108},{52,132}})));

  Fluid.BoilerCHP.CHP cHP(
    allowFlowReversal=allowFlowReversal,
    T_start=T_start,
    electricityDriven=false,
    TSetIn=true,
    redeclare package Medium = Medium,
    minCapacity=24,
    transferHeat=true,
    param=DataBase.CHP.CHPDataSimple.CHP_FMB_31_GSK(),
    final m_flow_nominal=m_flow_nominal,
    TAmb=298.15,
    delayTime=300)
    annotation (Placement(transformation(extent={{-52,108},{-28,132}})));

  HydraulicModules.Pump pumpCHP(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=298.15,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.028,
    d=0.32,
    length=1,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)),
    pipe3(length=2)) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,80})));

  HydraulicModules.Pump pumpBoiler(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=298.15,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.028,
    d=0.32,
    length=1,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)),
    pipe3(length=2)) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,80})));
  Fluid.Storage.BufferStorage HotWater(
    useHeatingCoil1=false,
    useHeatingRod=false,
    n=5,
    useHeatingCoil2=false,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    data=DataBase.Storage.Generic_22000l(),
    TStart=343.15)
    annotation (Placement(transformation(extent={{-16,-12},{16,28}})));
  BaseClasses.HighTempSystemBus highTemperatureSystemBus annotation (Placement(
        transformation(extent={{-16,126},{16,156}}), iconTransformation(extent=
            {{-14,124},{16,156}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=T_amb)
    annotation (Placement(transformation(extent={{32,8},{40,16}})));
protected
  Fluid.Sensors.TemperatureTwoPort senT_a(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=298.15,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-80,-26},{-68,-14}})));
  Fluid.Sensors.TemperatureTwoPort senT_b(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=298.15,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{64,-6},{76,6}})));
equation
  connect(pumpCHP.port_b1, cHP.port_a)
    annotation (Line(points={{-52,100},{-52,120}},
                                                 color={0,127,255}));
  connect(pumpCHP.port_a2, cHP.port_b)
    annotation (Line(points={{-28,100},{-28,120}},
                                                 color={0,127,255}));
  connect(pumpBoiler.port_b1, boilerNoControl.port_a)
    annotation (Line(points={{28,100},{28,120}}, color={0,127,255}));
  connect(pumpBoiler.port_a2, boilerNoControl.port_b)
    annotation (Line(points={{52,100},{52,120}}, color={0,127,255}));
  connect(pumpBoiler.port_a1, pumpCHP.port_a1) annotation (Line(points={{28,60},
          {28,36},{-52,36},{-52,60}}, color={0,127,255}));
  connect(pumpCHP.port_a1, HotWater.fluidportBottom1) annotation (Line(points={{-52,60},
          {-52,-12.4},{-5.4,-12.4}},        color={0,127,255}));
  connect(pumpCHP.port_b2, pumpBoiler.port_b2) annotation (Line(points={{-28,60},
          {-28,54},{52,54},{52,60}}, color={0,127,255}));
  connect(pumpCHP.port_b2, HotWater.fluidportTop1) annotation (Line(points={{-28,60},
          {-28,54},{-5.6,54},{-5.6,28.2}},         color={0,127,255}));
  connect(HotWater.fluidportBottom2, senT_a.port_b) annotation (Line(points={{
          4.6,-12.2},{4.6,-20},{-68,-20}}, color={0,127,255}));
  connect(senT_a.port_a, port_a)
    annotation (Line(points={{-80,-20},{-80,0},{-100,0}}, color={0,127,255}));
  connect(boilerNoControl.u_rel, highTemperatureSystemBus.uRelBoilerSet)
    annotation (Line(points={{31.6,128.4},{0.08,128.4},{0.08,141.075}},   color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerNoControl.fuelPower, highTemperatureSystemBus.fuelPowerBoilerMea)
    annotation (Line(points={{48.64,133.2},{56,133.2},{56,141.075},{0.08,
          141.075}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cHP.TSet, highTemperatureSystemBus.TChpSet) annotation (Line(points={{-48.4,
          112.8},{-62,112.8},{-62,112},{-74,112},{-74,141.075},{0.08,141.075}},
                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.on, highTemperatureSystemBus.onOffChpSet) annotation (Line(points={{-36.4,
          109.2},{-36.4,108},{0.08,108},{0.08,141.075}},          color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.fuelInput, highTemperatureSystemBus.fuelPowerChpMea) annotation (
      Line(points={{-37.6,130.8},{-37.6,141.075},{0.08,141.075}},  color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.thermalPower, highTemperatureSystemBus.thermalPowerChpMea)
    annotation (Line(points={{-42.4,130.8},{-42.4,141.075},{0.08,141.075}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHP.electricalPower, highTemperatureSystemBus.electricalPowerChpMea)
    annotation (Line(points={{-46,130.8},{-46,141.075},{0.08,141.075}},  color=
          {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pumpBoiler.hydraulicBus, highTemperatureSystemBus.pumpBoilerBus)
    annotation (Line(
      points={{20,80},{0.08,80},{0.08,141.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pumpCHP.hydraulicBus, highTemperatureSystemBus.pumpChpBus)
    annotation (Line(
      points={{-60,80},{-74,80},{-74,141.075},{0.08,141.075}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b.port_b, port_b)
    annotation (Line(points={{76,0},{100,0}}, color={0,127,255}));
  connect(senT_b.port_a, HotWater.fluidportTop2) annotation (Line(points={{64,0},
          {62,0},{62,28.2},{5,28.2}}, color={0,127,255}));
  connect(fixedTemperature1.port, HotWater.heatportOutside) annotation (Line(
        points={{40,12},{40,8},{15.6,8},{15.6,9.2}}, color={191,0,0}));
  connect(senT_b.T, highTemperatureSystemBus.TOutMea) annotation (Line(points={
          {70,6.6},{70,142},{0.08,142},{0.08,141.075}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a.T, highTemperatureSystemBus.TInMea) annotation (Line(points={{
          -74,-13.4},{-74,134},{0.08,134},{0.08,141.075}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -60},{100,140}}), graphics={
        Rectangle(
          extent={{-100,140},{100,-60}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Rectangle(extent={{-80,100},{-20,60}}, lineColor={0,0,0}),
        Rectangle(extent={{20,120},{64,60}}, lineColor={0,0,0}),
        Text(
          extent={{-68,90},{-34,64}},
          lineColor={0,0,0},
          textString="CHP"),
        Text(
          extent={{26,98},{60,72}},
          lineColor={0,0,0},
          textString="Boiler"),
        Line(points={{-56,60},{-56,36},{30,36},{30,60}}, color={28,108,200}),
        Line(points={{-34,60},{-34,28},{60,28},{60,52},{60,60}}, color={35,138,
              255}),
        Rectangle(
          extent={{-18,22},{22,-40}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=0.5),
        Rectangle(
          extent={{-18,22},{22,-40}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(points={{-56,44},{-56,-32},{-18,-32}}, color={28,108,200}),
        Line(points={{-34,34},{-34,14},{-18,14}}, color={35,138,255}),
        Line(points={{90,0},{60,0},{60,12},{22,12}}, color={35,138,255}),
        Line(points={{22,-30},{40,-30},{40,-52},{-80,-52},{-80,0},{-94,0}},
            color={28,108,200}),
        Ellipse(
          extent={{-64,56},{-48,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-56,56},{-64,48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-48,48},{-56,56}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{22,56},{38,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{30,56},{22,48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{38,48},{30,56}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},{100,140}})));
end HighTemperatureSystem;
