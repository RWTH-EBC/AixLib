within AixLib.ThermalZones.HighOrder.Rooms.MFD.CellarAttic;
model Cellar "Cellar completly under ground"
  import AixLib;
  ///////// construction parameters
  parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
        "EnEV_2009",                                                                                                    choice = 2
        "EnEV_2002",                                                                                                    choice = 3
        "WSchV_1995",                                                                                                    choice = 4
        "WSchV_1984",                                                                                                    radioButtons = true));
  // Room geometry
  parameter Modelica.SIunits.Length room_length = 10.24 "length" annotation(Dialog(group = "Room geometry", descriptionLabel = true));
  parameter Modelica.SIunits.Length room_width = 17.01 "width" annotation(Dialog(group = "Room geometry", descriptionLabel = true));
  parameter Modelica.SIunits.Height room_height = 2.5 "length" annotation(Dialog(group = "Room geometry", descriptionLabel = true));
  // Outer walls properties
  parameter Modelica.SIunits.Temperature T_Ground = 283.15 "GroundTemperature" annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
  parameter Integer ModelConvOW = 1 "Heat Convection Model" annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
        "DIN 6946",                                                                                                    choice = 2
        "ASHRAE Fundamentals",                                                                                                    choice = 3
        "Custom alpha",                                                                                                    radioButtons = true));
  //Initial temperatures
  parameter Modelica.SIunits.Temperature T0_air = 285.15 "Air" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_Walls = 284.95 "Walls" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature T0_Ceiling = 285.25 "Ceiling" annotation(Dialog(tab = "Initial temperatures", descriptionLabel = true));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0)
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(group = "Sunblind", enable=use_sunblind));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=room_V, T(
        start=T0_air))
    annotation (Placement(transformation(extent={{-18,-4},{-38,16}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
    T0=T0_Ceiling,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_CE,
    wall_length=room_width,
    wall_height=room_length,
    ISOrientation=3,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={110,62},
        extent={{-1.99998,-10},{1.99998,10}},
        rotation=270)));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
    T0=T0_Walls,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_length=room_width,
    wall_height=room_length,
    ISOrientation=2,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        origin={110,32},
        extent={{-1.99998,-10},{1.99998,10}},
        rotation=90)));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    room_V=room_V,
    n50=n50,
    e=e,
    eps=eps)
    annotation (Placement(transformation(extent={{-44,-100},{-18,-74}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall1(
    T0=T0_Walls,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_length=room_width,
    wall_height=room_height,
    ISOrientation=1,
    withWindow=false,
    withDoor=false) annotation (Placement(transformation(
        extent={{-9,-50},{9,50}},
        rotation=270,
        origin={2,65})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall3(
    T0=T0_Walls,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_height=room_height,
    wall_length=room_width,
    withDoor=false) annotation (Placement(transformation(
        extent={{-9,-50},{9,50}},
        rotation=90,
        origin={2,-45})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall2(
    T0=T0_Walls,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_height=room_height,
    wall_length=room_length,
    withDoor=false) annotation (Placement(transformation(
        extent={{-9,-50},{9,50}},
        rotation=180,
        origin={68,13})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall4(
    T0=T0_Walls,
    outside=false,
    final withSunblind=use_sunblind,
    final Blinding=1-ratioSunblind,
    final LimitSolIrr=solIrrThreshold,
    final TOutAirLimit=TOutAirLimit,
    WallType=Type_FL,
    wall_height=room_height,
    wall_length=room_length,
    withDoor=false) annotation (Placement(transformation(extent={{-9,-50},{9,50}},
          origin={-70,13})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-100, -100}, {-80, -80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCellar annotation(Placement(transformation(extent = {{100, 80}, {120, 100}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TGround(T = T_Ground) annotation(Placement(transformation(extent = {{118, -80}, {138, -60}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin = {4, -6})));
protected
  parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
    "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
  parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
  parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
  // Floor type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML() else AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML();
  // Ceiling  type
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEcellar_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEcellar_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEcellar_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEcellar_WSchV1984_SML_loHalf();
  parameter Modelica.SIunits.Volume room_V = room_length * room_width * room_height;
equation
  connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-44, -87}, {-42, -87}, {-42, -90}, {-90, -90}}, color = {191, 0, 0}));
  connect(infiltrationRate.port_b, airload.port) annotation(Line(points = {{-18, -87}, {-2, -87}, {-2, -64}, {-54, -64}, {-54, -24}, {-12, -24}, {-12, 4}, {-19, 4}}, color = {191, 0, 0}));
  connect(Wall_Ceiling.port_outside, thermCellar) annotation(Line(points={{110,
          64.1},{110,90}},                                                                           color = {191, 0, 0}));
  connect(TGround.port, Wall3.port_outside) annotation(Line(points = {{138, -70}, {2, -70}, {2, -54.45}}, color = {191, 0, 0}));
  connect(Wall2.port_outside, TGround.port) annotation(Line(points = {{77.45, 13}, {100, 13}, {100, -70}, {138, -70}}, color = {191, 0, 0}));
  connect(Wall_Floor.port_outside, TGround.port) annotation(Line(points={{110,
          29.9},{110,8},{100,8},{100,-70},{138,-70}},                                                                                color = {191, 0, 0}));
  connect(Wall1.port_outside, TGround.port) annotation(Line(points = {{2, 74.45}, {2, 88}, {100, 88}, {100, -70}, {138, -70}}, color = {191, 0, 0}));
  connect(Wall4.port_outside, TGround.port) annotation(Line(points = {{-79.45, 13}, {-86, 13}, {-86, -64}, {-2, -64}, {-2, -70}, {138, -70}}, color = {191, 0, 0}));
  connect(Wall2.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{59, 13}, {46, 13}, {46, -24}, {3.9, -24}, {3.9, -15.4}}, color = {191, 0, 0}));
  connect(Wall3.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{2, -36}, {2, -25.1125}, {3.9, -25.1125}, {3.9, -15.4}}, color = {191, 0, 0}));
  connect(Wall1.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{2, 56}, {2, 44}, {46, 44}, {46, -24}, {3.9, -24}, {3.9, -15.4}}, color = {191, 0, 0}));
  connect(Wall4.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points = {{-61, 13}, {-48, 13}, {-48, -24}, {3.9, -24}, {3.9, -15.4}}, color = {191, 0, 0}));
  connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{110,34},
          {110,34},{110,44},{46,44},{46,-24},{3.9,-24},{3.9,-15.4}},                                                                                                    color = {191, 0, 0}));
  connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb) annotation(Line(points={{110,60},
          {110,44},{46,44},{46,-24},{3.9,-24},{3.9,-15.4}},                                                                                                    color = {191, 0, 0}));
  connect(thermStar_Demux.therm, airload.port) annotation(Line(points = {{-1.1, 4.1}, {-1.1, 12}, {-12, 12}, {-12, 4}, {-19, 4}}, color = {191, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -150}, {150, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Rectangle(extent = {{-68, 74}, {134, -128}}, lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-66, 10}, {126, -48}}, lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Cellar")}), Documentation(revisions = "<html>
 <ul>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>August 17, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Model for a cellar for the whole building.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model can extended, if one wants to consider each of the floors belongig to the upper rooms individually.</p>
 </html>"));
end Cellar;
