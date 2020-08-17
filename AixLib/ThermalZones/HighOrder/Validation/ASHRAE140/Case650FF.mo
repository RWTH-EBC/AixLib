within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case650FF
  extends Modelica.Icons.Example;

  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition SetTempProfile = AixLib.DataBase.Profiles.ASHRAE140.SetTemp_caseX50();
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition AERProfile = AixLib.DataBase.Profiles.ASHRAE140.Ventilation_caseX50();

  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.BaseClasses.Sun sun(
    TimeCorrection=0,
    Latitude=39.76,
    Longitude=-104.9,
    DiffWeatherDataTime=-7,
    Diff_localStandardTime_WeatherDataTime=0.5)
    annotation (Placement(transformation(extent={{-142,61},{-118,85}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface.RadOnTiltedSurf_Perez
    radOnTiltedSurf_Perez[5](
    Azimut={180,-90,0,90,0},
    Tilt={90,90,90,90,0},
    each GroundReflection= 0.2,
    each Latitude= 39.76,
    each h= 1609,
    each WeatherFormat=2) "N,E,S,W, Horz"
    annotation (Placement(transformation(extent={{-102,56},{-74,84}})));

  Modelica.Blocks.Sources.CombiTimeTable Solar_Radiation(
    tableOnFile=true,
    tableName="Table",
    columns={2,3},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-102,1},{-85,18}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_Weather(
    tableOnFile=true,
    tableName="Table",
    columns={4,5,6,7},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-103,28},{-86,45}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp
    "ambient temperature"
    annotation (Placement(transformation(extent={{-66,46},{-55,57}})));
  Rooms.ASHRAE140.SouthFacingWindows Room(
    wallTypes=wallTypes,
    calcMethodIn=4,
    Type_Win=windowParam,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    solar_absorptance_OW=solar_absorptance_OW,
    calcMethodOut=2,
    absInnerWallSurf=absInnerWallSurf,
    redeclare Components.Types.CoeffTableSouthWindow partialCoeffTable)
    annotation (Placement(transformation(extent={{-7,-6},{35,35}})));

  Utilities.Sources.HourOfDay hourOfDay
    annotation (Placement(transformation(extent={{104,78},{117,90}})));
  Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationN "in kWh/m2"
    annotation (Placement(transformation(extent={{111,5},{131,25}})));
  Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationE "in kWh/m2"
    annotation (Placement(transformation(extent={{112,-12},{132,8}})));
  Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationW "in kWh/m2"
    annotation (Placement(transformation(extent={{111,-32},{131,-12}})));
  Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationS "in kWh/m2"
    annotation (Placement(transformation(extent={{111,-51},{131,-31}})));
  Modelica.Blocks.Interfaces.RealOutput TransmittedSolarRadiation_room
    "in kWh/m2"
    annotation (Placement(transformation(extent={{111,-97},{131,-77}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains(final k=internalGains)
    annotation (Placement(transformation(extent={{-146,-77},{-133,-64}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow Ground(Q_flow=0)
    "adiabatic boundary"
    annotation (Placement(transformation(extent={{-98,-44},{-78,-24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_convective
    annotation (Placement(transformation(extent={{-98,-68},{-78,-48}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_radiative
    annotation (Placement(transformation(extent={{-97,-88},{-77,-68}})));
  Modelica.Blocks.Math.Gain convectiveInternalGains(k=0.4) "Convective part"
    annotation (Placement(transformation(extent={{-120,-63},{-110,-53}})));
  Modelica.Blocks.Math.Gain radiativeInternalGains(k=0.6) "Radiative part"
    annotation (Placement(transformation(extent={{-120,-83},{-110,-73}})));
  Modelica.Blocks.Sources.RealExpression TransmittedRad(y=Room.outerWall_South.solarRadWinTrans)
    annotation (Placement(transformation(extent={{45,-82},{65,-62}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{75,-77},{84,-67.5}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh2
    annotation (Placement(transformation(extent={{95,-76},{104,-67}})));
  Modelica.Blocks.Math.Gain gainIntHea(k=1/(Room.Win_Area))
    "Converts to MWh"
    annotation (Placement(transformation(extent={{76,-90},{83,-83}})));
  Modelica.Blocks.Sources.RealExpression SolarRadN(y=Room.outerWall_North.SolarRadiationPort.I)
    annotation (Placement(transformation(extent={{44,4},{64,24}})));
  Modelica.Blocks.Sources.RealExpression SolarRadS(y=Room.outerWall_South.SolarRadiationPort.I)
    annotation (Placement(transformation(extent={{44,-51},{64,-31}})));
  Modelica.Blocks.Sources.RealExpression SolarRadW(y=Room.outerWall_West.SolarRadiationPort.I)
    annotation (Placement(transformation(extent={{44,-32},{64,-12}})));
  Modelica.Blocks.Sources.RealExpression SolarRadE(y=Room.outerWall_East.SolarRadiationPort.I)
    annotation (Placement(transformation(extent={{44,-13},{64,7}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh6
    annotation (Placement(transformation(extent={{93,-45},{102,-36}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh3
    annotation (Placement(transformation(extent={{93,-26},{102,-17}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh4
    annotation (Placement(transformation(extent={{92,-7},{101,2}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh5
    annotation (Placement(transformation(extent={{91,10},{100,19}})));
  Modelica.Blocks.Continuous.Integrator integrator3
    annotation (Placement(transformation(extent={{74,-27.5},{85,-16.5}})));
  Modelica.Blocks.Continuous.Integrator integrator4
    annotation (Placement(transformation(extent={{73,-8.5},{84,2.5}})));
  Modelica.Blocks.Continuous.Integrator integrator5
    annotation (Placement(transformation(extent={{73,8.5},{84,19.5}})));
  Modelica.Blocks.Continuous.Integrator integrator6
    annotation (Placement(transformation(extent={{74,-46.5},{85,-35.5}})));
  Modelica.Blocks.Sources.RealExpression SolarRadCeiling(y=Room.ceiling.SolarRadiationPort.I)
    annotation (Placement(transformation(extent={{44,-66},{64,-46}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh7
    annotation (Placement(transformation(extent={{94,-61},{103,-52}})));
  Modelica.Blocks.Continuous.Integrator integrator8
    annotation (Placement(transformation(extent={{74,-61.5},{84,-52}})));
  Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationHor "in kWh/m2"
    annotation (Placement(transformation(extent={{111,-66},{131,-46}})));

  BaseClasses.CheckResultsAccordingToASHRAE checkResultsAccordingToASHRAECooling(checkTime(displayUnit="h") = 284400) annotation (Placement(transformation(extent={{5,70},{20,85}})));
  Modelica.Blocks.Sources.CombiTimeTable ReferenceTempMin(tableOnFile=false,
      table=[600,-23,-21.6])
    "ReferenceTempMin according to ASHRAE140,  {2}=lowerLimit ReferenceTempMin, {3}=upperLimit ReferenceTempMin"
    annotation (Placement(transformation(extent={{-36,72},{-22,86}})));
  Modelica.Blocks.Sources.CombiTimeTable AirExchangeRate(
    columns={2},
    tableOnFile=false,
    table=AERProfile.Profile,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-39,-54},{-26,-41}})));
  Modelica.Blocks.Sources.RealExpression RoomTemp(y=Room.airload.T)
    annotation (Placement(transformation(extent={{45,44},{63,64}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    annotation (Placement(transformation(extent={{91,50},{100,59}})));
  Modelica.Blocks.Interfaces.RealOutput FreeFloatRoomTemperature "in degC"
    annotation (Placement(transformation(extent={{111,45},{131,65}})));
  Modelica.Blocks.Sources.CombiTimeTable ReferenceTempMax(tableOnFile=false,
      table=[600,63.2,68.2])
    "ReferenceTempMax according to ASHRAE140,  {2}=lowerLimit ReferenceTempMax, {3}=upperLimit ReferenceTempMax"
    annotation (Placement(transformation(extent={{-35,51},{-21,65}})));
  BaseClasses.CheckResultsAccordingToASHRAE checkResultsAccordingToASHRAEHeating(checkTime(displayUnit="h") = 25027200) annotation (Placement(transformation(extent={{4,49},{19,64}})));
  parameter Real internalGains=200 "Constant Internal Gains";
  parameter Components.Types.selectorCoefficients absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}";
  parameter Real solar_absorptance_OW=0.6 "Solar absoptance outer walls ";
  parameter DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes=
      AixLib.DataBase.Walls.Collections.ASHRAE140.LightMassCases()
    "Types of walls (contains multiple records)";
  replaceable parameter DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 windowParam
    constrainedby DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple "Window parametrization"
    annotation (choicesAllMatching=true);
  replaceable model CorrSolarGainWin = Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_ASHRAE140
    constrainedby Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
    "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true);
  parameter Modelica.SIunits.Area Win_Area=12 "Window area ";

equation
    //Connections for input solar model
  for i in 1:5 loop
    connect(sun.OutDayAngleSun, radOnTiltedSurf_Perez[i].InDayAngleSun);
    connect(sun.OutHourAngleSun, radOnTiltedSurf_Perez[i].InHourAngleSun);
    connect(sun.OutDeclinationSun, radOnTiltedSurf_Perez[i].InDeclinationSun);
    connect(Solar_Radiation.y[1], radOnTiltedSurf_Perez[i].solarInput1);
    connect(Solar_Radiation.y[2], radOnTiltedSurf_Perez[i].solarInput2);
  end for;

  connect(Source_Weather.y[1], outsideTemp.T) annotation (Line(
      points={{-85.15,36.5},{-80,36.5},{-80,51.5},{-67.1,51.5}},
      color={0,0,127}));
  connect(radOnTiltedSurf_Perez.OutTotalRadTilted, Room.SolarRadiationPort)
    annotation (Line(
      points={{-75.4,75.6},{-61,75.6},{-61,73},{-47,73},{-47,26.8},{-9.1,26.8}},
      color={255,128,0}));

  connect(Source_Weather.y[2], Room.WindSpeedPort) annotation (Line(
      points={{-85.15,36.5},{-53,36.5},{-53,21},{-9.1,21},{-9.1,20.65}},
      color={0,0,127}));
  connect(Ground.port, Room.Therm_ground) annotation (Line(
      points={{-78,-34},{-48,-34},{-48,-19},{7.28,-19},{7.28,-5.18}},
      color={191,0,0}));

  connect(InternalGains_convective.port, Room.thermRoom) annotation (Line(
      points={{-78,-58},{-48,-58},{-48,-19},{7,-19},{7,14.5},{11.06,14.5}},
      color={191,0,0}));
  connect(InternalGains_radiative.port, Room.starRoom) annotation (Line(
      points={{-77,-78},{-48,-78},{-48,-19},{18,-19},{18,-2},{17.36,-2},{17.36,
          14.5}},
      color={191,0,0}));
  connect(outsideTemp.port, Room.thermOutside) annotation (Line(points={{-55,
          51.5},{-47,51.5},{-47,35},{-27,35},{-27,34.59},{-7,34.59}},
                                              color={191,0,0}));
  connect(Source_InternalGains.y, convectiveInternalGains.u) annotation (Line(
        points={{-132.35,-70.5},{-128,-70.5},{-128,-58},{-121,-58}}, color={0,0,
          127}));
  connect(convectiveInternalGains.y, InternalGains_convective.Q_flow)
    annotation (Line(points={{-109.5,-58},{-98,-58}}, color={0,0,127}));
  connect(Source_InternalGains.y, radiativeInternalGains.u) annotation (Line(
        points={{-132.35,-70.5},{-128,-70.5},{-128,-78},{-121,-78}}, color={0,0,
          127}));
  connect(radiativeInternalGains.y, InternalGains_radiative.Q_flow)
    annotation (Line(points={{-109.5,-78},{-97,-78}}, color={0,0,127}));
  connect(TransmittedRad.y, integrator2.u) annotation (Line(points={{66,-72},{
          68,-72},{68,-72.25},{74.1,-72.25}}, color={0,0,127}));
  connect(IncidentSolarRadiationE, IncidentSolarRadiationE)
    annotation (Line(points={{122,-2},{122,-2}}, color={0,0,127}));
  connect(to_kWh5.y, IncidentSolarRadiationN) annotation (Line(points={{100.45,
          14.5},{101.225,14.5},{101.225,15},{121,15}},
                                            color={0,0,127}));
  connect(to_kWh3.y, IncidentSolarRadiationW) annotation (Line(points={{102.45,
          -21.5},{102.725,-21.5},{102.725,-22},{121,-22}},
                                                    color={0,0,127}));
  connect(to_kWh6.y, IncidentSolarRadiationS) annotation (Line(points={{102.45,
          -40.5},{102.725,-40.5},{102.725,-41},{121,-41}},
                                                    color={0,0,127}));
  connect(SolarRadN.y, integrator5.u)
    annotation (Line(points={{65,14},{71.9,14}}, color={0,0,127}));
  connect(integrator5.y, to_kWh5.u) annotation (Line(points={{84.55,14},{89,14},
          {89,14.5},{90.1,14.5}}, color={0,0,127}));
  connect(SolarRadE.y, integrator4.u)
    annotation (Line(points={{65,-3},{71.9,-3}}, color={0,0,127}));
  connect(integrator4.y, to_kWh4.u) annotation (Line(points={{84.55,-3},{90,-3},
          {90,-2.5},{91.1,-2.5}}, color={0,0,127}));
  connect(SolarRadW.y, integrator3.u)
    annotation (Line(points={{65,-22},{72.9,-22}}, color={0,0,127}));
  connect(integrator3.y, to_kWh3.u) annotation (Line(points={{85.55,-22},{92.1,
          -22},{92.1,-21.5}}, color={0,0,127}));
  connect(SolarRadS.y, integrator6.u)
    annotation (Line(points={{65,-41},{72.9,-41}}, color={0,0,127}));
  connect(to_kWh2.y, gainIntHea.u) annotation (Line(points={{104.45,-71.5},{106,
          -71.5},{106,-90},{43,-90},{43,-86.5},{75.3,-86.5}}, color={0,0,127}));
  connect(to_kWh4.y, IncidentSolarRadiationE) annotation (Line(points={{101.45,
          -2.5},{122,-2.5},{122,-2}}, color={0,0,127}));
  connect(integrator6.y, to_kWh6.u) annotation (Line(points={{85.55,-41},{92.1,
          -41},{92.1,-40.5}}, color={0,0,127}));
  connect(to_kWh7.y, IncidentSolarRadiationHor) annotation (Line(points={{
          103.45,-56.5},{102.725,-56.5},{102.725,-56},{121,-56}}, color={0,0,
          127}));
  connect(SolarRadCeiling.y, integrator8.u) annotation (Line(points={{65,-56},{
          68,-56},{68,-56.75},{73,-56.75}}, color={0,0,127}));
  connect(integrator8.y, to_kWh7.u) annotation (Line(points={{84.5,-56.75},{
          93.1,-56.75},{93.1,-56.5}}, color={0,0,127}));
  connect(integrator2.y, to_kWh2.u) annotation (Line(points={{84.45,-72.25},{
          94.1,-72.25},{94.1,-71.5}}, color={0,0,127}));
  connect(gainIntHea.y, TransmittedSolarRadiation_room) annotation (Line(points=
         {{83.35,-86.5},{121,-86.5},{121,-87}}, color={0,0,127}));
  connect(IncidentSolarRadiationHor, IncidentSolarRadiationHor) annotation (
      Line(points={{121,-56},{118.5,-56},{118.5,-56},{121,-56}}, color={0,0,127}));
  connect(ReferenceTempMin.y[1], checkResultsAccordingToASHRAECooling.lowerLimit)
    annotation (Line(points={{-21.3,79},{-9,79},{-9,83.5},{3.95,83.5}},color={0,
          0,127}));
  connect(ReferenceTempMin.y[2], checkResultsAccordingToASHRAECooling.upperLimit)
    annotation (Line(points={{-21.3,79},{-8,79},{-8,80.5},{3.95,80.5}},color={0,
          0,127}));
  connect(Room.AirExchangePort, AirExchangeRate.y[1]) annotation (Line(points={{
          -9.1,28.7475},{-20,28.7475},{-20,-47.5},{-25.35,-47.5}}, color={0,0,127}));
  connect(ReferenceTempMax.y[1], checkResultsAccordingToASHRAEHeating.lowerLimit)
    annotation (Line(points={{-20.3,58},{-9,58},{-9,62.5},{2.95,62.5}},color={0,
          0,127}));
  connect(ReferenceTempMax.y[2], checkResultsAccordingToASHRAEHeating.upperLimit)
    annotation (Line(points={{-20.3,58},{-8,58},{-8,59.5},{2.95,59.5}},color={0,
          0,127}));
  connect(RoomTemp.y, to_degC.u) annotation (Line(points={{63.9,54},{77,54},{77,
          54.5},{90.1,54.5}}, color={0,0,127}));
  connect(to_degC.y, FreeFloatRoomTemperature) annotation (Line(points={{100.45,
          54.5},{108.725,54.5},{108.725,55},{121,55}}, color={0,0,127}));
  connect(FreeFloatRoomTemperature, checkResultsAccordingToASHRAEHeating.modelResults)
    annotation (Line(points={{121,55},{129,55},{129,90},{-15,90},{-15,52.15},{2.95,
          52.15}},color={0,0,127}));
  connect(FreeFloatRoomTemperature, checkResultsAccordingToASHRAECooling.modelResults)
    annotation (Line(points={{121,55},{129,55},{129,90},{-15,90},{-15,73.15},{3.95,
          73.15}},color={0,0,127}));
  annotation (Diagram(coordinateSystem(
        extent={{-150,-110},{130,90}},
        preserveAspectRatio=false,
        grid={1,1}), graphics={
        Text(
          extent={{-56,-2},{12,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Building physics"),
        Rectangle(
          extent={{-47,90},{42,-19}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-150,-19},{-47,-112}},
          lineColor={0,0,127},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,90},{129,-112}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-150,90},{-47,-19}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Text(
          extent={{-143,18},{-115,2}},
          lineColor={0,0,255},
          textString="1 - Direct normal
     irradiance [W/m2]
2 - global horizontal 
     radiance in [W/m2]
",        fontSize=8),
        Text(
          extent={{-148,-10},{-80,-18}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Weather boundary conditions"),
                                         Text(
          extent={{-145,49},{-113,31}},
          lineColor={0,0,255},
          textString="1 - Air Temp [K]
2 - Wind Speed [m/s]
3- Dew Point Temp [K]
4- Cloud Cover",
          fontSize=8),
        Text(
          extent={{26,-91},{87,-99}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Outputs"),
        Rectangle(
          extent={{-47,-19},{42,-112}},
          lineColor={0,0,127},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-55,-90},{6,-98}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HVAC system"),
        Text(
          extent={{-157,-90},{-100,-97}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Internal gains")}),
                  Icon(coordinateSystem(
        extent={{-150,-110},{130,90}},
        preserveAspectRatio=false,
        grid={1,1})),
    experiment(Tolerance=1e-6, StopTime=31536000),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><ul>
  <li>July 1, 2020, by Konstantina Xanthopoulou:<br/>
    updated
  </li>
  <li>
    <i>March 9, 2015</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",info="<html><p>
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 650:
</p>
<ul>
  <li>no cooling or heating equipment
  </li>
</ul>
</html>"));
end Case650FF;
