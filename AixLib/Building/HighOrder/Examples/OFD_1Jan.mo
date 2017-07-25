within AixLib.Building.HighOrder.Examples;
model OFD_1Jan "OFD with TMC, TIR and TRY"
  import AixLib;
  extends Modelica.Icons.Example;
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the system"                                                                             annotation(Dialog(group = "Medium"), choicesAllMatching = true);
  parameter AixLib.DataBase.Profiles.Profile_BaseDataDefinition VentilationProfile = AixLib.DataBase.Profiles.Ventilation_2perDay_Mean05perH();
  parameter AixLib.DataBase.Profiles.Profile_BaseDataDefinition TSetProfile = AixLib.DataBase.Profiles.SetTemperatures_Ventilation2perDay();
  inner Modelica.Fluid.System system annotation(Placement(transformation(extent = {{181, 78.5}, {200.5, 99.5}})));
  Modelica.Blocks.Sources.CombiTimeTable NaturalVentilation(columns = {2, 3, 4, 5, 6}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = VentilationProfile.Profile) annotation(Placement(transformation(extent={{-103,6},
            {-83,26}})));
  Modelica.Blocks.Sources.CombiTimeTable TSet(columns = {2, 3, 4, 5, 6, 7}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = TSetProfile.Profile) annotation(Placement(transformation(extent={{-103,
            -29},{-83,-9}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRooms[10](unit = "degC") annotation(Placement(transformation(extent = {{177, 11}, {197, 31}}), iconTransformation(extent = {{171, -29}, {187, -13}})));
  Modelica.Blocks.Interfaces.RealOutput Toutside(unit = "degC") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={142,-94}),     iconTransformation(extent = {{172, -95}, {188, -79}})));
  Modelica.Blocks.Interfaces.RealOutput SolarRadiation[6](unit = "W/m2") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={186,-95}),     iconTransformation(extent = {{172, -95}, {188, -79}})));
  Modelica.Blocks.Interfaces.RealOutput VentilationSchedule[4] annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={100,-94}),     iconTransformation(extent = {{171, -29}, {187, -13}})));
  Modelica.Blocks.Interfaces.RealOutput TsetValvesSchedule[5](unit = "degC") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={121,-94}),     iconTransformation(extent = {{171, -29}, {187, -13}})));
protected
  AixLib.Building.Components.Weather.Weather Weather(Latitude = 49.5, Longitude = 8.5, GroundReflection = 0.2, tableName = "wetter", extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, SOD = AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(), Wind_dir = false, Wind_speed = true, Air_temp = true, fileName = "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt", WeatherData(tableOnFile=false, table=weatherDataDay.weatherData)) annotation(Placement(transformation(extent={{125,55},
            {77,87}})));
public
  AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope
    wholeHouseBuildingEnvelope
    annotation (Placement(transformation(extent={{-34,-58},{61,37}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside
    annotation (Placement(transformation(extent={{-4,53},{-16.5,66}})));
equation
  // Romm Temperatures
  TAirRooms[1] = Modelica.SIunits.Conversions.to_degC(OFD.GF.Livingroom.airload.port.T);
  TAirRooms[2] = Modelica.SIunits.Conversions.to_degC(OFD.GF.Hobby.airload.port.T);
  TAirRooms[3] = Modelica.SIunits.Conversions.to_degC(OFD.GF.Corridor.airload.port.T);
  TAirRooms[4] = Modelica.SIunits.Conversions.to_degC(OFD.GF.WC_Storage.airload.port.T);
  TAirRooms[5] = Modelica.SIunits.Conversions.to_degC(OFD.GF.Kitchen.airload.port.T);
  TAirRooms[6] = Modelica.SIunits.Conversions.to_degC(OFD.UF.Bedroom.airload.port.T);
  TAirRooms[7] = Modelica.SIunits.Conversions.to_degC(OFD.UF.Children1.airload.port.T);
  TAirRooms[8] = Modelica.SIunits.Conversions.to_degC(OFD.UF.Corridor.airload.port.T);
  TAirRooms[9] = Modelica.SIunits.Conversions.to_degC(OFD.UF.Bath.airload.port.T);
  TAirRooms[10] = Modelica.SIunits.Conversions.to_degC(OFD.UF.Children2.airload.port.T);
  //SimulationData
  VentilationSchedule[1] = NaturalVentilation.y[1];
  VentilationSchedule[2] = NaturalVentilation.y[2];
  VentilationSchedule[3] = NaturalVentilation.y[3];
  VentilationSchedule[4] = NaturalVentilation.y[4];
  TsetValvesSchedule[1] = Modelica.SIunits.Conversions.to_degC(TSet.y[1]);
  TsetValvesSchedule[2] = Modelica.SIunits.Conversions.to_degC(TSet.y[2]);
  TsetValvesSchedule[3] = Modelica.SIunits.Conversions.to_degC(TSet.y[3]);
  TsetValvesSchedule[4] = Modelica.SIunits.Conversions.to_degC(TSet.y[4]);
  TsetValvesSchedule[5] = Modelica.SIunits.Conversions.to_degC(TSet.y[5]);
  Toutside = Modelica.SIunits.Conversions.to_degC(Weather.AirTemp);
  //SolarRadiation
  SolarRadiation[1] = Weather.SolarRadiation_OrientedSurfaces[1].I;
  SolarRadiation[2] = Weather.SolarRadiation_OrientedSurfaces[2].I;
  SolarRadiation[3] = Weather.SolarRadiation_OrientedSurfaces[3].I;
  SolarRadiation[4] = Weather.SolarRadiation_OrientedSurfaces[4].I;
  SolarRadiation[5] = Weather.SolarRadiation_OrientedSurfaces[5].I;
  SolarRadiation[6] = Weather.SolarRadiation_OrientedSurfaces[6].I;
  connect(Weather.WindSpeed, wholeHouseBuildingEnvelope.WindSpeedPort)
    annotation (Line(points={{75.4,80.6},{-58,80.6},{-58,16},{-31.15,16},{
          -31.15,14.2}}, color={0,0,127}));
  connect(tempOutside.port, wholeHouseBuildingEnvelope.thermOutside)
    annotation (Line(points={{-16.5,59.5},{-29.25,59.5},{-29.25,32.25}}, color=
          {191,0,0}));
  connect(tempOutside.T, Weather.AirTemp) annotation (Line(points={{-2.75,59.5},
          {22,59.5},{22,75.8},{75.4,75.8}}, color={0,0,127}));
  connect(Weather.SolarRadiation_OrientedSurfaces[1],
    wholeHouseBuildingEnvelope.North) annotation (Line(points={{113.48,53.4},{
          113.48,-1.95},{56.25,-1.95}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[2],
    wholeHouseBuildingEnvelope.East) annotation (Line(points={{113.48,53.4},{
          113.48,-19.05},{56.25,-19.05}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[3],
    wholeHouseBuildingEnvelope.South) annotation (Line(points={{113.48,53.4},{
          113.48,-37.1},{56.25,-37.1}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[4],
    wholeHouseBuildingEnvelope.West) annotation (Line(points={{113.48,53.4},{
          113.48,-53.25},{56.25,-53.25}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[5],
    wholeHouseBuildingEnvelope.SolarRadiationPort_RoofN) annotation (Line(
        points={{113.48,53.4},{113.48,32.25},{56.25,32.25}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[6],
    wholeHouseBuildingEnvelope.SolarRadiationPort_RoofS) annotation (Line(
        points={{113.48,53.4},{113.48,17.05},{56.25,17.05}}, color={255,128,0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}}, grid = {1, 1}), graphics={  Rectangle(extent={{
              -184,-4},{-149,-32}},                                                                                                                                             lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -144,31},{-109,3}},                                                                                                                                                         lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -156,26},{-106,24}},                                                                                                                                                   lineColor = {0, 0, 255}, textString = "1-Bedroom"), Text(extent={{
              -156,20},{-106,18}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Children1"), Text(extent={{
              -156,14},{-106,12}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-Bath"), Text(extent={{
              -156,8},{-106,6}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-Children2"), Text(extent={{
              -197,-6},{-147,-8}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "1-Livingroom"), Text(extent={{
              -197,-12},{-147,-14}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Hobby"), Text(extent={{
              -197,-18},{-147,-20}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-Corridor"), Text(extent={{
              -197,-24},{-147,-26}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-WC"), Text(extent={{
              -197,-30},{-147,-32}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "5-Kitchen"), Text(extent={{
              -124,19},{-108,30}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Rectangle(extent={{
              -184,31},{-149,3}},                                                                                                                                                                             lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -164,19},{-148,30}},                                                                                                                                                    lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"), Text(extent={{
              -196,22},{-146,20}},                                                                                                                                                                       lineColor = {0, 0, 255}, textString = "1-Livingroom"), Text(extent={{
              -196,16},{-146,14}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Hobby"), Text(extent={{
              -196,10},{-146,8}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-WC"), Text(extent={{
              -197,6},{-147,4}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-Kitchen"), Rectangle(extent={{
              -144,-4},{-109,-32}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -164,-16},{-148,-5}},                                                                                                                                                  lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"), Text(extent={{
              -124,-16},{-108,-5}},                                                                                                                                                                   lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Text(extent={{
              -153,-9},{-103,-11}},                                                                                                                                                                    lineColor = {0, 0, 255}, textString = "1-Bedroom"), Text(extent={{
              -153,-15},{-103,-17}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Children1"), Text(extent={{
              -153,-21},{-103,-23}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-Bath"), Text(extent={{
              -153,-27},{-103,-29}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-Children2")}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-200, -100}, {200, 100}}, grid = {1, 1}), graphics), experiment(StopTime = 86400, Interval = 15, __Dymola_Algorithm = "Lsodar"), experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example for setting up a simulation for a one family dwelling.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Energy generation and delivery system consisting of boiler and pump.</p>
 <p>The example works for a day and shows how such a simulation can be set up. It is not guranteed that the model will work stable under sifferent conditions or for longer periods of time.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>"));
end OFD_1Jan;
