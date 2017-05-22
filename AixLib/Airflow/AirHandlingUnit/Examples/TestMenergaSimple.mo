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
    annotation (Placement(transformation(extent={{-92,6},{-72,26}})));
  Fluid.Sources.Boundary_pT outsideAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    nPorts=1,
    p=100000,
    T=283.15) "Source for outside air"
    annotation (Placement(transformation(extent={{104,12},{84,32}})));
  MenergaSimple menergaSimple
    annotation (Placement(transformation(extent={{-48,10},{52,56}})));
  Fluid.Sources.Boundary_pT exhaustAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.03,0.97},
    p=100000,
    T=296.15) "Source for exhaust air"
    annotation (Placement(transformation(extent={{-92,52},{-72,72}})));
  Fluid.Sources.Boundary_pT exitAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.01,0.99},
    p=100000,
    T=283.15) "Sink für exit air" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,86})));
equation
  connect(outsideAir.ports[1], menergaSimple.externalAir) annotation (Line(
        points={{84,22},{51.4,22},{51.4,22.6}}, color={0,127,255}));
  connect(supplyAir.ports[1], menergaSimple.SupplyAir) annotation (Line(points=
          {{-72,16},{-68,16},{-68,20},{-46.4,20},{-46.4,22.6}}, color={0,127,
          255}));
  connect(exhaustAir.ports[1], menergaSimple.exhaustAir) annotation (Line(
        points={{-72,62},{-66,62},{-66,56},{-46.4,56},{-46.4,50.4}}, color={0,
          127,255}));
  connect(exitAir.ports[1], menergaSimple.ExitAir) annotation (Line(points={{
          -1.77636e-015,76},{-1.77636e-015,53.8},{3.2,53.8}}, color={0,127,255}));
end TestMenergaSimple;
