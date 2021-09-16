within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.Examples;
model RCTabs_example
  extends Modelica.Icons.Example;
  package MediumAir = AixLib.Media.Air;
  package MediumWater = AixLib.Media.Water;
  parameter Modelica.SIunits.Area area=20;
  parameter Integer dis=100;
  final parameter Modelica.SIunits.MassFlowRate m_flow_total=0.05
    "Total mass flow in the panel heating system";

  RCTabs rCTabs(
    dis=dis,    External=false,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    PipeRecord=BaseClasses.Piping.PBpipe(),
    A=area,
    Spacing=0.35)
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[dis](Q_flow=
        10, T_ref=298.15)
           annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  MixingVolumes.MixingVolume              vol4(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{-56,32},{-36,52}})));
  TABSCircuit tABSCircuit(
    redeclare package Medium = MediumWater,
    dis=dis,
    calculateVol=1,
    A=area,
    m_flow_Circuit=m_flow_total,
    Spacing=0.35,
    d_i=rCTabs1.PipeRecord.d[1] - 2*rCTabs1.PipeRecord.t[1],
    use_vmax=1)
    annotation (Placement(transformation(extent={{-8,-4},{12,4}})));
  Modelica.Blocks.Sources.Constant const(each k=1)
    annotation (Placement(transformation(extent={{-28,28},{-14,42}})));
  RCTabs rCTabs1(
    dis=dis,
    External=false,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    PipeRecord=BaseClasses.Piping.PBpipe(),
    A=area,
    Spacing=0.35)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,32})));

  MixingVolumes.MixingVolume              vol1(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{26,50},{46,70}})));
  Sources.MassFlowSource_T              boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
  Sources.Boundary_pT              bou(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  TABSSystem tABSSystem(
    redeclare package Medium = MediumWater,
    RoomNo=2,
    dis=dis,
    Q_Nf={700,700},
    A={20,30},
    Spacing={0.35,0.35},
    wallTypeFloor={BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
        BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},
    wallTypeCeiling={BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
        BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},
    PipeRecord={BaseClasses.Piping.PBpipe(),BaseClasses.Piping.PBpipe()})
    annotation (Placement(transformation(extent={{102,-10},{136,10}})));
  Sources.MassFlowSource_T              boundary1(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  Sources.Boundary_pT              bou1(redeclare package Medium = MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{172,-10},{152,10}})));
  RCTabs rCTabs2(
    dis=dis,
    External=false,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    PipeRecord=BaseClasses.Piping.PBpipe(),
    A=area,
    Spacing=0.35)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={120,40})));
  Modelica.Blocks.Sources.Constant const1[2](each k=1)
    annotation (Placement(transformation(extent={{78,24},{92,38}})));
  MixingVolumes.MixingVolume              vol2(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{102,68},{122,88}})));
  RCTabs rCTabs3(
    dis=dis,
    External=false,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    PipeRecord=BaseClasses.Piping.PBpipe(),
    A=area + 10,
    Spacing=0.35)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={170,44})));
  MixingVolumes.MixingVolume              vol3(
    redeclare package Medium = MediumAir,
    T_start=283.15,
    m_flow_nominal=0.1,
    V=30*3)
    annotation (Placement(transformation(extent={{152,72},{172,92}})));
equation
  for i in 1:dis loop
    connect(fixedHeatFlow[i].port, rCTabs.port_heat[i]) annotation (Line(
      points={{-82,0},{-66,0}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  end for;
  connect(vol4.heatPort, rCTabs.port_int) annotation (Line(
      points={{-56,42},{-56,42},{-56,10}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(const.y, tABSCircuit.valveInput) annotation (Line(
      points={{-13.3,35},{-11.65,35},{-11.65,5.8},{-5.4,5.8}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(rCTabs1.port_heat, tABSCircuit.heatTABS) annotation (Line(
      points={{10,32},{8,32},{8,3.8},{2,3.8}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(vol1.heatPort, rCTabs1.port_int) annotation (Line(
      points={{26,60},{22,60},{22,42},{20,42}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(boundary.ports[1], tABSCircuit.port_a) annotation (Line(
      points={{-16,0},{-16,0},{-8,0}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSCircuit.port_b, bou.ports[1]) annotation (Line(
      points={{12,0},{16,0},{20,0}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(boundary1.ports[1], tABSSystem.port_a) annotation (Line(
      points={{84,0},{94,0},{102,0}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem.port_b, bou1.ports[1]) annotation (Line(
      points={{136,0},{152,0},{152,0}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(vol2.heatPort, rCTabs2.port_int) annotation (Line(
      points={{102,78},{90,78},{90,50},{120,50}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  connect(const1.y, tABSSystem.valveInput) annotation (Line(
      points={{92.7,31},{92.7,21.5},{108.12,21.5},{108.12,11.3333}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(vol3.heatPort,rCTabs3. port_int) annotation (Line(
      points={{152,82},{148,82},{148,54},{170,54}},
      color={191,0,0},
      smooth=Smooth.Bezier));
  for m in 1:2 loop
    for i in 1:tABSSystem.CircuitNo[m] loop
      for v in 1:dis loop
        if m == 1 then
          connect(tABSSystem.heatTABS[v + dis*(i-1)], rCTabs2.port_heat[v + dis*(i-1)]) annotation (Line(
      points={{119,10},{119,25},{110,25},{110,40}},
      color={191,0,0},
      smooth=Smooth.Bezier));
        else
          connect(tABSSystem.heatTABS[v + dis*(i-1) + dis*tABSSystem.CircuitNo[m-1]], rCTabs3.port_heat[v + dis*(i-1)]) annotation (Line(
      points={{119,10},{139.5,10},{139.5,44},{160,44}},
      color={191,0,0},
      smooth=Smooth.Bezier));
        end if;
      end for;
    end for;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})));
end RCTabs_example;
