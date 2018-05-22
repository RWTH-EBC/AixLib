within AixLib.Airflow.AirHandlingUnit.Examples;
model TestMenergaNoControl
  "Example model to test the MenergaSimple model without any controller"

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
    p=100000,
    T=296.15,
    X={0.02,0.98})
              "Source for exhaust air"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Fluid.Sources.Boundary_pT exitAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    X={0.01,0.99},
    p=100000,
    T=283.15) "Sink für exit air" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,32})));
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
  Modelica.Blocks.Sources.Constant one(k=1) "Dummy signal"
    annotation (Placement(transformation(extent={{-18,80},{-4,94}})));
  Modelica.Blocks.Sources.BooleanConstant trueSingal "Dummy signal"
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Modelica.Blocks.Sources.Constant zero(k=300) "Dummy signal"
    annotation (Placement(transformation(extent={{-18,52},{-4,66}})));
  Modelica.Blocks.Sources.BooleanConstant falseSignal(k=false) "Dummy signal"
    annotation (Placement(transformation(extent={{100,50},{80,70}})));
  Modelica.Blocks.Sources.Constant zero1(k=0) "Dummy signal"
    annotation (Placement(transformation(extent={{-50,68},{-36,82}})));
  BaseClasses.BusActors busActors1 "Bus connector for actor signals"
    annotation (Placement(transformation(extent={{20,8},{60,48}})));
  Modelica.Blocks.Sources.Constant zero2(k=0) "Dummy signal"
    annotation (Placement(transformation(extent={{-50,38},{-36,52}})));
  Modelica.Blocks.Sources.Constant zero3(k=1) "Dummy signal"
    annotation (Placement(transformation(extent={{-50,12},{-36,26}})));
equation
  connect(outsideAir.ports[1], menergaSimple.outsideAir) annotation (Line(
        points={{80,-14},{51,-14},{51,-14.2}}, color={0,127,255}));
  connect(supplyAir.ports[1],menergaSimple.supplyAir)  annotation (Line(points={{-80,-28},
          {-80,-27.6},{-46.8,-27.6}},                           color={0,127,
          255}));
  connect(exhaustAir.ports[1], menergaSimple.exhaustAir) annotation (Line(
        points={{-80,0},{-47,-0.2}},                                 color={0,
          127,255}));
  connect(exitAir.ports[1], menergaSimple.ExitAir) annotation (Line(points={{-1.77636e-15,
          22},{-1.77636e-15,8.2},{0.4,8.2}},                  color={0,127,255}));
  connect(WatSou.ports[1], menergaSimple.watInlHeaCoi) annotation (Line(points=
          {{-40,-62},{-34,-62},{-34,-36},{-26,-36}}, color={0,127,255}));
  connect(WatSin.ports[1], menergaSimple.watOutHeaCoi) annotation (Line(points=
          {{6.66134e-016,-62},{-8,-62},{-8,-36},{-23.8,-36}}, color={0,127,255}));

  connect(menergaSimple.busActors, busActors1) annotation (Line(
      points={{21.2,10},{20,10},{20,28},{40,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(one.y, busActors1.openingY04) annotation (Line(points={{-3.3,87},{
          40.1,87},{40.1,28.1}},
                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero1.y, busActors1.regenerationFan_dp) annotation (Line(points={{-35.3,
          75},{40.1,75},{40.1,28.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero.y, busActors1.exhaustFan_dp) annotation (Line(points={{-3.3,59},
          {40.1,59},{40.1,28.1}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero.y, busActors1.outsideFan_dp) annotation (Line(points={{-3.3,59},
          {40.1,59},{40.1,28.1}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(one.y, busActors1.openingY05) annotation (Line(points={{-3.3,87},{
          40.1,87},{40.1,28.1}},
                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero1.y, busActors1.openingY06) annotation (Line(points={{-35.3,75},{
          40.1,75},{40.1,28.1}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(one.y, busActors1.openingY01) annotation (Line(points={{-3.3,87},{
          40.1,87},{40.1,28.1}},
                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero1.y, busActors1.openingY02) annotation (Line(points={{-35.3,75},{
          40.1,75},{40.1,28.1}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(one.y, busActors1.pumpN04) annotation (Line(points={{-3.3,87},{40.1,
          87},{40.1,28.1}},
                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(falseSignal.y, busActors1.pumpN05) annotation (Line(points={{79,60},{40.1,
          60},{40.1,28.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(falseSignal.y, busActors1.pumpN06) annotation (Line(points={{79,60},{40.1,
          60},{40.1,28.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(falseSignal.y, busActors1.pumpN07) annotation (Line(points={{79,60},{40.1,
          60},{40.1,28.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(falseSignal.y, busActors1.pumpN08) annotation (Line(points={{79,60},{40.1,
          60},{40.1,28.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero2.y, busActors1.openingY09) annotation (Line(points={{-35.3,45},{
          40,45},{40,28.1},{40.1,28.1}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero2.y, busActors1.openingY10) annotation (Line(points={{-35.3,45},{
          40.1,45},{40.1,28.1}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero2.y, busActors1.openingY11) annotation (Line(points={{-35.3,45},{
          40,45},{40,28.1},{40.1,28.1}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero2.y, busActors1.openingY15) annotation (Line(points={{-35.3,45},{
          40,45},{40,28.1},{40.1,28.1}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero2.y, busActors1.openingY16) annotation (Line(points={{-35.3,45},{
          40,45},{40,28.1},{40.1,28.1}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero3.y, busActors1.exhaustFan) annotation (Line(points={{-35.3,19},{
          40,19},{40,28}},
                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero3.y, busActors1.outsideFan) annotation (Line(points={{-35.3,19},{
          40,19},{40,28}},
                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero2.y, busActors1.openingY03) annotation (Line(points={{-35.3,45},{
          40,45},{40,28.1},{40.1,28.1}},
                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(one.y, busActors1.openingY07) annotation (Line(points={{-3.3,87},{
          40.1,87},{40.1,28.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(one.y, busActors1.openingY08) annotation (Line(points={{-3.3,87},{
          40.1,87},{40.1,28.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero3.y, busActors1.regenerationFan) annotation (Line(points={{-35.3,
          19},{40,19},{40,28}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(one.y, busActors1.openValveHeatCoil) annotation (Line(points={{-3.3,
          87},{40,87},{40,28}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zero1.y, busActors1.mWatEvaporator) annotation (Line(points={{-35.3,
          75},{40,75},{40,28}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (experiment(StopTime=1800, Interval=10));
end TestMenergaNoControl;
