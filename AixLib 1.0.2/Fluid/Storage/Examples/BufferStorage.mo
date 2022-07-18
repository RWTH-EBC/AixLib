within AixLib.Fluid.Storage.Examples;
model BufferStorage

  extends Modelica.Icons.Example;
  import AixLib;
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;
  AixLib.Fluid.Storage.BufferStorage bufferStorage(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    m1_flow_nominal=const.k,
    m2_flow_nominal=boundary1.m_flow,
    mHC1_flow_nominal=boundary3.m_flow,
    n=10,
    redeclare package Medium = Medium,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil1=true,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart=303.15) annotation (Placement(transformation(extent={{0,0},{-20,24}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{-58,4},
            {-38,24}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    m_flow=0.2,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={22,46})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph5(          redeclare package Medium = Medium,
      nPorts=1)                                      annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={12,-20})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary1(
    m_flow=0,
    redeclare package Medium = Medium,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,46})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary2(
    m_flow=0,
    redeclare package Medium = Medium,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-46,-20})));
  Modelica.Blocks.Sources.Constant const(k=0.2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,38})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary3(
    m_flow=0.5*const.k,
    redeclare package Medium = Medium,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={14,20})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph1(redeclare package Medium = Medium, nPorts=1)
                                                     annotation(Placement(transformation(extent={{5,-5},{-5,5}},          rotation=0,     origin={13,7})));
equation
  connect(boundary.m_flow_in, const.y)
    annotation (Line(points={{34,38},{34,38},{51,38}}, color={0,0,127}));
  connect(boundary1.ports[1], bufferStorage.fluidportTop2) annotation (Line(points={{-34,46},{-14,46},{-14,24.12},{-13.125,24.12}}, color={0,127,255}));
  connect(bufferStorage.fluidportTop1, boundary.ports[1]) annotation (Line(points={{-6.5,24.12},{-6.5,45.06},{12,45.06},{12,46}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom1, boundary_ph5.ports[1]) annotation (Line(points={{-6.625,-0.24},{-6.625,-20.12},{2,-20.12},{2,-20}}, color={0,127,255}));
  connect(boundary2.ports[1], bufferStorage.fluidportBottom2) annotation (Line(points={{-36,-20},{-14,-20},{-14,-0.12},{-12.875,-0.12}}, color={0,127,255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (Line(points={{-38,14},{-30,14},{-30,12.72},{-19.75,12.72}}, color={191,0,0}));
  connect(boundary3.ports[1], bufferStorage.portHC1In) annotation (Line(points={{8,20},{6,20},{6,18.84},{0.25,18.84}}, color={0,127,255}));
  connect(boundary_ph1.ports[1], bufferStorage.portHC1Out) annotation (Line(points={{8,7},{4,7},{4,15.12},{0.125,15.12}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(Tolerance=1e-6, StopTime=86400, Interval=60),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Storage/Examples/BufferStorage.mos" "Simulate and plot"),
    Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  This is a simple example of a buffer storage that is charged with a
  mass flow with a higher temperature than the initial temperature.
</p>
<ul>
  <li>November 27, 2019, by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/793\">#793</a>:
    Add one heating coil to example.
  </li>
  <li>
    <i>October 11,2016</i> by Sebastian Stinner:<br/>
    implemented
  </li>
</ul>
</html>"));
end BufferStorage;
