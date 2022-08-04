within AixLib.Obsolete.Year2020.ThermalZones.HighOrder.Rooms.MFD.CellarAttic;
model Attic_Ro2Lf1
  "Attic with two saddle roofs and on floor towards the rooms on the lower floors"

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  ///////// construction parameters
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/MFD_Attic.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
        "EnEV_2009",                                                                                                    choice = 2
        "EnEV_2002",                                                                                                    choice = 3
        "WSchV_1995",                                                                                                    choice = 4
        "WSchV_1984",                                                                                                    radioButtons = true));
  // Room geometry
  parameter Modelica.Units.SI.Length room_length=10.24 "length"
    annotation (Dialog(group="Room geometry", descriptionLabel=true));
  parameter Modelica.Units.SI.Length room_width=17.01 "width"
    annotation (Dialog(group="Room geometry", descriptionLabel=true));
  parameter Modelica.Units.SI.Length roof_width1=5.7 "wRO1" annotation (Dialog(
      group="Room geometry",
      absoluteWidth=25,
      joinNext=true,
      descriptionLabel=true));
  parameter Modelica.Units.SI.Length roof_width2=5.7 "wRO2" annotation (Dialog(
      group="Room geometry",
      absoluteWidth=25,
      descriptionLabel=true));
  parameter Modelica.Units.SI.Angle alfa=Modelica.Units.Conversions.from_deg(
      120) "alfa"
    annotation (Dialog(group="Room geometry", descriptionLabel=true));
  parameter Modelica.Units.SI.Temperature T0_air=283.15 "Air"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.Units.SI.Temperature T0_RO1=282.15 "RO1"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.Units.SI.Temperature T0_RO2=282.15 "RO2"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  parameter Modelica.Units.SI.Temperature T0_FL=284.15 "FL"
    annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
  // Outer walls properties
  parameter Real solar_absorptance_RO = 0.25 "Solar absoptance roof " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
  parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
      group="Outer wall properties",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom hCon (constant)",
      radioButtons=true));
  // Windows and Doors
  parameter Boolean withWindow1 = false "Window 1 " annotation(Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox = true));
  parameter Modelica.Units.SI.Area windowarea_RO1=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow1));
  parameter Boolean withWindow2 = false "Window 2 " annotation(Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox = true));
  parameter Modelica.Units.SI.Area windowarea_RO2=0 "Window area" annotation (
      Dialog(
      group="Windows and Doors",
      naturalWidth=10,
      descriptionLabel=true,
      enable=withWindow2));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.Units.SI.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation (Dialog(group="Sunblind", enable=use_sunblind));
  parameter Modelica.Units.SI.Temperature TOutAirLimit
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation (Dialog(group="Sunblind", enable=use_sunblind));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof1(
    withDoor=false,
    door_height=0,
    door_width=0,
    T0=T0_RO1,
    solar_absorptance=solar_absorptance_RO,
    wall_height=roof_width1,
    wall_length=room_width,
    withWindow=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=Type_RO,
    ISOrientation=1) annotation (Placement(transformation(
        extent={{-4.99998,-28},{4.99998,28}},
        rotation=270,
        origin={-42,63})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(
    final T0=T0_air,
    final V=room_V)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-109.5, -10}, {-89.5, 10}}), iconTransformation(extent = {{-109.5, -10}, {-89.5, 10}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofNW annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-45.5, 100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-50, 90})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall roof2(
    solar_absorptance=solar_absorptance_RO,
    withDoor=false,
    door_height=0,
    door_width=0,
    T0=T0_RO2,
    wall_height=roof_width2,
    wall_length=room_width,
    withWindow=false,
    wallPar=Type_RO,
    outside=true,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    ISOrientation=1) annotation (Placement(transformation(
        origin={50,63},
        extent={{-4.99998,-28},{4.99998,28}},
        rotation=270)));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofSE annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {48, 100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {50, 90})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Floor(
    T0=T0_FL,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1 - ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    wallPar=Type_FL,
    wall_length=room_length,
    wall_height=room_width,
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={1,-46},
        extent={{-1.99999,-13},{1.99999,13}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps)
    annotation (Placement(transformation(extent={{-64,-24},{-46,-16}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-10, -86}, {10, -66}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=90,
        origin={-28,6})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(origin = {-100, 25}, extent = {{-10, -10}, {10, 10}}), iconTransformation(extent = {{-110, 30}, {-90, 50}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
    NaturalVentilation(V=room_V)
    annotation (Placement(transformation(extent={{-70,-56},{-50,-36}})));
protected
  parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
    "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
  parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
  parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
  // Floor to lower floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
  // Saddle roof type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO = if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleAttic_EnEV2009_SML() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleAttic_EnEV2002_SML() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleAttic_WSchV1995_SML() else AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleAttic_WSchV1984_SML() annotation(Dialog(tab = "Types"));
  //Window type
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
  parameter Modelica.Units.SI.Volume room_V=roof_width1*roof_width2*sin(alfa)*
      0.5*room_width;
equation
  // Connect-equation for ventilation/infiltration. If there are two windows, the ventilation rate is equally distributed between the two. the same with two door.
  // Be careful to set a given ventilation rate only for the windows, or for the doors, otherweise you will have double the ventilation rate.
  connect(SolarRadiationPort_RoofNW, roof1.SolarRadiationPort) annotation(Line(points={{-45.5,100},{-45.5,80},{-16.3333,80},{-16.3333,69.5}},          color = {255, 128, 0}));
  connect(SolarRadiationPort_RoofSE, roof2.SolarRadiationPort) annotation(Line(points={{48,100},{48,80},{75.6667,80},{75.6667,69.5}},          color = {255, 128, 0}));
  connect(thermOutside, thermOutside) annotation(Line(points = {{-90, 90}, {-90, 90}}, color = {191, 0, 0}));
  connect(roof1.WindSpeedPort, WindSpeedPort) annotation(Line(points={{-21.4667,68.25},{-21.4667,80},{-80,80},{-80,0},{-99.5,0}},            color = {0, 0, 127}));
  connect(roof2.WindSpeedPort, WindSpeedPort) annotation(Line(points={{70.5333,68.25},{70.5333,80},{-80,80},{-80,0},{-99.5,0}},            color = {0, 0, 127}));
  connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-64, -20}, {-80, -20}, {-80, 90}, {-90, 90}}, color = {191, 0, 0}));
  connect(infiltrationRate.port_b, airload.port) annotation(Line(points={{-46,-20},{-28,-20},{-28,-28},{-10,-28},{-10,-20},{10,-20}},             color = {191, 0, 0}));
  connect(Floor.port_outside, thermFloor) annotation(Line(points={{1,-48.1},{1,-65.55},{0,-65.55},{0,-76}},          color = {191, 0, 0}));
  connect(Floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{1,-44},{1,-28},{-28,-28},{-28,-4}},       color={191,0,0}));
  connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{-33,16},{-33,26},{-10,26},{-10,-20},{10,-20}},      color={191,0,0}));
  connect(roof2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{50,58},{50,50},{-42,50},{-42,-4},{-28,-4}},       color={191,0,0}));
  connect(roof1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-42,58},{-42,-4},{-28,-4}},       color={191,0,0}));
  connect(roof1.port_outside, thermOutside) annotation(Line(points={{-42,68.25},{-42,80},{-90,80},{-90,90}},          color = {191, 0, 0}));
  connect(roof2.port_outside, thermOutside) annotation(Line(points={{50,68.25},{50,80},{-90,80},{-90,90}},          color = {191, 0, 0}));
  connect(NaturalVentilation.port_a, thermOutside) annotation(Line(points = {{-70, -46}, {-80, -46}, {-80, 90}, {-90, 90}}, color = {191, 0, 0}));
  connect(NaturalVentilation.port_b, airload.port) annotation(Line(points={{-50,-46},{-28,-46},{-28,-28},{-10,-28},{-10,-20},{10,-20}},             color = {191, 0, 0}));
  connect(NaturalVentilation.InPort1, AirExchangePort) annotation(Line(points={{-71,-51},{-80,-51},{-80,25},{-100,25}},              color = {0, 0, 127}));
  annotation (
  obsolete = "Obsolete model - Model will be deleted in a future version.",
  Icon(graphics={  Polygon(points = {{-58, -20}, {16, 54}, {90, -20}, {76, -20}, {16, 40}, {-44, -20}, {-58, -20}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {175, 175, 175}), Polygon(points = {{-24, 0}, {6, 30}, {-8, 30}, {-38, 0}, {-24, 0}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid, visible = withWindow1), Text(extent = {{-36, 10}, {12, 22}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Win1", visible = withWindow1), Polygon(points = {{26, 30}, {56, 0}, {70, 0}, {40, 30}, {26, 30}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid, visible = withWindow2), Text(extent = {{22, 10}, {70, 22}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Win2", visible = withWindow2), Text(extent = {{-44, -14}, {74, -26}}, lineColor = {0, 0, 0}, fillColor = {255, 170, 170},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "width"), Line(points = {{-44, -20}, {-44, -24}}, color = {0, 0, 0}), Line(points = {{-44, -20}, {-20, -20}}, color = {0, 0, 0}), Line(points = {{48, -20}, {76, -20}}, color = {0, 0, 0}), Line(points = {{76, -20}, {76, -24}}, color = {0, 0, 0}), Line(points = {{-37, -37}, {37, 37}}, color = {0, 0, 0}, origin = {57, 21}, rotation = 90), Line(points = {{3, -3}, {-3, 3}}, color = {0, 0, 0}, origin = {93, -17}, rotation = 90), Text(extent = {{-28, 5}, {28, -5}}, lineColor = {0, 0, 0}, origin = {44, 47}, textString = "wRO2"), Line(points = {{3, -3}, {-3, 3}}, color = {0, 0, 0}, origin = {19, 57}, rotation = 90), Line(points = {{16, 54}, {10, 60}}, color = {0, 0, 0}), Line(points = {{-62, -16}, {12, 58}}, color = {0, 0, 0}), Text(extent = {{-40, 52}, {16, 42}}, lineColor = {0, 0, 0}, textString = "wRO1"), Line(points = {{-58, -20}, {-64, -14}}, color = {0, 0, 0})}), Documentation(revisions = "<html><ul>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>August 17, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for an attic for the whole building.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The model can extended, if one wants to consider each of the ceilings
  belongig to the lower rooms individually.
</p>
</html>"));
end Attic_Ro2Lf1;
