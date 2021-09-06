within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.SimpleRoom;
model OneRoomSimple_comparison
  "Example for underfloor heating system with one ideal room"
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
    Ceiling={false},
    wallTypeCeiling={BaseClasses.FloorLayers.Ceiling_Dummy()},
    Spacing={0.35},
    PipeThickness={0.002},
    d_a={0.017},
    withSheathing=false)
    annotation (Placement(transformation(extent={{-30,-64},{20,-34}})));

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
  MixingVolumes.MixingVolume              vol1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=area*3)
    annotation (Placement(transformation(extent={{188,14},{208,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=-1000)
    annotation (Placement(transformation(extent={{158,76},{178,96}})));
  UnderfloorHeatingSystem                   underfloorHeatingSystem1(
    redeclare package Medium = MediumWater,
    RoomNo=1,
    dis=dis,
    Q_Nf=-1.*{fixedHeatFlow.Q_flow},
    A={area},
    wallTypeFloor={
        testtabs.SimpleBuildingtesttabs.SimpleBuildingtesttabs_DataBase.SimpleBuildingtesttabs_tz_2_upperTABS()},
    Ceiling={false},
    Spacing={0.35},
    PipeThickness={0.002},
    d_a={0.017},
    withSheathing=false)
    annotation (Placement(transformation(extent={{168,-62},{218,-32}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=area*
        10.8)
    annotation (Placement(transformation(extent={{194,-10},{174,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow3(Q_flow=0)
    annotation (Placement(transformation(extent={{256,-98},{236,-78}})));
  Modelica.Blocks.Sources.Constant const1
                                        [1](each k=1)
    annotation (Placement(transformation(extent={{98,-24},{112,-10}})));
  Sources.MassFlowSource_T              boundary1(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,-56},{120,-36}})));
  Sources.Boundary_pT              bou1(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{272,-58},{252,-38}})));
equation

   connect(fixedHeatFlow1.port, underfloorHeatingSystem.heatCeiling[1])
    annotation (Line(points={{38,-90},{20,-90},{20,-92},{-5,-92},{-5,-64}},
        color={191,0,0}));
   connect(thermalConductor.port_b, vol.heatPort) annotation (Line(points={{-24,-2},
          {-34,-2},{-34,22},{-10,22}}, color={191,0,0}));

  connect(const.y, underfloorHeatingSystem.valveInput) annotation (Line(points={{-85.3,
          -19},{-21,-19},{-21,-32}},        color={0,0,127}));
  connect(boundary.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
        points={{-78,-48},{-56,-48},{-56,-49},{-30,-49}}, color={0,127,255}));
  connect(underfloorHeatingSystem.port_b, bou.ports[1]) annotation (Line(points={{20,-49},
          {38,-49},{38,-50},{54,-50}},          color={0,127,255}));
  connect(underfloorHeatingSystem.m_flowNominal, boundary.m_flow_in)
    annotation (Line(points={{-30,-58},{-40,-58},{-40,-56},{-68,-56},{-68,-62},
          {-106,-62},{-106,-40},{-100,-40}},color={0,0,127}));
  connect(underfloorHeatingSystem.T_FlowNominal, boundary.T_in) annotation (
      Line(points={{-30,-62.5},{-62,-62.5},{-62,-70},{-114,-70},{-114,-44},{
          -100,-44}},
                 color={0,0,127}));
  connect(thermalConductor.port_a, underfloorHeatingSystem.heatFloor[1])
    annotation (Line(points={{-4,-2},{-2,-2},{-2,-4},{4,-4},{4,-24},{-5,-24},{
          -5,-34}},
                 color={191,0,0}));
  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,84},{-14,
          84},{-14,22},{-10,22}}, color={191,0,0}));
  connect(fixedHeatFlow3.port, underfloorHeatingSystem1.heatCeiling[1])
    annotation (Line(points={{236,-88},{218,-88},{218,-90},{193,-90},{193,-62}},
        color={191,0,0}));
  connect(thermalConductor1.port_b, vol1.heatPort) annotation (Line(points={{
          174,0},{164,0},{164,24},{188,24}}, color={191,0,0}));
  connect(const1.y, underfloorHeatingSystem1.valveInput) annotation (Line(
        points={{112.7,-17},{177,-17},{177,-30}}, color={0,0,127}));
  connect(boundary1.ports[1], underfloorHeatingSystem1.port_a) annotation (Line(
        points={{120,-46},{142,-46},{142,-47},{168,-47}}, color={0,127,255}));
  connect(underfloorHeatingSystem1.port_b, bou1.ports[1]) annotation (Line(
        points={{218,-47},{236,-47},{236,-48},{252,-48}}, color={0,127,255}));
  connect(underfloorHeatingSystem1.m_flowNominal, boundary1.m_flow_in)
    annotation (Line(points={{168,-56},{158,-56},{158,-54},{130,-54},{130,-60},{
          92,-60},{92,-38},{98,-38}},  color={0,0,127}));
  connect(underfloorHeatingSystem1.T_FlowNominal, boundary1.T_in) annotation (
      Line(points={{168,-60.5},{136,-60.5},{136,-68},{84,-68},{84,-42},{98,-42}},
        color={0,0,127}));
  connect(thermalConductor1.port_a, underfloorHeatingSystem1.heatFloor[1])
    annotation (Line(points={{194,0},{196,0},{196,-2},{202,-2},{202,-22},{193,-22},
          {193,-32}},      color={191,0,0}));
  connect(fixedHeatFlow2.port, vol1.heatPort) annotation (Line(points={{178,86},
          {184,86},{184,24},{188,24}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{280,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{280,
            100}})));
end OneRoomSimple_comparison;
