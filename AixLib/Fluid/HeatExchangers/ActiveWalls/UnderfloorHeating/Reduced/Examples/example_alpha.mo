within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.Examples;
model example_alpha
    package MediumAir = AixLib.Media.Air;
    parameter Modelica.SIunits.Temperature T_start=278.15                                     "Initial temperature";

protected
  Modelica.Thermal.HeatTransfer.Components.Convection convIntWall(dT(start=0))
    "Convective heat transfer of interior walls"
    annotation (Placement(transformation(extent={{-58,70},{-78,50}})));
  Modelica.Blocks.Sources.Constant hConIntWall(k=20*2 + 10*1)
    "Coefficient of convective heat transfer for interior walls"
    annotation (Placement(transformation(
      extent={{5,-5},{-5,5}},
      rotation=-90,
      origin={-68,35})));
protected
  Modelica.Thermal.HeatTransfer.Components.Convection convIntWall1(dT(start=0))
    "Convective heat transfer of interior walls"
    annotation (Placement(transformation(extent={{-60,-30},{-80,-50}})));
  Modelica.Blocks.Sources.Constant hConIntWall1(k=20*2)
    "Coefficient of convective heat transfer for interior walls"
    annotation (Placement(transformation(
      extent={{5,-5},{-5,5}},
      rotation=-90,
      origin={-70,-65})));
protected
  Modelica.Thermal.HeatTransfer.Components.Convection convIntWall2(dT(start=0))
    "Convective heat transfer of interior walls"
    annotation (Placement(transformation(extent={{64,-32},{44,-52}})));
  Modelica.Blocks.Sources.Constant hConIntWall2(k=20*2)
    "Coefficient of convective heat transfer for interior walls"
    annotation (Placement(transformation(
      extent={{5,-5},{-5,5}},
      rotation=-90,
      origin={54,-67})));
protected
  Modelica.Thermal.HeatTransfer.Components.Convection convIntWall3(dT(start=0))
    "Convective heat transfer of interior walls"
    annotation (Placement(transformation(extent={{62,20},{42,0}})));
  Modelica.Blocks.Sources.Constant hConIntWall3(k=10)
    "Coefficient of convective heat transfer for interior walls"
    annotation (Placement(transformation(
      extent={{5,-5},{-5,5}},
      rotation=-90,
      origin={52,-15})));
protected
  Modelica.Thermal.HeatTransfer.Components.Convection convIntWall4(dT(start=0))
    "Convective heat transfer of interior walls"
    annotation (Placement(transformation(extent={{-42,16},{-62,-4}})));
  Modelica.Blocks.Sources.Constant hConIntWall4(k=10)
    "Coefficient of convective heat transfer for interior walls"
    annotation (Placement(transformation(
      extent={{5,-5},{-5,5}},
      rotation=-90,
      origin={-52,-15})));
public
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
                                                      fixedTemperature(T=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,60})));
  MixingVolumes.MixingVolume ROM_vol(
    redeclare package Medium = MediumAir,
    T_start=T_start,
    m_flow_nominal=0.1,
    V=20*3) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-102,60})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
                                                      fixedTemperature1(T=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-42})));
  MixingVolumes.MixingVolume ROM_vol1(
    redeclare package Medium = MediumAir,
    T_start=T_start,
    m_flow_nominal=0.1,
    V=20*3) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-104,-40})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
                                                      fixedTemperature2(T=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={104,-42})));
  MixingVolumes.MixingVolume ROM_vol2(
    redeclare package Medium = MediumAir,
    T_start=T_start,
    m_flow_nominal=0.1,
    V=20*3) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,-42})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                                      prescribedHeatFlow
    annotation (Placement(transformation(extent={{62,50},{82,70}})));
  Modelica.Blocks.Sources.Cosine   cosine(
    amplitude=200/2,
    freqHz(displayUnit="Hz") = 1/86400,
    offset=-200/2,
    startTime=0)
    annotation (Placement(transformation(extent={{16,54},{30,68}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_3(R=0.0001)
                      annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={90,60})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                                      prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-4,-16},{16,4}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_5(R=0.0001)
                      annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={24,-6})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                                      prescribedHeatFlow2
    annotation (Placement(transformation(extent={{-128,-10},{-108,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_6(R=0.0001)
                      annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-100,0})));
equation
  connect(hConIntWall.y,convIntWall. Gc)
    annotation (Line(points={{-68,40.5},{-68,50}},       color={0,0,127}));
  connect(convIntWall.fluid, ROM_vol.heatPort)
    annotation (Line(points={{-78,60},{-92,60}}, color={191,0,0}));
  connect(hConIntWall1.y, convIntWall1.Gc)
    annotation (Line(points={{-70,-59.5},{-70,-50}}, color={0,0,127}));
  connect(convIntWall1.fluid, ROM_vol1.heatPort)
    annotation (Line(points={{-80,-40},{-94,-40}}, color={191,0,0}));
  connect(hConIntWall2.y, convIntWall2.Gc)
    annotation (Line(points={{54,-61.5},{54,-52}}, color={0,0,127}));
  connect(convIntWall2.fluid, ROM_vol2.heatPort)
    annotation (Line(points={{44,-42},{30,-42}}, color={191,0,0}));
  connect(hConIntWall3.y, convIntWall3.Gc)
    annotation (Line(points={{52,-9.5},{52,0}}, color={0,0,127}));
  connect(convIntWall3.fluid, ROM_vol2.heatPort) annotation (Line(points={{42,10},
          {38,10},{38,-42},{30,-42}}, color={191,0,0}));
  connect(hConIntWall4.y, convIntWall4.Gc)
    annotation (Line(points={{-52,-9.5},{-52,-4}}, color={0,0,127}));
  connect(convIntWall4.fluid, convIntWall1.solid) annotation (Line(points={{-62,
          6},{-72,6},{-72,-26},{-54,-26},{-54,-40},{-60,-40}}, color={191,0,0}));
  connect(prescribedHeatFlow.port,RTabs_Up_3. port_b)
    annotation (Line(points={{82,60},{86,60}},   color={191,0,0}));
  connect(cosine.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{30.7,
          61},{37.35,61},{37.35,60},{62,60}}, color={0,0,127}));
  connect(RTabs_Up_3.port_a, ROM_vol.heatPort) annotation (Line(points={{94,60},
          {102,60},{102,84},{-92,84},{-92,60},{-92,60}}, color={191,0,0}));
  connect(prescribedHeatFlow1.port, RTabs_Up_5.port_b)
    annotation (Line(points={{16,-6},{20,-6}}, color={191,0,0}));
  connect(prescribedHeatFlow1.Q_flow, cosine.y) annotation (Line(points={{-4,-6},
          {-12,-6},{-12,42},{30.7,42},{30.7,61}}, color={0,0,127}));
  connect(RTabs_Up_5.port_a, ROM_vol2.heatPort)
    annotation (Line(points={{28,-6},{30,-6},{30,-42}}, color={191,0,0}));
  connect(prescribedHeatFlow2.port, RTabs_Up_6.port_b)
    annotation (Line(points={{-108,0},{-104,0}}, color={191,0,0}));
  connect(RTabs_Up_6.port_a, ROM_vol1.heatPort)
    annotation (Line(points={{-96,0},{-96,-40},{-94,-40}}, color={191,0,0}));
  connect(cosine.y, prescribedHeatFlow2.Q_flow) annotation (Line(points={{30.7,
          61},{30.7,22},{-142,22},{-142,0},{-128,0}}, color={0,0,127}));
  connect(convIntWall4.solid, fixedTemperature1.port) annotation (Line(points={
          {-42,6},{-36,6},{-36,-42},{-30,-42}}, color={191,0,0}));
  connect(convIntWall.solid, fixedTemperature.port)
    annotation (Line(points={{-58,60},{-28,60}}, color={191,0,0}));
  connect(convIntWall2.solid, fixedTemperature2.port)
    annotation (Line(points={{64,-42},{94,-42}}, color={191,0,0}));
  connect(convIntWall2.solid, convIntWall3.solid) annotation (Line(points={{64,
          -42},{64,-16},{64,10},{62,10}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},
            {120,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})));
end example_alpha;
