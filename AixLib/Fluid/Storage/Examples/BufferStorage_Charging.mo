within AixLib.Fluid.Storage.Examples;
model BufferStorage_Charging

  extends Modelica.Icons.Example;
  import AixLib;
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;
  AixLib.Fluid.Storage.BufferStorage storage_Aixlib(
    n=10,
    redeclare package Medium = Medium,
    use_heatingCoil1=false,
    use_heatingCoil2=false,
    use_heatingRod=false,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    T_start=303.15,
    data=AixLib.DataBase.Storage.Generic_500l())
    annotation (Placement(transformation(extent={{0,0},{-20,24}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 283.15) annotation(Placement(transformation(extent={{-58,4},
            {-38,24}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    m_flow=0.2,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=343.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,46})));
  AixLib.Fluid.Sources.FixedBoundary
                      boundary_ph5(nPorts=1, redeclare package Medium = Medium)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={12,-20})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary1(
    nPorts=1,
    m_flow=0,
    redeclare package Medium = Medium,
    T=343.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,46})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary2(
    nPorts=1,
    m_flow=0,
    redeclare package Medium = Medium,
    T=343.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-46,-20})));
  Modelica.Blocks.Sources.Constant const(k=0.2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,38})));
equation
  connect(fixedTemperature.port, storage_Aixlib.heatport_outside) annotation (
      Line(points={{-38,14},{-30,14},{-30,12.72},{-19.75,12.72}}, color={191,0,0}));
  connect(storage_Aixlib.fluidport_top1, boundary.ports[1]) annotation (Line(
        points={{-6.5,24.12},{-5.25,24.12},{-5.25,46},{12,46}}, color={0,127,255}));
  connect(boundary_ph5.ports[1], storage_Aixlib.fluidport_bottom1) annotation (
      Line(points={{2,-20},{-8,-20},{-8,-0.24},{-6.625,-0.24}}, color={0,127,255}));
  connect(boundary1.ports[1], storage_Aixlib.fluidport_top2) annotation (Line(
        points={{-34,46},{-12,46},{-12,24.12},{-13.125,24.12}}, color={0,127,255}));
  connect(boundary2.ports[1], storage_Aixlib.fluidport_bottom2) annotation (
      Line(points={{-36,-20},{-14,-20},{-14,-0.12},{-12.875,-0.12}}, color={0,127,
          255}));
  connect(boundary.m_flow_in, const.y)
    annotation (Line(points={{32,38},{42,38},{51,38}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end BufferStorage_Charging;
