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
    T0=292.15) annotation (Placement(transformation(extent={{-34,8},{30,28}})));
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
    annotation (Placement(transformation(extent={{-36,-66},{-16,-46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature fixedTemperature1
    annotation (Placement(transformation(extent={{-58,52},{-38,72}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature fixedTemperature2
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={72,64})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{40,8},{60,28}})));
  Modelica.Blocks.Sources.Step     const(
    height=-6,
    offset=299.15,
    startTime=42300)
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
equation
  Power =abs(panel_Dis1D.thermConv.Q_flow + panel_Dis1D.starRad.Q_flow);
  connect(Source.ports[1],pipe1. port_a) annotation (Line(
      points={{-74,18},{-62,18},{-62,19}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe1.port_b, panel_Dis1D.port_a) annotation (Line(
      points={{-46,19},{-42,19},{-42,16.3333},{-34,16.3333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedTemperature.port, panel_Dis1D.ThermDown) annotation (Line(
      points={{-16,-56},{0.56,-56},{0.56,7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedTemperature1.port,panel_Dis1D.starRad)  annotation (Line(
      points={{-38,62},{-5.84,62},{-5.84,29}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(fixedTemperature2.port, panel_Dis1D.thermConv) annotation (Line(
      points={{62,64},{36,64},{36,66},{2.48,66},{2.48,29.6667}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipe2.port_b, tank.ports[1]) annotation (Line(
      points={{78,21},{92,21}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(panel_Dis1D.port_b, temperature.port_a) annotation (Line(
      points={{30,16.3333},{36,16.3333},{36,18},{40,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe2.port_a, temperature.port_b) annotation (Line(
      points={{62,21},{62,18},{60,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fixedTemperature1.T, const.y) annotation (Line(
      points={{-60,62},{-66,62},{-66,60},{-73,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, fixedTemperature2.T) annotation (Line(
      points={{-73,60},{-70,60},{-70,92},{100,92},{100,64},{84,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, fixedTemperature.T) annotation (Line(
      points={{-73,60},{-70,60},{-70,-54},{-38,-54},{-38,-56}},
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{120,100}}), graphics),
    Icon(coordinateSystem(extent={{-140,-100},{120,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html><p>
  A simple test for <a href=
  \"AixLib.Fluid.HeatExchangers.ActiveWalls.Panel_Dis1D\">AixLib.Fluid.HeatExchangers.ActiveWalls.Panel_Dis1D</a>
</p>
<p>
  Notice how the cahnge in flow temperature, amrking the change between
  heating and cooling mode is sudden, in order to prevent the mode from
  getting stuck.
</p>
<ul>
  <li>
    <i>June 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end PanelHeatingSingle;
