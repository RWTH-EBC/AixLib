within AixLib.Building.Benchmark.Generation;
model Generation_heatPump
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_warmwater annotation(Dialog(tab = "generation_warmwater"), choicesAllMatching = true);
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
  Fluid.HeatPumps.HeatPumpDetailed        heatPumpDetailed(
    capCalcType=2,
    P_eleOutput=true,
    dataTable=DataBase.HeatPump.EN14511.Vaillant_VWL_101(),
    CoP_output=true,
    redeclare package Medium_con = Medium_Water,
    dp_conNominal=20000,
    redeclare package Medium_eva = Medium_Water,
    dp_evaNominal=100,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,-10},{16,10}})));

  Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,8})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-20,80},{20,120}}), iconTransformation(extent={{-10,90},{10,110}})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      per=pump_model_generation_warmwater)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={42,60})));
equation
  connect(heatPumpDetailed.port_conIn, Fluid_in_warm) annotation (Line(points={
          {14,-7},{58,-7},{58,-60},{100,-60}}, color={0,127,255}));
  connect(bou1.ports[1], Fluid_in_warm) annotation (Line(points={{84,-2},{84,
          -12},{58,-12},{58,-60},{100,-60}}, color={0,127,255}));
  connect(Fluid_out_cold, heatPumpDetailed.port_evaOut) annotation (Line(points=
         {{-100,-60},{-24,-60},{-24,-7},{-12,-7}}, color={0,127,255}));
  connect(Fluid_in_cold, heatPumpDetailed.port_evaIn) annotation (Line(points={
          {-100,60},{-24,60},{-24,7},{-12,7}}, color={0,127,255}));
  connect(heatPumpDetailed.onOff_in, controlBus.OnOff_heatpump) annotation (
      Line(points={{-4,9},{-4,60},{0.1,60},{0.1,100.1}}, color={255,0,255}));
  connect(fan4.port_a, heatPumpDetailed.port_conOut)
    annotation (Line(points={{34,60},{14,60},{14,7}}, color={0,127,255}));
  connect(fan4.port_b, Fluid_out_warm)
    annotation (Line(points={{50,60},{100,60}}, color={0,127,255}));
  connect(fan4.y, controlBus.Pump_Warmwater_heatpump_y) annotation (Line(points=
         {{42,69.6},{42,80},{0.1,80},{0.1,100.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-106,42},{-28,4}},
          lineColor={28,108,200},
          textString="Parameter Wärmepumpe
müssen angepasst werden
2. Wärmepumpe angeschlossen werden
")}));
end Generation_heatPump;
