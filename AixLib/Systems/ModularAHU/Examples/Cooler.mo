within AixLib.Systems.ModularAHU.Examples;
model Cooler "Cooler register example"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  package MediumAir = AixLib.Media.Air
    annotation (choicesAllMatching=true);

  RegisterModule registerModule(
    T_start=297.15,
    redeclare HydraulicModules.ThrottlePump hydraulicModule(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
      parameterIso=AixLib.DataBase.Pipes.Insulation.Iso25pc(),
      length=1,
      Kv=6.3,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2
            per))),
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=1,
    m2_flow_nominal=0.1,
    redeclare package Medium1 = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    dynamicHX(
      dp1_nominal=100,
      dp2_nominal=6000,
      dT_nom=20,
      Q_nom=30000,
      redeclare AixLib.Fluid.MixingVolumes.MixingVolume vol1,
      redeclare AixLib.Fluid.MixingVolumes.MixingVolume vol2),
    hydraulicModuleIcon="ThrottlePump",
    T_amb=293.15)
    annotation (Placement(transformation(extent={{-40,-46},{26,40}})));
  Fluid.Sources.Boundary_pT boundaryWaterSource(
    p=300000,
    nPorts=1,
    redeclare package Medium = MediumWater,
    T=279.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-60,-60})));
  Fluid.Sources.Boundary_pT boundaryWaterSink(
    p=300000,                                 nPorts=1, redeclare package Medium =
               MediumWater) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={40,-60})));
  Fluid.Sources.Boundary_pT boundaryAirSource(
    nPorts=1,
    redeclare package Medium = MediumAir,
    p=102000,
    T=298.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,40})));
  Fluid.Sources.Boundary_pT boundaryAirSink(nPorts=1, redeclare package Medium =
        MediumAir) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,40})));
  Controller.CtrRegBasic ctrBasic(
    k=0.04,
    Ti=120,
    Td=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    reverseAction=false,
    useExternalTset=true,
    TflowSet=289.15,
    rpm_pump=1000)
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  Modelica.Blocks.Sources.Constant Tset(k=273.15 + 19)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(boundaryWaterSink.ports[1], registerModule.port_b2) annotation (Line(
        points={{40,-50},{40,-19.5385},{26,-19.5385}}, color={0,127,255}));
  connect(boundaryWaterSource.ports[1], registerModule.port_a2) annotation (
      Line(points={{-60,-50},{-60,-19.5385},{-40,-19.5385}}, color={0,127,255}));
  connect(registerModule.port_b1, boundaryAirSink.ports[1]) annotation (Line(
        points={{26,20.1538},{44,20.1538},{44,40},{70,40}},
                                                  color={0,127,255}));
  connect(registerModule.port_a1, boundaryAirSource.ports[1]) annotation (Line(
        points={{-40,20.1538},{-40,20},{-70,20},{-70,40}},     color={0,127,255}));
  connect(ctrBasic.registerBus, registerModule.registerBus) annotation (Line(
      points={{-51.4,2.22045e-16},{-46,2.22045e-16},{-46,-0.0230769},{-39.67,
          -0.0230769}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrBasic.Tset, Tset.y)
    annotation (Line(points={{-74,0},{-79,0}},     color={0,0,127}));
  annotation (Documentation(info="<html><p>
  This example demonstrates the use of the RegsterModule for a cooling
  register with throttle circuit. The controller gets an external set
  point temperature and controls the outflow air temperature.
</p>
<ul>
  <li>August 30, 2019, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"), experiment(StopTime=3600));
end Cooler;
