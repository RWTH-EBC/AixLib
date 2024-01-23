within AixLib.ThermalZones.HighOrder.House.MFD.EnergySystem.OneAppartment;
model Radiators
  //Pipe lengths
 replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the system"                                                                             annotation(Dialog(group = "Medium"), choicesAllMatching = true);
  parameter Modelica.Units.SI.Length Length_thSt=2.5 "L1" annotation (Dialog(
      group="Pipe lengths",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length Length_thBath=2.5 "L2  " annotation (
      Dialog(
      group="Pipe lengths",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length Length_thChildren1=2.3 "L3  " annotation (
      Dialog(
      group="Pipe lengths",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length Length_thChildren2=1.5 "L4  "
    annotation (Dialog(group="Pipe lengths", descriptionLabel=true));
  parameter Modelica.Units.SI.Length Length_toKi=2.5 "l5" annotation (Dialog(
      group="Pipe lengths",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length Length_toBath=2 "l4  " annotation (Dialog(
      group="Pipe lengths",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length Length_toChildren=0.5 "l3  " annotation (
      Dialog(
      group="Pipe lengths",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length Length_toBedroom=4.0 "l2  " annotation (
      Dialog(
      group="Pipe lengths",
      descriptionLabel=true,
      joinNext=true));
  parameter Modelica.Units.SI.Length Length_toLi=7 "l1  " annotation (Dialog(
      group="Pipe lengths",
      groupImage=
          "modelica://AixLib/Resources/Images/Building/HighOrder/GroundFloor_Hydraulics.png",

      descriptionLabel=true));
  //Pipe diameters
  parameter Modelica.Units.SI.Diameter Diam_Main=0.016 "Diameter main pipe"
    annotation (Dialog(group="Pipe diameters", descriptionLabel=true));
  parameter Modelica.Units.SI.Diameter Diam_Sec=0.013
    "Diameter secondary pipe  "
    annotation (Dialog(group="Pipe diameters", descriptionLabel=true));
  //Hydraulic resistance
  parameter Real zeta_lateral = 2.5 "zeta lateral" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true, joinNext = true));
  parameter Real zeta_through = 0.6 "zeta through" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true));
  parameter Real zeta_bend = 1.0 "zeta bend" annotation(Dialog(group = "Hydraulic resistance", descriptionLabel = true));
  //Radiators
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition Type_Radiator_Livingroom = AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom()
    "Livingroom"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition Type_Radiator_Bedroom = AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Bedroom()
    "Bedroom"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition Type_Radiator_Children = AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Children()
    "Corridor"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition Type_Radiator_Bath = AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Bathroom() "Bath" annotation(Dialog(group = "Radiators", descriptionLabel = true));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition Type_Radiator_Kitchen = AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Kitchen()
    "Kitchen"                                                                                                     annotation(Dialog(group = "Radiators", descriptionLabel = true));
  Fluid.HeatExchangers.Radiators.Radiator radiatorKi(
    radiatorType=Type_Radiator_Kitchen,
    m_flow_nominal=0.01,
    redeclare package Medium = Medium,
    selectable=true)
    annotation (Placement(transformation(extent={{-89,-83},{-106,-66}})));
  Fluid.HeatExchangers.Radiators.Radiator radiatorBa(
    radiatorType=Type_Radiator_Bath,
    m_flow_nominal=0.01,
    redeclare package Medium = Medium,
    selectable=true)
    annotation (Placement(transformation(extent={{83,-48},{100,-31}})));
  Obsolete.Year2021.Fluid.Actuators.Valves.ThermostaticValve valveKi(
    Kvs=0.41,
    Kv_setT=0.262,
    m_flow_small=0.0001,
    redeclare package Medium = Medium,
    dp(start=1000)) annotation (Placement(transformation(extent={{-67,-82.5},{-82,-66.5}})));
  Fluid.HeatExchangers.Radiators.Radiator radiatorLi(
    radiatorType=Type_Radiator_Livingroom,
    m_flow_nominal=0.01,
    redeclare package Medium = Medium,
    selectable=true)
    annotation (Placement(transformation(extent={{-95,-5},{-113,13}})));
  Fluid.HeatExchangers.Radiators.Radiator radiatorBr(
    radiatorType=Type_Radiator_Bedroom,
    m_flow_nominal=0.01,
    redeclare package Medium = Medium,
    selectable=true)
    annotation (Placement(transformation(extent={{78,72},{94,88}})));
  Fluid.HeatExchangers.Radiators.Radiator radiatorCh(
    radiatorType=Type_Radiator_Children,
    m_flow_nominal=0.01,
    redeclare package Medium = Medium,
    selectable=true)
    annotation (Placement(transformation(extent={{86,33},{101,48}})));
  Obsolete.Year2021.Fluid.Actuators.Valves.ThermostaticValve valveBa(
    Kvs=0.24,
    Kv_setT=0.162,
    m_flow_small=0.0001,
    redeclare package Medium = Medium,
    dp(start=1000)) annotation (Placement(transformation(extent={{38,-47},{50,-31}})));
  Obsolete.Year2021.Fluid.Actuators.Valves.ThermostaticValve valveLi(
    Kvs=1.43,
    Kv_setT=0.4,
    m_flow_small=0.0001,
    redeclare package Medium = Medium,
    dp(start=1000)) annotation (Placement(transformation(extent={{-67,-4},{-79,12}})));
  Obsolete.Year2021.Fluid.Actuators.Valves.ThermostaticValve valveCh(
    Kvs=0.16,
    Kv_setT=0.088,
    m_flow_small=0.0001,
    redeclare package Medium = Medium,
    dp(start=1000)) annotation (Placement(transformation(extent={{64,32},{76,48}})));
  Obsolete.Year2021.Fluid.Actuators.Valves.ThermostaticValve valveBe(
    Kvs=0.24,
    Kv_setT=0.182,
    m_flow_small=0.0001,
    redeclare package Medium = Medium,
    dp(start=1000)) annotation (Placement(transformation(extent={{49,74},{60,87}})));
  Modelica.Fluid.Pipes.StaticPipe thStF(
    diameter = Diam_Main,
    length = Length_thSt,
    redeclare package Medium = Medium) "through the storage room, flow stream"                        annotation(Placement(transformation(extent = {{57, -85}, {40, -74}})));
  Modelica.Fluid.Pipes.StaticPipe toKiF(
    diameter = Diam_Sec,
    length = Length_toKi,
    redeclare package Medium = Medium) "to kitchen, flow stream"                       annotation(Placement(transformation(extent = {{8, -5}, {-8, 5}}, origin = {-49, -74.5})));
  Modelica.Fluid.Pipes.StaticPipe thStR(
    diameter = Diam_Main,
    length = Length_thSt,
    redeclare package Medium = Medium)
    "through the storage room, return stream"                                                           annotation(Placement(transformation(extent = {{40, -102}, {58, -90}})));
  Modelica.Fluid.Pipes.StaticPipe toKiR(
    diameter = Diam_Sec,
    length = Length_toKi,
    redeclare package Medium = Medium) "to kitchen, return stream"                       annotation(Placement(transformation(extent = {{-72, -102}, {-56, -90}})));
  Modelica.Fluid.Pipes.StaticPipe thBathF(
    diameter = Diam_Main,
    length = Length_thBath,
    redeclare package Medium = Medium) "through Bath, flow stream"                            annotation(Placement(transformation(extent = {{8, 4.5}, {-8, -4.5}}, rotation = 270, origin = {-4.5, -62})));
  Modelica.Fluid.Pipes.StaticPipe thBathR(
    diameter = Diam_Main,
    length = Length_thBath,
    redeclare package Medium = Medium) "through bath, return stream"                            annotation(Placement(transformation(extent = {{8.75, -4.25}, {-8.75, 4.25}}, rotation = 90, origin = {-18.25, -62.75})));
  Modelica.Fluid.Pipes.StaticPipe thChildren1R(
    diameter = Diam_Main,
    length = Length_thChildren1,
    redeclare package Medium = Medium) "through children room 1, return stream"                         annotation(Placement(transformation(extent = {{6.5, -5}, {-6.5, 5}}, rotation = 90, origin = {-18, -27.5})));
  Modelica.Fluid.Pipes.StaticPipe thChildren1F(
    diameter = Diam_Main,
    length = Length_thChildren1,
    redeclare package Medium = Medium) "through chidlren room 1, flow stream"                                      annotation(Placement(transformation(extent = {{6.5, 5}, {-6.5, -5}}, rotation = 270, origin = {-5, -26.5})));
  Modelica.Fluid.Pipes.StaticPipe toBathF(
    diameter = Diam_Sec,
    length = Length_toBath,
    redeclare package Medium = Medium) "to Bath, flow stream"                           annotation(Placement(transformation(extent = {{-8.5, 4.5}, {8.5, -4.5}}, origin = {18.5, -38.5})));
  Modelica.Fluid.Pipes.StaticPipe toBathR(
    diameter = Diam_Sec,
    length = Length_toBath,
    redeclare package Medium = Medium) "to bath return stream"                           annotation(Placement(transformation(extent = {{8.5, 4.5}, {-8.5, -4.5}}, origin = {18.5, -49.5})));
  Modelica.Fluid.Interfaces.FluidPort_b RETURN(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"                       annotation(Placement(transformation(extent = {{66, -114}, {86, -94}})));
  Modelica.Fluid.Interfaces.FluidPort_a FLOW(redeclare package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"                       annotation(Placement(transformation(extent = {{92, -114}, {112, -94}})));
  Modelica.Fluid.Pipes.StaticPipe toChildrenF(
    diameter = Diam_Sec,
    length = Length_toChildren,
    redeclare package Medium = Medium) "to Children, flow stream"                                   annotation(Placement(transformation(extent = {{-8.5, 4.5}, {8.5, -4.5}}, origin = {45.5, 40.5})));
  Modelica.Fluid.Pipes.StaticPipe toChildrenR(
    diameter = Diam_Sec,
    length = Length_toChildren,
    redeclare package Medium = Medium) "to Children, return stream"                                   annotation(Placement(transformation(extent = {{7.5, 4.5}, {-7.5, -4.5}}, origin = {47.5, 27})));
  Modelica.Fluid.Pipes.StaticPipe thChildrenF2(
    diameter = Diam_Main,
    length = Length_thChildren2,
    redeclare package Medium = Medium) "through chidlren room, flow stream"                                      annotation(Placement(transformation(extent = {{7, 5}, {-7, -5}}, rotation = 270, origin = {-5, 13})));
  Modelica.Fluid.Pipes.StaticPipe thChildrenR2(
    diameter = Diam_Main,
    length = Length_thChildren2,
    redeclare package Medium = Medium) "through chidlren room, return stream"                                      annotation(Placement(transformation(extent = {{7.5, -5}, {-7.5, 5}}, rotation = 90, origin = {-19, 12.5})));
  Modelica.Fluid.Pipes.StaticPipe toBedroomF(
    diameter = Diam_Sec,
    length = Length_toBedroom,
    redeclare package Medium = Medium) "to Bedroom , flow stream"                                 annotation(Placement(transformation(extent = {{-6.5, 4.5}, {6.5, -4.5}}, origin = {23.5, 80.5})));
  Modelica.Fluid.Pipes.StaticPipe toBedroomR(
    diameter = Diam_Sec,
    length = Length_toBedroom,
    redeclare package Medium = Medium) "to Bedroom, return stream"                                 annotation(Placement(transformation(extent = {{6.5, 4.5}, {-6.5, -4.5}}, origin = {20.5, 66})));
  Modelica.Fluid.Pipes.StaticPipe toLiF(
    diameter = Diam_Sec,
    length = Length_toLi,
    redeclare package Medium = Medium) "to livingroom, flow stream"                       annotation(Placement(transformation(extent = {{6, -4.5}, {-6, 4.5}}, origin = {-47.5, 3})));
  Modelica.Fluid.Pipes.StaticPipe   toLiR(
    redeclare package Medium = Medium,
    length=Length_toLi,
    diameter=Diam_Main)                "to livingroom, return stream"                        annotation(Placement(transformation(extent = {{6.5, -5}, {-6.5, 5}}, rotation = 180, origin = {-88.5, -16.5})));
  AixLib.Utilities.Interfaces.RadPort radLi annotation (Placement(transformation(extent={{-148,38},{-132,55}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convLi
    annotation (Placement(transformation(extent={{-146,25},{-133,38}})));
  AixLib.Utilities.Interfaces.RadPort radKi annotation (Placement(transformation(extent={{-146,-50},{-129,-34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convKi
    annotation (Placement(transformation(extent={{-145,-66},{-131,-51}})));
  AixLib.Utilities.Interfaces.RadPort radBe annotation (Placement(transformation(extent={{128,88},{146,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convBe
    annotation (Placement(transformation(extent={{130,64},{146,82}})));
  AixLib.Utilities.Interfaces.RadPort radCh annotation (Placement(transformation(extent={{130,39},{150,59}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convCh
    annotation (Placement(transformation(extent={{131,17},{146,34}})));
  AixLib.Utilities.Interfaces.RadPort radBa annotation (Placement(transformation(extent={{128,-38},{148,-18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convBa
    annotation (Placement(transformation(extent={{129,-59},{148,-41}})));
  Modelica.Blocks.Interfaces.RealInput TSet[5] annotation(Placement(transformation(extent = {{-123, 78}, {-95, 108}}), iconTransformation(extent = {{-10.5, -12}, {10.5, 12}}, rotation = 270, origin = {-105.5, 96})));
  Fluid.FixedResistances.HydraulicResistance hydResInflow(
    zeta=zeta_bend,
    diameter=Diam_Main,
    redeclare package Medium = Medium) "hydraulic resistance in floor"
    annotation (Placement(transformation(extent={{24,-84},{10,-75}})));
  Fluid.FixedResistances.HydraulicResistance hydResRadKi(
    zeta=3*zeta_bend,
    diameter=Diam_Sec,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-113,-100.5},{-99,-91.5}})));
  Fluid.FixedResistances.HydraulicResistance hydResBendRight(
    zeta=zeta_bend,
    diameter=Diam_Main,
    redeclare package Medium = Medium,
    m_flow_nominal=0.0001)             "hydraulic resistance bend right"
    annotation (Placement(transformation(
        extent={{-3.25,-2.25},{3.25,2.25}},
        rotation=90,
        origin={-3.75,-75.75})));
  Fluid.FixedResistances.HydraulicResistance hydResRadBa(
    zeta=2*zeta_bend,
    diameter=Diam_Sec,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{67,-53},{57,-44}})));
  Fluid.FixedResistances.HydraulicResistance hydResRadLi(
    zeta=3*zeta_bend,
    diameter=Diam_Sec,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-116,-21},{-102,-12}})));
  Fluid.FixedResistances.HydraulicResistance hydResRadCh(
    zeta=2*zeta_bend,
    diameter=Diam_Sec,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{84,22.5},{74,31.5}})));
  Fluid.FixedResistances.HydraulicResistance hydResRadBe(
    zeta=3*zeta_bend,
    diameter=Diam_Sec,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{74,61.5},{60,70.5}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensorLi
    annotation (Placement(transformation(extent={{-108,30},{-96,42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensorBe
    annotation (Placement(transformation(extent={{75,92},{63,104}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensorCh
    annotation (Placement(transformation(extent={{88,49},{76,61}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensorBa
    annotation (Placement(transformation(extent={{66,-21},{54,-9}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensorKi
    annotation (Placement(transformation(extent={{-91,-57},{-79,-45}})));
equation
  connect(radiatorLi.port_a, valveLi.port_b) annotation (Line(
      points={{-95,4},{-79,4}},
      color={255,0,0},
      thickness=0.5));
  connect(valveBa.port_b, radiatorBa.port_a) annotation (Line(
      points={{50,-39},{83,-39},{83,-39.5}},
      color={255,0,0},
      thickness=0.5));
  connect(valveCh.port_b, radiatorCh.port_a) annotation (Line(
      points={{76,40},{86,40},{86,40.5}},
      color={255,0,0},
      thickness=0.5));
  connect(valveBe.port_b, radiatorBr.port_a) annotation (Line(
      points={{60,80.5},{78,80.5},{78,80}},
      color={255,0,0},
      thickness=0.5));
  connect(thStR.port_b, RETURN) annotation(Line(points = {{58, -96}, {76, -96}, {76, -104}}, color = {0, 0, 255}, thickness = 0.5));
  connect(thStF.port_a, FLOW) annotation(Line(points = {{57, -79.5}, {60, -80}, {62, -80}, {62, -95}, {102, -95}, {102, -104}}, color = {255, 0, 0}, thickness = 0.5));
  connect(toBathF.port_b, valveBa.port_a) annotation (Line(
      points={{27,-38.5},{39,-38.5},{39,-39},{38,-39}},
      color={255,0,0},
      thickness=0.5));
  connect(toChildrenF.port_b, valveCh.port_a) annotation (Line(
      points={{54,40.5},{56,40},{64,40}},
      color={255,0,0},
      thickness=0.5));
  connect(toBedroomF.port_b, valveBe.port_a) annotation (Line(
      points={{30,80.5},{49,80.5}},
      color={255,0,0},
      thickness=0.5));
  connect(toLiF.port_b, valveLi.port_a) annotation (Line(
      points={{-53.5,3},{-53.5,4},{-67,4}},
      color={255,0,0},
      thickness=0.5));
  connect(valveKi.port_a, toKiF.port_b) annotation (Line(
      points={{-67,-74.5},{-57,-74.5}},
      color={255,0,0},
      thickness=0.5));
  connect(radiatorKi.port_a, valveKi.port_b) annotation (Line(
      points={{-89,-74.5},{-82,-74.5}},
      color={255,0,0},
      thickness=0.5));
  connect(hydResInflow.port_a, thStF.port_b) annotation (Line(
      points={{24,-79.5},{40,-79.5}},
      color={255,0,0},
      thickness=0.5));
  connect(radiatorKi.port_b, hydResRadKi.port_a) annotation (Line(
      points={{-106,-74.5},{-118,-74.5},{-118,-75},{-130,-75},{-130,-96},{-113,
          -96}},
      color={0,128,255},
      thickness=0.5));
  connect(hydResRadKi.port_b, toKiR.port_a) annotation (Line(
      points={{-99,-96},{-72,-96}},
      color={0,128,255},
      thickness=0.5));
  connect(toBathR.port_a, hydResRadBa.port_b) annotation (Line(
      points={{27,-49.5},{42,-49.5},{42,-48.5},{57,-48.5}},
      color={0,128,255},
      thickness=0.5));
  connect(hydResRadBa.port_a, radiatorBa.port_b) annotation (Line(
      points={{67,-48.5},{127,-48.5},{127,-39.5},{100,-39.5}},
      color={0,128,255},
      thickness=0.5));
  connect(hydResRadLi.port_b, toLiR.port_a) annotation (Line(
      points={{-102,-16.5},{-95,-16.5}},
      color={0,128,255},
      thickness=0.5));
  connect(hydResRadLi.port_a, radiatorLi.port_b) annotation (Line(
      points={{-116,-16.5},{-129,-16.5},{-129,4},{-113,4}},
      color={0,128,255},
      thickness=0.5));
  connect(toChildrenR.port_a, hydResRadCh.port_b) annotation (Line(
      points={{55,27},{74,27}},
      color={0,128,255},
      thickness=0.5));
  connect(hydResRadCh.port_a, radiatorCh.port_b) annotation (Line(
      points={{84,27},{126,27},{126,40.5},{101,40.5}},
      color={0,128,255},
      thickness=0.5));
  connect(toBedroomR.port_a, hydResRadBe.port_b) annotation (Line(
      points={{27,66},{60,66}},
      color={0,128,255},
      thickness=0.5));
  connect(hydResRadBe.port_a, radiatorBr.port_b) annotation (Line(
      points={{74,66},{126,66},{126,80},{94,80}},
      color={0,128,255},
      thickness=0.5));
  connect(hydResBendRight.port_b, thBathF.port_a) annotation (Line(
      points={{-3.75,-72.5},{-3.75,-70},{-4.5,-70}},
      color={0,127,255}));

  connect(toKiR.port_b, thStR.port_a) annotation(Line(points = {{-56, -96}, {40, -96}}, color = {0, 127, 255}, thickness = 0.5));
  connect(thBathR.port_b, thStR.port_a) annotation(Line(points = {{-18.25, -71.5}, {-18.25, -96}, {40, -96}}, color = {0, 127, 255}, thickness = 0.5));
  connect(thChildren1R.port_b, thBathR.port_a) annotation(Line(points = {{-18, -34}, {-18, -54}, {-18.25, -54}}, color = {0, 127, 255}, thickness = 0.5));
  connect(thChildrenR2.port_b, thChildren1R.port_a) annotation(Line(points = {{-19, 5}, {-19, -21}, {-18, -21}}, color = {0, 127, 255}, thickness = 0.5));
  connect(toLiR.port_b, thChildren1R.port_a) annotation(Line(points = {{-82, -16.5}, {-19, -16.5}, {-19, -21}, {-18, -21}}, color = {0, 127, 255}, thickness = 0.5));
  connect(toBedroomR.port_b, thChildrenR2.port_a) annotation(Line(points = {{14, 66}, {-19, 66}, {-19, 20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(toChildrenR.port_b, thChildrenR2.port_a) annotation(Line(points = {{40, 27}, {-19, 27}, {-19, 20}}, color = {0, 127, 255}, thickness = 0.5));
  connect(toBathR.port_b, thBathR.port_a) annotation(Line(points = {{10, -49.5}, {-18, -49.5}, {-18, -54}, {-18.25, -54}}, color = {0, 127, 255}, thickness = 0.5));
  connect(hydResBendRight.port_a, hydResInflow.port_b) annotation (Line(
      points={{-3.75,-79},{-3.75,-79.5},{10,-79.5}},
      color={0,127,255}));
  connect(thBathF.port_b, toBathF.port_a) annotation(Line(points = {{-4.5, -54}, {-4.5, -38.5}, {10, -38.5}}, color = {255, 0, 0}, thickness = 0.5));
  connect(toKiF.port_a, hydResInflow.port_b) annotation (Line(
      points={{-41,-74.5},{-23,-74.5},{-23,-80},{10,-80},{10,-79.5}},
      color={255,0,0},
      thickness=0.5));
  connect(thBathF.port_b, thChildren1F.port_a) annotation(Line(points = {{-4.5, -54}, {-4.5, -44}, {-5, -44}, {-5, -33}}, color = {255, 0, 0}, thickness = 0.5));
  connect(thChildren1F.port_b, thChildrenF2.port_a) annotation(Line(points = {{-5, -20}, {-5, 6}}, color = {0, 127, 255}));
  connect(thChildrenF2.port_b, toChildrenF.port_a) annotation(Line(points = {{-5, 20}, {-5, 40.5}, {37, 40.5}}, color = {255, 0, 0}, thickness = 0.5));
  connect(thChildrenF2.port_b, toBedroomF.port_a) annotation(Line(points = {{-5, 20}, {-5, 80.5}, {17, 80.5}}, color = {255, 0, 0}, thickness = 0.5));
  connect(thChildren1F.port_b, toLiF.port_a) annotation(Line(points = {{-5, -20}, {-5, 3}, {-41.5, 3}}, color = {255, 0, 0}, thickness = 0.5));
  connect(valveBe.T_setRoom, TSet[2]) annotation (Line(
      points={{57.58,86.87},{57.58,87},{-109,87}},
      color={0,0,127}));
  connect(valveCh.T_setRoom, TSet[3]) annotation (Line(
      points={{73.36,47.84},{73.36,57},{-77,57},{-77,92},{-109,92},{-109,93}},
      color={0,0,127}));
  connect(valveBa.T_setRoom, TSet[4]) annotation (Line(
      points={{47.36,-31.16},{47.36,-7},{18,-7},{18,29},{-76,29},{-76,99},{-109,
          99}},
      color={0,0,127}));
  connect(valveKi.T_setRoom, TSet[5]) annotation (Line(
      points={{-78.7,-66.66},{-78.7,-62},{-76,-62},{-76,105},{-109,105}},
      color={0,0,127}));
  connect(valveLi.T_setRoom, TSet[1]) annotation (Line(
      points={{-76.36,11.84},{-76.36,52},{-76,52},{-76,92},{-109,92},{-109,81}},
      color={0,0,127}));

  connect(convLi, tempSensorLi.port) annotation (Line(
      points={{-139.5,31.5},{-120,31.5},{-120,36},{-108,36}},
      color={191,0,0}));
  connect(tempSensorLi.T, valveLi.T_room) annotation (Line(
      points={{-96,36},{-69.16,36},{-69.16,11.84}},
      color={0,0,127}));
  connect(valveBe.T_room, tempSensorBe.T) annotation (Line(
      points={{50.98,86.87},{50.98,98},{63,98}},
      color={0,0,127}));
  connect(tempSensorBe.port, convBe) annotation (Line(
      points={{75,98},{89,98},{89,97},{141,97},{141,73},{138,73}},
      color={191,0,0}));
  connect(valveCh.T_room, tempSensorCh.T) annotation (Line(
      points={{66.16,47.84},{66.16,55},{76,55}},
      color={0,0,127}));
  connect(tempSensorCh.port, convCh) annotation (Line(
      points={{88,55},{138,55},{138,53},{138.5,53},{138.5,25.5}},
      color={191,0,0}));
  connect(valveBa.T_room, tempSensorBa.T) annotation (Line(
      points={{40.16,-31.16},{40.16,-15},{54,-15}},
      color={0,0,127}));
  connect(tempSensorBa.port, convBa) annotation (Line(
      points={{66,-15},{97,-15},{97,-21},{138.5,-21},{138.5,-50}},
      color={191,0,0}));
  connect(tempSensorKi.port, convKi) annotation (Line(
      points={{-91,-51},{-107,-51},{-107,-50},{-138,-50},{-138,-58.5}},
      color={191,0,0}));
  connect(tempSensorKi.T, valveKi.T_room) annotation (Line(
      points={{-79,-51},{-69.7,-51},{-69.7,-66.66}},
      color={0,0,127}));
  connect(radiatorLi.RadiativeHeat, radLi) annotation (Line(points={{-107.6,5.8},
          {-107.6,25.9},{-140,25.9},{-140,46.5}}, color={95,95,95}));
  connect(radiatorLi.ConvectiveHeat, convLi) annotation (Line(points={{-102.2,
          5.8},{-120.1,5.8},{-120.1,31.5},{-139.5,31.5}}, color={191,0,0}));
  connect(radKi, radiatorKi.RadiativeHeat) annotation (Line(points={{-137.5,-42},
          {-119.75,-42},{-119.75,-72.8},{-100.9,-72.8}}, color={95,95,95}));
  connect(convKi, radiatorKi.ConvectiveHeat) annotation (Line(points={{-138,
          -58.5},{-117,-58.5},{-117,-72.8},{-95.8,-72.8}}, color={191,0,0}));
  connect(radiatorBa.RadiativeHeat, radBa) annotation (Line(points={{94.9,-37.8},
          {117.45,-37.8},{117.45,-28},{138,-28}}, color={95,95,95}));
  connect(radiatorBa.ConvectiveHeat, convBa) annotation (Line(points={{89.8,
          -37.8},{113.9,-37.8},{113.9,-50},{138.5,-50}}, color={191,0,0}));
  connect(radiatorCh.RadiativeHeat, radCh) annotation (Line(points={{96.5,42},{
          119,42},{119,49},{140,49}}, color={95,95,95}));
  connect(radiatorCh.ConvectiveHeat, convCh) annotation (Line(points={{92,42},{
          115,42},{115,25.5},{138.5,25.5}}, color={191,0,0}));
  connect(radiatorBr.RadiativeHeat, radBe) annotation (Line(points={{89.2,81.6},
          {113.1,81.6},{113.1,97},{137,97}}, color={95,95,95}));
  connect(convBe, radiatorBr.ConvectiveHeat) annotation (Line(points={{138,73},
          {112,73},{112,81.6},{84.4,81.6}}, color={191,0,0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-150,
            -100},{150,110}},                                                                           grid = {1, 1}), graphics={  Rectangle(extent = {{1, 100}, {126, 63}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{4, 58}, {127, 15}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{4, -14}, {127, -67}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-129, 29}, {-22, -25}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-130, -49}, {-23, -103}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-120, -81}, {-69, -96}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Kitchen"), Text(extent = {{-156.5, 29}, {-49.5, 16}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Livingroom"), Text(extent = {{31, -15}, {138, -28}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Bath"), Text(extent = {{-27, 56}, {80, 43}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Children"), Text(extent = {{-34, 100}, {73, 87}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Bedroom"), Text(extent = {{-70, 103}, {-17, 71}}, lineColor = {0, 0, 0}, textString = "1 - Livingroom
 2- Bedroom
 3 - Children
 4 - Bath
 5 - Kitchen")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-150, -100}, {150, 110}}, grid = {1, 1}), graphics={  Rectangle(extent = {{-119, 92}, {123, -79}}, lineColor = {255, 0, 0}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-99, 22}, {104, 22}, {104, -6}}, color = {255, 0, 0}, thickness = 1), Line(points = {{-98, 13}, {95, 13}, {95, -6}}, color = {0, 0, 255}, thickness = 1), Line(points = {{-21, 13}, {-21, 35}}, color = {0, 0, 255}, thickness = 1), Line(points = {{-14, 23}, {-14, 45}}, color = {255, 0, 0}, thickness = 1), Text(extent = {{-124, 119}, {-84, 111}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Set"), Text(extent = {{-70, 81}, {-17, 49}}, lineColor = {0, 0, 0}, textString = "1 - Livingroom
 2- Bedroom
 3 - Children
 4 - Bath
 5 - Kitchen")}), Documentation(revisions="<html><ul>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe by MSL pipe
  </li>
  <li>
    <i>June 19, 2014</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The model is exemplarly build with components found in the HVAC
  package.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The model should be used as an example on how such a system can be
  built and connected to the building envelope.
</p>
</html>"));
end Radiators;
