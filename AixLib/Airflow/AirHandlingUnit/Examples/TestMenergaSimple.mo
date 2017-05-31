within AixLib.Airflow.AirHandlingUnit.Examples;
model TestMenergaSimple
  "Example model to test the MenergaSimple model"


    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT supplyAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.02,0.98},
    p=100000,
    T=294.15) "Sink for supply air"
    annotation (Placement(transformation(extent={{-98,-34},{-78,-14}})));
  Fluid.Sources.Boundary_pT outsideAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    nPorts=1,
    p=100000,
    T=283.15) "Source for outside air"
    annotation (Placement(transformation(extent={{102,-34},{82,-14}})));
  MenergaSimple menergaSimple
    annotation (Placement(transformation(extent={{-48,-36},{52,10}})));
  Fluid.Sources.Boundary_pT exhaustAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.03,0.97},
    p=100000,
    T=296.15) "Source for exhaust air"
    annotation (Placement(transformation(extent={{-92,-6},{-72,14}})));
  Fluid.Sources.Boundary_pT exitAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.01,0.99},
    p=100000,
    T=283.15) "Sink für exit air" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,88})));
  BaseClasses.Controllers.MenergaController menergaController
    annotation (Placement(transformation(extent={{-24,60},{-4,80}})));
equation
  connect(outsideAir.ports[1], menergaSimple.externalAir) annotation (Line(
        points={{82,-24},{51.4,-24},{51.4,-23.4}},
                                                color={0,127,255}));
  connect(supplyAir.ports[1], menergaSimple.SupplyAir) annotation (Line(points={{-78,-24},
          {-78,-23.4},{-46.4,-23.4}},                           color={0,127,
          255}));
  connect(exhaustAir.ports[1], menergaSimple.exhaustAir) annotation (Line(
        points={{-72,4},{-46.4,4.4}},                                color={0,
          127,255}));
  connect(exitAir.ports[1], menergaSimple.ExitAir) annotation (Line(points={{70,78},
          {70,7.8},{3.2,7.8}},                                color={0,127,255}));
  connect(menergaController.busController, menergaSimple.busController)
    annotation (Line(
      points={{-4.2,70.2},{-4.2,40.1},{-3.2,40.1},{-3.2,10.4}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=1800, Interval=10));
end TestMenergaSimple;
