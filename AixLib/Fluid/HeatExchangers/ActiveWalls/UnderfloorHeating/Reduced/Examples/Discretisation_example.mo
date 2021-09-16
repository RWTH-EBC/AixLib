within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.Examples;
model Discretisation_example
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
    annotation (Placement(transformation(extent={{-32,14},{-10,28}})));
  Modelica.Blocks.Sources.Constant const(each k=1)
    annotation (Placement(transformation(extent={{-52,50},{-38,64}})));
  RCTABS thermalTABS1(
    External=false,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    A=area) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
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
    annotation (Placement(transformation(extent={{-66,12},{-46,32}})));
  Sources.Boundary_pT              bou(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{16,12},{-4,32}})));
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
    annotation (Placement(transformation(extent={{100,14},{126,30}})));
  Modelica.Blocks.Sources.Constant const1(each k=1)
    annotation (Placement(transformation(extent={{76,46},{90,60}})));
  RCTABS thermalTABS2(
    External=false,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    A=area) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
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
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Sources.Boundary_pT              bou1(redeclare package Medium = MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{164,12},{144,32}})));
  RCTABS thermalTABS(
    External=false,
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
    annotation (Placement(transformation(extent={{-76,-74},{-56,-54}})));
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
    annotation (Placement(transformation(extent={{122,-68},{144,-54}})));
  Modelica.Blocks.Sources.Constant const2(each k=1)
    annotation (Placement(transformation(extent={{102,-32},{116,-18}})));
  MixingVolumes.MixingVolume              vol4(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{142,-20},{162,0}})));
  Sources.MassFlowSource_T              boundary3(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    m_flow=m_flow_total,
    use_T_in=true,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,-70},{108,-50}})));
  Sources.Boundary_pT              bou3(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{170,-70},{150,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow3(Q_flow=-700)
    annotation (Placement(transformation(extent={{74,-20},{94,0}})));
equation
  for i in 1:dis loop
  end for;
  connect(vol1.heatPort, thermalTABS1.port_int) annotation (Line(
      points={{2,82},{-2,82},{-2,64},{-4,64}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(boundary.ports[1], tABSSystem.port_a) annotation (Line(
      points={{-46,22},{-46,21},{-32,21}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem.port_b, bou.ports[1]) annotation (Line(
      points={{-10,21},{-4,21},{-4,22}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(vol2.heatPort, thermalTABS2.port_int) annotation (Line(
      points={{132,76},{128,76},{128,60}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(boundary1.ports[1], tABSSystem1.port_a) annotation (Line(
      points={{90,20},{90,22},{100,22}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem1.port_b, bou1.ports[1]) annotation (Line(
      points={{126,22},{126,22},{144,22}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(boundary2.ports[1], tABSElement.port_a) annotation (Line(
      points={{-56,-64},{-42,-64}},
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
  connect(tABSSystem.T_FlowNominal, boundary.T_in) annotation (Line(points={{-32,
          14.7},{-82,14.7},{-82,26},{-68,26}}, color={0,0,127}));
  connect(tABSSystem.m_flowNominal, boundary.m_flow_in) annotation (Line(points=
         {{-32,16.8},{-90,16.8},{-90,30},{-68,30}}, color={0,0,127}));
  connect(tABSSystem.m_flowNominal, boundary2.m_flow_in) annotation (Line(
        points={{-32,16.8},{-94,16.8},{-94,-56},{-78,-56}}, color={0,0,127}));
  connect(tABSSystem.T_FlowNominal, boundary2.T_in) annotation (Line(points={{-32,
          14.7},{-88,14.7},{-88,-60},{-78,-60}}, color={0,0,127}));
  connect(tABSSystem1.T_FlowNominal, boundary1.T_in) annotation (Line(points={{100,
          14.8},{60,14.8},{60,24},{68,24}}, color={0,0,127}));
  connect(tABSSystem1.m_flowNominal, boundary1.m_flow_in) annotation (Line(
        points={{100,17.2},{50,17.2},{50,28},{68,28}}, color={0,0,127}));
  connect(const.y, tABSSystem.valveInput[1]) annotation (Line(points={{-37.3,57},
          {-37.3,43.5},{-28.04,43.5},{-28.04,28.9333}},
                                             color={0,0,127}));
  connect(const1.y, tABSSystem1.valveInput[1]) annotation (Line(points={{90.7,53},
          {90.7,42.5},{104.68,42.5},{104.68,31.0667}},
                                            color={0,0,127}));
  connect(tABSSystem.heatTABS[1], thermalTABS1.port_heat) annotation (Line(
        points={{-21,28},{-21,41},{-14,41},{-14,54}}, color={191,0,0}));
  connect(tABSSystem1.heatTABS[1], thermalTABS2.port_heat) annotation (Line(
        points={{113,30},{116,30},{116,50},{118,50}}, color={191,0,0}));
  connect(boundary3.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
      points={{108,-60},{108,-61},{122,-61}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(underfloorHeatingSystem.port_b, bou3.ports[1]) annotation (Line(
      points={{144,-61},{150,-61},{150,-60}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(fixedHeatFlow3.port,vol4. heatPort) annotation (Line(
      points={{94,-10},{142,-10}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(underfloorHeatingSystem.T_FlowNominal, boundary3.T_in) annotation (
      Line(points={{122,-67.3},{72,-67.3},{72,-56},{86,-56}}, color={0,0,127}));
  connect(underfloorHeatingSystem.m_flowNominal, boundary3.m_flow_in)
    annotation (Line(points={{122,-65.2},{64,-65.2},{64,-52},{86,-52}}, color={
          0,0,127}));
  connect(const2.y, underfloorHeatingSystem.valveInput[1]) annotation (Line(
        points={{116.7,-25},{116.7,-38.5},{125.96,-38.5},{125.96,-53.0667}},
        color={0,0,127}));
  connect(underfloorHeatingSystem.heatFloor[1], vol4.heatPort) annotation (Line(
        points={{133,-54},{134,-54},{134,-10},{142,-10}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {200,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{200,100}})));
end Discretisation_example;
