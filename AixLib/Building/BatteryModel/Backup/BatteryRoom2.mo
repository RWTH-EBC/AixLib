within AixLib.Building.BatteryModel.Backup;
model BatteryRoom2 "Room of racked batteries, which are placed side by side"
   parameter Integer nBatRacks=8   "Number of battery racks installed in the battery room";
   parameter Integer nBatTypes = 1 "How many different Battery Types are installed in the room?" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=1 "1",
      choice=2 "2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType1 = true "Battery Type of Rack 1" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType2 = true "Battery Type of Rack 2" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType3 = true "Battery Type of Rack 3" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType4 = true "Battery Type of Rack 4" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType5 = true "Battery Type of Rack 5" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType6 = true "Battery Type of Rack 6" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType7 = true "Battery Type of Rack 7" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType8 = true "Battery Type of Rack 8" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType9 = true "Battery Type of Rack 9" annotation (Dialog(
      descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType10 = true "Battery Type of Rack 10" annotation (Dialog(
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
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallels=0,
      nSeries=0,
      nStacked=0,
      AirBetweenStacks=false,
      BatArrangement=true,
      AreaStandingAtWall=0)} "Parameters for the different battery racks";

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

  Boolean batTypes[10] = {batType1, batType2, batType3, batType4, batType5, batType6, batType7, batType8, batType9, batType10} "List for the different Battery Types";
  Integer listNBats[nBatRacks] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0} "List for the different number of Batteries per rack";
  constant Integer sumBatsType1 "Sum of installed batteries from type 1";
  constant Integer sumBatsType2 "Sum of installed batteries from type 2";
  parameter Real listFractionFactors[nBatRacks] "List of the fraction factors for the racks";

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
    BatType=rackParameters[1,1],
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
        nBatRacks) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={114,-60})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_conv annotation (
      Placement(transformation(extent={{172,-88},{228,-32}}),
        iconTransformation(extent={{162,-58},{198,-22}})));
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

initial equation

  if nBatRacks == 1 then
    listNBats = {batteryRack_1.nBats, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  elseif nBatRacks == 2 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, 0, 0, 0, 0, 0, 0, 0, 0};
  elseif nBatRacks == 3 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, 0, 0, 0, 0, 0, 0, 0};
  elseif nBatRacks == 4 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, batteryRack_4.nBats, 0, 0, 0, 0, 0, 0};
  elseif nBatRacks == 5 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, batteryRack_4.nBats, batteryRack_5.nBats, 0, 0, 0, 0, 0};
  elseif nBatRacks == 6 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, batteryRack_4.nBats, batteryRack_5.nBats, batteryRack_6.nBats, 0, 0, 0, 0};
  elseif nBatRacks == 7 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, batteryRack_4.nBats, batteryRack_5.nBats, batteryRack_6.nBats, batteryRack_7.nBats, 0, 0, 0};
  elseif nBatRacks == 8 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, batteryRack_4.nBats, batteryRack_5.nBats, batteryRack_6.nBats, batteryRack_7.nBats, batteryRack_8.nBats, 0, 0};
  elseif nBatRacks == 9 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, batteryRack_4.nBats, batteryRack_5.nBats, batteryRack_6.nBats, batteryRack_7.nBats, batteryRack_8.nBats, batteryRack_9.nBats, 0};
  elseif nBatRacks == 10 then
    listNBats = {batteryRack_1.nBats, batteryRack_2.nBats, batteryRack_3.nBats, batteryRack_4.nBats, batteryRack_5.nBats, batteryRack_6.nBats, batteryRack_7.nBats, batteryRack_8.nBats, batteryRack_9.nBats, batteryRack_10.nBats};
  end if;

  for i in 1:nBatRacks loop
    if batTypes[i] == true then
      sumBatsType1 = sumBatsType1 + listNBats[i];
    else
      sumBatsType2 = sumBatsType2 + listNBats[i];
    end if;
  end for;

  for j in 1:nBatRacks loop
    if batTypes[j] == true then
      listFractionFactors[j] = listNBats[j] / sumBatsType1;
    else
      listFractionFactors[j] = listNBats[j] / sumBatsType2;
    end if;
  end for;

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
end BatteryRoom2;
