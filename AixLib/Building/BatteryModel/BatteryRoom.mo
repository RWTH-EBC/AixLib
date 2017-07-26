within AixLib.Building.BatteryModel;
model BatteryRoom
  "Thermal model of a room, which contains racks of (different) battery types"
   parameter Integer nBatRacks=6   "Number of battery racks installed in the battery room" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=1 "1",
      choice=2 "2",
      choice=3 "3",
      choice=4 "4",
      choice=5 "5",
      choice=6 "6",
      choice=7 "7",
      choice=8 "8",
      choice=9 "9",
      choice=10 "10",
      radioButtons = true), choicesAllMatching = true);
   parameter Integer nBatTypes=1   "How many different Battery Types are installed in the room?" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=1 "1",
      choice=2 "2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType1 = true "Battery Type of Rack 1" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType2 = true "Battery Type of Rack 2" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType3 = true "Battery Type of Rack 3" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType4 = true "Battery Type of Rack 4" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType5 = true "Battery Type of Rack 5" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType6 = true "Battery Type of Rack 6" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType7 = true "Battery Type of Rack 7" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType8 = true "Battery Type of Rack 8" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType9 = true "Battery Type of Rack 9" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType10 = true "Battery Type of Rack 10" annotation (Dialog(
      tab="Battery Rack Types",
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);

  parameter AixLib.DataBase.Batteries.RackBaseDataDefinition rackParameters[10]=
     {AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0)} "Parameters for the different battery racks";

protected
  parameter Boolean batTypes[10] = {batType1, batType2, batType3, batType4, batType5, batType6, batType7, batType8, batType9, batType10} "List for the different Battery Types";
  parameter Integer listNBats[nBatRacks] = {if nBatRacks >= i then rackParameters[i].nParallels * rackParameters[i].nSeries * rackParameters[i].nStacked else 0 for i in 1:nBatRacks} "List for the different number of Batteries per rack";
  parameter Integer sumBatsType1 = sum({if batTypes[i] == true then listNBats[i] else 0 for i in 1:nBatRacks}) "Sum of installed batteries from type 1";
  parameter Integer sumBatsType2 = sum({if batTypes[i] == false then listNBats[i] else 0 for i in 1:nBatRacks}) "Sum of installed batteries from type 1";
  parameter Real listFractionFactors[nBatRacks] = {if batTypes[i] == true then listNBats[i] / sumBatsType1 else listNBats[i] / sumBatsType2 for i in 1:nBatRacks} "List of the fraction factors for the racks";

public
  Modelica.Blocks.Interfaces.RealInput Battery1_Loss
    "Thermal Loss of the first Battery Type - from external file"
                                                          annotation (Placement(
        transformation(extent={{-254,64},{-182,136}}), iconTransformation(
          extent={{-200,40},{-120,120}})));
  Modelica.Blocks.Interfaces.RealInput Battery2_Loss if nBatTypes == 2
    "Thermal Loss of the second Battery Type - from external file"
    annotation (Placement(transformation(extent={{-254,-136},{-182,-64}}),
        iconTransformation(extent={{-200,-120},{-120,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_conv
    "Port for the output of convection heat"                    annotation (
      Placement(transformation(extent={{172,-88},{228,-32}}),
        iconTransformation(extent={{162,-58},{198,-22}})));
  Utilities.Interfaces.Star        star "Port for the output of radiation heat"
                                        annotation (Placement(transformation(
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
    BatType=rackParameters[1].batType,
    nParallels=rackParameters[1].nParallels,
    nSeries=rackParameters[1].nSeries,
    nStacked=rackParameters[1].nStacked,
    airBetweenStacks=rackParameters[1].airBetweenStacks,
    batArrangement=rackParameters[1].batArrangement,
    areaStandingAtWall=rackParameters[1].areaStandingAtWall)
    annotation (Placement(transformation(extent={{20,180},{40,200}})));
  BatteryRack batteryRack_2(
    BatType=rackParameters[2].batType,
    nParallels=rackParameters[2].nParallels,
    nSeries=rackParameters[2].nSeries,
    nStacked=rackParameters[2].nStacked,
    airBetweenStacks=rackParameters[2].airBetweenStacks,
    batArrangement=rackParameters[2].batArrangement,
    areaStandingAtWall=rackParameters[2].areaStandingAtWall) if nBatRacks > 1
    annotation (Placement(transformation(extent={{20,140},{40,160}})));
  BatteryRack batteryRack_3(
    BatType=rackParameters[3].batType,
    nParallels=rackParameters[3].nParallels,
    nSeries=rackParameters[3].nSeries,
    nStacked=rackParameters[3].nStacked,
    airBetweenStacks=rackParameters[3].airBetweenStacks,
    batArrangement=rackParameters[3].batArrangement,
    areaStandingAtWall=rackParameters[3].areaStandingAtWall) if nBatRacks > 2
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  BatteryRack batteryRack_4(
    BatType=rackParameters[4].batType,
    nParallels=rackParameters[4].nParallels,
    nSeries=rackParameters[4].nSeries,
    nStacked=rackParameters[4].nStacked,
    airBetweenStacks=rackParameters[4].airBetweenStacks,
    batArrangement=rackParameters[4].batArrangement,
    areaStandingAtWall=rackParameters[4].areaStandingAtWall) if nBatRacks > 3
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  BatteryRack batteryRack_5(
    BatType=rackParameters[5].batType,
    nParallels=rackParameters[5].nParallels,
    nSeries=rackParameters[5].nSeries,
    nStacked=rackParameters[5].nStacked,
    airBetweenStacks=rackParameters[5].airBetweenStacks,
    batArrangement=rackParameters[5].batArrangement,
    areaStandingAtWall=rackParameters[5].areaStandingAtWall) if nBatRacks > 4
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  BatteryRack batteryRack_6(
    BatType=rackParameters[6].batType,
    nParallels=rackParameters[6].nParallels,
    nSeries=rackParameters[6].nSeries,
    nStacked=rackParameters[6].nStacked,
    airBetweenStacks=rackParameters[6].airBetweenStacks,
    batArrangement=rackParameters[6].batArrangement,
    areaStandingAtWall=rackParameters[6].areaStandingAtWall) if nBatRacks > 5
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  BatteryRack batteryRack_7(
    BatType=rackParameters[7].batType,
    nParallels=rackParameters[7].nParallels,
    nSeries=rackParameters[7].nSeries,
    nStacked=rackParameters[7].nStacked,
    airBetweenStacks=rackParameters[7].airBetweenStacks,
    batArrangement=rackParameters[7].batArrangement,
    areaStandingAtWall=rackParameters[7].areaStandingAtWall) if nBatRacks > 6
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  BatteryRack batteryRack_8(
    BatType=rackParameters[8].batType,
    nParallels=rackParameters[8].nParallels,
    nSeries=rackParameters[8].nSeries,
    nStacked=rackParameters[8].nStacked,
    airBetweenStacks=rackParameters[8].airBetweenStacks,
    batArrangement=rackParameters[8].batArrangement,
    areaStandingAtWall=rackParameters[8].areaStandingAtWall) if nBatRacks > 7
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));

  BatteryRack batteryRack_9(
    BatType=rackParameters[9].batType,
    nParallels=rackParameters[9].nParallels,
    nSeries=rackParameters[9].nSeries,
    nStacked=rackParameters[9].nStacked,
    airBetweenStacks=rackParameters[9].airBetweenStacks,
    batArrangement=rackParameters[9].batArrangement,
    areaStandingAtWall=rackParameters[9].areaStandingAtWall) if nBatRacks > 8
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
  BatteryRack batteryRack_10(
    BatType=rackParameters[10].batType,
    nParallels=rackParameters[10].nParallels,
    nSeries=rackParameters[10].nSeries,
    nStacked=rackParameters[10].nStacked,
    airBetweenStacks=rackParameters[10].airBetweenStacks,
    batArrangement=rackParameters[10].batArrangement,
    areaStandingAtWall=rackParameters[10].areaStandingAtWall) if nBatRacks > 9
    annotation (Placement(transformation(extent={{20,-200},{40,-180}})));

  Modelica.Blocks.Math.Gain lossFraction1(k=listFractionFactors[1])
    annotation (Placement(transformation(extent={{-40,180},{-20,200}})));
  Modelica.Blocks.Math.Gain lossFraction2(k=listFractionFactors[2]) if nBatRacks > 1
    annotation (Placement(transformation(extent={{-40,140},{-20,160}})));
  Modelica.Blocks.Math.Gain lossFraction3(k=listFractionFactors[3]) if nBatRacks > 2
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Modelica.Blocks.Math.Gain lossFraction4(k=listFractionFactors[4]) if nBatRacks > 3
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Math.Gain lossFraction5(k=listFractionFactors[5]) if nBatRacks > 4
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Math.Gain lossFraction6(k=listFractionFactors[6]) if nBatRacks > 5
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Math.Gain lossFraction7(k=listFractionFactors[7]) if nBatRacks > 6
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Gain lossFraction8(k=listFractionFactors[8]) if nBatRacks > 7
    annotation (Placement(transformation(extent={{-40,-120},{-20,-100}})));
  Modelica.Blocks.Math.Gain lossFraction9(k=listFractionFactors[9]) if nBatRacks > 8
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Modelica.Blocks.Math.Gain lossFraction10(k=listFractionFactors[10]) if nBatRacks > 9
    annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector convCollector(m=
        nBatRacks) "Collects the convection heat of the different racks"
                   annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={114,-60})));
  Modelica.Blocks.Logical.Switch lossSwitch1
    annotation (Placement(transformation(extent={{-80,180},{-60,200}})));
  Modelica.Blocks.Logical.Switch lossSwitch2 if nBatRacks > 1
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
  Modelica.Blocks.Logical.Switch lossSwitch3 if nBatRacks > 2
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  Modelica.Blocks.Logical.Switch lossSwitch4 if nBatRacks > 3
    annotation (Placement(transformation(extent={{-78,60},{-58,80}})));
  Modelica.Blocks.Logical.Switch lossSwitch5 if nBatRacks > 4
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Logical.Switch lossSwitch6 if nBatRacks > 5
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Logical.Switch lossSwitch7 if nBatRacks > 6
    annotation (Placement(transformation(extent={{-78,-80},{-58,-60}})));
  Modelica.Blocks.Logical.Switch lossSwitch8 if nBatRacks > 7
    annotation (Placement(transformation(extent={{-80,-120},{-60,-100}})));
  Modelica.Blocks.Logical.Switch lossSwitch9 if nBatRacks > 8
    annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
  Modelica.Blocks.Logical.Switch lossSwitch10 if nBatRacks > 9
    annotation (Placement(transformation(extent={{-80,-200},{-60,-180}})));
  Modelica.Blocks.Sources.RealExpression Zero1(y=0) if nBatTypes == 1
    annotation (Placement(transformation(extent={{-94,166},{-88,182}})));
  Modelica.Blocks.Sources.RealExpression Zero2(y=0) if nBatTypes == 1 and nBatRacks > 1
    annotation (Placement(transformation(extent={{-94,126},{-88,142}})));
  Modelica.Blocks.Sources.RealExpression Zero3(y=0) if nBatTypes == 1 and nBatRacks > 2
    annotation (Placement(transformation(extent={{-94,86},{-88,102}})));
  Modelica.Blocks.Sources.RealExpression Zero4(y=0) if nBatTypes == 1 and nBatRacks > 3
    annotation (Placement(transformation(extent={{-94,44},{-88,60}})));
  Modelica.Blocks.Sources.RealExpression Zero5(y=0) if nBatTypes == 1 and nBatRacks > 4
    annotation (Placement(transformation(extent={{-94,4},{-88,20}})));
  Modelica.Blocks.Sources.RealExpression Zero6(y=0) if nBatTypes == 1 and nBatRacks > 5
    annotation (Placement(transformation(extent={{-94,-54},{-88,-38}})));
  Modelica.Blocks.Sources.RealExpression Zero7(y=0) if nBatTypes == 1 and nBatRacks > 6
    annotation (Placement(transformation(extent={{-94,-94},{-88,-78}})));
  Modelica.Blocks.Sources.RealExpression Zero8(y=0) if nBatTypes == 1 and nBatRacks > 7
    annotation (Placement(transformation(extent={{-94,-134},{-88,-118}})));
  Modelica.Blocks.Sources.RealExpression Zero9(y=0) if nBatTypes == 1 and nBatRacks > 8
    annotation (Placement(transformation(extent={{-94,-176},{-88,-160}})));
  Modelica.Blocks.Sources.RealExpression Zero10(y=0) if nBatTypes == 1 and nBatRacks > 9
    annotation (Placement(transformation(extent={{-94,-212},{-88,-196}})));

  Modelica.Blocks.Sources.BooleanExpression batteryType1(y=batType1)
    annotation (Placement(transformation(extent={{-128,180},{-104,200}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType2(y=batType2) if nBatRacks > 1
    annotation (Placement(transformation(extent={{-128,140},{-104,160}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType3(y=batType3) if nBatRacks > 2
    annotation (Placement(transformation(extent={{-128,100},{-104,120}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType4(y=batType4) if nBatRacks > 3
    annotation (Placement(transformation(extent={{-128,60},{-104,80}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType5(y=batType5) if nBatRacks > 4
    annotation (Placement(transformation(extent={{-130,20},{-106,40}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType6(y=batType6) if nBatRacks > 5
    annotation (Placement(transformation(extent={{-130,-40},{-106,-20}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType7(y=batType7) if nBatRacks > 6
    annotation (Placement(transformation(extent={{-130,-80},{-106,-60}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType8(y=batType8) if nBatRacks > 7
    annotation (Placement(transformation(extent={{-130,-120},{-106,-100}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType9(y=batType9) if nBatRacks > 8
    annotation (Placement(transformation(extent={{-132,-160},{-108,-140}})));
  Modelica.Blocks.Sources.BooleanExpression batteryType10(y=batType6) if nBatRacks > 9
    annotation (Placement(transformation(extent={{-132,-200},{-108,-180}})));

  Utilities.Interfaces.ThermalRadiationCollector radCollector(m=nBatRacks)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={114,60})));

equation

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
  connect(lossSwitch1.y, lossFraction1.u)
    annotation (Line(points={{-59,190},{-42,190}}, color={0,0,127}));
  connect(lossSwitch2.y, lossFraction2.u)
    annotation (Line(points={{-59,150},{-42,150}}, color={0,0,127}));
  connect(lossSwitch3.y, lossFraction3.u)
    annotation (Line(points={{-59,110},{-42,110}}, color={0,0,127}));
  connect(lossSwitch4.y, lossFraction4.u)
    annotation (Line(points={{-57,70},{-42,70}}, color={0,0,127}));
  connect(lossSwitch5.y, lossFraction5.u)
    annotation (Line(points={{-59,30},{-42,30}}, color={0,0,127}));
  connect(lossSwitch6.y, lossFraction6.u)
    annotation (Line(points={{-59,-30},{-42,-30}}, color={0,0,127}));
  connect(lossSwitch7.y, lossFraction7.u)
    annotation (Line(points={{-57,-70},{-42,-70}}, color={0,0,127}));
  connect(lossSwitch8.y, lossFraction8.u)
    annotation (Line(points={{-59,-110},{-42,-110}}, color={0,0,127}));
  connect(lossSwitch9.y, lossFraction9.u)
    annotation (Line(points={{-59,-150},{-42,-150}}, color={0,0,127}));
  connect(lossSwitch10.y, lossFraction10.u)
    annotation (Line(points={{-59,-190},{-42,-190}}, color={0,0,127}));
  connect(Zero2.y, lossSwitch2.u3) annotation (Line(points={{-87.7,134},{-82,134},
          {-82,142}}, color={0,0,127}));
  connect(Zero3.y, lossSwitch3.u3)
    annotation (Line(points={{-87.7,94},{-82,94},{-82,102}}, color={0,0,127}));
  connect(Zero4.y, lossSwitch4.u3)
    annotation (Line(points={{-87.7,52},{-80,52},{-80,62}}, color={0,0,127}));
  connect(Zero5.y, lossSwitch5.u3)
    annotation (Line(points={{-87.7,12},{-82,12},{-82,22}}, color={0,0,127}));
  connect(Zero6.y, lossSwitch6.u3) annotation (Line(points={{-87.7,-46},{-82,-46},
          {-82,-38}}, color={0,0,127}));
  connect(Zero7.y, lossSwitch7.u3) annotation (Line(points={{-87.7,-86},{-80,-86},
          {-80,-78}}, color={0,0,127}));
  connect(Zero8.y, lossSwitch8.u3) annotation (Line(points={{-87.7,-126},{-82,-126},
          {-82,-118}}, color={0,0,127}));
  connect(Zero1.y, lossSwitch1.u3) annotation (Line(points={{-87.7,174},{-82,174},
          {-82,182}}, color={0,0,127}));
  connect(Zero9.y, lossSwitch9.u3) annotation (Line(points={{-87.7,-168},{-82,-168},
          {-82,-158}}, color={0,0,127}));
  connect(Zero10.y, lossSwitch10.u3) annotation (Line(points={{-87.7,-204},{-82,
          -204},{-82,-198}}, color={0,0,127}));
  connect(batteryType1.y, lossSwitch1.u2)
    annotation (Line(points={{-102.8,190},{-82,190}}, color={255,0,255}));
  connect(batteryType2.y, lossSwitch2.u2)
    annotation (Line(points={{-102.8,150},{-82,150}}, color={255,0,255}));
  connect(batteryType3.y, lossSwitch3.u2) annotation (Line(points={{-102.8,110},{-92,110},{-92,110},{
          -82,110}}, color={255,0,255}));
  connect(batteryType4.y, lossSwitch4.u2)
    annotation (Line(points={{-102.8,70},{-80,70}}, color={255,0,255}));
  connect(batteryType5.y, lossSwitch5.u2)
    annotation (Line(points={{-104.8,30},{-82,30}}, color={255,0,255}));
  connect(batteryType6.y, lossSwitch6.u2)
    annotation (Line(points={{-104.8,-30},{-82,-30}}, color={255,0,255}));
  connect(batteryType7.y, lossSwitch7.u2)
    annotation (Line(points={{-104.8,-70},{-80,-70}}, color={255,0,255}));
  connect(batteryType8.y, lossSwitch8.u2)
    annotation (Line(points={{-104.8,-110},{-82,-110}}, color={255,0,255}));
  connect(batteryType9.y, lossSwitch9.u2)
    annotation (Line(points={{-106.8,-150},{-82,-150}}, color={255,0,255}));
  connect(batteryType10.y, lossSwitch10.u2)
    annotation (Line(points={{-106.8,-190},{-82,-190}}, color={255,0,255}));
  connect(Battery1_Loss, lossSwitch1.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,198},{-82,198}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch2.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,158},{-82,158}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch3.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,118},{-82,118}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch4.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,78},{-80,78}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch5.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,38},{-82,38}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch6.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,-22},{-82,-22}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch7.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,-62},{-80,-62}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch8.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,-102},{-82,-102}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch9.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,-142},{-82,-142}}, color={0,0,127}));
  connect(Battery1_Loss, lossSwitch10.u1) annotation (Line(points={{-218,100},{-140,
          100},{-140,-182},{-82,-182}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch1.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,182},{-82,182}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch2.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,142},{-82,142}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch3.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,102},{-82,102}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch4.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,62},{-80,62}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch5.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,22},{-82,22}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch6.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,-38},{-82,-38}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch7.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,-78},{-80,-78}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch8.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,-118},{-82,-118}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch9.u3) annotation (Line(points={{-218,-100},{-160,
          -100},{-160,-158},{-82,-158}}, color={0,0,127}));
  connect(Battery2_Loss, lossSwitch10.u3) annotation (Line(points={{-218,-100},{
          -160,-100},{-160,-198},{-82,-198}}, color={0,0,127}));
  connect(convCollector.port_b, port_conv)
    annotation (Line(points={{134,-60},{200,-60}}, color={191,0,0}));
  connect(batteryRack_1.battery_temperature, battery1_temperature) annotation (
      Line(points={{36,200},{36,210},{92,210},{92,160},{120,160},{120,210}},
        color={0,0,127}));
  connect(batteryRack_10.battery_temperature, battery2_temperature) annotation (
     Line(points={{36,-180},{36,-168},{160,-168},{160,210}}, color={0,0,127}));
  connect(radCollector.Star_b, star)
    annotation (Line(points={{133.6,60},{201,60}}, color={95,95,95}));
  connect(batteryRack_1.star, radCollector.Star_a[1]) annotation (Line(points={{
          40,192},{80,192},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_2.star, radCollector.Star_a[2]) annotation (Line(points={{
          40,152},{80,152},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_3.star, radCollector.Star_a[3]) annotation (Line(points={{
          40,112},{80,112},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_4.star, radCollector.Star_a[4]) annotation (Line(points={{
          40,72},{80,72},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_5.star, radCollector.Star_a[5]) annotation (Line(points={{
          40,32},{80,32},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_6.star, radCollector.Star_a[6]) annotation (Line(points={{
          40,-28},{80,-28},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_7.star, radCollector.Star_a[7]) annotation (Line(points={{
          40,-68},{80,-68},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_8.star, radCollector.Star_a[8]) annotation (Line(points={{
          40,-108},{80,-108},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_9.star, radCollector.Star_a[9]) annotation (Line(points={{
          40,-148},{80,-148},{80,60},{94,60}}, color={95,95,95}));
  connect(batteryRack_10.star, radCollector.Star_a[10]) annotation (Line(points=
         {{40,-188},{80,-188},{80,60},{94,60}}, color={95,95,95}));
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
            200}})),
    Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>BatteryRoom</b> model represents the thermal behaviour of a room, which contains different battery racks. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>This is a base model, which can be expanded if there are more difficult models needed. This base model can deal with ten battery racks and two different types of installed battery types. </p>
<p>The model needs an input of heat loss of the batteries and separates this input automatically on the different battery racks.</p>
</ul>
<p><b><font style=\"color: #008000; \">Example</font></b> </p>
<p><a href=\"AixLib.Building.BatteryModel.ExampleBatteryRoom\">AixLib.Building.BatteryModel.ExampleBatteryRoom </a></p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>The model uses the <a href=\"AixLib.Utilities.Interfaces.ThermalRadiationCollector\">AixLib.Utilities.Interfaces.ThermalRadiationCollector </a>to collect the radiation heat of the different battery racks.
The <b>ThermalRadiationCollector</b> is based on the <b>ThermalCollector</b> from the Modelica Library.</p>
<p>The model uses the record <a href=\"AixLib.DataBase.Batteries.RackBaseDataDefinition\">AixLib.DataBase.Batteries.RackBaseDataDefinition </a>to define the rack parameters.</p>
</html>",  revisions="<html>
<ul>
<li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
</ul>
</html>"));
end BatteryRoom;
