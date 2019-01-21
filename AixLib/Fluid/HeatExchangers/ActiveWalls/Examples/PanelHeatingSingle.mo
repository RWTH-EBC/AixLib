within AixLib.Fluid.HeatExchangers.ActiveWalls.Examples;
model PanelHeatingSingle
  extends Modelica.Icons.Example;
     replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panel_Dis1D(
    redeclare package Medium = Medium,
    dis=2,
    A=2,
    isFloor=true,
    T0=292.15) annotation (Placement(transformation(extent={{-34,10},{30,30}})));
  Modelica.Fluid.Sources.MassFlowSource_T Source(
    nPorts=1,
    m_flow=0.01,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    T=343.15)
    annotation (Placement(transformation(extent={{-94,8},{-74,28}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    diameter=0.02,
    redeclare package Medium = Medium,
    length=0.5)
    annotation (Placement(transformation(extent={{-62,12},{-46,26}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    length=10,
    diameter=0.02,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{62,14},{78,28}})));
  Modelica.Fluid.Sources.FixedBoundary
                                  tank(
    redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{112,12},{92,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature fixedTemperature
    annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature fixedTemperature2
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={72,64})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{40,8},{60,28}})));
  Modelica.Blocks.Sources.Step     const(
    height=-6,
    startTime=42300,
    offset=292.15)
    annotation (Placement(transformation(extent={{-94,50},{-74,70}})));
  Modelica.Blocks.Sources.Step     const1(
    height=24,
    offset=289.15,
    startTime=42300)
    annotation (Placement(transformation(extent={{-126,2},{-106,22}})));
  Modelica.Blocks.Sources.Constant const2(k=0.005)
    annotation (Placement(transformation(extent={{-128,32},{-108,52}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient,
      p_ambient(displayUnit="Pa"))
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput Power
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput Treturn
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Tflow "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-94},{120,-74}})));
  ThermalZones.HighOrder.Components.Walls.Wall        Wall_Ceiling(
    outside=false,
    final withSunblind=false,
    final Blinding=1-0,
    final LimitSolIrr=0,
    wall_length=sqrt(8.35),
    wall_height=sqrt(8.35),
    ISOrientation=3,
    withWindow=false,
    withDoor=false,
    WallType=DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf(),
    calculationMethod=3,
    final TOutAirLimit=273.15,
    T0=292.15)      annotation (Placement(transformation(
        origin={2.99999,49},
        extent={{5,-33},{-5,33}},
        rotation=270)));
  ThermalZones.HighOrder.Components.Walls.Wall        Wall_Floor(
    outside=false,
    final withSunblind=false,
    final Blinding=1,
    final LimitSolIrr=0,
    wall_length=sqrt(8.35),
    wall_height=sqrt(8.35),
    ISOrientation=2,
    withWindow=false,
    withDoor=false,
    WallType=DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf(),
    final TOutAirLimit=273.15,
    T0=292.15)      annotation (Placement(transformation(
        origin={2,-37.0001},
        extent={{4.99994,32},{-4.99989,-32}},
        rotation=90)));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent={{0,-70},
            {-16,-58}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux1
                                                               annotation(Placement(transformation(extent={{28,60},
            {44,72}})));
equation
  Power =abs(panel_Dis1D.thermConv.Q_flow);
  connect(Source.ports[1],pipe1. port_a) annotation (Line(
      points={{-74,18},{-62,18},{-62,19}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_b, panel_Dis1D.port_a) annotation (Line(
      points={{-46,19},{-42,19},{-42,18.3333},{-34,18.3333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe2.port_b, tank.ports[1]) annotation (Line(
      points={{78,21},{92,21}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(panel_Dis1D.port_b, temperature.port_a) annotation (Line(
      points={{30,18.3333},{36,18.3333},{36,18},{40,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe2.port_a, temperature.port_b) annotation (Line(
      points={{62,21},{62,18},{60,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const.y, fixedTemperature2.T) annotation (Line(
      points={{-73,60},{-70,60},{-70,92},{100,92},{100,64},{84,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, fixedTemperature.T) annotation (Line(
      points={{-73,60},{-70,60},{-70,-64},{-62,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const1.y, Source.T_in) annotation (Line(
      points={{-105,12},{-96,12},{-96,22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const2.y, Source.m_flow_in) annotation (Line(
      points={{-107,42},{-104,42},{-104,38},{-94,38},{-94,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperature.T, Treturn) annotation (Line(
      points={{50,29},{50,42},{60,42},{60,-20},{110,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const1.y, Tflow) annotation (Line(
      points={{-105,12},{-96,12},{-96,-84},{110,-84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Wall_Floor.port_outside, panel_Dis1D.ThermDown) annotation (Line(
        points={{2,-31.7502},{0.56,-31.7502},{0.56,9}}, color={191,0,0}));
  connect(fixedTemperature.port, thermStar_Demux.star) annotation (Line(points={
          {-40,-64},{-26,-64},{-26,-59.65},{-16.32,-59.65}}, color={191,0,0}));
  connect(fixedTemperature.port, thermStar_Demux.therm) annotation (Line(points=
         {{-40,-64},{-26,-64},{-26,-67.825},{-16.08,-67.825}}, color={191,0,0}));
  connect(thermStar_Demux.thermStarComb, Wall_Floor.thermStarComb_inside)
    annotation (Line(points={{-0.48,-64.075},{-0.48,-52},{2,-52},{2,-42}},
        color={191,0,0}));
  connect(thermStar_Demux1.thermStarComb, Wall_Ceiling.thermStarComb_inside)
    annotation (Line(points={{28.48,65.925},{4,65.925},{4,66},{2,66},{2,54},{
          2.99999,54}},   color={191,0,0}));
  connect(panel_Dis1D.thermConv, Wall_Ceiling.port_outside) annotation (Line(
        points={{2.48,31.6667},{2.48,43.75},{2.99999,43.75}},  color={191,0,0}));
  connect(thermStar_Demux1.therm, fixedTemperature2.port) annotation (Line(
        points={{44.08,62.175},{52.04,62.175},{52.04,64},{62,64}}, color={191,0,
          0}));
  connect(thermStar_Demux1.star, fixedTemperature2.port) annotation (Line(
        points={{44.32,70.35},{48,70.35},{48,70},{52,70},{52,64},{62,64}},
        color={95,95,95}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{120,100}})),
    Icon(coordinateSystem(extent={{-140,-100},{120,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>A simple test for <a href=\"AixLib.Fluid.HeatExchangers.ActiveWalls.Panel_Dis1D\">AixLib.Fluid.HeatExchangers.ActiveWalls.Panel_Dis1D</a> </p>
<p>Notice how the cahnge in flow temperature, amrking the change between heating and cooling mode is sudden, in order to prevent the mode from getting stuck.</p>
</html>", revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
</ul>
</html>"));
end PanelHeatingSingle;
