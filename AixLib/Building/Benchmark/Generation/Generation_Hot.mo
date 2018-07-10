within AixLib.Building.Benchmark.Generation;
model Generation_Hot
  Fluid.BoilerCHP.Boiler boiler(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    allowFlowReversal=false,
    m_flow_nominal=1,
    m_flow_small=0.01,
    show_T=true,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_11kW(),
    paramHC=DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10
        (),
    redeclare model ExtControl =
        Fluid.BoilerCHP.BaseClasses.Controllers.ExternalControlNightDayHC)
    annotation (Placement(transformation(extent={{12,4},{34,26}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    length=1,
    diameter=0.05)
    annotation (Placement(transformation(extent={{-12,8},{2,22}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_Hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,4},{110,24}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_Hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealInput TAmbient1
    "Ambient air temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100})));
  Modelica.Blocks.Interfaces.BooleanInput switchToNightMode1
     "Connector of Boolean input signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-18,100})));
  Modelica.Blocks.Interfaces.BooleanInput isOn1
    "Switches Controler on and off" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-56,100})));
  Modelica.Blocks.Interfaces.RealInput dp_in1
    "Prescribed pressure rise" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-88,100})));
  Fluid.Movers.Pump pump(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    MinMaxCharacteristics=DataBase.Pumps.Pump1(),
    m_flow_small=0.01)
    annotation (Placement(transformation(extent={{-52,6},{-32,26}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{64,16},{84,36}})));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{56,-20},{76,0}})));
  Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-36,26},{-16,46}})));
  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    height=0.1,
    crossArea=0.1,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-86,14},{-72,28}})));
equation
  connect(pipe.port_b, boiler.port_a)
    annotation (Line(points={{2,15},{12,15}}, color={0,127,255}));
  connect(boiler.port_b, Fluid_out_Hot) annotation (Line(points={{34,15},{68,15},
          {68,16},{100,16},{100,14}}, color={0,127,255}));
  connect(boiler.TAmbient, TAmbient1) annotation (Line(points={{15.3,22.7},{20,
          22.7},{20,100}}, color={0,0,127}));
  connect(boiler.switchToNightMode, switchToNightMode1) annotation (Line(points
        ={{15.3,19.4},{-18,19.4},{-18,100}}, color={255,0,255}));
  connect(boiler.isOn, isOn1) annotation (Line(points={{28.5,5.1},{28.5,-14},{
          -56,-14},{-56,100}}, color={255,0,255}));
  connect(pump.port_b, pipe.port_a) annotation (Line(points={{-32,16},{-22,16},
          {-22,15},{-12,15}}, color={0,127,255}));
  connect(pump.IsNight, switchToNightMode1) annotation (Line(points={{-42,26.2},
          {-42,54},{-18,54},{-18,100}}, color={255,0,255}));
  connect(boiler.port_b, temperature.port) annotation (Line(points={{34,15},{68,
          15},{68,16},{74,16}}, color={0,127,255}));
  connect(Fluid_in_Hot, temperature1.port)
    annotation (Line(points={{100,-20},{66,-20}}, color={0,127,255}));
  connect(pump.port_b, temperature2.port)
    annotation (Line(points={{-32,16},{-26,16},{-26,26}}, color={0,127,255}));
  connect(tank1.ports[1], pump.port_a) annotation (Line(points={{-80.4,14},{-68,
          14},{-68,16},{-52,16}}, color={0,127,255}));
  connect(tank1.ports[2], temperature1.port) annotation (Line(points={{-77.6,14},
          {-80,14},{-80,-22},{66,-22},{66,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{26,72},{88,52}},
          lineColor={28,108,200},
          textString="Parameter passen nicht
Regelung des Boilers muss angepasst werden")}));
end Generation_Hot;
