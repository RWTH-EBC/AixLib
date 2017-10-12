within AixLib.Building.BatteryModel;
model BatteryRoom
  "Thermal model of a room, which contains racks of (different) battery types"

public
   parameter Integer nBatRack=6
   "Number of battery racks installed in the battery room" annotation (Dialog(
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
   parameter Integer nBatType=1
   "How many different battery types are installed in the room?"
      annotation (Dialog(
      descriptionLabel=true), choices(
      choice=1 "1",
      choice=2 "2",
      radioButtons = true), choicesAllMatching = true);

   parameter Boolean batType01 = true
   "Battery type of rack 1" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType02 = true
   "Battery type of rack 2" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType03 = true
   "Battery type of rack 3" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType04 = true
   "Battery type of rack 4" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType05 = true
   "Battery type of rack 5" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType06 = true
   "Battery type of rack 6" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType07 = true
   "Battery type of rack 7" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType08 = true
   "Battery type of rack 8" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType09 = true
   "Battery type of rack 9" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);
   parameter Boolean batType10 = true
   "Battery type of rack 10" annotation (Dialog(
      tab="Battery Rack Types", descriptionLabel=true), choices(
      choice=true "Type 1",
      choice=false "Type 2",
      radioButtons = true), choicesAllMatching = true);

   parameter AixLib.DataBase.Batteries.RackBaseDataDefinition
    rackParameters[10]=
     {AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
      batType=AixLib.DataBase.Batteries.LeadBattery1(),
      nParallel=0,
      nSeries=0,
      nStacked=0,
      airBetweenStacks=false,
      batArrangement=true,
      areaStandingAtWall=0)} "Parameters for the different battery racks";

  Modelica.Blocks.Interfaces.RealInput ThermalLossBat1
    "Thermal Loss of the first battery type - from external file"
    annotation (Placement(transformation(extent={{-254,64},{-182,136}}),
        iconTransformation(extent={{-200,40},{-120,120}})));
  Modelica.Blocks.Interfaces.RealInput ThermalLossBat2 if nBatType == 2
    "Thermal Loss of the second battery type - from external file"
    annotation (Placement(transformation(extent={{-254,-136},{-182,-64}}),
        iconTransformation(extent={{-200,-120},{-120,-40}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b PortConv
    "Port for the output of convection heat"
    annotation (Placement(transformation(extent={{172,-88},{228,-32}}),
        iconTransformation(extent={{162,-58},{198,-22}})));
  Utilities.Interfaces.Star Star "Port for the output of radiation heat"
    annotation (Placement(transformation(extent={{178,40},{224,80}}),
        iconTransformation(extent={{160,20},{200,60}})));

  Modelica.Blocks.Interfaces.RealOutput TemperatureBat1(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC")
    "Temperature of the first battery type"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={120,210}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,180})));
  Modelica.Blocks.Interfaces.RealOutput TemperatureBat2(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") if nBatType == 2
    "Temperature of the second battery type"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={160,210}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={120,180})));

  BatteryRack BatRack01(
    batType=rackParameters[1].batType,
    nParallel=rackParameters[1].nParallel,
    nSeries=rackParameters[1].nSeries,
    nStacked=rackParameters[1].nStacked,
    airBetweenStacks=rackParameters[1].airBetweenStacks,
    batArrangement=rackParameters[1].batArrangement,
    areaStandingAtWall=rackParameters[1].areaStandingAtWall)
    annotation (Placement(transformation(extent={{20,180},{40,200}})));
  BatteryRack BatRack02(
    batType=rackParameters[2].batType,
    nParallel=rackParameters[2].nParallel,
    nSeries=rackParameters[2].nSeries,
    nStacked=rackParameters[2].nStacked,
    airBetweenStacks=rackParameters[2].airBetweenStacks,
    batArrangement=rackParameters[2].batArrangement,
    areaStandingAtWall=rackParameters[2].areaStandingAtWall) if nBatRack > 1
    annotation (Placement(transformation(extent={{20,140},{40,160}})));
  BatteryRack BatRack03(
    batType=rackParameters[3].batType,
    nParallel=rackParameters[3].nParallel,
    nSeries=rackParameters[3].nSeries,
    nStacked=rackParameters[3].nStacked,
    airBetweenStacks=rackParameters[3].airBetweenStacks,
    batArrangement=rackParameters[3].batArrangement,
    areaStandingAtWall=rackParameters[3].areaStandingAtWall) if nBatRack > 2
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  BatteryRack BatRack04(
    batType=rackParameters[4].batType,
    nParallel=rackParameters[4].nParallel,
    nSeries=rackParameters[4].nSeries,
    nStacked=rackParameters[4].nStacked,
    airBetweenStacks=rackParameters[4].airBetweenStacks,
    batArrangement=rackParameters[4].batArrangement,
    areaStandingAtWall=rackParameters[4].areaStandingAtWall) if nBatRack > 3
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  BatteryRack BatRack05(
    batType=rackParameters[5].batType,
    nParallel=rackParameters[5].nParallel,
    nSeries=rackParameters[5].nSeries,
    nStacked=rackParameters[5].nStacked,
    airBetweenStacks=rackParameters[5].airBetweenStacks,
    batArrangement=rackParameters[5].batArrangement,
    areaStandingAtWall=rackParameters[5].areaStandingAtWall) if nBatRack > 4
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  BatteryRack BatRack06(
    batType=rackParameters[6].batType,
    nParallel=rackParameters[6].nParallel,
    nSeries=rackParameters[6].nSeries,
    nStacked=rackParameters[6].nStacked,
    airBetweenStacks=rackParameters[6].airBetweenStacks,
    batArrangement=rackParameters[6].batArrangement,
    areaStandingAtWall=rackParameters[6].areaStandingAtWall) if nBatRack > 5
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  BatteryRack BatRack07(
    batType=rackParameters[7].batType,
    nParallel=rackParameters[7].nParallel,
    nSeries=rackParameters[7].nSeries,
    nStacked=rackParameters[7].nStacked,
    airBetweenStacks=rackParameters[7].airBetweenStacks,
    batArrangement=rackParameters[7].batArrangement,
    areaStandingAtWall=rackParameters[7].areaStandingAtWall) if nBatRack > 6
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  BatteryRack BatRack08(
    batType=rackParameters[8].batType,
    nParallel=rackParameters[8].nParallel,
    nSeries=rackParameters[8].nSeries,
    nStacked=rackParameters[8].nStacked,
    airBetweenStacks=rackParameters[8].airBetweenStacks,
    batArrangement=rackParameters[8].batArrangement,
    areaStandingAtWall=rackParameters[8].areaStandingAtWall) if nBatRack > 7
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  BatteryRack BatRack09(
    batType=rackParameters[9].batType,
    nParallel=rackParameters[9].nParallel,
    nSeries=rackParameters[9].nSeries,
    nStacked=rackParameters[9].nStacked,
    airBetweenStacks=rackParameters[9].airBetweenStacks,
    batArrangement=rackParameters[9].batArrangement,
    areaStandingAtWall=rackParameters[9].areaStandingAtWall) if nBatRack > 8
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
  BatteryRack BatRack10(
    batType=rackParameters[10].batType,
    nParallel=rackParameters[10].nParallel,
    nSeries=rackParameters[10].nSeries,
    nStacked=rackParameters[10].nStacked,
    airBetweenStacks=rackParameters[10].airBetweenStacks,
    batArrangement=rackParameters[10].batArrangement,
    areaStandingAtWall=rackParameters[10].areaStandingAtWall) if nBatRack > 9
    annotation (Placement(transformation(extent={{20,-200},{40,-180}})));

  Modelica.Blocks.Math.Gain LossFraction01(final k=listFractionFactors[1])
    "Block to calculate the part of the thermal loss of the battery for 
    rack 1"
    annotation (Placement(transformation(extent={{-40,180},{-20,200}})));
  Modelica.Blocks.Math.Gain LossFraction02(final k=listFractionFactors[2]) if
       nBatRack > 1
    "Block to calculate the part of the thermal loss of the battery for 
    rack 2"
    annotation (Placement(transformation(extent={{-40,140},{-20,160}})));
  Modelica.Blocks.Math.Gain LossFraction03(final k=listFractionFactors[3]) if
       nBatRack > 2
    "Block to calculate the part of the thermal loss of the battery for 
    rack 3"
    annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
  Modelica.Blocks.Math.Gain LossFraction04(final k=listFractionFactors[4]) if
       nBatRack > 3
    "Block to calculate the part of the thermal loss of the battery for 
    rack 4"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Math.Gain LossFraction05(final k=listFractionFactors[5]) if
       nBatRack > 4
    "Block to calculate the part of the thermal loss of the battery for 
    rack 5"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Math.Gain LossFraction06(final k=listFractionFactors[6]) if
       nBatRack > 5
    "Block to calculate the part of the thermal loss of the battery for 
    rack 6"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Math.Gain LossFraction07(final k=listFractionFactors[7]) if
       nBatRack > 6
    "Block to calculate the part of the thermal loss of the battery for 
    rack 7"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Gain LossFraction08(final k=listFractionFactors[8]) if
       nBatRack > 7
    "Block to calculate the part of the thermal loss of the battery for 
    rack 8"
    annotation (Placement(transformation(extent={{-40,-120},{-20,-100}})));
  Modelica.Blocks.Math.Gain LossFraction09(final k=listFractionFactors[9]) if
       nBatRack > 8
    "Block to calculate the part of the thermal loss of the battery for 
    rack 9"
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Modelica.Blocks.Math.Gain LossFraction10(final k=listFractionFactors[10]) if
       nBatRack > 9
    "Block to calculate the part of the thermal loss of the battery for 
    rack 10"
    annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector ConvCollector(
     final m=nBatRack)
    "Collects the convection heat of the different racks"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={114,-60})));
  Utilities.Interfaces.ThermalRadiationCollector RadCollector(
     final m=nBatRack)
    "Collects the radiation heat of the different racks"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={114,60})));

  Modelica.Blocks.Logical.Switch LossSwitch01
  "Block to calculate the part of the thermal loss of the battery for 
    rack 1"
    annotation (Placement(transformation(extent={{-80,180},{-60,200}})));
  Modelica.Blocks.Logical.Switch LossSwitch02 if nBatRack > 1
  "Block to calculate the part of the thermal loss of the battery for 
    rack 2"
    annotation (Placement(transformation(extent={{-80,140},{-60,160}})));
  Modelica.Blocks.Logical.Switch LossSwitch03 if nBatRack > 2
  "Block to calculate the part of the thermal loss of the battery for 
    rack 3"
    annotation (Placement(transformation(extent={{-80,100},{-60,120}})));
  Modelica.Blocks.Logical.Switch LossSwitch04 if nBatRack > 3
  "Block to calculate the part of the thermal loss of the battery for 
    rack 4"
    annotation (Placement(transformation(extent={{-78,60},{-58,80}})));
  Modelica.Blocks.Logical.Switch LossSwitch05 if nBatRack > 4
  "Block to calculate the part of the thermal loss of the battery for 
    rack 5"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Logical.Switch LossSwitch06 if nBatRack > 5
  "Block to calculate the part of the thermal loss of the battery for 
    rack 6"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Logical.Switch LossSwitch07 if nBatRack > 6
  "Block to calculate the part of the thermal loss of the battery for 
    rack 7"
    annotation (Placement(transformation(extent={{-78,-80},{-58,-60}})));
  Modelica.Blocks.Logical.Switch LossSwitch08 if nBatRack > 7
  "Block to calculate the part of the thermal loss of the battery for 
    rack 8"
    annotation (Placement(transformation(extent={{-80,-120},{-60,-100}})));
  Modelica.Blocks.Logical.Switch LossSwitch09 if nBatRack > 8
  "Block to calculate the part of the thermal loss of the battery for 
    rack 9"
    annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));
  Modelica.Blocks.Logical.Switch LossSwitch10 if nBatRack > 9
  "Block to calculate the part of the thermal loss of the battery for 
    rack 10"
    annotation (Placement(transformation(extent={{-80,-200},{-60,-180}})));

  Modelica.Blocks.Sources.RealExpression Zero01(y=0) if
       nBatType == 1
  "Block to calculate the part of the thermal loss of the battery for 
    rack 1"
    annotation (Placement(transformation(extent={{-94,166},{-88,182}})));
  Modelica.Blocks.Sources.RealExpression Zero02(y=0) if
       nBatType == 1 and nBatRack > 1
  "Block to calculate the part of the thermal loss of the battery for 
    rack 2"
    annotation (Placement(transformation(extent={{-94,126},{-88,142}})));
  Modelica.Blocks.Sources.RealExpression Zero03(y=0) if
       nBatType == 1 and nBatRack > 2
  "Block to calculate the part of the thermal loss of the battery for 
    rack 3"
    annotation (Placement(transformation(extent={{-94,86},{-88,102}})));
  Modelica.Blocks.Sources.RealExpression Zero04(y=0) if
       nBatType == 1 and nBatRack > 3
  "Block to calculate the part of the thermal loss of the battery for 
    rack 4"
    annotation (Placement(transformation(extent={{-94,44},{-88,60}})));
  Modelica.Blocks.Sources.RealExpression Zero05(y=0) if
       nBatType == 1 and nBatRack > 4
  "Block to calculate the part of the thermal loss of the battery for 
    rack 5"
    annotation (Placement(transformation(extent={{-94,4},{-88,20}})));
  Modelica.Blocks.Sources.RealExpression Zero06(y=0) if
       nBatType == 1 and nBatRack > 5
  "Block to calculate the part of the thermal loss of the battery for 
    rack 6"
    annotation (Placement(transformation(extent={{-94,-54},{-88,-38}})));
  Modelica.Blocks.Sources.RealExpression Zero07(y=0) if
       nBatType == 1 and nBatRack > 6
  "Block to calculate the part of the thermal loss of the battery for 
    rack 7"
    annotation (Placement(transformation(extent={{-94,-94},{-88,-78}})));
  Modelica.Blocks.Sources.RealExpression Zero08(y=0) if
       nBatType == 1 and nBatRack > 7
  "Block to calculate the part of the thermal loss of the battery for 
    rack 8"
    annotation (Placement(transformation(extent={{-94,-134},{-88,-118}})));
  Modelica.Blocks.Sources.RealExpression Zero09(y=0) if
       nBatType == 1 and nBatRack > 8
  "Block to calculate the part of the thermal loss of the battery for 
    rack 9"
    annotation (Placement(transformation(extent={{-94,-176},{-88,-160}})));
  Modelica.Blocks.Sources.RealExpression Zero10(y=0) if
       nBatType == 1 and nBatRack > 9
  "Block to calculate the part of the thermal loss of the battery for 
    rack 10"
    annotation (Placement(transformation(extent={{-94,-212},{-88,-196}})));

  Modelica.Blocks.Sources.BooleanExpression BatType01(y=batType01)
  "Block to calculate the part of the thermal loss of the battery for 
    rack 1"
    annotation (Placement(transformation(extent={{-128,180},{-104,200}})));
  Modelica.Blocks.Sources.BooleanExpression BatType02(y=batType02) if
       nBatRack > 1
  "Block to calculate the part of the thermal loss of the battery for 
    rack 2"
    annotation (Placement(transformation(extent={{-128,140},{-104,160}})));
  Modelica.Blocks.Sources.BooleanExpression BatType03(y=batType03) if
       nBatRack > 2
  "Block to calculate the part of the thermal loss of the battery for 
    rack 3"
    annotation (Placement(transformation(extent={{-128,100},{-104,120}})));
  Modelica.Blocks.Sources.BooleanExpression BatType04(y=batType04) if
       nBatRack > 3
  "Block to calculate the part of the thermal loss of the battery for 
    rack 4"
    annotation (Placement(transformation(extent={{-128,60},{-104,80}})));
  Modelica.Blocks.Sources.BooleanExpression BatType05(y=batType05) if
       nBatRack > 4
  "Block to calculate the part of the thermal loss of the battery for 
    rack 5"
    annotation (Placement(transformation(extent={{-130,20},{-106,40}})));
  Modelica.Blocks.Sources.BooleanExpression BatType06(y=batType06) if
       nBatRack > 5
  "Block to calculate the part of the thermal loss of the battery for 
    rack 6"
    annotation (Placement(transformation(extent={{-130,-40},{-106,-20}})));
  Modelica.Blocks.Sources.BooleanExpression BatType07(y=batType07) if
       nBatRack > 6
  "Block to calculate the part of the thermal loss of the battery for 
    rack 7"
    annotation (Placement(transformation(extent={{-130,-80},{-106,-60}})));
  Modelica.Blocks.Sources.BooleanExpression BatType08(y=batType08) if
       nBatRack > 7
  "Block to calculate the part of the thermal loss of the battery for 
    rack 8"
    annotation (Placement(transformation(extent={{-130,-120},{-106,-100}})));
  Modelica.Blocks.Sources.BooleanExpression BatType09(y=batType09) if
       nBatRack > 8
  "Block to calculate the part of the thermal loss of the battery for 
    rack 9"
    annotation (Placement(transformation(extent={{-132,-160},{-108,-140}})));
  Modelica.Blocks.Sources.BooleanExpression BatType10(y=batType10) if
       nBatRack > 9
  "Block to calculate the part of the thermal loss of the battery for 
    rack 10"
    annotation (Placement(transformation(extent={{-132,-200},{-108,-180}})));

protected
  parameter Boolean listBatType[10]=
    {batType01, batType02, batType03, batType04, batType05,
     batType06, batType07, batType08, batType09, batType10}
     "List for the different battery types";
  parameter Integer listNBat[nBatRack]=
    {if nBatRack >= i
     then rackParameters[i].nParallel * rackParameters[i].nSeries *
          rackParameters[i].nStacked
     else 0
     for i in 1:nBatRack}
    "List for the different number of batteries per rack";
  parameter Integer sumBatType1=
    sum({if listBatType[i] == true
         then listNBat[i]
         else 0
         for i in 1:nBatRack})
    "Sum of installed batteries from type 1";
  parameter Integer sumBatType2=
    sum({if listBatType[i] == false
         then listNBat[i]
         else 0
         for i in 1:nBatRack})
    "Sum of installed batteries from type 2";
  parameter Real listFractionFactors[nBatRack]=
    {if listBatType[i] == true
     then listNBat[i] / sumBatType1
     else listNBat[i] / sumBatType2
     for i in 1:nBatRack}
     "List of the fraction factors for the racks";

equation

  connect(LossFraction01.y, BatRack01.ThermalLoss)
    annotation (Line(points={{-19,190},{20,190}}, color={0,0,127}));
  connect(LossFraction02.y, BatRack02.ThermalLoss)
    annotation (Line(points={{-19,150},{20,150}}, color={0,0,127}));
  connect(LossFraction03.y, BatRack03.ThermalLoss)
    annotation (Line(points={{-19,110},{20,110}}, color={0,0,127}));
  connect(LossFraction04.y, BatRack04.ThermalLoss)
    annotation (Line(points={{-19,70},{20,70}}, color={0,0,127}));
  connect(LossFraction05.y, BatRack05.ThermalLoss)
    annotation (Line(points={{-19,30},{20,30}}, color={0,0,127}));
  connect(LossFraction06.y, BatRack06.ThermalLoss)
    annotation (Line(points={{-19,-30},{20,-30}}, color={0,0,127}));
  connect(LossFraction07.y, BatRack07.ThermalLoss)
    annotation (Line(points={{-19,-70},{20,-70}}, color={0,0,127}));
  connect(LossFraction08.y, BatRack08.ThermalLoss)
    annotation (Line(points={{-19,-110},{20,-110}}, color={0,0,127}));
  connect(LossFraction09.y, BatRack09.ThermalLoss)
    annotation (Line(points={{-19,-150},{20,-150}}, color={0,0,127}));
  connect(LossFraction10.y, BatRack10.ThermalLoss)
    annotation (Line(points={{-19,-190},{20,-190}}, color={0,0,127}));
  connect(BatRack01.PortConv, ConvCollector.port_a[1])
    annotation (Line(points={{40,186},{60,186},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack02.PortConv, ConvCollector.port_a[2])
    annotation (Line(points={{40,146},{60,146},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack03.PortConv, ConvCollector.port_a[3])
    annotation (Line(points={{40,106},{60,106},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack04.PortConv, ConvCollector.port_a[4])
    annotation (Line(points={{40,66},{60,66},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack05.PortConv, ConvCollector.port_a[5])
    annotation (Line(points={{40,26},{60,26},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack06.PortConv, ConvCollector.port_a[6])
    annotation (Line(points={{40,-34},{60,-34},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack07.PortConv, ConvCollector.port_a[7])
    annotation (Line(points={{40,-74},{60,-74},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack08.PortConv, ConvCollector.port_a[8])
    annotation (Line(points={{40,-114},{60,-114},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack09.PortConv, ConvCollector.port_a[9])
    annotation (Line(points={{40,-154},{60,-154},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(BatRack10.PortConv, ConvCollector.port_a[10])
    annotation (Line(points={{40,-194},{60,-194},{60,-60},{94,-60}},
                color={191,0,0}));
  connect(LossSwitch01.y, LossFraction01.u)
    annotation (Line(points={{-59,190},{-42,190}}, color={0,0,127}));
  connect(LossSwitch02.y, LossFraction02.u)
    annotation (Line(points={{-59,150},{-42,150}}, color={0,0,127}));
  connect(LossSwitch03.y, LossFraction03.u)
    annotation (Line(points={{-59,110},{-42,110}}, color={0,0,127}));
  connect(LossSwitch04.y, LossFraction04.u)
    annotation (Line(points={{-57,70},{-42,70}}, color={0,0,127}));
  connect(LossSwitch05.y, LossFraction05.u)
    annotation (Line(points={{-59,30},{-42,30}}, color={0,0,127}));
  connect(LossSwitch06.y, LossFraction06.u)
    annotation (Line(points={{-59,-30},{-42,-30}}, color={0,0,127}));
  connect(LossSwitch07.y, LossFraction07.u)
    annotation (Line(points={{-57,-70},{-42,-70}}, color={0,0,127}));
  connect(LossSwitch08.y, LossFraction08.u)
    annotation (Line(points={{-59,-110},{-42,-110}}, color={0,0,127}));
  connect(LossSwitch09.y, LossFraction09.u)
    annotation (Line(points={{-59,-150},{-42,-150}}, color={0,0,127}));
  connect(LossSwitch10.y, LossFraction10.u)
    annotation (Line(points={{-59,-190},{-42,-190}}, color={0,0,127}));
  connect(Zero02.y, LossSwitch02.u3)
    annotation (Line(points={{-87.7,134},{-82,134},{-82,142}},
                color={0,0,127}));
  connect(Zero03.y, LossSwitch03.u3)
    annotation (Line(points={{-87.7,94},{-82,94},{-82,102}}, color={0,0,127}));
  connect(Zero04.y, LossSwitch04.u3)
    annotation (Line(points={{-87.7,52},{-80,52},{-80,62}}, color={0,0,127}));
  connect(Zero05.y, LossSwitch05.u3)
    annotation (Line(points={{-87.7,12},{-82,12},{-82,22}}, color={0,0,127}));
  connect(Zero06.y, LossSwitch06.u3)
    annotation (Line(points={{-87.7,-46},{-82,-46},{-82,-38}},
                color={0,0,127}));
  connect(Zero07.y, LossSwitch07.u3)
    annotation (Line(points={{-87.7,-86},{-80,-86},{-80,-78}},
                color={0,0,127}));
  connect(Zero08.y, LossSwitch08.u3)
    annotation (Line(points={{-87.7,-126},{-82,-126},{-82,-118}},
                color={0,0,127}));
  connect(Zero01.y, LossSwitch01.u3)
    annotation (Line(points={{-87.7,174},{-82,174},{-82,182}},
                color={0,0,127}));
  connect(Zero09.y, LossSwitch09.u3)
    annotation (Line(points={{-87.7,-168},{-82,-168},{-82,-158}},
                color={0,0,127}));
  connect(Zero10.y, LossSwitch10.u3)
    annotation (Line(points={{-87.7,-204},{-82,-204},{-82,-198}},
                color={0,0,127}));
  connect(BatType01.y, LossSwitch01.u2)
    annotation (Line(points={{-102.8,190},{-82,190}}, color={255,0,255}));
  connect(BatType02.y, LossSwitch02.u2)
    annotation (Line(points={{-102.8,150},{-82,150}}, color={255,0,255}));
  connect(BatType03.y, LossSwitch03.u2)
    annotation (Line(points={{-102.8,110},{-92,110},{-92,110},{-82,110}},
                color={255,0,255}));
  connect(BatType04.y, LossSwitch04.u2)
    annotation (Line(points={{-102.8,70},{-80,70}}, color={255,0,255}));
  connect(BatType05.y, LossSwitch05.u2)
    annotation (Line(points={{-104.8,30},{-82,30}}, color={255,0,255}));
  connect(BatType06.y, LossSwitch06.u2)
    annotation (Line(points={{-104.8,-30},{-82,-30}}, color={255,0,255}));
  connect(BatType07.y, LossSwitch07.u2)
    annotation (Line(points={{-104.8,-70},{-80,-70}}, color={255,0,255}));
  connect(BatType08.y, LossSwitch08.u2)
    annotation (Line(points={{-104.8,-110},{-82,-110}}, color={255,0,255}));
  connect(BatType09.y, LossSwitch09.u2)
    annotation (Line(points={{-106.8,-150},{-82,-150}}, color={255,0,255}));
  connect(BatType10.y, LossSwitch10.u2)
    annotation (Line(points={{-106.8,-190},{-82,-190}}, color={255,0,255}));
  connect(ThermalLossBat1, LossSwitch01.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,198},{-82,198}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch02.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,158},{-82,158}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch03.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,118},{-82,118}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch04.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,78},{-80,78}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch05.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,38},{-82,38}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch06.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,-22},{-82,-22}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch07.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,-62},{-80,-62}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch08.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,-102},{-82,-102}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch09.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,-142},{-82,-142}},
                color={0,0,127}));
  connect(ThermalLossBat1, LossSwitch10.u1)
    annotation (Line(points={{-218,100},{-140,100},{-140,-182},{-82,-182}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch01.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,182},{-82,182}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch02.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,142},{-82,142}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch03.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,102},{-82,102}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch04.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,62},{-80,62}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch05.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,22},{-82,22}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch06.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,-38},{-82,-38}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch07.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,-78},{-80,-78}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch08.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,-118},{-82,-118}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch09.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,-158},{-82,-158}},
                color={0,0,127}));
  connect(ThermalLossBat2, LossSwitch10.u3)
    annotation (Line(points={{-218,-100},{-160,-100},{-160,-198},{-82,-198}},
                color={0,0,127}));
  connect(ConvCollector.port_b, PortConv)
    annotation (Line(points={{134,-60},{200,-60}}, color={191,0,0}));
  connect(BatRack01.TemperatureBat, TemperatureBat1)
    annotation (
      Line(points={{36,200},{36,210},{92,210},{92,160},{120,160},{120,210}},
        color={0,0,127}));
  connect(BatRack10.TemperatureBat, TemperatureBat2)
    annotation (
     Line(points={{36,-180},{36,-168},{160,-168},{160,210}}, color={0,0,127}));
  connect(RadCollector.Star_b, Star)
    annotation (Line(points={{133.6,60},{201,60}}, color={95,95,95}));
  connect(BatRack01.Star, RadCollector.Star_a[1])
    annotation (Line(points={{
          40,192},{80,192},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack02.Star, RadCollector.Star_a[2])
    annotation (Line(points={{
          40,152},{80,152},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack03.Star, RadCollector.Star_a[3])
    annotation (Line(points={{
          40,112},{80,112},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack04.Star, RadCollector.Star_a[4])
    annotation (Line(points={{
          40,72},{80,72},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack05.Star, RadCollector.Star_a[5])
    annotation (Line(points={{
          40,32},{80,32},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack06.Star, RadCollector.Star_a[6])
    annotation (Line(points={{
          40,-28},{80,-28},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack07.Star, RadCollector.Star_a[7])
    annotation (Line(points={{
          40,-68},{80,-68},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack08.Star, RadCollector.Star_a[8])
    annotation (Line(points={{
          40,-108},{80,-108},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack09.Star, RadCollector.Star_a[9])
    annotation (Line(points={{
          40,-148},{80,-148},{80,60},{94,60}}, color={95,95,95}));
  connect(BatRack10.Star, RadCollector.Star_a[10])
    annotation (Line(points=
         {{40,-188},{80,-188},{80,60},{94,60}}, color={95,95,95}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false,
         extent={{-200,-200},{200,200}}), graphics={Rectangle(
          extent={{-160,160},{160,-160}},
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-136,40},{138,-32}},
          lineColor={28,108,200},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-200,-200},{200,200}})),
    Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>BatteryRoom</b> model represents the thermal 
behaviour of a room, which contains different battery racks. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>This is a base model, which can be expanded if there are more difficult 
models needed. This base model can deal with ten battery racks and two 
different types of installed battery types. </p>
<p>The model needs an input of heat loss of the batteries and separates 
this input automatically on the different battery racks.</p>
<p><b><font style=\"color: #008000; \">Example</font></b> </p>
<p><a href=\"AixLib.Building.BatteryModel.ExampleBatteryRoom\">AixLib.Building.BatteryModel.ExampleBatteryRoom </a></p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>The model uses the 
<a href=\"AixLib.Utilities.Interfaces.ThermalRadiationCollector\">AixLib.Utilities.Interfaces.ThermalRadiationCollector </a>
to collect the radiation heat of the different battery racks.
The <b>ThermalRadiationCollector</b> is based on the <b>ThermalCollector</b> 
from the Modelica Library.</p>
<p>The model uses the record 
<a href=\"AixLib.DataBase.Batteries.RackBaseDataDefinition\">AixLib.DataBase.Batteries.RackBaseDataDefinition </a>
to define the rack parameters.</p>
</html>",  revisions="<html>
<ul>
<li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
</ul>
</html>"));
end BatteryRoom;
