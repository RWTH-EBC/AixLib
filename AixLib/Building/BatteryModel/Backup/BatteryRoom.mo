within AixLib.Building.BatteryModel.Backup;
model BatteryRoom "Room of racked batteries, which are placed side by side"
   parameter Integer nBatRacks=8   "Number of battery racks installed in the battery room";
   parameter Integer nRacksFirstType = 8 "Number of battery racks which are from the first battery type";
   parameter Integer nBatTypes = 1 "How many different Battery Types are installed in the room?" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=1 "1",
      choice=2 "2",
      radioButtons = true));

  inner parameter DataBase.Batteries.RackBaseDataZeros RackType1
    "Rack Type of Rack 1"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType2 if         nBatRacks > 1
    "Rack Type of Rack 2"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType3 if         nBatRacks > 2
    "Rack Type of Rack 3"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType4 if         nBatRacks > 3
    "Rack Type of Rack 4"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType5 if         nBatRacks > 4
    "Rack Type of Rack 5"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType6 if         nBatRacks > 5
    "Rack Type of Rack 6"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType7 if         nBatRacks > 6
    "Rack Type of Rack 7"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType8 if         nBatRacks > 7
    "Rack Type of Rack 8"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType9 if         nBatRacks > 8
    "Rack Type of Rack 9"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  inner parameter DataBase.Batteries.RackBaseDataZeros RackType10 if         nBatRacks > 9
    "Rack Type of Rack 10"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);

  Modelica.Blocks.Interfaces.RealInput Battery1_Loss
    "Electrical Loss of the Battery - from external file" annotation (Placement(
        transformation(extent={{-254,64},{-182,136}}), iconTransformation(
          extent={{-200,40},{-120,120}})));
  Modelica.Blocks.Interfaces.RealInput Battery2_Loss if nBatTypes == 2
    "Electrical Loss of the Battery - from external file"
    annotation (Placement(transformation(extent={{-254,-136},{-182,-64}}),
        iconTransformation(extent={{-200,-120},{-120,-40}})));
  AixLib.Utilities.Interfaces.Star star annotation (Placement(transformation(
          extent={{178,40},{224,80}}), iconTransformation(extent={{160,20},{200,
            60}})));

  Modelica.Blocks.Interfaces.RealOutput battery1_temperature(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC")
    "Temperature of the first battery type" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={120,210}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,180})));
  Modelica.Blocks.Interfaces.RealOutput battery2_temperature(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") if nBatTypes == 2
    "Temperature of the second battery type" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={160,210}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={120,180})));

  BatteryRack batteryRack_1(
    BatType=RackType1.BatType,
    nParallels=RackType1.nParallels,
    nSeries=RackType1.nSeries,
    nStacked=RackType1.nStacked,
    AirBetweenStacks=RackType1.AirBetweenStacks,
    BatArrangement=RackType1.BatArrangement,
    AreaStandingAtWall=RackType1.AreaStandingAtWall)
    annotation (Placement(transformation(extent={{20,180},{40,200}})));
  BatteryRack batteryRack_2(
    BatType=RackType2.BatType,
    nParallels=RackType2.nParallels,
    nSeries=RackType2.nSeries,
    nStacked=RackType2.nStacked,
    AirBetweenStacks=RackType2.AirBetweenStacks,
    BatArrangement=RackType2.BatArrangement,
    AreaStandingAtWall=RackType2.AreaStandingAtWall) if nBatRacks > 1
    annotation (Placement(transformation(extent={{20,140},{40,160}})));
  BatteryRack batteryRack_3(
    BatType=RackType3.BatType,
    nParallels=RackType3.nParallels,
    nSeries=RackType3.nSeries,
    nStacked=RackType3.nStacked,
    AirBetweenStacks=RackType3.AirBetweenStacks,
    BatArrangement=RackType3.BatArrangement,
    AreaStandingAtWall=RackType3.AreaStandingAtWall) if nBatRacks > 2
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  BatteryRack batteryRack_4(
    BatType=RackType4.BatType,
    nParallels=RackType4.nParallels,
    nSeries=RackType4.nSeries,
    nStacked=RackType4.nStacked,
    AirBetweenStacks=RackType4.AirBetweenStacks,
    BatArrangement=RackType4.BatArrangement,
    AreaStandingAtWall=RackType4.AreaStandingAtWall) if nBatRacks > 3
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  BatteryRack batteryRack_5(
    BatType=RackType5.BatType,
    nParallels=RackType5.nParallels,
    nSeries=RackType5.nSeries,
    nStacked=RackType5.nStacked,
    AirBetweenStacks=RackType5.AirBetweenStacks,
    BatArrangement=RackType5.BatArrangement,
    AreaStandingAtWall=RackType5.AreaStandingAtWall) if nBatRacks > 4
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  BatteryRack batteryRack_6(
    BatType=RackType6.BatType,
    nParallels=RackType6.nParallels,
    nSeries=RackType6.nSeries,
    nStacked=RackType6.nStacked,
    AirBetweenStacks=RackType6.AirBetweenStacks,
    BatArrangement=RackType6.BatArrangement,
    AreaStandingAtWall=RackType6.AreaStandingAtWall) if nBatRacks > 5
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  BatteryRack batteryRack_7(
    BatType=RackType7.BatType,
    nParallels=RackType7.nParallels,
    nSeries=RackType7.nSeries,
    nStacked=RackType7.nStacked,
    AirBetweenStacks=RackType7.AirBetweenStacks,
    BatArrangement=RackType7.BatArrangement,
    AreaStandingAtWall=RackType7.AreaStandingAtWall) if nBatRacks > 6
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  BatteryRack batteryRack_8(
    BatType=RackType8.BatType,
    nParallels=RackType8.nParallels,
    nSeries=RackType8.nSeries,
    nStacked=RackType8.nStacked,
    AirBetweenStacks=RackType8.AirBetweenStacks,
    BatArrangement=RackType8.BatArrangement,
    AreaStandingAtWall=RackType8.AreaStandingAtWall) if nBatRacks > 7
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));

  BatteryRack batteryRack_9(
    BatType=RackType9.BatType,
    nParallels=RackType9.nParallels,
    nSeries=RackType9.nSeries,
    nStacked=RackType9.nStacked,
    AirBetweenStacks=RackType9.AirBetweenStacks,
    BatArrangement=RackType9.BatArrangement,
    AreaStandingAtWall=RackType9.AreaStandingAtWall) if nBatRacks > 8
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
  BatteryRack batteryRack_10(
    BatType=RackType10.BatType,
    nParallels=RackType10.nParallels,
    nSeries=RackType10.nSeries,
    nStacked=RackType10.nStacked,
    AirBetweenStacks=RackType10.AirBetweenStacks,
    BatArrangement=RackType10.BatArrangement,
    AreaStandingAtWall=RackType10.AreaStandingAtWall) if nBatRacks > 9
    annotation (Placement(transformation(extent={{20,-200},{40,-180}})));

  Modelica.Blocks.Math.Gain lossFraction1(k=0.2)
    annotation (Placement(transformation(extent={{-40,180},{-20,200}})));
  Modelica.Blocks.Math.Gain lossFraction2(k=0.2) if                                                                                                                                               nBatRacks > 1
    annotation (Placement(transformation(extent={{-40,140},{-20,160}})));
  Modelica.Blocks.Math.Gain lossFraction3(k=0.2) if                                                                                                                                               nBatRacks > 2
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Modelica.Blocks.Math.Gain lossFraction4(k=0.2) if                                                                                                                                               nBatRacks > 3
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Math.Gain lossFraction5(k=0.1) if                                                                                                                                               nBatRacks > 4
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Math.Gain lossFraction6(k=0.1) if                                                                                                                                               nBatRacks > 5
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Math.Gain lossFraction7 if nBatRacks > 6
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Gain lossFraction8 if nBatRacks > 7
    annotation (Placement(transformation(extent={{-40,-120},{-20,-100}})));
  Modelica.Blocks.Math.Gain lossFraction9 if nBatRacks > 8
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Modelica.Blocks.Math.Gain lossFraction10 if nBatRacks > 9
    annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector convCollector(m=
        nBatRacks) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={114,-60})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_conv annotation (
      Placement(transformation(extent={{172,-88},{228,-32}}),
        iconTransformation(extent={{162,-58},{198,-22}})));
equation

  connect(batteryRack_9.battery_temperature, battery2_temperature) annotation (
      Line(points={{36,-140},{36,-130},{140,-130},{140,40},{160,40},{160,210}},
                                                              color={0,0,127}));
  connect(batteryRack_1.battery_temperature, battery1_temperature) annotation (
      Line(points={{36,200},{36,210},{92,210},{92,168},{120,168},{120,210}},
        color={0,0,127}));
  connect(lossFraction1.y, batteryRack_1.Battery_Loss)
    annotation (Line(points={{-19,190},{20,190}}, color={0,0,127}));
  connect(lossFraction2.y, batteryRack_2.Battery_Loss)
    annotation (Line(points={{-19,150},{20,150}}, color={0,0,127}));
  connect(lossFraction3.y, batteryRack_3.Battery_Loss)
    annotation (Line(points={{-19,110},{20,110}}, color={0,0,127}));
  connect(lossFraction4.y, batteryRack_4.Battery_Loss)
    annotation (Line(points={{-19,70},{20,70}}, color={0,0,127}));
  connect(lossFraction5.y, batteryRack_5.Battery_Loss)
    annotation (Line(points={{-19,30},{20,30}}, color={0,0,127}));
  connect(lossFraction6.y, batteryRack_6.Battery_Loss)
    annotation (Line(points={{-19,-30},{20,-30}}, color={0,0,127}));
  connect(lossFraction7.y, batteryRack_7.Battery_Loss)
    annotation (Line(points={{-19,-70},{20,-70}}, color={0,0,127}));
  connect(lossFraction8.y, batteryRack_8.Battery_Loss)
    annotation (Line(points={{-19,-110},{20,-110}}, color={0,0,127}));
  connect(lossFraction9.y, batteryRack_9.Battery_Loss)
    annotation (Line(points={{-19,-150},{20,-150}}, color={0,0,127}));
  connect(lossFraction10.y, batteryRack_10.Battery_Loss)
    annotation (Line(points={{-19,-190},{20,-190}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction1.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,190},{-42,190}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction2.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,150},{-42,150}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction3.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,110},{-42,110}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction4.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,70},{-42,70}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction5.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,30},{-42,30}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction6.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,-30},{-42,-30}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction7.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,-70},{-42,-70}}, color={0,0,127}));
  connect(Battery1_Loss, lossFraction8.u) annotation (Line(points={{-218,100},{-80,
          100},{-80,-110},{-42,-110}}, color={0,0,127}));
  connect(batteryRack_1.port_conv, convCollector.port_a[1]) annotation (Line(
        points={{40,186},{60,186},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_2.port_conv, convCollector.port_a[2]) annotation (Line(
        points={{40,146},{60,146},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_3.port_conv, convCollector.port_a[3]) annotation (Line(
        points={{40,106},{60,106},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_4.port_conv, convCollector.port_a[4]) annotation (Line(
        points={{40,66},{60,66},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_5.port_conv, convCollector.port_a[5]) annotation (Line(
        points={{40,26},{60,26},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_6.port_conv, convCollector.port_a[6]) annotation (Line(
        points={{40,-34},{60,-34},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_7.port_conv, convCollector.port_a[7]) annotation (Line(
        points={{40,-74},{60,-74},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_8.port_conv, convCollector.port_a[8]) annotation (Line(
        points={{40,-114},{60,-114},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_9.port_conv, convCollector.port_a[9]) annotation (Line(
        points={{40,-154},{60,-154},{60,-60},{94,-60}}, color={191,0,0}));
  connect(batteryRack_10.port_conv, convCollector.port_a[10]) annotation (Line(
        points={{40,-194},{60,-194},{60,-60},{94,-60}}, color={191,0,0}));
  connect(convCollector.port_b, port_conv)
    annotation (Line(points={{134,-60},{200,-60}}, color={191,0,0}));
  connect(batteryRack_1.star, star) annotation (Line(points={{40,192},{80,192},{
          80,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_2.star, star) annotation (Line(points={{40,152},{80,152},{
          80,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_3.star, star) annotation (Line(points={{40,112},{80,112},{
          80,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_4.star, star) annotation (Line(points={{40,72},{80,72},{80,
          60},{201,60}}, color={95,95,95}));
  connect(batteryRack_5.star, star) annotation (Line(points={{40,32},{80,32},{80,
          60},{201,60}}, color={95,95,95}));
  connect(batteryRack_6.star, star) annotation (Line(points={{40,-28},{80,-28},{
          80,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_7.star, star) annotation (Line(points={{40,-68},{80,-68},{
          80,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_8.star, star) annotation (Line(points={{40,-108},{80,-108},
          {80,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_9.star, star) annotation (Line(points={{40,-148},{80,-148},
          {80,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_10.star, star) annotation (Line(points={{40,-188},{80,-188},
          {80,60},{201,60}}, color={95,95,95}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}),
                                                      graphics={Rectangle(
          extent={{-160,160},{160,-160}},
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-136,40},{138,-32}},
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,
            200}})));
end BatteryRoom;
