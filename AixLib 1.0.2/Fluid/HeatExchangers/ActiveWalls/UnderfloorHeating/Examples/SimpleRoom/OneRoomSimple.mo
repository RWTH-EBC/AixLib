within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.SimpleRoom;
model OneRoomSimple "Example for underfloor heating system with one ideal room"
  extends Modelica.Icons.Example;
  package MediumAir = AixLib.Media.Air;
   package MediumWater = AixLib.Media.Water;
   parameter Modelica.SIunits.Area area=20;

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=area*3)
    annotation (Placement(transformation(extent={{-10,12},{10,32}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=-1000)
    annotation (Placement(transformation(extent={{-40,74},{-20,94}})));
  UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
    redeclare package Medium = MediumWater,
    RoomNo=1,
    dis=dis,
    Q_Nf=-1.*{fixedHeatFlow.Q_flow},
    A={area},
    wallTypeFloor={
        UnderfloorHeating.BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH()},
    PipeRecord={BaseClasses.Piping.PBpipe()},
    wallTypeCeiling={
        UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy()},
    Spacing={0.35})
    annotation (Placement(transformation(extent={{-28,-64},{22,-34}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        area*10.8)
    annotation (Placement(transformation(extent={{-4,-12},{-24,8}})));
  parameter Integer dis=100
    "Number of discretization layers for panel heating pipe";
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=0)
    annotation (Placement(transformation(extent={{58,-100},{38,-80}})));
  Modelica.Blocks.Sources.Constant const[1](each k=1)
    annotation (Placement(transformation(extent={{-100,-26},{-86,-12}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-58},{-78,-38}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{74,-60},{54,-40}})));
equation

   connect(fixedHeatFlow1.port, underfloorHeatingSystem.heatCeiling[1])
    annotation (Line(points={{38,-90},{20,-90},{20,-92},{-3,-92},{-3,-64}},
        color={191,0,0}));
   connect(thermalConductor.port_b, vol.heatPort) annotation (Line(points={{-24,-2},
          {-34,-2},{-34,22},{-10,22}}, color={191,0,0}));

  connect(const.y, underfloorHeatingSystem.valveInput) annotation (Line(points={{-85.3,
          -19},{-19,-19},{-19,-32}},        color={0,0,127}));
  connect(boundary.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
        points={{-78,-48},{-56,-48},{-56,-49},{-28,-49}}, color={0,127,255}));
  connect(underfloorHeatingSystem.port_b, bou.ports[1]) annotation (Line(points={{22,-49},
          {38,-49},{38,-50},{54,-50}},          color={0,127,255}));
  connect(underfloorHeatingSystem.m_flowNominal, boundary.m_flow_in)
    annotation (Line(points={{-28,-58},{-40,-58},{-40,-56},{-68,-56},{-68,-62},{
          -106,-62},{-106,-40},{-100,-40}}, color={0,0,127}));
  connect(underfloorHeatingSystem.T_FlowNominal, boundary.T_in) annotation (
      Line(points={{-28,-62.5},{-62,-62.5},{-62,-70},{-114,-70},{-114,-44},{-100,
          -44}}, color={0,0,127}));
  connect(thermalConductor.port_a, underfloorHeatingSystem.heatFloor[1])
    annotation (Line(points={{-4,-2},{-2,-2},{-2,-4},{4,-4},{4,-24},{-3,-24},{-3,
          -34}}, color={191,0,0}));
  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,84},{-14,
          84},{-14,22},{-10,22}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OneRoomSimple;
