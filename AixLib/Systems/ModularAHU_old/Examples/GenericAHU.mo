within AixLib.Systems.ModularAHU_old.Examples;
model GenericAHU "Example of generic ahu model"
  extends Modelica.Icons.Example;
  AixLib.Systems.ModularAHU_old.GenericAHU genericAHU(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=293.15,
    m1_flow_nominal=3000/3600*1.2,
    m2_flow_nominal=0.5,
    T_start=293.15,
    usePreheater=true,
    useHumidifierRet=true,
    useHumidifier=true,
    perheater(redeclare AixLib.Systems.HydraulicModules_old.Admix
        hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=1,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))),
        dynamicHX(
        dp1_nominal=50,
        dp2_nominal=5000,
        tau1=5,
        tau2=15,
        dT_nom=30,
        Q_nom=30000)),
    cooler(redeclare AixLib.Systems.HydraulicModules_old.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=1,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per))),
        dynamicHX(
        dp1_nominal=80,
        dp2_nominal=1000,
        tau1=5,
        tau2=10,
        dT_nom=30,
        Q_nom=50000)),
    heater(redeclare AixLib.Systems.HydraulicModules_old.Admix hydraulicModule(
        dIns=0.01,
        kIns=0.028,
        d=0.032,
        length=1,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules_old.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per))),
        dynamicHX(
        dp1_nominal=50,
        dp2_nominal=5000,
        tau1=5,
        tau2=15,
        dT_nom=30,
        Q_nom=30000)),
    dynamicHX(
      dp1_nominal=200,
      dp2_nominal=200,
      dT_nom=2,
      Q_nom=30000),
    humidifier(
      dp_nominal=20,
      mWat_flow_nominal=1,
      TLiqWat_in=288.15),
    humidifierRet(
      dp_nominal=20,
      mWat_flow_nominal=0.5,
      TLiqWat_in=288.15))
    annotation (Placement(transformation(extent={{-60,-14},{60,52}})));
  Fluid.Sources.Boundary_pT boundaryOutsideAir(
    nPorts=1,
    redeclare package Medium = Media.Air,
    T=283.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,16})));
  Fluid.Sources.Boundary_pT boundarySupplyAir(nPorts=1, redeclare package
      Medium = Media.Air) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,16})));
  Fluid.Sources.Boundary_pT boundaryExhaustAir(nPorts=1, redeclare package
      Medium = Media.Air) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,40})));
  Fluid.Sources.Boundary_pT boundaryReturnAir(
    T=294.15,
    nPorts=1,
    redeclare package Medium = Media.Air) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,40})));
  Fluid.Sources.Boundary_pT SourcePreheater(
    nPorts=1,
    redeclare package Medium = Media.Water,
    T=333.15) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={-46,-40})));
  Fluid.Sources.Boundary_pT SinkPreheater(
    nPorts=1,
    redeclare package Medium = Media.Water,
    p=102000,
    T=283.15) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={-26,-40})));
  Fluid.Sources.Boundary_pT SourceCooler(
    nPorts=1,
    redeclare package Medium = Media.Water,
    T=283.15) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={-2,-40})));
  Fluid.Sources.Boundary_pT SinkSink(
    nPorts=1,
    redeclare package Medium = Media.Water,
    T=283.15) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={12,-40})));
  Fluid.Sources.Boundary_pT SourceHeater(
    nPorts=1,
    redeclare package Medium = Media.Water,
    T=333.15) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={32,-40})));
  Fluid.Sources.Boundary_pT SinkHeater(nPorts=1, redeclare package Medium =
        Media.Water) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={48,-40})));
  Controller.CtrAHUBasic ctrAHUBasic(
    TFlowSet=293.15,
    useTwoFanCont=true,
    VFlowSet=3000/3600,                               ctrRh(k=0.01))
    annotation (Placement(transformation(extent={{-40,62},{-20,82}})));
equation
  connect(boundaryReturnAir.ports[1], genericAHU.port_a2)
    annotation (Line(points={{70,40},{60.5455,40}}, color={0,127,255}));
  connect(boundarySupplyAir.ports[1], genericAHU.port_b1)
    annotation (Line(points={{70,16},{60.5455,16}}, color={0,127,255}));
  connect(boundaryOutsideAir.ports[1], genericAHU.port_a1)
    annotation (Line(points={{-70,16},{-60,16}}, color={0,127,255}));
  connect(boundaryExhaustAir.ports[1], genericAHU.port_b2)
    annotation (Line(points={{-70,40},{-60,40}}, color={0,127,255}));
  connect(SourcePreheater.ports[1], genericAHU.port_a3) annotation (Line(points={{-46,-32},
          {-46,-14},{-43.6364,-14}},           color={0,127,255}));
  connect(SinkPreheater.ports[1], genericAHU.port_b3) annotation (Line(points={{-26,-32},
          {-26,-14},{-32.7273,-14}},           color={0,127,255}));
  connect(SourceCooler.ports[1], genericAHU.port_a4) annotation (Line(points={{
          -2,-32},{-2,-14},{-7.10543e-15,-14}}, color={0,127,255}));
  connect(SinkSink.ports[1], genericAHU.port_b4) annotation (Line(points={{12,
          -32},{10,-32},{10,-14},{10.9091,-14}}, color={0,127,255}));
  connect(SourceHeater.ports[1], genericAHU.port_a5) annotation (Line(points={{32,-32},
          {30,-32},{30,-22},{20,-22},{20,-14},{21.8182,-14}},         color={0,
          127,255}));
  connect(SinkHeater.ports[1], genericAHU.port_b5) annotation (Line(points={{48,-32},
          {48,-26},{32.1818,-26},{32.1818,-14}},      color={0,127,255}));
  connect(ctrAHUBasic.genericAHUBus, genericAHU.genericAHUBus) annotation (Line(
      points={{-20,72.1},{0,72.1},{0,52.3},{-6.66134e-15,52.3}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=7200), Documentation(revisions="<html>
<ul>
<li>October 29, 2019, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>"));
end GenericAHU;
