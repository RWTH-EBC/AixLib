within AixLib.Building.Benchmark.Generation;
model Generation_heatPump
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter Modelica.SIunits.Temp_K T_conMax_big = 328.15 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Temp_K T_conMax_small = 328.15 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 20000 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Volume vol_small = 0.012 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Volume vol_big = 0.024 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.ThermalConductance R_loss_small = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.ThermalConductance R_loss_big = 0 annotation(Dialog(tab = "General"));
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
  Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed_big(
    capCalcType=2,
    P_eleOutput=true,
    CoP_output=true,
    redeclare package Medium_con = Medium_Water,
    redeclare package Medium_eva = Medium_Water,
    T_conMax=T_conMax_big,
    heatLosses_con=true,
    R_loss=R_loss_small,
    dataTable=DataBase.HeatPump.EN14511.Benchmark_Heatpump_Big(),
    volume_eva=vol_big,
    volume_con=vol_big,
    factorScale=1,
    CorrFlowEv=false,
    dp_conNominal=dpHeatexchanger_nominal/100,
    dp_evaNominal=dpHeatexchanger_nominal/90,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,18},{16,38}})));

  Fluid.Sources.Boundary_pT bou1(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-24})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={{-60,80},
            {-20,120}}),         iconTransformation(extent={{-50,90},{-30,110}})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
    y_start=1)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={42,60})));
  Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed_small(
    capCalcType=2,
    P_eleOutput=true,
    CoP_output=true,
    redeclare package Medium_con = Medium_Water,
    redeclare package Medium_eva = Medium_Water,
    T_conMax=T_conMax_small,
    heatLosses_con=true,
    R_loss=R_loss_small,
    volume_eva=vol_small,
    volume_con=vol_small,
    factorScale=1,
    CorrFlowEv=false,
    dataTable=DataBase.HeatPump.EN14511.Benchmark_Heatpump_Small(),
    dp_conNominal=dpHeatexchanger_nominal/100,
    dp_evaNominal=dpHeatexchanger_nominal/90,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,-38},{16,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 25)
    annotation (Placement(transformation(extent={{-76,-24},{-56,-4}})));
  BusSystem.measureBus measureBus annotation (Placement(transformation(extent={{
            10,70},{50,110}}), iconTransformation(extent={{30,90},{50,110}})));
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
equation
  connect(fan4.port_b, Fluid_out_warm)
    annotation (Line(points={{50,60},{100,60}}, color={0,127,255}));
  connect(fan4.y, controlBus.Pump_Warmwater_heatpump_y) annotation (Line(points={{42,69.6},
          {42,80},{-39.9,80},{-39.9,100.1}},       color={0,0,127}));
  connect(heatPumpDetailed_big.port_evaOut, heatPumpDetailed_small.port_evaIn)
    annotation (Line(points={{-12,21},{-12,-21}},          color={0,127,255}));
  connect(heatPumpDetailed_small.port_evaOut, Fluid_out_cold) annotation (Line(
        points={{-12,-35},{-12,-60},{-100,-60}}, color={0,127,255}));
  connect(heatPumpDetailed_small.port_conIn, bou1.ports[1]) annotation (Line(
        points={{14,-35},{62,-35},{62,-34}},                   color={0,127,255}));
  connect(heatPumpDetailed_small.port_conOut, heatPumpDetailed_big.port_conIn)
    annotation (Line(points={{14,-21},{14,21}}, color={0,127,255}));
  connect(heatPumpDetailed_big.port_conOut, fan4.port_a) annotation (Line(
        points={{14,35},{30,35},{30,36},{30,36},{30,60},{34,60}}, color={0,127,255}));
  connect(heatPumpDetailed_big.onOff_in, controlBus.OnOff_heatpump_big)
    annotation (Line(points={{-4,37},{-4,50},{-40,50},{-40,100.1},{-39.9,100.1}},
        color={255,0,255}));
  connect(heatPumpDetailed_small.onOff_in, controlBus.OnOff_heatpump_small)
    annotation (Line(points={{-4,-19},{-4,0},{-40,0},{-40,50},{-39.9,50},{-39.9,
          100.1}},
        color={255,0,255}));
  connect(realExpression.y, heatPumpDetailed_small.T_amb)
    annotation (Line(points={{-55,-14},{6,-14},{6,-19}}, color={0,0,127}));
  connect(heatPumpDetailed_big.T_amb, heatPumpDetailed_small.T_amb) annotation (
     Line(points={{6,37},{6,50},{-40,50},{-40,-14},{6,-14},{6,-19}}, color={0,0,
          127}));
  connect(fan4.P, measureBus.Pump_Warmwater_heatpump_power) annotation (Line(
        points={{50.8,67.2},{60,67.2},{60,80},{30.1,80},{30.1,90.1}}, color={0,0,
          127}));
  connect(heatPumpDetailed_big.CoP_out, measureBus.Heatpump_big_COP)
    annotation (Line(points={{0,19},{0,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(heatPumpDetailed_big.P_eleOut, measureBus.Heatpump_big_power)
    annotation (Line(points={{-4,19},{-4,14},{30.1,14},{30.1,90.1}}, color={0,0,
          127}));
  connect(heatPumpDetailed_small.CoP_out, measureBus.Heatpump_small_COP)
    annotation (Line(points={{0,-37},{0,-44},{30.1,-44},{30.1,90.1}}, color={0,0,
          127}));
  connect(heatPumpDetailed_small.P_eleOut, measureBus.Heatpump_small_power)
    annotation (Line(points={{-4,-37},{-4,-44},{30.1,-44},{30.1,90.1}}, color={0,
          0,127}));
  connect(senTem2.port, fan4.port_a) annotation (Line(points={{16,48},{16,44},{
          30,44},{30,60},{34,60}}, color={0,127,255}));
  connect(heatPumpDetailed_small.port_conIn, senTem3.port) annotation (Line(
        points={{14,-35},{41,-35},{41,-18},{40,-18}}, color={0,127,255}));
  connect(senTem1.T, measureBus.Heatpump_cold_big_in) annotation (Line(points={
          {-53,70},{-40,70},{-40,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
  connect(senTem.T, measureBus.Heatpump_cold_small_out) annotation (Line(points={{-51,-50},
          {-40,-50},{-40,80},{30.1,80},{30.1,90.1}},           color={0,0,127}));
  connect(senTem2.T, measureBus.Heatpump_warm_big_out)
    annotation (Line(points={{23,58},{30.1,58},{30.1,90.1}}, color={0,0,127}));
  connect(senTem3.T, measureBus.Heatpump_warm_small_in) annotation (Line(points=
         {{47,-8},{54,-8},{54,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(Fluid_in_cold, senMasFlo.port_a)
    annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
  connect(senMasFlo.port_b, senTem1.port)
    annotation (Line(points={{-68,60},{-60,60}}, color={0,127,255}));
  connect(senTem1.port, heatPumpDetailed_big.port_evaIn) annotation (Line(
        points={{-60,60},{-60,40},{-12,40},{-12,35}}, color={0,127,255}));
  connect(senMasFlo1.port_a, Fluid_in_warm)
    annotation (Line(points={{84,-60},{100,-60}}, color={0,127,255}));
  connect(senMasFlo1.port_b, bou1.ports[2])
    annotation (Line(points={{64,-60},{64,-34},{58,-34}}, color={0,127,255}));
  connect(senMasFlo.m_flow, measureBus.heatpump_cold_massflow) annotation (Line(
        points={{-78,71},{-78,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
  connect(senMasFlo1.m_flow, measureBus.heatpump_warm_massflow) annotation (
      Line(points={{74,-49},{74,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(senTem.port, Fluid_out_cold)
    annotation (Line(points={{-58,-60},{-100,-60}}, color={0,127,255}));
  connect(heatPumpDetailed_small.port_evaOut, senTem.port) annotation (Line(
        points={{-12,-35},{-12,-60},{-58,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
