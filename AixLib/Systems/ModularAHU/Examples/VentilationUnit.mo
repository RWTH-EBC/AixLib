within AixLib.Systems.ModularAHU.Examples;
model VentilationUnit "Example of the ventilation unit"
  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT boundaryOutsideAir(
    redeclare package Medium = Media.Air,
    p=105000,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,16})));
  Fluid.Sources.Boundary_pT SourceCooler(
    redeclare package Medium = Media.Water,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={-6,-52})));
  Fluid.Sources.Boundary_pT SinkSink(
    redeclare package Medium = Media.Water,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={14,-62})));
  Fluid.Sources.Boundary_pT SourceHeater(
    redeclare package Medium = Media.Water,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={20,-42})));
  Fluid.Sources.Boundary_pT SinkHeater(          redeclare package Medium =
        Media.Water, nPorts=1)
                     annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={42,-42})));
  AixLib.Systems.ModularAHU.VentilationUnit ventilationUnit(
    redeclare package Medium1 = Media.Air,
    redeclare package Medium2 = Media.Water,
    T_amb=293.15,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    cooler(
      redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        length=1,
        Kv=6.3,
redeclare AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
      dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=10000)),
    heater(
      redeclare AixLib.Systems.HydraulicModules.Admix hydraulicModule(
        length=0.5,
        Kv=6.3,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))),
      dynamicHX(
        dp1_nominal=10,
        dp2_nominal=1000,
        dT_nom=10,
        Q_nom=2000)))
    annotation (Placement(transformation(extent={{-18,-6},{44,54}})));
  Fluid.Sources.Boundary_pT boundaryExhAir(
    redeclare package Medium = Media.Air,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-76,44})));
  Controller.CtrVentilationUnitBasic ctrVentilationUnitBasic(TFlowSet=293.15,
      VFlowSet=1000/3600)
    annotation (Placement(transformation(extent={{-56,70},{-36,90}})));
equation
  connect(ventilationUnit.port_a3, SourceCooler.ports[1])
    annotation (Line(points={{-5.6,-6},{-6,-6},{-6,-44}}, color={0,127,255}));
  connect(ventilationUnit.port_b3, SinkSink.ports[1]) annotation (Line(points={{4.94,-6},
          {8,-6},{8,-54},{14,-54}},          color={0,127,255}));
  connect(SourceHeater.ports[1],ventilationUnit.port_a4)
    annotation (Line(points={{20,-34},{20,-6},{17.34,-6}},color={0,127,255}));
  connect(ventilationUnit.port_b4, SinkHeater.ports[1])
    annotation (Line(points={{27.88,-6},{42,-6},{42,-34}}, color={0,127,255}));
  connect(boundaryOutsideAir.ports[1], ventilationUnit.port_a1) annotation (
      Line(points={{-70,16},{-44,16},{-44,24},{-18,24}}, color={0,127,255}));
  connect(boundaryExhAir.ports[1], ventilationUnit.port_b2) annotation (Line(
        points={{-66,44},{-42,44},{-42,42},{-17.38,42}}, color={0,127,255}));
  connect(ventilationUnit.port_b1, ventilationUnit.port_a2) annotation (Line(
        points={{44.62,24},{52,24},{52,42},{44,42}}, color={0,127,255}));
  connect(ctrVentilationUnitBasic.genericAHUBus, ventilationUnit.genericAHUBus)
    annotation (Line(
      points={{-36,80.1},{-14,80.1},{-14,82},{13,82},{13,60.3}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=7200), Documentation(revisions="<html>
<ul>
<li>October 29, 2019, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>"));
end VentilationUnit;
