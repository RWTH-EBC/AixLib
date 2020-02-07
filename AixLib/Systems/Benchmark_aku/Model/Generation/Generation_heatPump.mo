within AixLib.Systems.Benchmark.Model.Generation;
model Generation_heatPump
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter Modelica.SIunits.Temp_K T_conMax_1 = 328.15 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Temp_K T_conMax_2 = 328.15 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 20000 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Volume vol_1 = 0.012 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Volume vol_2 = 0.024 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.ThermalConductance R_loss_1 = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.ThermalConductance R_loss_2 = 0 annotation(Dialog(tab = "General"));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));

  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid input port"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid output port"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed_1(
    capCalcType=2,
    P_eleOutput=true,
    CoP_output=true,
    redeclare package Medium_con = Medium_Water,
    redeclare package Medium_eva = Medium_Water,
    heatLosses_con=true,
    dataTable=DataBase.HeatPump.EN14511.HeatpumpBenchmarkSystem(),
    factorScale=1,
    CorrFlowEv=false,
    dp_evaNominal=dpHeatexchanger_nominal/90,
    PT1_cycle=true,
    timeConstantCycle=30,
    volume_eva=vol_1,
    volume_con=vol_1,
    R_loss=R_loss_1,
    T_conMax=T_conMax_1,
    dp_conNominal=dpHeatexchanger_nominal/120,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,18},{16,38}})));

  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={50,-22})));
  BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
           {{-60,80},{-20,120}}), iconTransformation(extent={{-50,90},{-30,110}})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
    y_start=1,
    redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={42,60})));
  Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed_2(
    capCalcType=2,
    P_eleOutput=true,
    CoP_output=true,
    redeclare package Medium_con = Medium_Water,
    redeclare package Medium_eva = Medium_Water,
    heatLosses_con=true,
    factorScale=1,
    CorrFlowEv=false,
    dp_evaNominal=dpHeatexchanger_nominal/90,
    PT1_cycle=true,
    timeConstantCycle=30,
    dataTable=DataBase.HeatPump.EN14511.HeatpumpBenchmarkSystem(),
    volume_eva=vol_2,
    volume_con=vol_2,
    R_loss=R_loss_2,
    T_conMax=T_conMax_2,
    dp_conNominal=dpHeatexchanger_nominal/120,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,-38},{16,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 25)
    annotation (Placement(transformation(extent={{-76,-24},{-56,-4}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{10,70},{50,110}}), iconTransformation(extent={{30,90},{50,110}})));
  Fluid.Sensors.Temperature senTem(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-68,-60},{-48,-40}})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{6,48},{26,68}})));
  Fluid.Sensors.Temperature senTem3(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{30,-18},{50,2}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-88,50},{-68,70}})));
  Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{84,-70},{64,-50}})));
  Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium = Medium_Water,
    y_start=1,
    redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
      per)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={70,60})));
equation
  connect(heatPumpDetailed_1.port_evaOut, heatPumpDetailed_2.port_evaIn)
    annotation (Line(points={{-12,21},{-12,-21}}, color={0,127,255}));
  connect(heatPumpDetailed_2.port_evaOut, Fluid_out_cold) annotation (Line(
        points={{-12,-35},{-12,-60},{-100,-60}}, color={0,127,255}));
  connect(heatPumpDetailed_2.port_conOut, heatPumpDetailed_1.port_conIn)
    annotation (Line(points={{14,-21},{14,21}}, color={0,127,255}));
  connect(heatPumpDetailed_1.port_conOut, fan4.port_a) annotation (Line(points={
          {14,35},{30,35},{30,36},{30,36},{30,60},{34,60}}, color={0,127,255}));
  connect(realExpression.y, heatPumpDetailed_2.T_amb)
    annotation (Line(points={{-55,-14},{6,-14},{6,-19}}, color={0,0,127}));
  connect(heatPumpDetailed_1.T_amb, heatPumpDetailed_2.T_amb) annotation (Line(
        points={{6,37},{6,50},{-40,50},{-40,-14},{6,-14},{6,-19}}, color={0,0,127}));
  connect(senTem2.port, fan4.port_a) annotation (Line(points={{16,48},{16,44},{
          30,44},{30,60},{34,60}}, color={0,127,255}));
  connect(Fluid_in_cold, senMasFlo.port_a)
    annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
  connect(senMasFlo.port_b, senTem1.port)
    annotation (Line(points={{-68,60},{-60,60}}, color={0,127,255}));
  connect(senTem1.port, heatPumpDetailed_1.port_evaIn) annotation (Line(points={
          {-60,60},{-60,40},{-12,40},{-12,35}}, color={0,127,255}));
  connect(senMasFlo1.port_a, Fluid_in_warm)
    annotation (Line(points={{84,-60},{100,-60}}, color={0,127,255}));
  connect(senMasFlo.m_flow, measureBus.heatpump_cold_massflow) annotation (Line(
        points={{-78,71},{-78,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
  connect(senMasFlo1.m_flow, measureBus.heatpump_warm_massflow) annotation (
      Line(points={{74,-49},{74,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(senTem.port, Fluid_out_cold)
    annotation (Line(points={{-58,-60},{-100,-60}}, color={0,127,255}));
  connect(heatPumpDetailed_2.port_evaOut, senTem.port) annotation (Line(points={
          {-12,-35},{-12,-60},{-58,-60}}, color={0,127,255}));
  connect(senMasFlo1.port_b, heatPumpDetailed_2.port_conIn) annotation (Line(
        points={{64,-60},{50,-60},{50,-35},{14,-35}}, color={0,127,255}));
  connect(senTem3.port, heatPumpDetailed_2.port_conIn)
    annotation (Line(points={{40,-18},{40,-35},{14,-35}}, color={0,127,255}));
  connect(bou1.ports[1], heatPumpDetailed_2.port_conIn)
    annotation (Line(points={{50,-26},{50,-35},{14,-35}}, color={0,127,255}));
  connect(heatPumpDetailed_1.onOff_in, controlBus.OnOff_heatpump_1) annotation (
     Line(points={{-4,37},{-4,50},{-39.9,50},{-39.9,100.1}}, color={255,0,255}));
  connect(heatPumpDetailed_2.onOff_in, controlBus.OnOff_heatpump_2) annotation (
     Line(points={{-4,-19},{-4,-14},{-39.9,-14},{-39.9,100.1}}, color={255,0,255}));
  connect(senTem1.T, measureBus.Heatpump_cold_in) annotation (Line(points={{-53,
          70},{-40,70},{-40,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
  connect(senTem.T, measureBus.Heatpump_cold_out) annotation (Line(points={{-51,
          -50},{-40,-50},{-40,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
  connect(senTem2.T, measureBus.Heatpump_warm_out)
    annotation (Line(points={{23,58},{30.1,58},{30.1,90.1}}, color={0,0,127}));
  connect(senTem3.T, measureBus.Heatpump_warm_in) annotation (Line(points={{47,-8},
          {56,-8},{56,-8},{56,-8},{56,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(heatPumpDetailed_1.CoP_out, measureBus.Heatpump_1_COP) annotation (
      Line(points={{0,19},{0,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(heatPumpDetailed_1.P_eleOut, measureBus.Heatpump_1_power) annotation (
     Line(points={{-4,19},{-4,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(heatPumpDetailed_2.CoP_out, measureBus.Heatpump_2_COP) annotation (
      Line(points={{0,-37},{0,-42},{30.1,-42},{30.1,90.1}}, color={0,0,127}));
  connect(heatPumpDetailed_2.P_eleOut, measureBus.Heatpump_2_power) annotation (
     Line(points={{-4,-37},{-4,-42},{30.1,-42},{30.1,90.1}}, color={0,0,127}));
  connect(fan4.port_b, fan1.port_a)
    annotation (Line(points={{50,60},{62,60}}, color={0,127,255}));
  connect(fan1.port_b, Fluid_out_warm)
    annotation (Line(points={{78,60},{100,60}}, color={0,127,255}));
  connect(fan4.y, controlBus.Pump_Warmwater_heatpump_1_y) annotation (Line(
        points={{42,69.6},{42,80},{-39.9,80},{-39.9,100.1}}, color={0,0,127}));
  connect(fan1.y, controlBus.Pump_Warmwater_heatpump_2_y) annotation (Line(
        points={{70,69.6},{70,80},{-39.9,80},{-39.9,100.1}}, color={0,0,127}));
  connect(fan4.P, measureBus.Pump_Warmwater_heatpump_1_power) annotation (Line(
        points={{50.8,67.2},{56,67.2},{56,80},{30.1,80},{30.1,90.1}}, color={0,
          0,127}));
  connect(fan1.P, measureBus.Pump_Warmwater_heatpump_2_power) annotation (Line(
        points={{78.8,67.2},{78.8,68},{82,68},{82,80},{30.1,80},{30.1,90.1}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
