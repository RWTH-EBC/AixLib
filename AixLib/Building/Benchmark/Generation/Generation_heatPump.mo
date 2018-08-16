within AixLib.Building.Benchmark.Generation;
model Generation_heatPump
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter Real factor_heatpump_model_small = 3 annotation(Dialog(tab = "General"));
    parameter Real factor_heatpump_model_big = 6 annotation(Dialog(tab = "General"));
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

  Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-24})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={{-60,80},
            {-20,120}}),         iconTransformation(extent={{-50,90},{-30,110}})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={42,60})));
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
  Fluid.HeatPumps.HeatPumpSimple heatPumpSimple(
    redeclare package Medium = Medium_Water,
    tablePower=[0,35,45,55; -5,3225,4000,4825; 0,3300,4000,4900; 5,3300,4000,
        4900],
    tableHeatFlowCondenser=[0,35,45,55; -5,12762,12100,11513; 0,14500,13900,
        13200; 5,16100,15600,14900])
    annotation (Placement(transformation(extent={{-20,6},{0,26}})));
equation
  connect(fan4.port_b, Fluid_out_warm)
    annotation (Line(points={{50,60},{100,60}}, color={0,127,255}));
  connect(fan4.y, controlBus.Pump_Warmwater_heatpump_y) annotation (Line(points={{42,69.6},
          {42,80},{-39.9,80},{-39.9,100.1}},       color={0,0,127}));
  connect(fan4.P, measureBus.Pump_Warmwater_heatpump_power) annotation (Line(
        points={{50.8,67.2},{60,67.2},{60,80},{30.1,80},{30.1,90.1}}, color={0,0,
          127}));
  connect(senTem2.port, fan4.port_a) annotation (Line(points={{16,48},{16,44},{
          30,44},{30,60},{34,60}}, color={0,127,255}));
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
  connect(senMasFlo1.port_a, Fluid_in_warm)
    annotation (Line(points={{84,-60},{100,-60}}, color={0,127,255}));
  connect(senMasFlo1.port_b, bou1.ports[1])
    annotation (Line(points={{64,-60},{64,-34},{60,-34}}, color={0,127,255}));
  connect(senMasFlo.m_flow, measureBus.heatpump_cold_massflow) annotation (Line(
        points={{-78,71},{-78,80},{30.1,80},{30.1,90.1}}, color={0,0,127}));
  connect(senMasFlo1.m_flow, measureBus.heatpump_warm_massflow) annotation (
      Line(points={{74,-49},{74,14},{30.1,14},{30.1,90.1}}, color={0,0,127}));
  connect(senTem.port, Fluid_out_cold)
    annotation (Line(points={{-58,-60},{-100,-60}}, color={0,127,255}));
  connect(senTem1.port, heatPumpSimple.port_a_source)
    annotation (Line(points={{-60,60},{-19,60},{-19,23}}, color={0,127,255}));
  connect(heatPumpSimple.port_b_source, senTem.port)
    annotation (Line(points={{-19,9},{-19,-60},{-58,-60}}, color={0,127,255}));
  connect(heatPumpSimple.port_b_sink, fan4.port_a)
    annotation (Line(points={{-1,23},{-1,60},{34,60}}, color={0,127,255}));
  connect(heatPumpSimple.port_a_sink, senMasFlo1.port_b)
    annotation (Line(points={{-1,9},{-1,-60},{64,-60}}, color={0,127,255}));
  connect(heatPumpSimple.OnOff, controlBus.OnOff_heatpump_small) annotation (
      Line(points={{-10,24},{-12,24},{-12,88},{-39.9,88},{-39.9,100.1}}, color=
          {255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senTem3.port, senMasFlo1.port_b)
    annotation (Line(points={{40,-18},{40,-60},{64,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
