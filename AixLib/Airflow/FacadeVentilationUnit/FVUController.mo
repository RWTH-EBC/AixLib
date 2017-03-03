within AixLib.Airflow.FacadeVentilationUnit;
model FVUController

  parameter Real minimumSupTemp = 273.15+17 "Minimum supply air temperature";

  parameter Real co2SetConcentration = 600 "Set point for CO2 concentration";

  parameter Real maxSupFanPower = 60 "Maximum supply air fan power";

  parameter Real maxExFanPower = 60 "Maximum exhaust air fan power";

  parameter Real fullyOpen = 100
    "Percentage value representing fuly opened flap";

  parameter Real deltaTemp = 100
    "Added to the set temperature in cooling mode";

  Modelica.Blocks.Interfaces.RealInput roomTemperature
    annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.RealInput outdoorTemperature
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Interfaces.RealInput co2Concentration
    annotation (Placement(transformation(extent={{-120,-110},{-80,-70}})));
  Modelica.Blocks.Interfaces.RealInput roomSetTemperature
    annotation (Placement(transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Logical.OnOffController roomToBeCooled(bandwidth=2)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Logical.OnOffController roomToBeHeated(bandwidth=2)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Logical.OnOffController roomToBeVentilated(bandwidth=200)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Logical.OnOffController freeCoolingPossible(bandwidth=2)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Logical.OnOffController coldRecoveryPossible(bandwidth=2)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Logical.OnOffController heatRecoveryPossible(bandwidth=2)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Sources.Constant co2SeetConcentrationSource(k=
        co2SetConcentration)  annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-46,6})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-62,-52},{-50,-40}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-64,-102},{-52,-90}})));
  Modelica.Blocks.Sources.Constant setDeviationFreeCooling(k=-4)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-54,-24})));
  Modelica.Blocks.Sources.Constant setDeviationRecovery(k=0) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-62,-72})));
  Modelica.Blocks.Logical.Switch useCoolingValve
    annotation (Placement(transformation(extent={{62,80},{74,92}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{0,80},{14,94}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{0,44},{14,58}})));
  Modelica.Blocks.Logical.Or climatizationNeeded
    annotation (Placement(transformation(extent={{0,6},{14,20}})));
  Modelica.Blocks.Logical.And and3
    annotation (Placement(transformation(extent={{0,-34},{14,-20}})));
  Modelica.Blocks.Logical.Switch useHeatingValve
    annotation (Placement(transformation(extent={{62,48},{74,60}})));
  Modelica.Blocks.Sources.Constant one(k=1) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={8,70})));
  Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={6,34})));
  Modelica.Blocks.Logical.Or useExFan
    annotation (Placement(transformation(extent={{60,0},{74,14}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{86,1},{98,13}})));
  Modelica.Blocks.Sources.Constant exhaustFan(k=maxExFanPower)
    annotation (Placement(transformation(extent={{40,32},{52,44}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{114,-6},{126,6}})));
  Modelica.Blocks.Sources.Constant twoHours(k=2*3600)
    annotation (Placement(transformation(extent={{100,86},{112,98}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{134,46},{148,60}})));
  Modelica.Blocks.Logical.Greater timePassed
    annotation (Placement(transformation(extent={{162,52},{174,66}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{86,48},{96,58}})));
  Modelica.Blocks.Sources.Constant twentyMinutes(k=20*60)
    annotation (Placement(transformation(extent={{100,66},{112,78}})));
  Modelica.Blocks.Logical.Greater timePassed1
    annotation (Placement(transformation(extent={{162,32},{174,46}})));
  Modelica.Blocks.Logical.Timer timer1
    annotation (Placement(transformation(extent={{134,26},{148,40}})));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
    annotation (Placement(transformation(extent={{105,40},{121,56}})));
  Modelica.Blocks.Interfaces.RealOutput fanExhaustAirPower
    annotation (Placement(transformation(extent={{210,20},{230,40}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{28,-32},{40,-20}})));
  Modelica.Blocks.Interfaces.RealOutput coolingValveOpening
    annotation (Placement(transformation(extent={{210,80},{230,100}})));
  Modelica.Blocks.Interfaces.RealOutput heatingValveOpening
    annotation (Placement(transformation(extent={{210,50},{230,70}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{160,-33},{172,-21}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{116,-38},{128,-26}})));
  Modelica.Blocks.Sources.Constant supplyFan(k=maxSupFanPower)
    annotation (Placement(transformation(extent={{84,-26},{96,-14}})));
  Modelica.Blocks.Interfaces.RealOutput fanSupplyAirPower
    annotation (Placement(transformation(extent={{210,-10},{230,10}})));
  Modelica.Blocks.Logical.Greater PexaLargerPsupa
    annotation (Placement(transformation(extent={{138,-16},{150,-2}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=if
        fanExhaustAirPower > fanSupplyAirPower + 0.1 or fanExhaustAirPower <
        fanSupplyAirPower - 0.1 then false else true)
    annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{160,-66},{172,-54}})));
  Modelica.Blocks.Interfaces.RealOutput circulationdamperOpening
    annotation (Placement(transformation(extent={{210,-40},{230,-20}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{28,-50},{42,-36}})));
  Modelica.Blocks.Logical.Switch useHRC
    annotation (Placement(transformation(extent={{62,-49},{74,-37}})));
  Modelica.Blocks.Interfaces.RealOutput HRCDamperOpening
    annotation (Placement(transformation(extent={{210,-70},{230,-50}})));
  Modelica.Blocks.Logical.Pre pre1 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={164,22})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=5)
    annotation (Placement(transformation(extent={{40,-86},{52,-74}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{64,-86},{76,-74}})));
  Modelica.Blocks.Interfaces.RealOutput freshAirDamperOpening
    annotation (Placement(transformation(extent={{210,-100},{230,-80}})));
  Modelica.Blocks.Sources.Constant delta(k=deltaTemp) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-86,54})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-92,64},{-80,76}})));
equation
  connect(outdoorTemperature, add.u1) annotation (Line(points={{-100,30},{
          -78,30},{-78,-42.4},{-63.2,-42.4}}, color={0,0,127}));
  connect(roomTemperature, add.u2) annotation (Line(points={{-100,90},{-74,
          90},{-74,-40},{-68,-40},{-66,-40},{-66,-49.6},{-63.2,-49.6}},
        color={0,0,127}));
  connect(outdoorTemperature, add1.u2) annotation (Line(points={{-100,30},{
          -88,30},{-78,30},{-78,-99.6},{-65.2,-99.6}}, color={0,0,127}));
  connect(roomTemperature, add1.u1) annotation (Line(points={{-100,90},{-88,
          90},{-74,90},{-74,-92.4},{-65.2,-92.4}}, color={0,0,127}));
  connect(add1.y, heatRecoveryPossible.u)
    annotation (Line(points={{-51.4,-96},{-42,-96}}, color={0,0,127}));
  connect(add.y, coldRecoveryPossible.u) annotation (Line(points={{-49.4,
          -46},{-48,-46},{-48,-66},{-42,-66}}, color={0,0,127}));
  connect(setDeviationFreeCooling.y, freeCoolingPossible.reference)
    annotation (Line(points={{-47.4,-24},{-46,-24},{-42,-24}}, color={0,0,
          127}));
  connect(setDeviationRecovery.y, coldRecoveryPossible.reference)
    annotation (Line(points={{-55.4,-72},{-52,-72},{-52,-54},{-42,-54}},
        color={0,0,127}));
  connect(setDeviationRecovery.y, heatRecoveryPossible.reference)
    annotation (Line(points={{-55.4,-72},{-52,-72},{-52,-84},{-42,-84}},
        color={0,0,127}));
  connect(roomToBeCooled.y, and1.u1) annotation (Line(points={{-39,90},{-28,
          90},{-28,87},{-1.4,87}}, color={255,0,255}));
  connect(coldRecoveryPossible.y, and1.u2) annotation (Line(points={{-19,
          -60},{-6,-60},{-6,81.4},{-1.4,81.4}}, color={255,0,255}));
  connect(roomToBeCooled.y, useCoolingValve.u2) annotation (Line(points={{
          -39,90},{-28,90},{-28,100},{22,100},{22,86},{60.8,86}}, color={
          255,0,255}));
  connect(roomToBeCooled.y, and2.u1) annotation (Line(points={{-39,90},{-28,
          90},{-28,51},{-1.4,51}}, color={255,0,255}));
  connect(freeCoolingPossible.y, and2.u2) annotation (Line(points={{-19,-30},
          {-12,-30},{-12,45.4},{-1.4,45.4}}, color={255,0,255}));
  connect(roomToBeCooled.y, climatizationNeeded.u1) annotation (Line(points=
         {{-39,90},{-28,90},{-28,13},{-1.4,13}}, color={255,0,255}));
  connect(roomToBeHeated.y, climatizationNeeded.u2) annotation (Line(points=
         {{-39,60},{-30,60},{-30,7.4},{-1.4,7.4}}, color={255,0,255}));
  connect(heatRecoveryPossible.y, and3.u2) annotation (Line(points={{-19,
          -90},{-1.4,-90},{-1.4,-32.6}}, color={255,0,255}));
  connect(roomToBeHeated.y, and3.u1) annotation (Line(points={{-39,60},{-30,
          60},{-30,8},{-10,8},{-10,-27},{-1.4,-27}}, color={255,0,255}));
  connect(roomToBeHeated.y, useHeatingValve.u2) annotation (Line(points={{
          -39,60},{26,60},{26,54},{60.8,54}}, color={255,0,255}));
  connect(one.y, useHeatingValve.u1) annotation (Line(points={{14.6,70},{30,70},
          {30,58.8},{60.8,58.8}}, color={0,0,127}));
  connect(zero.y, useHeatingValve.u3) annotation (Line(points={{12.6,34},{
          34,34},{34,49.2},{60.8,49.2}}, color={0,0,127}));
  connect(roomToBeVentilated.y, useExFan.u2) annotation (Line(points={{-39,
          30},{-20,30},{-20,24},{18,24},{18,1.4},{58.6,1.4}}, color={255,0,
          255}));
  connect(useExFan.y, switch3.u2) annotation (Line(points={{74.7,7},{79.35,
          7},{84.8,7}}, color={255,0,255}));
  connect(exhaustFan.y, switch3.u1) annotation (Line(points={{52.6,38},{76,
          38},{76,11.8},{84.8,11.8}}, color={0,0,127}));
  connect(zero.y, switch3.u3) annotation (Line(points={{12.6,34},{24,34},{
          34,34},{34,-6},{80,-6},{80,2.2},{84.8,2.2}}, color={0,0,127}));
  connect(useExFan.y, not1.u) annotation (Line(points={{74.7,7},{80,7},{80,
          53},{85,53}}, color={255,0,255}));
  connect(timePassed.y, timer1.u) annotation (Line(points={{174.6,59},{184,
          59},{184,46},{128,46},{128,33},{132.6,33}}, color={255,0,255}));
  connect(not1.y, rSFlipFlop.S) annotation (Line(points={{96.5,53},{100,53},
          {100,52.8},{103.4,52.8}}, color={255,0,255}));
  connect(rSFlipFlop.Q, timer.u) annotation (Line(points={{121.8,52.8},{
          127.4,52.8},{127.4,53},{132.6,53}}, color={255,0,255}));
  connect(switch4.y, fanExhaustAirPower) annotation (Line(points={{126.6,0},{
          192,0},{192,30},{220,30}}, color={0,0,127}));
  connect(zero.y, useCoolingValve.u3) annotation (Line(points={{12.6,34},{
          24,34},{34,34},{34,81.2},{60.8,81.2}}, color={0,0,127}));
  connect(freeCoolingPossible.y, switch5.u2) annotation (Line(points={{-19,
          -30},{-12,-30},{-12,-14},{22,-14},{22,-26},{26.8,-26}}, color={
          255,0,255}));
  connect(zero.y, switch5.u1) annotation (Line(points={{12.6,34},{34,34},{
          34,-16},{24,-16},{24,-21.2},{26.8,-21.2}}, color={0,0,127}));
  connect(one.y, switch5.u3) annotation (Line(points={{14.6,70},{30,70},{30,-12},
          {20,-12},{20,-30.8},{26.8,-30.8}}, color={0,0,127}));
  connect(switch5.y, useCoolingValve.u1) annotation (Line(points={{40.6,-26},
          {56,-26},{56,90},{56,90.8},{60.8,90.8}}, color={0,0,127}));
  connect(useCoolingValve.y, coolingValveOpening) annotation (Line(points={{74.6,86},
          {82,86},{82,104},{204,104},{204,90},{220,90}},           color={0,
          0,127}));
  connect(useHeatingValve.y, heatingValveOpening) annotation (Line(points={{74.6,54},
          {78,54},{78,80},{200,80},{200,60},{220,60}},           color={0,0,
          127}));
  connect(co2SeetConcentrationSource.y, roomToBeVentilated.u) annotation (
      Line(points={{-52.6,6},{-62,6},{-62,24}}, color={0,0,127}));
  connect(co2Concentration, roomToBeVentilated.reference) annotation (Line(
        points={{-100,-90},{-76,-90},{-76,36},{-62,36}}, color={0,0,127}));
  connect(climatizationNeeded.y, switch2.u2) annotation (Line(points={{14.7,
          13},{52,13},{52,-32},{114.8,-32}}, color={255,0,255}));
  connect(supplyFan.y, switch2.u1) annotation (Line(points={{96.6,-20},{110,
          -20},{110,-27.2},{114.8,-27.2}}, color={0,0,127}));
  connect(zero.y, switch2.u3) annotation (Line(points={{12.6,34},{34,34},{
          34,-6},{80,-6},{80,-36.8},{114.8,-36.8}}, color={0,0,127}));
  connect(switch2.y, switch1.u3) annotation (Line(points={{128.6,-32},{154,
          -32},{154,-31.8},{158.8,-31.8}}, color={0,0,127}));
  connect(switch1.y, fanSupplyAirPower) annotation (Line(points={{172.6,-27},{
          200,-27},{200,0},{220,0}}, color={0,0,127}));
  connect(PexaLargerPsupa.y, switch1.u2) annotation (Line(points={{150.6,-9},
          {152,-9},{152,-27},{158.8,-27}}, color={255,0,255}));
  connect(switch4.y, switch1.u1) annotation (Line(points={{126.6,0},{142,0},
          {156,0},{156,-22.2},{158.8,-22.2}}, color={0,0,127}));
  connect(booleanExpression.y, switch6.u2)
    annotation (Line(points={{141,-60},{158.8,-60}}, color={255,0,255}));
  connect(switch6.y, circulationdamperOpening) annotation (Line(points={{172.6,
          -60},{196,-60},{196,-30},{220,-30}}, color={0,0,127}));
  connect(and1.y, or3.u1) annotation (Line(points={{14.7,87},{20,87},{20,
          -43},{26.6,-43}}, color={255,0,255}));
  connect(and3.y, or3.u2) annotation (Line(points={{14.7,-27},{18,-27},{18,
          -48.6},{26.6,-48.6}}, color={255,0,255}));
  connect(or3.y, useHRC.u2) annotation (Line(points={{42.7,-43},{42.7,-43},
          {60.8,-43}},color={255,0,255}));
  connect(one.y, useHRC.u1) annotation (Line(points={{14.6,70},{22,70},{30,70},
          {30,-12},{50,-12},{50,-38.2},{60.8,-38.2}}, color={0,0,127}));
  connect(zero.y, useHRC.u3) annotation (Line(points={{12.6,34},{34,34},{34,
          -6},{54,-6},{54,-47.8},{60.8,-47.8}}, color={0,0,127}));
  connect(useHRC.y, HRCDamperOpening) annotation (Line(points={{74.6,-43},{74,-43},
          {74,-44},{186,-44},{186,-60},{220,-60}}, color={0,0,127}));
  connect(add1.y, freeCoolingPossible.u) annotation (Line(points={{-51.4,
          -96},{-46,-96},{-46,-36},{-42,-36}}, color={0,0,127}));
  connect(timePassed1.y, pre1.u) annotation (Line(points={{174.6,39},{182,39},{182,
          22},{171.2,22}}, color={255,0,255}));
  connect(pre1.y, rSFlipFlop.R) annotation (Line(points={{157.4,22},{100,22},{100,
          43.2},{103.4,43.2}}, color={255,0,255}));
  connect(roomTemperature, roomToBeHeated.u) annotation (Line(points={{-100,90},
          {-74,90},{-74,54},{-62,54}},     color={0,0,127}));
  connect(roomSetTemperature, roomToBeHeated.reference) annotation (Line(
        points={{-100,-30},{-70,-30},{-70,66},{-62,66}}, color={0,0,127}));
  connect(roomTemperature, roomToBeCooled.reference) annotation (Line(
        points={{-100,90},{-74,90},{-74,96},{-62,96}}, color={0,0,127}));
  connect(switch4.y, PexaLargerPsupa.u1) annotation (Line(points={{126.6,0},
          {130,0},{130,-9},{136.8,-9}}, color={0,0,127}));
  connect(switch2.y, PexaLargerPsupa.u2) annotation (Line(points={{128.6,
          -32},{130,-32},{130,-14.6},{136.8,-14.6}}, color={0,0,127}));
  connect(timer.y, timePassed.u1) annotation (Line(points={{148.7,53},{154,
          53},{154,59},{160.8,59}}, color={0,0,127}));
  connect(twoHours.y, timePassed.u2) annotation (Line(points={{112.6,92},{
          134,92},{156,92},{156,53.4},{160.8,53.4}}, color={0,0,127}));
  connect(timer1.y, timePassed1.u1) annotation (Line(points={{148.7,33},{
          154,33},{154,39},{160.8,39}}, color={0,0,127}));
  connect(twentyMinutes.y, timePassed1.u2) annotation (Line(points={{112.6,
          72},{132,72},{150,72},{150,33.4},{160.8,33.4}}, color={0,0,127}));
  connect(exhaustFan.y, switch4.u1) annotation (Line(points={{52.6,38},{76,
          38},{76,26},{90,26},{90,18},{106,18},{106,4.8},{112.8,4.8}},
        color={0,0,127}));
  connect(timePassed.y, switch4.u2) annotation (Line(points={{174.6,59},{
          184,59},{184,12},{108,12},{108,0},{112.8,0}}, color={255,0,255}));
  connect(switch3.y, switch4.u3) annotation (Line(points={{98.6,7},{104,7},
          {104,-4.8},{112.8,-4.8}}, color={0,0,127}));
  connect(and2.y, useExFan.u1) annotation (Line(points={{14.7,51},{24,51},{
          24,7},{58.6,7}}, color={255,0,255}));
  connect(greaterThreshold.y,switch7. u2) annotation (Line(points={{52.6,
          -80},{58,-80},{62.8,-80}},     color={255,0,255}));
  connect(switch7.y, freshAirDamperOpening) annotation (Line(points={{76.6,-80},
          {180,-80},{180,-90},{220,-90}}, color={0,0,127}));
  connect(switch4.y, greaterThreshold.u) annotation (Line(points={{126.6,0},
          {174,0},{182,0},{182,-68},{78,-68},{78,-60},{32,-60},{32,-80},{
          38.8,-80}}, color={0,0,127}));
  connect(one.y, switch6.u3) annotation (Line(points={{14.6,70},{22,70},{30,70},
          {30,-12},{50,-12},{50,-56},{50,-58},{80,-58},{80,-64.8},{158.8,-64.8}},
        color={0,0,127}));
  connect(zero.y, switch6.u1) annotation (Line(points={{12.6,34},{34,34},{
          34,-6},{80,-6},{80,-48},{146,-48},{146,-55.2},{158.8,-55.2}},
        color={0,0,127}));
  connect(one.y, switch7.u1) annotation (Line(points={{14.6,70},{30,70},{30,-12},
          {16,-12},{16,-70},{58,-70},{58,-75.2},{62.8,-75.2}}, color={0,0,127}));
  connect(zero.y, switch7.u3) annotation (Line(points={{12.6,34},{34,34},{34,-6},
          {54,-6},{54,-84.8},{62.8,-84.8}}, color={0,0,127}));
  connect(delta.y, add2.u2) annotation (Line(points={{-92.6,54},{-96,54},{-96,
          66.4},{-93.2,66.4}}, color={0,0,127}));
  connect(roomSetTemperature, add2.u1) annotation (Line(points={{-100,-30},{-70,
          -30},{-70,80},{-96,80},{-96,73.6},{-93.2,73.6}}, color={0,0,127}));
  connect(add2.y, roomToBeCooled.u) annotation (Line(points={{-79.4,70},{-72,70},
          {-66,70},{-66,84},{-62,84}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{220,100}}), graphics={Rectangle(
          extent={{-100,100},{220,-100}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,40},{184,-34}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="FVU Controller")}),                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            220,100}})),
    Documentation(revisions="<html>
<ul>
<li><i><span style=\"font-family: Arial,sans-serif;\">November 10, 2016&nbsp;</span></i> by Roozbeh Sangi and Marc Baranski:<br>Implemented.</li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: Arial,sans-serif;\">This model is the controller of the facade ventilation unit.</span></p>
<p><b><span style=\"font-family: Arial,sans-serif; color: #008000;\">Level of Development</span></b></span><span style=\"font-family: MS Shell Dlg 2;\"> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\"/></span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">It makes use of six two-point controllers that determine </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- Heating</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- Cooling</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- Ventilation</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">demand and indicate if </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- Free cooling</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- Heat recovery</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- Cold recovery</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">is possible. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">As these are decentralized controllers and as the fresh air temperature is measured inside the unit, we require an additional measurement mode. This mode is activated every two hours if there is no ventilation demand and the unit consequently circulates air. In order to measure the correct fresh air temperature, the circulation damper is closed for twenty minutes. Furthermore, the exhaust air fan is switched on and the fresh air damper is opened. This allows ambient air to flow inside the unit. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The temperature set point in cooling mode is increased by adding the value &QUOT;deltaTemp&QUOT; to the set point in heating mode.</span></p>
</html>"));
end FVUController;
