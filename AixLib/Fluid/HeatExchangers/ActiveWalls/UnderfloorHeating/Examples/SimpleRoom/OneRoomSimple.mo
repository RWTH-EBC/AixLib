within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.SimpleRoom;
model OneRoomSimple "Example for underfloor heating system with one ideal room"
  extends Modelica.Icons.Example;
  package MediumAir = AixLib.Media.Air;
   package MediumWater = AixLib.Media.Water;
   parameter Modelica.Units.SI.Area area=20;

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=area*3)
    annotation (Placement(transformation(extent={{-10,12},{10,32}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=-1000)
    annotation (Placement(transformation(extent={{-40,74},{-20,94}})));
  UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
    redeclare package Medium = MediumWater,
    nZones=1,
    dis=dis,
    Q_flow_nominal=-1.*{fixedHeatFlow.Q_flow},
    A={area},
    wallTypeFloor={Data.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH()},
    Ceiling={false},
    wallTypeCeiling={Data.FloorLayers.Ceiling_Dummy()},
    spa={0.35},
    sPip={0.002},
    dOut={0.017},
    withSheathing=false)
    annotation (Placement(transformation(extent={{-32,-64},{18,-34}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[dis](
      each G=area/dis*10.8)
    annotation (Placement(transformation(extent={{-4,-12},{-24,8}})));
  parameter Integer dis=100
    "Number of discretization layers for panel heating pipe";
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=0)
    annotation (Placement(transformation(extent={{58,-100},{38,-80}})));
  Modelica.Blocks.Sources.Constant const[1](each k=1)
    annotation (Placement(transformation(extent={{-100,-26},{-86,-12}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    m_flow=underfloorHeatingSystem.m_flow_nominal,
    T=underfloorHeatingSystem.TSup_nominal,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-58},{-78,-38}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{74,-60},{54,-40}})));

  Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort annotation (
     Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=270,
        origin={-12,-8})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
    annotation (Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=90,
        origin={-12,-86})));
  BaseClasses.RadConvToSingle radConvToSingle
    annotation (Placement(transformation(extent={{24,12},{44,32}})));
  BaseClasses.RadConvToSingle radConvToSingle1
    annotation (Placement(transformation(extent={{46,-96},{26,-76}})));
equation

  for i in 1:dis loop
    connect(thermalConductor[i].port_b, vol.heatPort) annotation (Line(points={{-24,-2},
            {-22,-2},{-22,22},{-10,22}},
                                       color={191,0,0}));
    connect(radConvToSingle.portCon, thermalConductor[i].port_a) annotation (
        Line(points={{24,28},{10,28},{10,-2},{-4,-2}}, color={191,0,0}));
  end for;

  for i in 1:underfloorHeatingSystem.nZones loop
    connect(convRadToCombPort1.portConv, underfloorHeatingSystem.portConCei[i]) annotation (Line(points={{-7,-76},
            {-7,-72},{3,-72},{3,-67.3333}},
        color={191,0,0}));
    connect(convRadToCombPort1.portRad, underfloorHeatingSystem.portRadCei[i])
    annotation (Line(points={{-17,-76},{-17,-67.3333},{-17,-67.3333}},
        color={0,0,0}));
    connect(underfloorHeatingSystem.portRadFloor[i], convRadToCombPort.portRad)
    annotation (Line(points={{-17,-34},{-20,-34},{-20,-18},{-17,-18}}, color={191,
          0,0}));
    connect(underfloorHeatingSystem.portConFloor[i], convRadToCombPort.portConv)
    annotation (Line(points={{3,-34},{-6,-34},{-6,-18},{-7,-18}},
                                                                color={191,0,0}));
  end for;

  connect(const.y, underfloorHeatingSystem.uVal) annotation (Line(points={{-85.3,
          -19},{-37,-19},{-37,-40.6667}},
                                     color={0,0,127}));
  connect(boundary.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
        points={{-78,-48},{-56,-48},{-56,-50.6667},{-32,-50.6667}},
                                                          color={0,127,255}));
  connect(underfloorHeatingSystem.port_b, bou.ports[1]) annotation (Line(points={{18,
          -50.6667},{38,-50.6667},{38,-50},{54,-50}},
                                                color={0,127,255}));
  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,84},{
          -10,84},{-10,22},{-10,22}},
                                  color={191,0,0}));


  connect(convRadToCombPort.portConvRadComb, radConvToSingle.heatFloor)
    annotation (Line(points={{-12,2},{62,2},{62,22},{44,22}},color={191,0,0}));
  connect(fixedHeatFlow1.port, radConvToSingle1.portCon) annotation (Line(
        points={{38,-90},{42,-90},{42,-80},{46,-80}}, color={191,0,0}));
  connect(radConvToSingle1.heatFloor, convRadToCombPort1.portConvRadComb)
    annotation (Line(points={{26,-86},{-2,-86},{-2,-96},{-12,-96}},
                                                 color={191,0,0}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OneRoomSimple;
