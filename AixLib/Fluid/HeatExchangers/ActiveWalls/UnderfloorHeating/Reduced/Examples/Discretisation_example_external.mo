within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.Examples;
model Discretisation_example_external
  extends Modelica.Icons.Example;
  package MediumAir = AixLib.Media.Air;
  package MediumWater = AixLib.Media.Water;
  parameter Modelica.SIunits.Area area=20;
  parameter Integer dis=100;
  final parameter Modelica.SIunits.MassFlowRate m_flow_total=0.05
    "Total mass flow in the panel heating system";

  TABSSystem  tABSSystem(
    redeclare package Medium = MediumWater,
    RoomNo=1,
    dis=dis,
    Q_Nf={700},
    calculateVol=1,
    A={area},
    Spacing={0.35},
    use_vmax=1,
    wallTypeFloor={
        BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},
    wallTypeCeiling={BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},
    PipeRecord={BaseClasses.Piping.PBpipe()})
    annotation (Placement(transformation(extent={{-32,14},{-6,30}})));
  Modelica.Blocks.Sources.Constant const(each k=1)
    annotation (Placement(transformation(extent={{-52,50},{-38,64}})));
  RCTABS rCTabs1(
    External=true,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    A=area)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-4,54})));

  MixingVolumes.MixingVolume              vol1(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{2,72},{22,92}})));
  Sources.MassFlowSource_T              boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    m_flow=m_flow_total,
    use_T_in=true,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,12},{-48,32}})));
  Sources.Boundary_pT              bou(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{26,12},{6,32}})));
  TABSSystem  tABSSystem1(
    redeclare package Medium = MediumWater,
    RoomNo=1,
    dis=1,
    Q_Nf={700},
    calculateVol=1,
    A={area},
    Spacing={0.35},
    use_vmax=1,
    wallTypeFloor={
        BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},
    wallTypeCeiling={BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},
    PipeRecord={BaseClasses.Piping.PBpipe()})
    annotation (Placement(transformation(extent={{100,14},{128,30}})));
  Modelica.Blocks.Sources.Constant const1(each k=1)
    annotation (Placement(transformation(extent={{76,46},{90,60}})));
  RCTABS rCTabs2(
    External=true,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    A=area)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={128,50})));
  MixingVolumes.MixingVolume              vol2(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{132,66},{152,86}})));
  Sources.MassFlowSource_T              boundary1(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    m_flow=m_flow_total,
    use_T_in=true,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{68,12},{88,32}})));
  Sources.Boundary_pT              bou1(redeclare package Medium = MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{166,12},{146,32}})));
  RCTABS thermalTABS(
    External=true,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    A=area)
    annotation (Placement(transformation(extent={{-12,-46},{8,-26}})));
  Sources.MassFlowSource_T              boundary2(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    m_flow=m_flow_total,
    use_T_in=true,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-74,-74},{-54,-54}})));
  Sources.Boundary_pT              bou2(redeclare package Medium = MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{22,-74},{2,-54}})));
  TABSElement tABSElement(
    redeclare package Medium = MediumWater,
    R_Pipe=tABSSystem.tABSRoom[1].R_Pipe,
    d_i=0.013,
    PipeLength=20/0.35,
    dis=1,
    calculateVol=1,
    T0=283.15,
    m_flow_Circuit=m_flow_total,
    use_vmax=1) annotation (Placement(transformation(extent={{-42,-68},{-22,-60}})));
  MixingVolumes.MixingVolume              vol3(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{20,-18},{40,2}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=-700)
    annotation (Placement(transformation(extent={{-62,-28},{-42,-8}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=-700)
    annotation (Placement(transformation(extent={{-66,72},{-46,92}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-700)
    annotation (Placement(transformation(extent={{72,70},{92,90}})));
  UnderfloorHeatingSystem
              underfloorHeatingSystem(
    redeclare package Medium = MediumWater,
    RoomNo=1,
    dis=dis,
    Q_Nf={700},
    calculateVol=1,
    A={area},
    Spacing={0.35},
    use_vmax=1,
    wallTypeFloor={
        BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},
    wallTypeCeiling={BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},

    PipeRecord={BaseClasses.Piping.PBpipe()})
    annotation (Placement(transformation(extent={{104,-72},{130,-56}})));
  Modelica.Blocks.Sources.Constant const2(each k=1)
    annotation (Placement(transformation(extent={{84,-36},{98,-22}})));
  MixingVolumes.MixingVolume              vol4(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{138,-14},{158,6}})));
  Sources.MassFlowSource_T              boundary3(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    m_flow=m_flow_total,
    use_T_in=true,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{68,-74},{88,-54}})));
  Sources.Boundary_pT              bou3(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{162,-74},{142,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow3(Q_flow=-700)
    annotation (Placement(transformation(extent={{70,-14},{90,6}})));
equation
  for i in 1:dis loop
  end for;
  connect(vol1.heatPort, rCTabs1.port_int) annotation (Line(
      points={{2,82},{-2,82},{-2,64},{-4,64}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(boundary.ports[1], tABSSystem.port_a) annotation (Line(
      points={{-48,22},{-48,22},{-32,22}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem.port_b, bou.ports[1]) annotation (Line(
      points={{-6,22},{-6,22},{6,22}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(vol2.heatPort,rCTabs2. port_int) annotation (Line(
      points={{132,76},{128,76},{128,60}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(boundary1.ports[1], tABSSystem1.port_a) annotation (Line(
      points={{88,22},{88,22},{100,22}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem1.port_b, bou1.ports[1]) annotation (Line(
      points={{128,22},{128,22},{146,22}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(boundary2.ports[1], tABSElement.port_a) annotation (Line(
      points={{-54,-64},{-42,-64}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSElement.port_b, bou2.ports[1]) annotation (Line(
      points={{-22,-64},{-10,-64},{2,-64}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSElement.heatTabs, thermalTABS.port_heat) annotation (Line(
      points={{-32,-59.8},{-18,-59.8},{-18,-36},{-12,-36}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(vol3.heatPort, thermalTABS.port_int) annotation (Line(
      points={{20,-8},{10,-8},{10,-26},{-2,-26}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(fixedHeatFlow.port, vol3.heatPort) annotation (Line(
      points={{-42,-18},{-12,-18},{-12,-8},{20,-8}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(fixedHeatFlow2.port, vol1.heatPort) annotation (Line(
      points={{-46,82},{2,82}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(fixedHeatFlow1.port, vol2.heatPort) annotation (Line(
      points={{92,80},{112,80},{112,76},{132,76}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(tABSSystem.m_flowNominal, boundary.m_flow_in) annotation (Line(points=
         {{-32,17.2},{-44,17.2},{-44,30},{-70,30}}, color={0,0,127}));
  connect(tABSSystem.T_FlowNominal, boundary.T_in) annotation (Line(points={{-32,
          14.8},{-74,14.8},{-74,26},{-70,26}}, color={0,0,127}));
  connect(tABSSystem.T_FlowNominal, boundary2.T_in) annotation (Line(points={{-32,
          14.8},{-32,9.4},{-76,9.4},{-76,-60}}, color={0,0,127}));
  connect(boundary2.m_flow_in, tABSSystem.m_flowNominal) annotation (Line(
        points={{-76,-56},{-92,-56},{-92,17.2},{-32,17.2}}, color={0,0,127}));
  connect(tABSSystem1.heatTABS[1], rCTabs2.port_heat) annotation (Line(points={{
          114,30},{116,30},{116,50},{118,50}}, color={191,0,0}));
  connect(tABSSystem.heatTABS[1], rCTabs1.port_heat) annotation (Line(points={{-19,
          30},{-16,30},{-16,54},{-14,54}}, color={191,0,0}));
  connect(tABSSystem1.m_flowNominal, boundary1.m_flow_in) annotation (Line(
        points={{100,17.2},{96,17.2},{96,30},{66,30}}, color={0,0,127}));
  connect(tABSSystem1.T_FlowNominal, boundary1.T_in) annotation (Line(points={{100,
          14.8},{56,14.8},{56,26},{66,26}}, color={0,0,127}));
  connect(const.y, tABSSystem.valveInput[1]) annotation (Line(points={{-37.3,57},
          {-37.3,44.5},{-28,44.5},{-28,32}}, color={0,0,127}));
  connect(const1.y, tABSSystem1.valveInput[1]) annotation (Line(points={{90.7,
          53},{90.7,41.5},{106,41.5},{106,30}}, color={0,0,127}));
  connect(boundary3.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
      points={{88,-64},{88,-64},{104,-64}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(underfloorHeatingSystem.port_b, bou3.ports[1]) annotation (Line(
      points={{130,-64},{130,-64},{142,-64}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(fixedHeatFlow3.port,vol4. heatPort) annotation (Line(
      points={{90,-4},{138,-4}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(underfloorHeatingSystem.m_flowNominal, boundary3.m_flow_in)
    annotation (Line(points={{104,-68.8},{92,-68.8},{92,-56},{66,-56}}, color={
          0,0,127}));
  connect(underfloorHeatingSystem.T_FlowNominal, boundary3.T_in) annotation (
      Line(points={{104,-71.2},{62,-71.2},{62,-60},{66,-60}}, color={0,0,127}));
  connect(const2.y, underfloorHeatingSystem.valveInput[1]) annotation (Line(
        points={{98.7,-29},{98.7,-41.5},{108.68,-41.5},{108.68,-54.9333}},
        color={0,0,127}));
  connect(underfloorHeatingSystem.heatFloor[1], vol4.heatPort) annotation (Line(
        points={{117,-56},{117,-30},{138,-30},{138,-4}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {200,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{200,100}})));
end Discretisation_example_external;
