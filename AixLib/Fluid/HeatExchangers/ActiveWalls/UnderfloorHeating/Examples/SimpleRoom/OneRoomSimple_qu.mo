within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.SimpleRoom;
model OneRoomSimple_qu "Example for underfloor heating system with two rooms for ideal upward and downward heat flow"
  extends Modelica.Icons.Example;
  package MediumAir = AixLib.Media.Air;
   package MediumWater = AixLib.Media.Water;
   parameter Modelica.SIunits.Area area=20;

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=area*3)
    annotation (Placement(transformation(extent={{-10,44},{10,64}})));
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
    Ceiling={true},
    wallTypeCeiling={
        UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},
    Spacing={0.35},
    PipeThickness={0.002},
    d_a={0.017},
    withSheathing=false)
    annotation (Placement(transformation(extent={{-32,-32},{18,-2}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[dis](each G=
        area/dis*10.8)
    annotation (Placement(transformation(extent={{-4,20},{-24,40}})));
  parameter Integer dis=100
    "Number of discretization layers for panel heating pipe";
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-232)
    annotation (Placement(transformation(extent={{58,-100},{38,-80}})));
  Modelica.Blocks.Sources.Constant const[1](each k=1)
    annotation (Placement(transformation(extent={{-100,6},{-86,20}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-26},{-78,-6}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{74,-28},{54,-8}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1
                                                                            [dis](each G=
        area/dis*5.8824)
    annotation (Placement(transformation(extent={{18,-76},{-2,-56}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=area*3)
    annotation (Placement(transformation(extent={{36,-76},{56,-56}})));
equation

  for i in 1:dis loop
    connect(thermalConductor[i].port_b, vol.heatPort) annotation (Line(points={{-24,30},
            {-34,30},{-34,54},{-10,54}},
                                       color={191,0,0}));
    connect(thermalConductor1[i].port_a, vol1.heatPort)
    annotation (Line(points={{18,-66},{36,-66}}, color={191,0,0}));
  end for;

  connect(const.y, underfloorHeatingSystem.valveInput) annotation (Line(points={{-85.3,
          13},{-23,13},{-23,0}},            color={0,0,127}));
  connect(boundary.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
        points={{-78,-16},{-56,-16},{-56,-17},{-32,-17}}, color={0,127,255}));
  connect(underfloorHeatingSystem.port_b, bou.ports[1]) annotation (Line(points={{18,-17},
          {38,-17},{38,-18},{54,-18}},          color={0,127,255}));
  connect(underfloorHeatingSystem.m_flowNominal, boundary.m_flow_in)
    annotation (Line(points={{-32,-26},{-40,-26},{-40,-24},{-68,-24},{-68,-30},{
          -106,-30},{-106,-8},{-100,-8}},   color={0,0,127}));
  connect(underfloorHeatingSystem.T_FlowNominal, boundary.T_in) annotation (
      Line(points={{-32,-30.5},{-62,-30.5},{-62,-38},{-114,-38},{-114,-12},{-100,
          -12}}, color={0,0,127}));
  connect(thermalConductor.port_a, underfloorHeatingSystem.heatFloor)
    annotation (Line(points={{-4,30},{-2,30},{-2,28},{4,28},{4,8},{-7,8},{-7,-2}},
                 color={191,0,0}));
  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,84},{-16,
          84},{-16,54},{-10,54}}, color={191,0,0}));
  connect(underfloorHeatingSystem.heatCeiling, thermalConductor1.port_b)
    annotation (Line(points={{-7,-32},{-7,-49},{-2,-49},{-2,-66}}, color={191,0,
          0}));

  connect(fixedHeatFlow1.port, vol1.heatPort) annotation (Line(points={{38,-90},
          {28,-90},{28,-66},{36,-66}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=8640000));
end OneRoomSimple_qu;
