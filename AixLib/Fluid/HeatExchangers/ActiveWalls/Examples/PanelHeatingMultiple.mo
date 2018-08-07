within AixLib.Fluid.HeatExchangers.ActiveWalls.Examples;
model PanelHeatingMultiple
  extends Modelica.Icons.Example;
      replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater "Medium in the system"                annotation(choicesAllMatching = true);

  parameter Modelica.SIunits.Area panelHeatingArea = 10 "Area of heating panels";

  Distributor distributor(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-44,-20},{36,20}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis1(redeclare
      package Medium =                                                                                 Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,64},{84,76}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis2(redeclare
      package Medium =                                                                                 Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,34},{84,46}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis3(redeclare
      package Medium =                                                                                 Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,6},{84,18}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis4(redeclare
      package Medium =                                                                                 Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,-22},{84,-10}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis5(redeclare
      package Medium =                                                                                 Medium, A=
        panelHeatingArea)
    annotation (Placement(transformation(extent={{56,-52},{84,-40}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.PanelHeating panelheating_1D_Dis6(redeclare
      package Medium =                                                                                 Medium, A=
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
  connect(boundary.ports[1],distributor. MAIN_FLOW) annotation (Line(
      points={{-60,12},{-54,12},{-54,8},{-44.8,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary1.ports[1],distributor. MAIN_RETURN) annotation (Line(
      points={{-60,-14},{-54,-14},{-54,-8},{-44,-8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Flow_1, panelheating_1D_Dis1.port_a) annotation (Line(
      points={{-28.8,20},{-26,20},{-26,69},{56,69}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Flow_2, panelheating_1D_Dis2.port_a) annotation (Line(
      points={{-16,20},{-16,39},{56,39}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Flow_3, panelheating_1D_Dis3.port_a) annotation (Line(
      points={{-3.2,20},{-4,20},{-4,30},{46,30},{46,11},{56,11}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Flow_4, panelheating_1D_Dis4.port_a) annotation (Line(
      points={{8.8,20},{8,20},{8,0},{46,0},{46,-17},{56,-17}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Flow_5, panelheating_1D_Dis5.port_a) annotation (Line(
      points={{21.6,20},{21.6,-4},{42,-4},{42,-47},{56,-47}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Flow_6, panelheating_1D_Dis6.port_a) annotation (Line(
      points={{32.8,20},{40,20},{40,-75},{56,-75}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Return_1, panelheating_1D_Dis1.port_b) annotation (Line(
      points={{-28.8,-20.8},{-28.8,-34},{94,-34},{94,69},{84,69}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Return_2, panelheating_1D_Dis2.port_b) annotation (Line(
      points={{-16,-20.8},{-16,-30},{90,-30},{90,39},{84,39}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Return_3, panelheating_1D_Dis3.port_b) annotation (Line(
      points={{-3.2,-20.8},{-3.2,-42},{98,-42},{98,11},{84,11}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Return_4, panelheating_1D_Dis4.port_b) annotation (Line(
      points={{8.8,-20.8},{8.8,-28},{88,-28},{88,-17},{84,-17}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Return_5, panelheating_1D_Dis5.port_b) annotation (Line(
      points={{20.8,-20.8},{20.8,-58},{94,-58},{94,-47},{84,-47}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(distributor.Return_6, panelheating_1D_Dis6.port_b) annotation (Line(
      points={{31.2,-20.8},{31.2,-88},{94,-88},{94,-75},{84,-75}},
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Documentation(info="<html>
<p>A simple example to test the models <a href=\"AixLib.Fluid.HeatExchangers.ActiveWalls.Panelheating_1D_Dis\">panelheating_1D_Dis1</a> and <a href=\"AixLib.Fluid.HeatExchangers.ActiveWalls.Contributor\">contributor</a>.</p>
</html>",
        revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>November 28, 2014&nbsp;</i> by Xian Wu:<br/>
Added to the HVAC library.</li>
</ul>
</html>"),
    experiment(StopTime=86400, Interval=60),
    __Dymola_experimentSetupOutput);
end PanelHeatingMultiple;
