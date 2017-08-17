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
    annotation (Placement(transformation(extent={{-100,-38},{-80,-18}})));
  Fluid.Sources.Boundary_pT outsideAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    nPorts=1,
    p=100000,
    T=283.15) "Source for outside air"
    annotation (Placement(transformation(extent={{100,-24},{80,-4}})));
  MenergaSimple menergaSimple
    annotation (Placement(transformation(extent={{-48,-36},{52,10}})));
  Fluid.Sources.Boundary_pT exhaustAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.03,0.97},
    p=100000,
    T=296.15) "Source for exhaust air"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Fluid.Sources.Boundary_pT exitAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.01,0.99},
    p=100000,
    T=283.15) "Sink für exit air" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,40})));
  BaseClasses.Controllers.MenergaController menergaController
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Fluid.Sources.Boundary_pT WatSou(
    nPorts=1,
    redeclare package Medium = MediumWater,
    T=318.15) "Water source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-72})));
  Modelica.Fluid.Sources.Boundary_pT WatSin(nPorts=1, redeclare package Medium =
        MediumWater) "Water sink" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-72})));
equation
  connect(outsideAir.ports[1], menergaSimple.outsideAir) annotation (Line(
        points={{80,-14},{51,-14},{51,-14.2}}, color={0,127,255}));
  connect(supplyAir.ports[1],menergaSimple.supplyAir)  annotation (Line(points={{-80,-28},
          {-80,-27.6},{-46.8,-27.6}},                           color={0,127,
          255}));
  connect(exhaustAir.ports[1], menergaSimple.exhaustAir) annotation (Line(
        points={{-80,0},{-47,-0.2}},                                 color={0,
          127,255}));
  connect(exitAir.ports[1], menergaSimple.ExitAir) annotation (Line(points={{
          -1.77636e-015,30},{-1.77636e-015,8.2},{0.4,8.2}},   color={0,127,255}));
  connect(menergaController.busActors, menergaSimple.busActors) annotation (
      Line(
      points={{10,76.4},{29.8,76.4},{29.8,12},{21.2,12},{21.2,10}},
      color={255,204,51},
      thickness=0.5));
  connect(menergaSimple.busSensors, menergaController.busSensors) annotation (
      Line(
      points={{-16.2,10},{-16.2,12},{-28,12},{-28,76.6},{-10,76.6}},
      color={255,204,51},
      thickness=0.5));
  connect(WatSou.ports[1], menergaSimple.watInlHeaCoi) annotation (Line(points=
          {{-40,-62},{-34,-62},{-34,-36},{-26,-36}}, color={0,127,255}));
  connect(WatSin.ports[1], menergaSimple.watOutHeaCoi) annotation (Line(points=
          {{6.66134e-016,-62},{-8,-62},{-8,-36},{-23.8,-36}}, color={0,127,255}));
  annotation (experiment(StopTime=1800, Interval=10));
end TestMenergaSimple;
