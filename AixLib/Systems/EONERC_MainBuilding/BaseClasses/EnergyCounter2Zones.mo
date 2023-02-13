within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
model EnergyCounter2Zones "Sums up all consumed energy"
    parameter Modelica.Units.SI.Temperature Tset = 273.15+22 "Set Temperature of rooms for ISE calculation";
    parameter Modelica.Units.SI.Temperature deltaTset = 2 "Set Temperature of rooms for ISE calculation";
  MainBus2Zones mainBus annotation (Placement(transformation(extent={{-118,-18},
            {-80,18}}), iconTransformation(extent={{-18,-42},{16,-6}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-10,90},{0,100}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{-10,74},{0,84}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-26,74},{-16,84}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{-10,56},{0,66}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-26,40},{-16,50}})));
  Modelica.Blocks.Continuous.Integrator integrator3
    annotation (Placement(transformation(extent={{-10,40},{0,50}})));
  Modelica.Blocks.Continuous.Integrator integrator4
    annotation (Placement(transformation(extent={{-10,20},{0,30}})));
  Modelica.Blocks.Continuous.Integrator integrator5
    annotation (Placement(transformation(extent={{-10,4},{0,14}})));
  Modelica.Blocks.Continuous.Integrator integrator6
    annotation (Placement(transformation(extent={{-10,-22},{0,-12}})));
  Modelica.Blocks.Continuous.Integrator integrator7
    annotation (Placement(transformation(extent={{-10,-40},{0,-30}})));
  Modelica.Blocks.Continuous.Integrator integrator8
    annotation (Placement(transformation(extent={{-10,-60},{0,-50}})));
  Modelica.Blocks.Continuous.Integrator integrator9
    annotation (Placement(transformation(extent={{-8,-80},{2,-70}})));
  Modelica.Blocks.Continuous.Integrator integratorPelCHP
    annotation (Placement(transformation(extent={{-10,-100},{0,-90}})));
  Modelica.Blocks.Math.Sum sum1(nin=3)
    annotation (Placement(transformation(extent={{-30,-22},{-20,-12}})));
  Modelica.Blocks.Math.Sum sumWel(nin=11)
    annotation (Placement(transformation(extent={{50,-22},{60,-12}})));
  Modelica.Blocks.Math.Sum sumQbr(nin=3)
    annotation (Placement(transformation(extent={{50,-40},{60,-30}})));
  Modelica.Blocks.Continuous.Integrator integrator11
    annotation (Placement(transformation(extent={{112,88},{122,98}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=0, uMin=-100)
    annotation (Placement(transformation(extent={{88,88},{98,98}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{74,88},{84,98}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{102,90},{108,96}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 59.5)
    annotation (Placement(transformation(extent={{60,88},{66,94}})));
  Modelica.Blocks.Continuous.Integrator integrator13
    annotation (Placement(transformation(extent={{114,22},{124,32}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=1000, uMin=0)
    annotation (Placement(transformation(extent={{90,22},{100,32}})));
  Modelica.Blocks.Math.Add add4(k2=-1)
    annotation (Placement(transformation(extent={{76,22},{86,32}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 16.5)
    annotation (Placement(transformation(extent={{64,20},{70,26}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{104,24},{110,30}})));
  Modelica.Blocks.Continuous.Integrator integrator12
    annotation (Placement(transformation(extent={{112,48},{122,58}})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{72,48},{82,58}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{102,50},{108,56}})));
  Modelica.Blocks.Sources.Constant const1(k=Tset)
    annotation (Placement(transformation(extent={{60,46},{68,54}})));
  Modelica.Blocks.Continuous.Integrator integrator14
    annotation (Placement(transformation(extent={{110,66},{120,76}})));
  Modelica.Blocks.Math.Add add6(k2=-1)
    annotation (Placement(transformation(extent={{70,66},{80,76}})));
  Modelica.Blocks.Math.Product product4
    annotation (Placement(transformation(extent={{100,68},{106,74}})));
  Modelica.Blocks.Sources.Constant const4(k=Tset)
    annotation (Placement(transformation(extent={{58,64},{66,72}})));
  Modelica.Blocks.Nonlinear.DeadZone deadZone(uMax=deltaTset, uMin=-deltaTset)
    annotation (Placement(transformation(extent={{86,48},{96,58}})));
  Modelica.Blocks.Nonlinear.DeadZone deadZone1(uMax=deltaTset, uMin=-deltaTset)
    annotation (Placement(transformation(extent={{86,66},{96,76}})));
  Modelica.Blocks.Continuous.Integrator integratorAHUs
    annotation (Placement(transformation(extent={{-10,-122},{0,-112}})));
  Modelica.Blocks.Math.Sum sumAHUs(nin=6)
    annotation (Placement(transformation(extent={{-34,-122},{-24,-112}})));
  Modelica.Blocks.Continuous.Integrator integratorCCAs
    annotation (Placement(transformation(extent={{-10,-142},{0,-132}})));
  Modelica.Blocks.Math.Sum sumCCAs(nin=6)
    annotation (Placement(transformation(extent={{-34,-142},{-24,-132}})));
  Modelica.Blocks.Continuous.Integrator integratorCCAs1
    annotation (Placement(transformation(extent={{-10,-160},{0,-150}})));
  Modelica.Blocks.Math.Sum sumCCAs1(nin=2)
    annotation (Placement(transformation(extent={{-34,-160},{-24,-150}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={20,-86})));
  Modelica.Blocks.Math.MultiSum multiSumPCons(nu=10)
    annotation (Placement(transformation(extent={{2,156},{14,168}})));
  Modelica.Blocks.Math.Add add5(k2=-1)
    annotation (Placement(transformation(extent={{36,146},{56,166}})));
  Modelica.Blocks.Nonlinear.Limiter elecBuy(uMax=10000000, uMin=0)
    annotation (Placement(transformation(extent={{84,172},{104,192}})));
  Modelica.Blocks.Nonlinear.Limiter elecSell(uMax=0, uMin=-1000000)
    annotation (Placement(transformation(extent={{84,140},{104,160}})));
  Modelica.Blocks.Continuous.Integrator integrator10
    annotation (Placement(transformation(extent={{116,178},{126,188}})));
  Modelica.Blocks.Continuous.Integrator integrator15
    annotation (Placement(transformation(extent={{118,144},{128,154}})));
equation
  connect(integrator.u, mainBus.hpSystemBus.busHP.PelMea) annotation (Line(points={
          {-11,95},{-98.905,95},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u2, mainBus.hpSystemBus.busPumpHot.pumpBus.PelMea) annotation (
      Line(points={{-27,76},{-98.905,76},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u1, mainBus.hpSystemBus.busPumpCold.pumpBus.PelMea) annotation (
      Line(points={{-27,82},{-90,82},{-90,84},{-98.905,84},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.y, integrator1.u)
    annotation (Line(points={{-15.5,79},{-11,79}}, color={0,0,127}));
  connect(integrator.y, mainBus.evaBus.WelHPMea) annotation (Line(points={{0.5,95},
          {32,95},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator1.y, mainBus.evaBus.WelPumpsHPMea) annotation (Line(points={
          {0.5,79},{32,79},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator2.u, mainBus.hpSystemBus.PelAirCoolerMea) annotation (Line(
        points={{-11,61},{-98.905,61},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator2.y, mainBus.evaBus.WelGCMea) annotation (Line(points={{0.5,
          61},{32,61},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add1.y, integrator3.u) annotation (Line(points={{-15.5,45},{-11,45}},
                                 color={0,0,127}));
  connect(add1.u1, mainBus.hxBus.primBus.pumpBus.PelMea) annotation (Line(
        points={{-27,48},{-98.905,48},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add1.u2, mainBus.hxBus.secBus.pumpBus.PelMea) annotation (Line(points=
         {{-27,42},{-98.905,42},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator3.y, mainBus.evaBus.WelPumpsHXMea) annotation (Line(points={
          {0.5,45},{32,45},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator4.u, mainBus.swuBus.pumpBus.PelMea) annotation (Line(points=
         {{-11,25},{-98.905,25},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator4.y, mainBus.evaBus.WelPumpSWUMea) annotation (Line(points={
          {0.5,25},{32,25},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator5.u, mainBus.gtfBus.primBus.pumpBus.PelMea) annotation (
      Line(points={{-11,9},{-98.905,9},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator5.y, mainBus.evaBus.WelPumpGTFMea) annotation (Line(points={
          {0.5,9},{32,9},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator6.y, mainBus.evaBus.WelPumpsHTSMea) annotation (Line(points=
         {{0.5,-17},{32,-17},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator7.u, mainBus.htsBus.fuelPowerBoiler1Mea) annotation (Line(
        points={{-11,-35},{-98.905,-35},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator7.y, mainBus.evaBus.QbrBoi1Mea) annotation (Line(points={{0.5,
          -35},{32,-35},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator8.u, mainBus.htsBus.fuelPowerBoiler2Mea) annotation (Line(
        points={{-11,-55},{-98.905,-55},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator8.y, mainBus.evaBus.QbrBoi2Mea) annotation (Line(points={{0.5,
          -55},{32,-55},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator9.u, mainBus.htsBus.fuelPowerChpMea) annotation (Line(
        points={{-9,-75},{-98.905,-75},{-98.905,0.09}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator9.y, mainBus.evaBus.QbrCHPMea) annotation (Line(points={{2.5,-75},
          {32,-75},{32,0.09},{-98.905,0.09}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorPelCHP.u, mainBus.htsBus.electricalPowerChpMea) annotation (
     Line(points={{-11,-95},{-98.905,-95},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integratorPelCHP.y, mainBus.evaBus.WelCPHMea) annotation (Line(points=
         {{0.5,-95},{32,-95},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sum1.u[1], mainBus.htsBus.admixBus1.pumpBus.PelMea) annotation (Line(
        points={{-31,-17.3333},{-98.905,-17.3333},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sum1.u[2], mainBus.htsBus.admixBus2.pumpBus.PelMea) annotation (Line(
        points={{-31,-17},{-98.905,-17},{-98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sum1.u[3], mainBus.htsBus.throttlePumpBus.pumpBus.PelMea) annotation (
     Line(points={{-31,-16.6667},{-98.905,-16.6667},{-98.905,0.09}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sum1.y, integrator6.u) annotation (Line(points={{-19.5,-17},{-14.75,
          -17},{-14.75,-17},{-11,-17}}, color={0,0,127}));
  connect(integrator.y, sumWel.u[1])
    annotation (Line(points={{0.5,95},{49,95},{49,-17.4545}},color={0,0,127}));
  connect(integrator1.y, sumWel.u[2])
    annotation (Line(points={{0.5,79},{49,79},{49,-17.3636}},color={0,0,127}));
  connect(integrator2.y, sumWel.u[3]) annotation (Line(points={{0.5,61},{32,61},
          {32,10},{49,10},{49,-17.2727}},color={0,0,127}));
  connect(integrator3.y, sumWel.u[4]) annotation (Line(points={{0.5,45},{16,45},
          {16,46},{32,46},{32,-17.1818},{49,-17.1818}},
                                          color={0,0,127}));
  connect(integrator4.y, sumWel.u[5]) annotation (Line(points={{0.5,25},{32.25,
          25},{32.25,-17.0909},{49,-17.0909}},
                                             color={0,0,127}));
  connect(integrator5.y, sumWel.u[6])
    annotation (Line(points={{0.5,9},{49,9},{49,-17}},     color={0,0,127}));
  connect(integrator6.y, sumWel.u[7]) annotation (Line(points={{0.5,-17},{49,
          -17},{49,-16.9091}},color={0,0,127}));
  connect(sumWel.y, mainBus.evaBus.WelTotalMea) annotation (Line(points={{60.5,-17},
          {64,-17},{64,-16},{66,-16},{66,0.09},{-98.905,0.09}},
                                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator7.y, sumQbr.u[1]) annotation (Line(points={{0.5,-35},{21.25,
          -35},{21.25,-35.3333},{49,-35.3333}}, color={0,0,127}));
  connect(integrator8.y, sumQbr.u[2])
    annotation (Line(points={{0.5,-55},{49,-55},{49,-35}}, color={0,0,127}));
  connect(integrator9.y, sumQbr.u[3]) annotation (Line(points={{2.5,-75},{20,
          -75},{20,-74},{48,-74},{48,-34.6667},{49,-34.6667}}, color={0,0,127}));
  connect(sumQbr.y, mainBus.evaBus.QbrTotalMea) annotation (Line(points={{60.5,-35},
          {64,-35},{64,-36},{66,-36},{66,0.09},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add2.y, limiter.u)
    annotation (Line(points={{84.5,93},{87,93}}, color={0,0,127}));
  connect(limiter.y, product.u2) annotation (Line(points={{98.5,93},{100.25,93},
          {100.25,91.2},{101.4,91.2}}, color={0,0,127}));
  connect(limiter.y, product.u1) annotation (Line(points={{98.5,93},{98.5,94.5},
          {101.4,94.5},{101.4,94.8}}, color={0,0,127}));
  connect(product.y, integrator11.u) annotation (Line(points={{108.3,93},{
          109.15,93},{109.15,93},{111,93}}, color={0,0,127}));
  connect(const.y, add2.u2) annotation (Line(points={{66.3,91},{70.15,91},{
          70.15,90},{73,90}}, color={0,0,127}));
  connect(add2.u1, mainBus.consHtcBus.TFwrdInMea) annotation (Line(points={{73,96},
          {68,96},{68,112},{-98.905,112},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator11.y, mainBus.evaBus.IseHTC) annotation (Line(points={{122.5,
          93},{132,93},{132,132},{-98.905,132},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const2.y, add4.u2) annotation (Line(points={{70.3,23},{72.15,23},{72.15,
          24},{75,24}},       color={0,0,127}));
  connect(add4.y, limiter2.u)
    annotation (Line(points={{86.5,27},{89,27}}, color={0,0,127}));
  connect(integrator13.u, product2.y)
    annotation (Line(points={{113,27},{110.3,27}}, color={0,0,127}));
  connect(limiter2.y, product2.u2) annotation (Line(points={{100.5,27},{102.25,27},
          {102.25,25.2},{103.4,25.2}},     color={0,0,127}));
  connect(limiter2.y, product2.u1) annotation (Line(points={{100.5,27},{100.5,28.8},
          {103.4,28.8}},       color={0,0,127}));
  connect(add4.u1, mainBus.consCold1Bus.TFwrdInMea) annotation (Line(points={{75,30},
          {62,30},{62,32},{54,32},{54,96},{-98.905,96},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator13.y, mainBus.evaBus.IseCold1) annotation (Line(points={{124.5,
          27},{150,27},{150,104},{-98.905,104},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(product1.y, integrator12.u)
    annotation (Line(points={{108.3,53},{111,53}}, color={0,0,127}));
  connect(const1.y, add3.u2) annotation (Line(points={{68.4,50},{71,50}},
                        color={0,0,127}));
  connect(product4.y, integrator14.u)
    annotation (Line(points={{106.3,71},{109,71}}, color={0,0,127}));
  connect(const4.y,add6. u2) annotation (Line(points={{66.4,68},{69,68}},
                          color={0,0,127}));
  connect(add6.u1, mainBus.TZone1Mea) annotation (Line(points={{69,74},{-30,74},
          {-30,76},{-98.905,76},{-98.905,0.09}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add3.u1, mainBus.TZone2Mea) annotation (Line(points={{71,56},{54,56},
          {54,102},{-100,102},{-100,0.09},{-98.905,0.09}},
                                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator14.y, mainBus.evaBus.IseZone1) annotation (Line(points={{120.5,
          71},{126,71},{126,72},{132,72},{132,104},{-98.905,104},{-98.905,0.09}},
                                                              color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator12.y, mainBus.evaBus.IseZone2) annotation (Line(points={{122.5,
          53},{132,53},{132,104},{-98.905,104},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add3.y, deadZone.u)
    annotation (Line(points={{82.5,53},{85,53}}, color={0,0,127}));
  connect(deadZone.y, product1.u1) annotation (Line(points={{96.5,53},{98.25,53},
          {98.25,54.8},{101.4,54.8}}, color={0,0,127}));
  connect(deadZone.y, product1.u2) annotation (Line(points={{96.5,53},{97.25,53},
          {97.25,51.2},{101.4,51.2}}, color={0,0,127}));
  connect(add6.y, deadZone1.u) annotation (Line(points={{80.5,71},{82.25,71},{
          82.25,71},{85,71}}, color={0,0,127}));
  connect(deadZone1.y, product4.u1) annotation (Line(points={{96.5,71},{98.25,
          71},{98.25,72.8},{99.4,72.8}}, color={0,0,127}));
  connect(deadZone1.y, product4.u2) annotation (Line(points={{96.5,71},{98.25,
          71},{98.25,69.2},{99.4,69.2}}, color={0,0,127}));
  connect(sumAHUs.y, integratorAHUs.u)
    annotation (Line(points={{-23.5,-117},{-11,-117}}, color={0,0,127}));
  connect(integratorAHUs.y, sumWel.u[8]) annotation (Line(points={{0.5,-117},{
          46,-117},{46,-16.8182},{49,-16.8182}},
                                             color={0,0,127}));
  connect(sumCCAs.y, integratorCCAs.u)
    annotation (Line(points={{-23.5,-137},{-11,-137}}, color={0,0,127}));
  connect(integratorCCAs.y, sumWel.u[9]) annotation (Line(points={{0.5,-137},{
          24,-137},{24,-138},{46,-138},{46,-16},{50,-16},{50,-16.7273},{49,
          -16.7273}},
        color={0,0,127}));
  connect(sumAHUs.u[1], mainBus.ahu1Bus.preheaterBus.hydraulicBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-117.417},{-98.905,-117.417},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumAHUs.u[2], mainBus.ahu1Bus.coolerBus.hydraulicBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-117.25},{-98.905,-117.25},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumAHUs.u[3], mainBus.ahu1Bus.heaterBus.hydraulicBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-117.083},{-98.905,-117.083},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumAHUs.u[4], mainBus.ahu2Bus.preheaterBus.hydraulicBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-116.917},{-98.905,-116.917},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumAHUs.u[5], mainBus.ahu2Bus.coolerBus.hydraulicBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-116.75},{-98.905,-116.75},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumAHUs.u[6], mainBus.ahu2Bus.heaterBus.hydraulicBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-116.583},{-98.905,-116.583},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumCCAs.u[1], mainBus.tabs1Bus.pumpBus.pumpBus.PelMea) annotation (
      Line(points={{-35,-137.417},{-106,-137.417},{-106,0.09},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumCCAs.u[2], mainBus.tabs1Bus.hotThrottleBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-137.25},{-98.905,-137.25},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumCCAs.u[3], mainBus.tabs1Bus.coldThrottleBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-137.083},{-98.905,-137.083},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumCCAs.u[4], mainBus.tabs2Bus.pumpBus.pumpBus.PelMea) annotation (
      Line(points={{-35,-136.917},{-98.905,-136.917},{-98.905,0.09}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumCCAs.u[5], mainBus.tabs2Bus.hotThrottleBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-136.75},{-98.905,-136.75},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumCCAs.u[6], mainBus.tabs2Bus.coldThrottleBus.pumpBus.PelMea)
    annotation (Line(points={{-35,-136.583},{-108,-136.583},{-108,0.09},{
          -98.905,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integratorCCAs.y, mainBus.evaBus.WelPumpsTABSMea) annotation (Line(
        points={{0.5,-137},{24,-137},{24,-172},{-146,-172},{-146,0.09},{-98.905,
          0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorAHUs.y, mainBus.evaBus.WelPumpsAHUMea) annotation (Line(
        points={{0.5,-117},{44,-117},{44,-190},{-178,-190},{-178,0.09},{-98.905,
          0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sumCCAs1.y, integratorCCAs1.u)
    annotation (Line(points={{-23.5,-155},{-11,-155}}, color={0,0,127}));
  connect(integratorCCAs1.y, sumWel.u[10]) annotation (Line(points={{0.5,-155},
          {32,-155},{32,-18},{40,-18},{40,-16.6364},{49,-16.6364}},
                                                                color={0,0,127}));
  connect(sumCCAs1.u[1], mainBus.consHtcBus.pumpBus.PelMea) annotation (Line(
        points={{-35,-155.25},{-98.905,-155.25},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sumCCAs1.u[2], mainBus.consCold1Bus.pumpBus.PelMea) annotation (Line(
        points={{-35,-154.75},{-98.905,-154.75},{-98.905,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integratorCCAs1.y, mainBus.evaBus.WelPumpsConsMea) annotation (Line(
        points={{0.5,-155},{24,-155},{24,-196},{-98.905,-196},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorPelCHP.y, gain.u) annotation (Line(points={{0.5,-95},{0.5,
          -96},{20,-96},{20,-90.8}}, color={0,0,127}));
  connect(gain.y, sumWel.u[11]) annotation (Line(points={{20,-81.6},{20,-76},{
          32,-76},{32,-18},{40,-18},{40,-16.5455},{49,-16.5455}}, color={0,0,
          127}));
  connect(integrator.u, multiSumPCons.u[1]) annotation (Line(points={{-11,95},{
          -14,95},{-14,114},{2,114},{2,160.11}}, color={0,0,127}));
  connect(integrator1.u, multiSumPCons.u[2]) annotation (Line(points={{-11,79},
          {-14,79},{-14,114},{2,114},{2,160.53}}, color={0,0,127}));
  connect(integrator2.u, multiSumPCons.u[3]) annotation (Line(points={{-11,61},
          {-32,61},{-32,88},{-14,88},{-14,114},{2,114},{2,160.95}}, color={0,0,
          127}));
  connect(integrator3.u, multiSumPCons.u[4]) annotation (Line(points={{-11,45},
          {-14,45},{-14,56},{-16,56},{-16,60},{-32,60},{-32,88},{-14,88},{-14,
          114},{2,114},{2,161.37}}, color={0,0,127}));
  connect(integrator4.u, multiSumPCons.u[5]) annotation (Line(points={{-11,25},
          {-32,25},{-32,88},{-14,88},{-14,114},{2,114},{2,161.79}}, color={0,0,
          127}));
  connect(integrator5.u, multiSumPCons.u[6]) annotation (Line(points={{-11,9},{
          -16,9},{-16,24},{-32,24},{-32,88},{-14,88},{-14,114},{2,114},{2,
          162.21}}, color={0,0,127}));
  connect(integrator6.u, multiSumPCons.u[7]) annotation (Line(points={{-11,-17},
          {-12,-17},{-12,-12},{-14,-12},{-14,4},{-16,4},{-16,24},{-32,24},{-32,
          88},{-14,88},{-14,114},{2,114},{2,162.63}}, color={0,0,127}));
  connect(integratorAHUs.u, multiSumPCons.u[8]) annotation (Line(points={{-11,
          -117},{-16,-117},{-16,-12},{-14,-12},{-14,4},{-16,4},{-16,24},{-32,24},
          {-32,88},{-14,88},{-14,114},{2,114},{2,163.05}}, color={0,0,127}));
  connect(integratorCCAs.u, multiSumPCons.u[9]) annotation (Line(points={{-11,
          -137},{-11,-120},{-16,-120},{-16,-12},{-14,-12},{-14,4},{-16,4},{-16,
          24},{-32,24},{-32,88},{-14,88},{-14,114},{2,114},{2,163.47}}, color={
          0,0,127}));
  connect(integratorCCAs1.u, multiSumPCons.u[10]) annotation (Line(points={{-11,
          -155},{-11,-120},{-16,-120},{-16,-12},{-14,-12},{-14,4},{-16,4},{-16,
          24},{-32,24},{-32,88},{-14,88},{-14,114},{2,114},{2,163.89}}, color={
          0,0,127}));
  connect(multiSumPCons.y, add5.u1)
    annotation (Line(points={{15.02,162},{34,162}}, color={0,0,127}));
  connect(add5.y, elecBuy.u) annotation (Line(points={{57,156},{62,156},{62,182},
          {82,182}}, color={0,0,127}));
  connect(add5.y, elecSell.u)
    annotation (Line(points={{57,156},{57,150},{82,150}}, color={0,0,127}));
  connect(elecBuy.y, integrator10.u)
    annotation (Line(points={{105,182},{105,183},{115,183}}, color={0,0,127}));
  connect(elecSell.y, integrator15.u) annotation (Line(points={{105,150},{111,
          150},{111,149},{117,149}}, color={0,0,127}));
  connect(integrator10.y, mainBus.evaBus.WelTotalBuyMea) annotation (Line(
        points={{126.5,183},{126.5,162},{-98.905,162},{-98.905,0.09}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator15.y, mainBus.evaBus.WelTotalSellMea) annotation (Line(
        points={{128.5,149},{142,149},{142,170},{-98.905,170},{-98.905,0.09}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integratorPelCHP.u, add5.u2)
    annotation (Line(points={{-11,-95},{-11,150},{34,150}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-86,80},{94,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{30,36}}, color={0,0,0}),
        Polygon(
          points={{44,48},{-8,2},{2,-6},{44,48}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,64},{-56,42}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-26,70},{-22,46}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{28,70},{22,46}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{86,60},{66,38}},
          color={0,0,0},
          thickness=1)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EnergyCounter2Zones;
