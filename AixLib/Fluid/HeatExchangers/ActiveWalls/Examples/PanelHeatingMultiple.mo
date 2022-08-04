within AixLib.Fluid.HeatExchangers.ActiveWalls.Examples;
model PanelHeatingMultiple
  extends Modelica.Icons.Example;
      replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

  parameter Modelica.Units.SI.Area panelHeatingArea=10 "Area of heating panels";

  Distributor distributor(redeclare package Medium = Medium, m_flow_nominal=0.5, n=6)
    annotation (Placement(transformation(extent={{-32,-20},{8,20}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis1(redeclare
      package                                                                                 Medium = Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,64},{84,76}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis2(redeclare
      package                                                                                 Medium = Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,34},{84,46}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis3(redeclare
      package                                                                                 Medium = Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,6},{84,18}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis4(redeclare
      package                                                                                 Medium = Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,-22},{84,-10}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis5(redeclare
      package                                                                                 Medium = Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,-52},{84,-40}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis6(redeclare
      package                                                                                 Medium = Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,-80},{84,-68}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    use_T_in=false,
    redeclare package Medium = Medium,
    m_flow=0.5,
    T=313.15) annotation (Placement(transformation(extent={{-80,2},{-60,22}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(                  nPorts=1,
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,-14})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature FixedTemp(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,90})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature FixedTemp1(
                                                                   T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,90})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature FixedTemp2(
                                                                   T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,-90})));
equation
  connect(boundary.ports[1], distributor.mainFlow) annotation (Line(
      points={{-60,12},{-54,12},{-54,10.6667},{-32,10.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary1.ports[1], distributor.mainReturn) annotation (Line(
      points={{-60,-14},{-54,-14},{-54,-10},{-32,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis2.thermConv, FixedTemp.port) annotation (Line(
      points={{71.96,47},{71.96,52},{50,52},{50,78},{-30,78},{-30,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis1.thermConv, FixedTemp.port) annotation (Line(
      points={{71.96,77},{50,77},{50,78},{-30,78},{-30,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis3.thermConv, FixedTemp.port) annotation (Line(
      points={{71.96,19},{71.96,24},{50,24},{50,78},{-30,78},{-30,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis4.thermConv, FixedTemp.port) annotation (Line(
      points={{71.96,-9},{71.96,-4},{50,-4},{50,78},{-30,78},{-30,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis5.thermConv, FixedTemp.port) annotation (Line(
      points={{71.96,-39},{71.96,-32},{50,-32},{50,78},{-30,78},{-30,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis6.thermConv, FixedTemp.port) annotation (Line(
      points={{71.96,-67},{71.96,-62},{50,-62},{50,78},{-30,78},{-30,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis1.starRad, FixedTemp1.port) annotation (Line(
      points={{68.32,76.6},{68.32,100},{18,100}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(panelheating_1D_Dis2.starRad, FixedTemp1.port) annotation (Line(
      points={{68.32,46.6},{52,46.6},{52,100},{18,100}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(panelheating_1D_Dis3.starRad, FixedTemp1.port) annotation (Line(
      points={{68.32,18.6},{52,18.6},{52,100},{18,100}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(panelheating_1D_Dis4.starRad, FixedTemp1.port) annotation (Line(
      points={{68.32,-9.4},{52,-9.4},{52,100},{18,100}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(panelheating_1D_Dis5.starRad, FixedTemp1.port) annotation (Line(
      points={{68.32,-39.4},{52,-39.4},{52,100},{18,100}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(panelheating_1D_Dis6.starRad, FixedTemp1.port) annotation (Line(
      points={{68.32,-67.4},{52,-67.4},{52,100},{18,100}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(panelheating_1D_Dis2.ThermDown, FixedTemp2.port) annotation (Line(
      points={{71.12,33.4},{48,33.4},{48,64},{-86,63.4},{-86,-70},{-4,-70},{
          -4,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis1.ThermDown, FixedTemp2.port) annotation (Line(
      points={{71.12,63.4},{48,64},{-86,63.4},{-86,-70},{-4,-70},{-4,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis3.ThermDown, FixedTemp2.port) annotation (Line(
      points={{71.12,5.4},{48,5.4},{48,64},{-86,63.4},{-86,-70},{-4,-70},{-4,
          -80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis4.ThermDown, FixedTemp2.port) annotation (Line(
      points={{71.12,-22.6},{48,-22.6},{48,64},{-86,63.4},{-86,-70},{-4,-70},
          {-4,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis5.ThermDown, FixedTemp2.port) annotation (Line(
      points={{71.12,-52.6},{48,-52.6},{48,64},{-86,63.4},{-86,-70},{-4,-70},
          {-4,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panelheating_1D_Dis6.ThermDown, FixedTemp2.port) annotation (Line(
      points={{71.12,-80.6},{48,-80.6},{48,64},{-86,63.4},{-86,-70},{-4,-70},
          {-4,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(distributor.flowPorts[1], panelheating_1D_Dis1.port_a)
    annotation (Line(points={{-5.33333,20},{-5.33333,69},{56,69}},
                                                         color={0,127,255}));
  connect(panelheating_1D_Dis2.port_a, distributor.flowPorts[2])
    annotation (Line(points={{56,39},{-8,39},{-8,20}},   color={0,127,255}));
  connect(panelheating_1D_Dis3.port_a, distributor.flowPorts[3]) annotation (
      Line(points={{56,11},{40,11},{40,20},{-10.6667,20}},
                                                      color={0,127,255}));
  connect(panelheating_1D_Dis4.port_a, distributor.flowPorts[4]) annotation (
      Line(points={{56,-17},{40,-17},{40,20},{-13.3333,20}},
                                                        color={0,127,255}));
  connect(panelheating_1D_Dis5.port_a, distributor.flowPorts[5]) annotation (
      Line(points={{56,-47},{40,-47},{40,20},{-16,20}}, color={0,127,255}));
  connect(panelheating_1D_Dis6.port_a, distributor.flowPorts[6]) annotation (
      Line(points={{56,-75},{40,-75},{40,20},{-18.6667,20}},
                                                        color={0,127,255}));
  connect(panelheating_1D_Dis1.port_b, distributor.returnPorts[1]) annotation (
      Line(points={{84,69},{96,69},{96,-92},{20,-92},{20,-40},{-5.33333,-40},{
          -5.33333,-20.6667}},
        color={0,127,255}));
  connect(panelheating_1D_Dis2.port_b, distributor.returnPorts[2]) annotation (
      Line(points={{84,39},{96,39},{96,-92},{20,-92},{20,-40},{-8,-40},{-8,
          -20.6667}},
        color={0,127,255}));
  connect(panelheating_1D_Dis3.port_b, distributor.returnPorts[3]) annotation (
      Line(points={{84,11},{96,11},{96,-92},{20,-92},{20,-40},{-10.6667,-40},{
          -10.6667,-20.6667}},
        color={0,127,255}));
  connect(panelheating_1D_Dis4.port_b, distributor.returnPorts[4]) annotation (
      Line(points={{84,-17},{96,-17},{96,-92},{20,-92},{20,-40},{-13.3333,-40},
          {-13.3333,-20.6667}},
                 color={0,127,255}));
  connect(panelheating_1D_Dis5.port_b, distributor.returnPorts[5]) annotation (
      Line(points={{84,-47},{96,-47},{96,-92},{20,-92},{20,-40},{-16,-40},{-16,
          -20.6667}},
                 color={0,127,255}));
  connect(panelheating_1D_Dis6.port_b, distributor.returnPorts[6]) annotation (
      Line(points={{84,-75},{96,-75},{96,-92},{20,-92},{20,-40},{-18.6667,-40},
          {-18.6667,-20.6667}},
                 color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Documentation(info="<html><p>
  A simple example to test the models <a href=
  \"AixLib.Fluid.HeatExchangers.ActiveWalls.Panelheating_1D_Dis\">panelheating_1D_Dis1</a>
  and <a href=
  \"AixLib.Fluid.HeatExchangers.ActiveWalls.Contributor\">contributor</a>.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>June 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>November 28, 2014&#160;</i> by Xian Wu:<br/>
    Added to the HVAC library.
  </li>
</ul>
</html>"),
    experiment(StopTime=86400, Interval=60),
    __Dymola_experimentSetupOutput);
end PanelHeatingMultiple;
