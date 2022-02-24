within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.Examples;
model ROMvsHOMint
  extends Modelica.Icons.Example;
  package MediumAir = AixLib.Media.Air;
  package MediumWater = AixLib.Media.Water;
  parameter Modelica.SIunits.Area area=20;
  parameter Integer dis=100;
  parameter Modelica.SIunits.MassFlowRate m_flow_total=0.05
    "Total mass flow in the panel heating system";
  parameter Modelica.SIunits.Temperature T_start=278.15                                     "Initial temperature";
  parameter Modelica.SIunits.Power Q_Nf=500 "Initial temperature";
  parameter Modelica.Fluid.Types.Dynamics energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance for wall capacities: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics"));

  TABSSystem  tABSSystem(
    redeclare package Medium = MediumWater,
    RoomNo=1,
    dis=dis,
    Q_Nf={700},
    calculateVol=1,
    A={area},
    T_Room={278.15},
    Spacing={0.35},
    use_vmax=1,
    wallTypeFloor={
        BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},
    wallTypeCeiling={BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},
    PipeRecord={BaseClasses.Piping.PBpipe()})
    annotation (Placement(transformation(extent={{-42,-40},{-20,-26}})));
  Modelica.Blocks.Sources.Constant const(each k=1)
    annotation (Placement(transformation(extent={{-58,-12},{-44,2}})));
  RCTABS thermalTABS1(
    External=false,
    UpperTABS=BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate(),
    LowerTABS=BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    A=area,
    OrientationTabs=-0.017453292519943,
    T_start=T_start,
    energyDynamics=energyDynamicsWalls)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-12,4})));

  MixingVolumes.MixingVolume ROM_vol(
    redeclare package Medium = MediumAir,
    T_start=T_start,
    m_flow_nominal=0.1,
    V=20*3) annotation (Placement(transformation(extent={{-8,18},{12,38}})));
  Sources.MassFlowSource_T              boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    m_flow=m_flow_total,
    use_T_in=true,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-76,-42},{-56,-22}})));
  Sources.Boundary_pT              bou(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{6,-42},{-14,-22}})));

  TABSSystem  tABSSystem1(
    redeclare package Medium = MediumWater,
    Reduced=false,
    RoomNo=1,
    dis=100,
    Q_Nf={700},
    calculateVol=1,
    A={area},
    T_Room={278.15},
    Spacing={0.35},
    use_vmax=1,
    wallTypeFloor={
        BaseClasses.Flooring.FLpartition_EnEV2009_SM_upHalf_UFH_Laminate()},
    wallTypeCeiling={BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},
    PipeRecord={BaseClasses.Piping.PBpipe()})
    annotation (Placement(transformation(extent={{108,-26},{130,-12}})));

  Modelica.Blocks.Sources.Constant const2(each k=1)
    annotation (Placement(transformation(extent={{92,-4},{106,10}})));
  MixingVolumes.MixingVolume HOM_vol(
    redeclare package Medium = MediumAir,
    T_start=T_start,
    m_flow_nominal=0.1,
    V=20*3) annotation (Placement(transformation(extent={{128,22},{148,42}})));
  Sources.MassFlowSource_T              boundary3(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    m_flow=m_flow_total,
    use_T_in=true,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{74,-28},{94,-8}})));
  Sources.Boundary_pT              bou3(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{156,-28},{136,-8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                                      prescribedHeatFlow
    annotation (Placement(transformation(extent={{-50,18},{-30,38}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                                      prescribedHeatFlow3
    annotation (Placement(transformation(extent={{60,22},{80,42}})));
  Modelica.Blocks.Sources.Step m_flow(
    height=0.5,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-110,-22},{-94,-6}})));
  Modelica.Blocks.Sources.Step T_in(
    height=40,
    offset=278.15,
    startTime=1E5)
    annotation (Placement(transformation(extent={{-108,-50},{-92,-34}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2)
    annotation (Placement(transformation(extent={{-78,22},{-64,36}})));
  Modelica.Blocks.Sources.Step m_flow1(
    height=1,
    offset=0,
    startTime=1E5)
    annotation (Placement(transformation(extent={{-112,4},{-96,20}})));
  Modelica.Blocks.Sources.Cosine   cosine(
    amplitude=200/2,
    freqHz(displayUnit="Hz") = 1/86400,
    offset=-200/2,
    startTime=1E5)
    annotation (Placement(transformation(extent={{-112,30},{-98,44}})));

  Modelica.Blocks.Sources.Step m_flow4(
    height=0.5,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{34,-8},{50,8}})));
  Modelica.Blocks.Sources.Step T_in3(
    height=40,
    offset=278.15,
    startTime=1E5)
    annotation (Placement(transformation(extent={{34,-36},{50,-20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_4(R=0.0001)
                      annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-22,28})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor RTabs_Up_2(R=0.0001)
                      annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={100,32})));
protected
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTAir
    "Room air temperature"
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=0,
        origin={11,3})));
equation
  for i in 1:dis loop
  end for;
  connect(boundary.ports[1], tABSSystem.port_a) annotation (Line(
      points={{-56,-32},{-56,-33},{-42,-33}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem.port_b, bou.ports[1]) annotation (Line(
      points={{-20,-33},{-14,-33},{-14,-32}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem.heatTABS[1], thermalTABS1.port_heat) annotation (Line(
        points={{-31,-26},{-31,-13},{-2,-13},{-2,4}}, color={191,0,0}));
  connect(boundary3.ports[1], tABSSystem1.port_a) annotation (Line(
      points={{94,-18},{94,-19},{108,-19}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(tABSSystem1.port_b, bou3.ports[1]) annotation (Line(
      points={{130,-19},{136,-19},{136,-18}},
      color={0,127,255},
      smooth=Smooth.Bezier));
  connect(const2.y, tABSSystem1.valveInput[1]) annotation (Line(points={{106.7,3},
          {106.7,3.5},{111.96,3.5},{111.96,-11.0667}},    color={0,0,127}));
  connect(cosine.y, multiProduct.u[1]) annotation (Line(points={{-97.3,37},{
          -89.65,37},{-89.65,31.45},{-78,31.45}}, color={0,0,127}));
  connect(m_flow1.y, multiProduct.u[2]) annotation (Line(points={{-95.2,12},{
          -90,12},{-90,26.55},{-78,26.55}}, color={0,0,127}));
  connect(m_flow.y, boundary.m_flow_in) annotation (Line(points={{-93.2,-14},{
          -86,-14},{-86,-24},{-78,-24}},
                                      color={0,0,127}));
  connect(T_in.y, boundary.T_in) annotation (Line(points={{-91.2,-42},{-86,-42},
          {-86,-28},{-78,-28}},
                             color={0,0,127}));
  connect(const.y, tABSSystem.valveInput[1]) annotation (Line(points={{-43.3,-5},
          {-43.3,-15.5},{-38.04,-15.5},{-38.04,-25.0667}},
                                                        color={0,0,127}));
  connect(multiProduct.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-62.81,
          29},{-56.405,29},{-56.405,28},{-50,28}},        color={0,0,127}));
  connect(multiProduct.y, prescribedHeatFlow3.Q_flow) annotation (Line(points={{-62.81,
          29},{-62.81,42},{16,42},{16,32},{60,32}},             color={0,0,127}));
  connect(T_in3.y, boundary3.T_in) annotation (Line(points={{50.8,-28},{60,-28},
          {60,-14},{72,-14}}, color={0,0,127}));
  connect(m_flow4.y, boundary3.m_flow_in) annotation (Line(points={{50.8,0},{62,
          0},{62,-10},{72,-10}},      color={0,0,127}));
  connect(prescribedHeatFlow.port, RTabs_Up_4.port_b)
    annotation (Line(points={{-30,28},{-26,28}}, color={191,0,0}));
  connect(RTabs_Up_4.port_a, ROM_vol.heatPort)
    annotation (Line(points={{-18,28},{-8,28}}, color={191,0,0}));
  connect(prescribedHeatFlow3.port, RTabs_Up_2.port_b)
    annotation (Line(points={{80,32},{96,32}},    color={191,0,0}));
  connect(RTabs_Up_2.port_a, HOM_vol.heatPort)
    annotation (Line(points={{104,32},{128,32}},   color={191,0,0}));
  connect(thermalTABS1.port_int, ROM_vol.heatPort) annotation (Line(points={{-12,14},
          {-10,14},{-10,28},{-8,28}},         color={191,0,0}));
  connect(tABSSystem1.heatTABS[1], HOM_vol.heatPort) annotation (Line(points={{
          119,-12},{119,10},{128,10},{128,32}}, color={191,0,0}));
  connect(senTAir.port, ROM_vol.heatPort) annotation (Line(points={{6,3},{2,3},
          {2,16},{-8,16},{-8,28}}, color={191,0,0}));
  connect(senTAir.T, thermalTABS1.TAir) annotation (Line(points={{16,3},{20,3},
          {20,-14},{-16,-14},{-16,-7}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -60},{160,60}})),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-60},{160,60}})));
end ROMvsHOMint;
