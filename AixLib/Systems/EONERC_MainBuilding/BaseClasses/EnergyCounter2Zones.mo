within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
model EnergyCounter2Zones "Sums up all consumed energy"
  parameter Modelica.SIunits.Temperature Tset = 273.15+21 "Set Temperature of rooms for ISE calculation";

  EONERC_MainBuilding.BaseClasses.MainBus2ZoneMainBuilding mainBus annotation (
      Placement(transformation(extent={{-118,-18},{-82,16}}),
        iconTransformation(extent={{-18,-42},{16,-6}})));
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
  Modelica.Blocks.Continuous.Integrator integrator9
    annotation (Placement(transformation(extent={{-10,-80},{0,-70}})));
  Modelica.Blocks.Continuous.Integrator integrator10
    annotation (Placement(transformation(extent={{-10,-100},{0,-90}})));
  Modelica.Blocks.Math.Sum sum1(nin=2)
    annotation (Placement(transformation(extent={{-30,-22},{-20,-12}})));
  Modelica.Blocks.Math.Sum sumWel(nin=7)
    annotation (Placement(transformation(extent={{58,4},{68,14}})));
  Modelica.Blocks.Math.Sum sumQbr(nin=2)
    annotation (Placement(transformation(extent={{60,-40},{70,-30}})));
  Modelica.Blocks.Continuous.Integrator integrator11
    annotation (Placement(transformation(extent={{110,56},{120,66}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{84,56},{94,66}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{100,58},{106,64}})));
  Modelica.Blocks.Sources.Constant const(k=Tset)
    annotation (Placement(transformation(extent={{72,54},{78,60}})));
  Modelica.Blocks.Continuous.Integrator integrator8
    annotation (Placement(transformation(extent={{110,74},{120,84}})));
  Modelica.Blocks.Math.Add add6(k2=-1)
    annotation (Placement(transformation(extent={{84,74},{94,84}})));
  Modelica.Blocks.Math.Product product4
    annotation (Placement(transformation(extent={{100,76},{106,82}})));
  Modelica.Blocks.Sources.Constant const4(k=Tset)
    annotation (Placement(transformation(extent={{72,72},{78,78}})));
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
    annotation (Placement(transformation(extent={{114,38},{124,48}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=0, uMin=-100)
    annotation (Placement(transformation(extent={{90,38},{100,48}})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{76,38},{86,48}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{104,40},{110,46}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 59.5)
    annotation (Placement(transformation(extent={{64,36},{70,42}})));
equation
  connect(integrator.u, mainBus.hpSystemBus.busHP.Pel) annotation (Line(points={{-11,95},
          {-99.91,95},{-99.91,-0.915}},           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u2, mainBus.hpSystemBus.busPumpHot.pumpBus.power) annotation (
      Line(points={{-27,76},{-99.91,76},{-99.91,-0.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u1, mainBus.hpSystemBus.busPumpCold.pumpBus.power) annotation (
      Line(points={{-27,82},{-90,82},{-90,84},{-99.91,84},{-99.91,-0.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.y, integrator1.u)
    annotation (Line(points={{-15.5,79},{-11,79}}, color={0,0,127}));
  connect(integrator.y, mainBus.evaBus.WelHPMea) annotation (Line(points={{0.5,95},
          {32,95},{32,-0.915},{-99.91,-0.915}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator1.y, mainBus.evaBus.WelPumpsHPMea) annotation (Line(points={{0.5,79},
          {32,79},{32,-0.915},{-99.91,-0.915}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator2.u, mainBus.hpSystemBus.PelAirCoolerMea) annotation (Line(
        points={{-11,61},{-99.91,61},{-99.91,-0.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator2.y, mainBus.evaBus.WelGCMea) annotation (Line(points={{0.5,61},
          {32,61},{32,-0.915},{-99.91,-0.915}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add1.y, integrator3.u) annotation (Line(points={{-15.5,45},{-11,45}},
                                 color={0,0,127}));
  connect(add1.u1, mainBus.hxBus.primBus.pumpBus.power) annotation (Line(points={{-27,48},
          {-99.91,48},{-99.91,-0.915}},          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add1.u2, mainBus.hxBus.secBus.pumpBus.power) annotation (Line(points={{-27,42},
          {-99.91,42},{-99.91,-0.915}},           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator3.y, mainBus.evaBus.WelPumpsHXMea) annotation (Line(points={{0.5,45},
          {32,45},{32,-0.915},{-99.91,-0.915}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator4.u, mainBus.swuBus.pumpBus.power) annotation (Line(points={{-11,25},
          {-99.91,25},{-99.91,-0.915}},           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator4.y, mainBus.evaBus.WelPumpSWUMea) annotation (Line(points={{0.5,25},
          {32,25},{32,-0.915},{-99.91,-0.915}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator5.u, mainBus.gtfBus.primBus.pumpBus.power) annotation (Line(
        points={{-11,9},{-99.91,9},{-99.91,-0.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator5.y, mainBus.evaBus.WelPumpGTFMea) annotation (Line(points={{0.5,9},
          {32,9},{32,-0.915},{-99.91,-0.915}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator6.y, mainBus.evaBus.WelPumpsHTSMea) annotation (Line(points={{0.5,-17},
          {32,-17},{32,-0.915},{-99.91,-0.915}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator7.u, mainBus.htsBus.fuelPowerBoilerMea) annotation (Line(
        points={{-11,-35},{-99.91,-35},{-99.91,-0.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator7.y, mainBus.evaBus.QbrBoiMea) annotation (Line(points={{0.5,-35},
          {32,-35},{32,-0.915},{-99.91,-0.915}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(integrator9.u, mainBus.htsBus.fuelPowerChpMea) annotation (Line(
        points={{-11,-75},{-99.91,-75},{-99.91,-0.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator9.y, mainBus.evaBus.QbrCHPMea) annotation (Line(points={{0.5,-75},
          {32,-75},{32,-0.915},{-99.91,-0.915}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator10.u, mainBus.htsBus.electricalPowerChpMea) annotation (
      Line(points={{-11,-95},{-99.91,-95},{-99.91,-0.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator10.y, mainBus.evaBus.WelCPHMea) annotation (Line(points={{0.5,-95},
          {32,-95},{32,-0.915},{-99.91,-0.915}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sum1.u[1], mainBus.htsBus.pumpBoilerBus.pumpBus.power) annotation (
      Line(points={{-31,-17.5},{-99.91,-17.5},{-99.91,-0.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sum1.u[2], mainBus.htsBus.pumpChpBus.pumpBus.power) annotation (Line(
        points={{-31,-16.5},{-99.91,-16.5},{-99.91,-0.915}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(sum1.y, integrator6.u) annotation (Line(points={{-19.5,-17},{-14.75,
          -17},{-14.75,-17},{-11,-17}}, color={0,0,127}));
  connect(integrator.y, sumWel.u[1])
    annotation (Line(points={{0.5,95},{57,95},{57,8.14286}}, color={0,0,127}));
  connect(integrator1.y, sumWel.u[2])
    annotation (Line(points={{0.5,79},{57,79},{57,8.42857}}, color={0,0,127}));
  connect(integrator2.y, sumWel.u[3]) annotation (Line(points={{0.5,61},{32,
          61},{32,10},{57,10},{57,8.71429}},
                                         color={0,0,127}));
  connect(integrator3.y, sumWel.u[4]) annotation (Line(points={{0.5,45},{16,
          45},{16,46},{32,46},{32,9},{57,9}},
                                          color={0,0,127}));
  connect(integrator4.y, sumWel.u[5]) annotation (Line(points={{0.5,25},{
          32.25,25},{32.25,9.28571},{57,9.28571}},
                                             color={0,0,127}));
  connect(integrator5.y, sumWel.u[6])
    annotation (Line(points={{0.5,9},{57,9},{57,9.57143}}, color={0,0,127}));
  connect(integrator6.y, sumWel.u[7]) annotation (Line(points={{0.5,-17},{57,
          -17},{57,9.85714}}, color={0,0,127}));
  connect(sumWel.y, mainBus.evaBus.WelTotalMea) annotation (Line(points={{68.5,9},
          {80,9},{80,-0.915},{-99.91,-0.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator7.y, sumQbr.u[1]) annotation (Line(points={{0.5,-35},{21.25,
          -35},{21.25,-35.5},{59,-35.5}},       color={0,0,127}));
  connect(sumQbr.y, mainBus.evaBus.QbrTotalMea) annotation (Line(points={{70.5,
          -35},{76,-35},{76,-36},{80,-36},{80,-0.915},{-99.91,-0.915}},
                                                                     color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(product.y, integrator11.u) annotation (Line(points={{106.3,61},{109,
          61}},                             color={0,0,127}));
  connect(const.y, add2.u2) annotation (Line(points={{78.3,57},{80.15,57},{
          80.15,58},{83,58}}, color={0,0,127}));
  connect(integrator9.y, sumQbr.u[2]) annotation (Line(points={{0.5,-75},{50,-75},
          {50,-34.5},{59,-34.5}}, color={0,0,127}));
  connect(product4.y, integrator8.u)
    annotation (Line(points={{106.3,79},{109,79}},   color={0,0,127}));
  connect(const4.y, add6.u2) annotation (Line(points={{78.3,75},{80.15,75},{
          80.15,76},{83,76}},
                          color={0,0,127}));
  connect(add6.y, product4.u2) annotation (Line(points={{94.5,79},{97.25,79},{
          97.25,77.2},{99.4,77.2}},     color={0,0,127}));
  connect(add6.y, product4.u1) annotation (Line(points={{94.5,79},{97.25,79},{
          97.25,80.8},{99.4,80.8}},     color={0,0,127}));
  connect(add2.y, product.u1) annotation (Line(points={{94.5,61},{97.25,61},{
          97.25,62.8},{99.4,62.8}},  color={0,0,127}));
  connect(add2.y, product.u2) annotation (Line(points={{94.5,61},{97.25,61},{
          97.25,59.2},{99.4,59.2}},  color={0,0,127}));
  connect(add6.u1, mainBus.TRoom1Mea) annotation (Line(points={{83,82},{-16,82},
          {-16,84},{-99.91,84},{-99.91,-0.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add2.u1, mainBus.TRoom2Mea) annotation (Line(points={{83,64},{72,64},
          {72,100},{-100,100},{-100,-0.915},{-99.91,-0.915}},
                                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator8.y, mainBus.evaBus.IseRoom1) annotation (Line(points={{120.5,
          79},{128,79},{128,98},{-99.91,98},{-99.91,-0.915}},       color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator11.y, mainBus.evaBus.IseRoom2) annotation (Line(points={{120.5,
          61},{134,61},{134,100},{-99.91,100},{-99.91,-0.915}},       color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const2.y,add4. u2) annotation (Line(points={{70.3,23},{72.15,23},{
          72.15,24},{75,24}}, color={0,0,127}));
  connect(add4.y,limiter2. u)
    annotation (Line(points={{86.5,27},{89,27}}, color={0,0,127}));
  connect(integrator13.u,product2. y)
    annotation (Line(points={{113,27},{110.3,27}}, color={0,0,127}));
  connect(limiter2.y,product2. u2) annotation (Line(points={{100.5,27},{102.25,
          27},{102.25,25.2},{103.4,25.2}}, color={0,0,127}));
  connect(limiter2.y,product2. u1) annotation (Line(points={{100.5,27},{100.5,
          28.8},{103.4,28.8}}, color={0,0,127}));
  connect(add4.u1, mainBus.consCold1Bus.TFwrdInMea) annotation (Line(points={{75,30},
          {54,30},{54,100},{-99.91,100},{-99.91,-0.915}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator13.y, mainBus.evaBus.IseCold1) annotation (Line(points={{124.5,
          27},{134,27},{134,100},{-99.91,100},{-99.91,-0.915}},       color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add3.y,limiter. u)
    annotation (Line(points={{86.5,43},{89,43}}, color={0,0,127}));
  connect(limiter.y, product1.u2) annotation (Line(points={{100.5,43},{102.25,
          43},{102.25,41.2},{103.4,41.2}}, color={0,0,127}));
  connect(limiter.y, product1.u1) annotation (Line(points={{100.5,43},{100.5,
          44.5},{103.4,44.5},{103.4,44.8}}, color={0,0,127}));
  connect(product1.y, integrator12.u)
    annotation (Line(points={{110.3,43},{113,43}}, color={0,0,127}));
  connect(const1.y, add3.u2) annotation (Line(points={{70.3,39},{72.15,39},{
          72.15,40},{75,40}}, color={0,0,127}));
  connect(add3.u1, mainBus.consHtcBus.TFwrdInMea) annotation (Line(points={{75,46},
          {70,46},{70,62},{-99.91,62},{-99.91,-0.915}},       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator12.y, mainBus.evaBus.IseHTC) annotation (Line(points={{124.5,
          43},{134,43},{134,82},{-99.91,82},{-99.91,-0.915}},         color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
