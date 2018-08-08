within AixLib.Controls.AirHandling;
model FVUController "Rule-based controller of a facade ventilation unit"

  parameter Modelica.SIunits.Temperature minimumSupTemp=273.15 + 17
    "Minimum supply air temperature";

  parameter Real co2SetConcentration(min=0) = 600
    "Set point for CO2 concentration in ppm";

  parameter Real maxSupFanPower(min=0, max=0) = 1
    "Maximum relative supply air fan power (0..1)";

  parameter Real maxExFanPower(min=0, max=0) = 1
    "Maximum relative exhaust air fan power (0..1)";

  parameter Modelica.SIunits.TemperatureDifference deltaTemp = 1
    "Added to the set temperature in cooling mode";

  Modelica.Blocks.Logical.OnOffController roomToBeCooled(bandwidth=2)
    "Detects cooling demand"
    annotation (Placement(transformation(extent={{-58,110},{-38,130}})));
  Modelica.Blocks.Logical.OnOffController roomToBeHeated(bandwidth=2)
    "Detects heating demand"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Logical.OnOffController roomToBeVentilated(bandwidth=200)
    "Detects ventilation demand"
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Logical.OnOffController freeCoolingPossible(bandwidth=2)
    "Detects if free cooling is possible"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Logical.OnOffController coldRecoveryPossible(bandwidth=2)
    "Detects if cold recovery is possible"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Logical.OnOffController heatRecoveryPossible(bandwidth=2)
    "Detects if heat recovery is possible"
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Sources.Constant co2SeetConcentrationSource(k=
        co2SetConcentration) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-46,36})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-62,-22},{-50,-10}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-64,-72},{-52,-60}})));
  Modelica.Blocks.Sources.Constant setDeviationFreeCooling(k=-4) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-54,6})));
  Modelica.Blocks.Sources.Constant setDeviationRecovery(k=0) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-62,-42})));
  Modelica.Blocks.Logical.Switch useCoolingValve
    annotation (Placement(transformation(extent={{62,110},{74,122}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{0,110},{14,124}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{0,74},{14,88}})));
  Modelica.Blocks.Logical.Or climatizationNeeded
    annotation (Placement(transformation(extent={{0,36},{14,50}})));
  Modelica.Blocks.Logical.And and3
    annotation (Placement(transformation(extent={{0,-4},{14,10}})));
  Modelica.Blocks.Logical.Switch useHeatingValve
    annotation (Placement(transformation(extent={{62,78},{74,90}})));
  Modelica.Blocks.Sources.Constant one(k=1) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={8,100})));
  Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={6,64})));
  Modelica.Blocks.Logical.Or useExFan
    annotation (Placement(transformation(extent={{60,30},{74,44}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{86,31},{98,43}})));
  Modelica.Blocks.Sources.Constant exhaustFan(k=maxExFanPower)
    annotation (Placement(transformation(extent={{40,62},{52,74}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{114,24},{126,36}})));
  Modelica.Blocks.Sources.Constant twoHours(k=2*3600)
    annotation (Placement(transformation(extent={{100,116},{112,128}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{134,76},{148,90}})));
  Modelica.Blocks.Logical.Greater timePassed
    annotation (Placement(transformation(extent={{162,82},{174,96}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{86,78},{96,88}})));
  Modelica.Blocks.Sources.Constant twentyMinutes(k=20*60)
    annotation (Placement(transformation(extent={{100,96},{112,108}})));
  Modelica.Blocks.Logical.Greater timePassed1
    annotation (Placement(transformation(extent={{162,62},{174,76}})));
  Modelica.Blocks.Logical.Timer timer1
    annotation (Placement(transformation(extent={{134,56},{148,70}})));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
    annotation (Placement(transformation(extent={{105,70},{121,86}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{28,-2},{40,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{160,-3},{172,9}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{116,-8},{128,4}})));
  Modelica.Blocks.Sources.Constant supplyFan(k=maxSupFanPower)
    annotation (Placement(transformation(extent={{84,4},{96,16}})));
  Modelica.Blocks.Logical.Greater PexaLargerPsupa
    annotation (Placement(transformation(extent={{138,14},{150,28}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=if
        fVUControlBus.fanExhaustAirPower > fVUControlBus.fanSupplyAirPower +
        0.001 or fVUControlBus.fanExhaustAirPower < fVUControlBus.fanSupplyAirPower
         - 0.001 then false else true)
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{160,-36},{172,-24}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{28,-20},{42,-6}})));
  Modelica.Blocks.Logical.Switch useHRC
    annotation (Placement(transformation(extent={{62,-19},{74,-7}})));
  Modelica.Blocks.Logical.Pre pre1 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={164,52})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.05)
    annotation (Placement(transformation(extent={{40,-56},{52,-44}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{64,-56},{76,-44}})));
  Modelica.Blocks.Sources.Constant delta(k=deltaTemp) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-86,84})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-92,94},{-80,106}})));
  Interfaces.FVUControlBus fVUControlBus
    "Bus connector containing all inputs and outputs of the controller"
                                         annotation (Placement(transformation(
        extent={{-32,-32},{32,32}},
        rotation=90,
        origin={220,38})));
equation
  connect(add1.y, heatRecoveryPossible.u)
    annotation (Line(points={{-51.4,-66},{-42,-66}}, color={0,0,127}));
  connect(add.y, coldRecoveryPossible.u) annotation (Line(points={{-49.4,-16},{
          -48,-16},{-48,-36},{-42,-36}}, color={0,0,127}));
  connect(setDeviationFreeCooling.y, freeCoolingPossible.reference) annotation (
     Line(points={{-47.4,6},{-46,6},{-42,6}},       color={0,0,127}));
  connect(setDeviationRecovery.y, coldRecoveryPossible.reference) annotation (
      Line(points={{-55.4,-42},{-52,-42},{-52,-24},{-42,-24}}, color={0,0,127}));
  connect(setDeviationRecovery.y, heatRecoveryPossible.reference) annotation (
      Line(points={{-55.4,-42},{-52,-42},{-52,-54},{-42,-54}}, color={0,0,127}));
  connect(roomToBeCooled.y, and1.u1) annotation (Line(points={{-37,120},{-28,120},
          {-28,117},{-1.4,117}},
                               color={255,0,255}));
  connect(coldRecoveryPossible.y, and1.u2) annotation (Line(points={{-19,-30},{
          -6,-30},{-6,111.4},{-1.4,111.4}},
                                          color={255,0,255}));
  connect(roomToBeCooled.y, useCoolingValve.u2) annotation (Line(points={{-37,120},
          {-28,120},{-28,130},{22,130},{22,116},{60.8,116}},  color={255,0,255}));
  connect(roomToBeCooled.y, and2.u1) annotation (Line(points={{-37,120},{-28,120},
          {-28,81},{-1.4,81}}, color={255,0,255}));
  connect(freeCoolingPossible.y, and2.u2) annotation (Line(points={{-19,0},{-12,
          0},{-12,75.4},{-1.4,75.4}},   color={255,0,255}));
  connect(roomToBeCooled.y, climatizationNeeded.u1) annotation (Line(points={{-37,120},
          {-28,120},{-28,43},{-1.4,43}},    color={255,0,255}));
  connect(roomToBeHeated.y, climatizationNeeded.u2) annotation (Line(points={{-39,90},
          {-30,90},{-30,37.4},{-1.4,37.4}},   color={255,0,255}));
  connect(heatRecoveryPossible.y, and3.u2) annotation (Line(points={{-19,-60},{
          -1.4,-60},{-1.4,-2.6}},  color={255,0,255}));
  connect(roomToBeHeated.y, and3.u1) annotation (Line(points={{-39,90},{-30,90},
          {-30,38},{-10,38},{-10,3},{-1.4,3}},   color={255,0,255}));
  connect(roomToBeHeated.y, useHeatingValve.u2) annotation (Line(points={{-39,90},
          {26,90},{26,84},{60.8,84}},     color={255,0,255}));
  connect(one.y, useHeatingValve.u1) annotation (Line(points={{14.6,100},{30,
          100},{30,88.8},{60.8,88.8}},
                                  color={0,0,127}));
  connect(zero.y, useHeatingValve.u3) annotation (Line(points={{12.6,64},{34,64},
          {34,79.2},{60.8,79.2}}, color={0,0,127}));
  connect(roomToBeVentilated.y, useExFan.u2) annotation (Line(points={{-39,60},
          {-20,60},{-20,54},{18,54},{18,31.4},{58.6,31.4}},
                                                          color={255,0,255}));
  connect(useExFan.y, switch3.u2)
    annotation (Line(points={{74.7,37},{79.35,37},{84.8,37}},
                                                           color={255,0,255}));
  connect(exhaustFan.y, switch3.u1) annotation (Line(points={{52.6,68},{76,68},
          {76,41.8},{84.8,41.8}}, color={0,0,127}));
  connect(zero.y, switch3.u3) annotation (Line(points={{12.6,64},{24,64},{34,64},
          {34,24},{80,24},{80,32.2},{84.8,32.2}},
                                                color={0,0,127}));
  connect(useExFan.y, not1.u) annotation (Line(points={{74.7,37},{80,37},{80,83},
          {85,83}}, color={255,0,255}));
  connect(timePassed.y, timer1.u) annotation (Line(points={{174.6,89},{184,89},
          {184,76},{128,76},{128,63},{132.6,63}}, color={255,0,255}));
  connect(not1.y, rSFlipFlop.S) annotation (Line(points={{96.5,83},{100,83},{
          100,82.8},{103.4,82.8}}, color={255,0,255}));
  connect(rSFlipFlop.Q, timer.u) annotation (Line(points={{121.8,82.8},{127.4,
          82.8},{127.4,83},{132.6,83}}, color={255,0,255}));
  connect(zero.y, useCoolingValve.u3) annotation (Line(points={{12.6,64},{24,64},
          {34,64},{34,111.2},{60.8,111.2}},
                                          color={0,0,127}));
  connect(freeCoolingPossible.y, switch5.u2) annotation (Line(points={{-19,0},{
          -12,0},{-12,16},{22,16},{22,4},{26.8,4}},          color={255,0,255}));
  connect(zero.y, switch5.u1) annotation (Line(points={{12.6,64},{34,64},{34,14},
          {24,14},{24,8.8},{26.8,8.8}},      color={0,0,127}));
  connect(one.y, switch5.u3) annotation (Line(points={{14.6,100},{30,100},{30,
          18},{20,18},{20,-0.8},{26.8,-0.8}},color={0,0,127}));
  connect(switch5.y, useCoolingValve.u1) annotation (Line(points={{40.6,4},{56,
          4},{56,120},{56,120.8},{60.8,120.8}},   color={0,0,127}));
  connect(co2SeetConcentrationSource.y, roomToBeVentilated.u)
    annotation (Line(points={{-52.6,36},{-62,36},{-62,54}},
                                                          color={0,0,127}));
  connect(climatizationNeeded.y, switch2.u2) annotation (Line(points={{14.7,43},
          {52,43},{52,-2},{114.8,-2}},   color={255,0,255}));
  connect(supplyFan.y, switch2.u1) annotation (Line(points={{96.6,10},{110,10},
          {110,2.8},{114.8,2.8}},     color={0,0,127}));
  connect(zero.y, switch2.u3) annotation (Line(points={{12.6,64},{34,64},{34,24},
          {80,24},{80,-6.8},{114.8,-6.8}},   color={0,0,127}));
  connect(switch2.y, switch1.u3) annotation (Line(points={{128.6,-2},{154,-2},{
          154,-1.8},{158.8,-1.8}},    color={0,0,127}));
  connect(PexaLargerPsupa.y, switch1.u2) annotation (Line(points={{150.6,21},{
          152,21},{152,3},{158.8,3}},     color={255,0,255}));
  connect(switch4.y, switch1.u1) annotation (Line(points={{126.6,30},{142,30},{
          156,30},{156,7.8},{158.8,7.8}},    color={0,0,127}));
  connect(booleanExpression.y, switch6.u2)
    annotation (Line(points={{141,-30},{158.8,-30}}, color={255,0,255}));
  connect(and1.y, or3.u1) annotation (Line(points={{14.7,117},{20,117},{20,-13},
          {26.6,-13}},color={255,0,255}));
  connect(and3.y, or3.u2) annotation (Line(points={{14.7,3},{18,3},{18,-18.6},{
          26.6,-18.6}},  color={255,0,255}));
  connect(or3.y, useHRC.u2) annotation (Line(points={{42.7,-13},{42.7,-13},{
          60.8,-13}}, color={255,0,255}));
  connect(one.y, useHRC.u1) annotation (Line(points={{14.6,100},{22,100},{30,
          100},{30,18},{50,18},{50,-8.2},{60.8,-8.2}},color={0,0,127}));
  connect(zero.y, useHRC.u3) annotation (Line(points={{12.6,64},{34,64},{34,24},
          {54,24},{54,-17.8},{60.8,-17.8}}, color={0,0,127}));
  connect(add1.y, freeCoolingPossible.u) annotation (Line(points={{-51.4,-66},{
          -46,-66},{-46,-6},{-42,-6}},   color={0,0,127}));
  connect(timePassed1.y, pre1.u) annotation (Line(points={{174.6,69},{182,69},{
          182,52},{171.2,52}}, color={255,0,255}));
  connect(pre1.y, rSFlipFlop.R) annotation (Line(points={{157.4,52},{100,52},{
          100,73.2},{103.4,73.2}}, color={255,0,255}));
  connect(switch4.y, PexaLargerPsupa.u1) annotation (Line(points={{126.6,30},{
          130,30},{130,21},{136.8,21}},color={0,0,127}));
  connect(switch2.y, PexaLargerPsupa.u2) annotation (Line(points={{128.6,-2},{
          130,-2},{130,15.4},{136.8,15.4}},    color={0,0,127}));
  connect(timer.y, timePassed.u1) annotation (Line(points={{148.7,83},{154,83},
          {154,89},{160.8,89}}, color={0,0,127}));
  connect(twoHours.y, timePassed.u2) annotation (Line(points={{112.6,122},{134,
          122},{156,122},{156,83.4},{160.8,83.4}},
                                                 color={0,0,127}));
  connect(timer1.y, timePassed1.u1) annotation (Line(points={{148.7,63},{154,63},
          {154,69},{160.8,69}}, color={0,0,127}));
  connect(twentyMinutes.y, timePassed1.u2) annotation (Line(points={{112.6,102},
          {132,102},{150,102},{150,63.4},{160.8,63.4}},
                                                      color={0,0,127}));
  connect(exhaustFan.y, switch4.u1) annotation (Line(points={{52.6,68},{76,68},
          {76,56},{90,56},{90,48},{106,48},{106,34.8},{112.8,34.8}},
                                                                   color={0,0,
          127}));
  connect(timePassed.y, switch4.u2) annotation (Line(points={{174.6,89},{184,89},
          {184,42},{108,42},{108,30},{112.8,30}},
                                                color={255,0,255}));
  connect(switch3.y, switch4.u3) annotation (Line(points={{98.6,37},{104,37},{
          104,25.2},{112.8,25.2}},
                               color={0,0,127}));
  connect(and2.y, useExFan.u1) annotation (Line(points={{14.7,81},{24,81},{24,
          37},{58.6,37}},
                     color={255,0,255}));
  connect(greaterThreshold.y, switch7.u2) annotation (Line(points={{52.6,-50},{
          58,-50},{62.8,-50}}, color={255,0,255}));
  connect(switch4.y, greaterThreshold.u) annotation (Line(points={{126.6,30},{
          174,30},{182,30},{182,-38},{78,-38},{78,-30},{32,-30},{32,-50},{38.8,
          -50}},
        color={0,0,127}));
  connect(one.y, switch6.u3) annotation (Line(points={{14.6,100},{22,100},{30,
          100},{30,18},{50,18},{50,-26},{50,-28},{80,-28},{80,-34.8},{158.8,
          -34.8}},
        color={0,0,127}));
  connect(zero.y, switch6.u1) annotation (Line(points={{12.6,64},{34,64},{34,24},
          {80,24},{80,-18},{146,-18},{146,-25.2},{158.8,-25.2}}, color={0,0,127}));
  connect(one.y, switch7.u1) annotation (Line(points={{14.6,100},{30,100},{30,
          18},{16,18},{16,-40},{58,-40},{58,-45.2},{62.8,-45.2}},
                                                               color={0,0,127}));
  connect(zero.y, switch7.u3) annotation (Line(points={{12.6,64},{34,64},{34,24},
          {54,24},{54,-54.8},{62.8,-54.8}}, color={0,0,127}));
  connect(delta.y, add2.u2) annotation (Line(points={{-92.6,84},{-96,84},{-96,
          96.4},{-93.2,96.4}}, color={0,0,127}));
  connect(add2.y, roomToBeCooled.u) annotation (Line(points={{-79.4,100},{-72,100},
          {-66,100},{-66,114},{-60,114}},
                                       color={0,0,127}));
  connect(useCoolingValve.y, fVUControlBus.coolingValveOpening) annotation (
      Line(points={{74.6,116},{82,116},{82,132},{192,132},{192,38.16},{219.84,
          38.16}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(useHeatingValve.y, fVUControlBus.heatingValveOpening) annotation (
      Line(points={{74.6,84},{78,84},{78,110},{192,110},{192,38.16},{219.84,
          38.16}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switch4.y, fVUControlBus.fanExhaustAirPower) annotation (Line(points={{126.6,
          30},{162,30},{192,30},{192,38.16},{219.84,38.16}},        color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switch1.y, fVUControlBus.fanSupplyAirPower) annotation (Line(points={{172.6,3},
          {182,3},{192,3},{192,38.16},{219.84,38.16}},          color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switch6.y, fVUControlBus.circulationDamperOpening) annotation (Line(
        points={{172.6,-30},{192,-30},{192,38.16},{219.84,38.16}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(useHRC.y, fVUControlBus.hRCDamperOpening) annotation (Line(points={{74.6,
          -13},{192,-13},{192,38.16},{219.84,38.16}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switch7.y, fVUControlBus.freshAirDamperOpening) annotation (Line(
        points={{76.6,-50},{192,-50},{192,38.16},{219.84,38.16}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomToBeCooled.reference, fVUControlBus.roomTemperature) annotation (
      Line(points={{-60,126},{-74,126},{-74,140},{219.84,140},{219.84,38.16}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomToBeHeated.u, fVUControlBus.roomTemperature) annotation (Line(
        points={{-62,84},{-74,84},{-74,140},{219.84,140},{219.84,38.16}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(add1.u1, fVUControlBus.roomTemperature) annotation (Line(points={{-65.2,
          -62.4},{-74,-62.4},{-74,140},{219.84,140},{219.84,38.16}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(add.u2, fVUControlBus.roomTemperature) annotation (Line(points={{-63.2,
          -19.6},{-74,-19.6},{-74,140},{219.84,140},{219.84,38.16}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(add1.u2, fVUControlBus.outdoorTemperature) annotation (Line(points={{-65.2,
          -69.6},{-80,-69.6},{-80,-100},{219.84,-100},{219.84,38.16}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(add.u1, fVUControlBus.outdoorTemperature) annotation (Line(points={{-63.2,
          -12.4},{-80,-12.4},{-80,-100},{219.84,-100},{219.84,38.16}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(add2.u1, fVUControlBus.roomSetTemperature) annotation (Line(points={{-93.2,
          103.6},{-98,103.6},{-98,144},{219.84,144},{219.84,38.16}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomToBeHeated.reference, fVUControlBus.roomSetTemperature)
    annotation (Line(points={{-62,96},{-68,96},{-68,144},{219.84,144},{219.84,
          38.16}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomToBeVentilated.reference, fVUControlBus.co2Concentration)
    annotation (Line(points={{-62,66},{-84,66},{-84,-96},{219.84,-96},{219.84,
          38.16}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{220,
            160}}), graphics={Rectangle(extent={{-100,160},{220,-100}},
            lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern = FillPattern.Solid), Text(extent={{2,48},{122,-4}},                                                                                                                                                          lineColor = {175, 175, 175}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            220,160}})),
    Documentation(revisions="<html>
<ul>
  <li><i>Septmeber, 2014&nbsp;</i>
    by by Roozbeh Sangi and Marc Baranski:<br/>
    Model implemented</li>
</ul>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model is the controller of the facade ventilation unit. It makes use of
six two-point controllers that determine heating, cooling and ventilation 
demand. It further indicates if free cooling, heat recovery or cold recovery is
possible. As these are decentralized controllers and as the fresh air
temperature is measured inside the unit, we require an additional measurement
mode. This mode is activated every two hours if there is no ventilation demand 
and the unit consequently circulates air. In order to measure the correct fresh
air temperature, the circulation damper is closed for twenty minutes.
Furthermore, the exhaust air fan is switched on and the fresh air damper is 
opened. This allows ambient air to flow inside the unit. The temperature set 
point in cooling mode is increased by adding the value deltaTemp to the set 
point in heating mode.
</p>
</html>"));
end FVUController;
