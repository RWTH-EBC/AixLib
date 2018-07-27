within AixLib.Fluid.HydraulicModules.Example;
model ERC_ExperimentalHall_CoolingCircuit
  "Cooling circuit of the new ERC experimental hall"
  import AixLib;
  extends Modelica.Icons.Example;
  package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (choicesAllMatching=true);

  Sources.Boundary_pT              bou(                   nPorts=1, redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-182,-78},{-162,-58}})));
  HeatExchangers.ConstantEffectiveness              hex(
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium)
                    annotation (Placement(transformation(
        extent={{-20,-25},{20,25}},
        rotation=90,
        origin={-121,-48})));
  Sources.MassFlowSource_T              boundary(
    nPorts=1,
    m_flow=4,
    redeclare package Medium = Medium,
    T=280.15)
    annotation (Placement(transformation(extent={{-182,-38},{-162,-18}})));

  SimpleConsumer simpleConsumer(
    kA=2000,
    T_amb=293.15,
    m_flow_nominal=1,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-84,36},{-54,66}})));
  SimpleConsumer simpleConsumer1(
    kA=20000,
    T_amb=293.15,
    m_flow_nominal=1,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-12,34},{18,64}})));
  SimpleConsumer simpleConsumer2(
    kA=10000,
    m_flow_nominal=1,
    T_start=293.15)
    annotation (Placement(transformation(extent={{60,34},{90,64}})));
  Controls.HydraulicModules.CtrAdmix ctr_admix(
    Td=0,
    Ti=180,
    k=0.12) annotation (Placement(transformation(extent={{-142,-2},{-116,24}})));
  Controls.HydraulicModules.CtrUnmixed ctr_unmixed_simple
    annotation (Placement(transformation(extent={{-142,80},{-118,104}})));
  Controls.HydraulicModules.CtrUnmixed ctr_unmixed_simple1
    annotation (Placement(transformation(extent={{-142,58},{-118,82}})));
  Sources.Boundary_pT              bou1(
    nPorts=1,
    p=200000,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-106,-86})));
  AixLib.Fluid.HydraulicModules.Unmixed Unmixed(redeclare package Medium = Medium,
    redeclare
      AixLib.Fluid.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    m_flow_nominal=1,
    T_amb=293.15,
    pipe1(
      dIns=0.01,
      kIns=0.028,
      length=2),
    pipe2(
      dIns=0.01,
      kIns=0.028,
      length=2),
    pipe3(
      dIns=0.01,
      kIns=0.028,
      length=4))
    annotation (Placement(
        transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={3,7})));
  AixLib.Fluid.HydraulicModules.Unmixed Unmixed1(
                                                redeclare package Medium = Medium,
    redeclare
      AixLib.Fluid.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    T_amb=293.15,
    m_flow_nominal=1,
    pipe1(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe2(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe3(
      length=1,
      dIns=0.01,
      kIns=0.028))
    annotation (Placement(
        transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={75,7})));
  AixLib.Fluid.HydraulicModules.Admix Admix(
    redeclare package Medium = Medium,
    redeclare
      AixLib.Fluid.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    m_flow_nominal=1,
    pipe1(
      dIns=0.001,
      length=1,
      kIns=0.028),
    pipe2(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe5(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe6(
      length=1,
      dIns=0.01,
      kIns=0.028),
    val(Kv=10),
    T_amb=293.15,
    pipe3(
      dIns=0.01,
      kIns=0.028,
      length=4),
    pipe4(
      dIns=0.01,
      kIns=0.028,
      length=5))                    annotation (Placement(transformation(
        extent={{-25,-25},{25,25}},
        rotation=90,
        origin={-69,7})));
equation
  connect(bou.ports[1],hex. port_a1) annotation (Line(points={{-162,-68},{-136,
          -68}},                         color={0,127,255}));
  connect(boundary.ports[1],hex. port_b1) annotation (Line(points={{-162,-28},{
          -136,-28}},                      color={0,127,255}));
  connect(bou1.ports[1], hex.port_b2)
    annotation (Line(points={{-106,-76},{-106,-68}}, color={0,127,255}));
  connect(Unmixed.port_b1, simpleConsumer1.port_a)
    annotation (Line(points={{-12,32},{-12,49}}, color={0,127,255}));
  connect(Unmixed.port_a2, simpleConsumer1.port_b)
    annotation (Line(points={{18,32},{18,49}}, color={0,127,255}));
  connect(Unmixed1.port_b1, simpleConsumer2.port_a)
    annotation (Line(points={{60,32},{60,49}}, color={0,127,255}));
  connect(Unmixed1.port_a2, simpleConsumer2.port_b)
    annotation (Line(points={{90,32},{90,49}}, color={0,127,255}));
  connect(simpleConsumer.port_a, Admix.port_b1)
    annotation (Line(points={{-84,51},{-84,32}}, color={0,127,255}));
  connect(simpleConsumer.port_b, Admix.port_a2)
    annotation (Line(points={{-54,51},{-54,32}}, color={0,127,255}));
  connect(ctr_admix.hydraulicBus, Admix.hydraulicBus) annotation (Line(
      points={{-116.91,9.57},{-104.455,9.57},{-104.455,7},{-94,7}},
      color={255,204,51},
      thickness=0.5));
  connect(ctr_unmixed_simple1.hydraulicBus, Unmixed.hydraulicBus) annotation (
      Line(
      points={{-117.88,70},{-22,70},{-22,7}},
      color={255,204,51},
      thickness=0.5));
  connect(ctr_unmixed_simple.hydraulicBus, Unmixed1.hydraulicBus) annotation (
      Line(
      points={{-117.88,92},{-50,92},{-50,86},{50,86},{50,7}},
      color={255,204,51},
      thickness=0.5));
  connect(Admix.port_a1, hex.port_a2) annotation (Line(points={{-84,-18},{-84,-28},
          {-106,-28}}, color={0,127,255}));
  connect(Unmixed.port_a1, hex.port_a2) annotation (Line(points={{-12,-18},{-12,
          -28},{-106,-28}}, color={0,127,255}));
  connect(Unmixed1.port_a1, hex.port_a2) annotation (Line(points={{60,-18},{62,-18},
          {62,-28},{-106,-28}}, color={0,127,255}));
  connect(Unmixed1.port_b2, hex.port_b2) annotation (Line(points={{90,-18},{90,-68},
          {-106,-68}}, color={0,127,255}));
  connect(Unmixed.port_b2, hex.port_b2) annotation (Line(points={{18,-18},{18,-68},
          {-106,-68}}, color={0,127,255}));
  connect(Admix.port_b2, hex.port_b2) annotation (Line(points={{-54,-18},{-54,-68},
          {-106,-68}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-180,-100},{100,100}})), Icon(
        coordinateSystem(extent={{-180,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>This example demonstrates the use of the hydraulic modules. </p>
</html>"),
    experiment(StopTime=3600));
end ERC_ExperimentalHall_CoolingCircuit;
