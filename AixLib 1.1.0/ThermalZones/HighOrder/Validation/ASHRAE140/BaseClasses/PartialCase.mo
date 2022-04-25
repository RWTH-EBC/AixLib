within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses;
partial model PartialCase "This is the base class from which the base cases will extend."
  extends Modelica.Icons.Example;

  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.BaseClasses.Sun sun(
    TimeCorrection=0,
    Latitude=39.76,
    Longitude=-104.9,
    DiffWeatherDataTime=-7,
    Diff_localStandardTime_WeatherDataTime=0.5)
    annotation (Placement(transformation(extent={{-142,46},{-118,70}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface.RadOnTiltedSurf_Perez
    radOnTiltedSurf_Perez[5](
    Azimut={180,-90,0,90,0},
    Tilt={90,90,90,90,0},
    each GroundReflection= 0.2,
    each Latitude=sun.Latitude,
    each h= 1609,
    each WeatherFormat=2) "N, E, S, W, Horz"
    annotation (Placement(transformation(extent={{-102,41},{-74,69}})));

  Modelica.Blocks.Sources.CombiTimeTable Solar_Radiation(
    tableOnFile=true,
    tableName="Table",
    columns={2,3},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-102,-14},{-85,3}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_Weather(
    tableOnFile=true,
    tableName="Table",
    columns={4,5,6,7},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-103,13},{-86,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp
    "ambient temperature"
    annotation (Placement(transformation(extent={{-66,31},{-55,42}})));

  replaceable model RoomModel = Rooms.ASHRAE140.SouthFacingWindows  annotation (
      choices(
        choice(redeclare model Room = Rooms.ASHRAE140.SouthFacingWindows (
          wallTypes=wallTypes,
          calcMethodIn=4,
          Type_Win=windowParam,
          redeclare final model CorrSolarGainWin = CorrSolarGainWin,
          solar_absorptance_OW=solar_absorptance_OW,
          calcMethodOut=2,
          Win_Area=Win_Area,
          absInnerWallSurf=absInnerWallSurf)
        "Room with south facing window"),
        choice(redeclare model Room = Rooms.ASHRAE140.EathWestFacingWindows (
          wallTypes=wallTypes,
          calcMethodIn=4,
          Type_Win=windowParam,
          redeclare final model CorrSolarGainWin = CorrSolarGainWin,
          solar_absorptance_OW=solar_absorptance_OW,
          calcMethodOut=2,
          Win_Area=Win_Area,
          absInnerWallSurf=absInnerWallSurf)
        "Room with east and west facing window")));
   RoomModel Room(
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=294.15,
    TWalls_start=289.15,
    final wallTypes=wallTypes,
    calcMethodIn=4,
    final Type_Win=windowParam,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    final solar_absorptance_OW=solar_absorptance_OW,
    calcMethodOut=2,
    final Win_Area=Win_Area,
    final absInnerWallSurf=absInnerWallSurf,
    final use_dynamicShortWaveRadMethod=false)
                  annotation(Placement(transformation(extent={{-27,8},{29,62}})));

  Modelica.Blocks.Interfaces.RealOutput AnnualHeatingLoad "in kWh"
    annotation (Placement(transformation(extent={{130,58},{150,78}})));
  Modelica.Blocks.Interfaces.RealOutput AnnualCoolingLoad "in kWh"
    annotation (Placement(transformation(extent={{130,42},{150,62}})));
  Modelica.Blocks.Interfaces.RealOutput TransmittedSolarRadiation_room
    "in kWh/m2"
    annotation (Placement(transformation(extent={{130,-11},{150,9}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains(final k=internalGains)
    annotation (Placement(transformation(extent={{-146,-86},{-133,-73}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow Ground(Q_flow=0)
    "adiabatic boundary"
    annotation (Placement(transformation(extent={{-98,-53},{-78,-33}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_convective
    annotation (Placement(transformation(extent={{-98,-77},{-78,-57}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_radiative
    annotation (Placement(transformation(extent={{-97,-97},{-77,-77}})));
  Modelica.Blocks.Continuous.Integrator integratorHeat annotation (Placement(transformation(extent={{72,62.5},{83,73.5}})));
  Modelica.Blocks.Continuous.Integrator integratorCool annotation (Placement(transformation(extent={{72,46.5},{83,57.5}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWhHeat annotation (Placement(transformation(extent={{92,63},{102,73}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWhCool annotation (Placement(transformation(extent={{92,47},{102,57}})));
  Modelica.Blocks.Math.Gain convectiveInternalGains(k=0.4) "Convective part"
    annotation (Placement(transformation(extent={{-120,-72},{-110,-62}})));
  Modelica.Blocks.Math.Gain radiativeInternalGains(k=0.6) "Radiative part"
    annotation (Placement(transformation(extent={{-120,-92},{-110,-82}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{75,-6},{85,4.5}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWhTransRad annotation (Placement(transformation(extent={{92,-6},{102,4}})));
  Modelica.Blocks.Math.Gain gainIntHea(k=1/(Room.Win_Area))
    "Converts to MWh"
    annotation (Placement(transformation(extent={{116,-4},{122,2}})));

  BaseClasses.CheckResultsAccordingToASHRAE checkResultsAccordingToASHRAEHeatingOrTempMax(final checkTime=checkTimeHeatOrTempMax, final dispType=dispTypeHeatOrTempMax)
                                                                                                              annotation (Placement(transformation(extent={{99,-49},{114,-64}})));
  Modelica.Blocks.Sources.CombiTimeTable ReferenceHeatingLoadOrTempMax(tableOnFile=false, final table=tableHeatOrTempMax)
                                                                                                               "According to ASHRAE140: If annual heating load then at t=31536000s {2}=lower limit and {3}=upper limit, if maximal temperature then {2}=lower limit ReferenceTempMax and {3}=upper limit ReferenceTempMax" annotation (Placement(transformation(extent={{58,-62},{72,-48}})));
  BaseClasses.CheckResultsAccordingToASHRAE checkResultsAccordingToASHRAECoolingOrTempMin(final checkTime=checkTimeCoolOrTempMin, final dispType=dispTypeCoolOrTempMin)
                                                                                                              annotation (Placement(transformation(extent={{99,-70},{114,-85}})));
  Modelica.Blocks.Sources.CombiTimeTable ReferenceCoolingLoadOrTempMin(tableOnFile=false, final table=tableCoolOrTempMin)
                                                                                                               "According to ASHRAE140: If annual cooling load then at t=31536000s {2}=lower limit and {3}=upper limit, if minimal temperature then {2}=lower limit ReferenceTempMin and {3}=upper limit ReferenceTempMin" annotation (Placement(transformation(extent={{58,-84},{72,-70}})));
  parameter Real airExchange=0.41 "Constant Air Exchange Rate";
  parameter Real TsetCooler=27 "Constant Set Temperature for Cooler";
  parameter Real TsetHeater=20 "Constant Set Temperature for Heater";
  parameter Real internalGains=200 "Constant Internal Gains";
  parameter Components.Types.selectorCoefficients absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}";
  parameter Real solar_absorptance_OW=0.6 "Solar absoptance outer walls ";
  parameter DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes = AixLib.DataBase.Walls.Collections.ASHRAE140.LightMassCases()
    "Types of walls (contains multiple records)"
    annotation (choicesAllMatching=true);
  replaceable parameter DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 windowParam
    constrainedby DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple "Window parametrization"
    annotation (choicesAllMatching=true);
  replaceable model CorrSolarGainWin =
      Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_ASHRAE140
    constrainedby Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
    "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true);

  parameter Modelica.SIunits.Area Win_Area=12 "Window area ";

  parameter Real tableHeatOrTempMax[:,:]=[0.0,0.0,0.0] "Limits to be checked according to ASHRAE 140" annotation (Dialog(tab="Results check", group="Heating load or max. temperature"));
  parameter Real tableCoolOrTempMin[:,:]=[0.0,0.0,0.0] "Limits to be checked according to ASHRAE 140" annotation (Dialog(tab="Results check", group="Cooling load or min. temperature"));
  parameter String dispTypeHeatOrTempMax="None" "Letter displayed in icon of results checker" annotation (Dialog(tab="Results check", group="Heating load or max. temperature"),
    choices(
      choice="Q Heat",
      choice="Q Cool",
      choice="T Max",
      choice="T Min"));
  parameter String dispTypeCoolOrTempMin="None" "Letter displayed in icon of results checker" annotation (Dialog(tab="Results check", group="Cooling load or min. temperature"),
    choices(
      choice="Q Heat",
      choice="Q Cool",
      choice="T Max",
      choice="T Min"));
  parameter Modelica.SIunits.Time checkTimeHeatOrTempMax=31536000 "Simulation time when block should check if model results lies in limit range" annotation (Dialog(tab="Results check", group="Heating load or max. temperature"));
  parameter Modelica.SIunits.Time checkTimeCoolOrTempMin=31536000 "Simulation time when block should check if model results lies in limit range" annotation (Dialog(tab="Results check", group="Cooling load or min. temperature"));

  Modelica.Blocks.Math.UnitConversions.To_degC to_degCRoomConvTemp annotation (Placement(transformation(extent={{92,31},{102,41}})));
  Modelica.Blocks.Interfaces.RealOutput FreeFloatRoomTemperature annotation (Placement(transformation(extent={{130,26},{150,46}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (Placement(transformation(extent={{72,30},{84,42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1 annotation (Placement(transformation(extent={{72,12},{84,24}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degCRoomConvTemp1 annotation (Placement(transformation(extent={{92,13},{102,23}})));
  Modelica.Blocks.Interfaces.RealOutput FreeFloatRoomRadTemperature annotation (Placement(transformation(extent={{130,8},{150,28}})));
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
      points={{-85.15,21.5},{-80,21.5},{-80,36.5},{-67.1,36.5}},
      color={0,0,127}));
  connect(radOnTiltedSurf_Perez.OutTotalRadTilted, Room.SolarRadiationPort)
    annotation (Line(
      points={{-75.4,60.6},{-61,60.6},{-61,61},{-51,61},{-51,50.12},{-29.8,50.12}},
      color={255,128,0}));

  connect(Source_Weather.y[2], Room.WindSpeedPort) annotation (Line(
      points={{-85.15,21.5},{-68,21.5},{-68,22},{-48,22},{-48,43},{-29.8,43},{-29.8,
          33.38}},
      color={0,0,127}));
  connect(Ground.port, Room.Therm_ground) annotation (Line(
      points={{-78,-43},{-48,-43},{-48,-19},{-27,-19},{-27,8}},
      color={191,0,0}));

  connect(InternalGains_convective.port, Room.thermRoom) annotation (Line(
      points={{-78,-67},{-48,-67},{-48,-19},{-2,-19},{-2,35},{-2.92,35}},
      color={191,0,0}));
  connect(InternalGains_radiative.port, Room.starRoom) annotation (Line(
      points={{-77,-87},{-48,-87},{-48,-19},{5.48,-19},{5.48,35}},
      color={191,0,0}));
  connect(outsideTemp.port, Room.thermOutside) annotation (Line(points={{-55,36.5},{-49,36.5},{-49,64},{-27,64},{-27,61.46}},
                                              color={191,0,0}));
  connect(integratorHeat.y, to_kWhHeat.u) annotation (Line(points={{83.55,68},{91,68}}, color={0,0,127}));
  connect(to_kWhHeat.y, AnnualHeatingLoad) annotation (Line(points={{102.5,68},{140,68}}, color={0,0,127}));
  connect(integratorCool.y, to_kWhCool.u) annotation (Line(points={{83.55,52},{91,52}}, color={0,0,127}));
  connect(Source_InternalGains.y, convectiveInternalGains.u) annotation (Line(
        points={{-132.35,-79.5},{-128,-79.5},{-128,-67},{-121,-67}}, color={0,0,
          127}));
  connect(convectiveInternalGains.y, InternalGains_convective.Q_flow)
    annotation (Line(points={{-109.5,-67},{-98,-67}}, color={0,0,127}));
  connect(Source_InternalGains.y, radiativeInternalGains.u) annotation (Line(
        points={{-132.35,-79.5},{-128,-79.5},{-128,-87},{-121,-87}}, color={0,0,
          127}));
  connect(radiativeInternalGains.y, InternalGains_radiative.Q_flow)
    annotation (Line(points={{-109.5,-87},{-97,-87}}, color={0,0,127}));
  connect(to_kWhTransRad.y, gainIntHea.u) annotation (Line(points={{102.5,-1},{115.4,-1}}, color={0,0,127}));
  connect(to_kWhCool.y, AnnualCoolingLoad) annotation (Line(points={{102.5,52},{140,52}}, color={0,0,127}));
  connect(integrator2.y, to_kWhTransRad.u) annotation (Line(points={{85.5,-0.75},{91,-0.75},{91,-1}}, color={0,0,127}));
  connect(gainIntHea.y, TransmittedSolarRadiation_room) annotation (Line(points={{122.3,-1},{140,-1}},
                                                color={0,0,127}));
  connect(ReferenceHeatingLoadOrTempMax.y[1], checkResultsAccordingToASHRAEHeatingOrTempMax.lowerLimit) annotation (Line(points={{72.7,-55},{85,-55},{85,-62.5},{97.95,-62.5}}, color={0,0,127}));
  connect(ReferenceHeatingLoadOrTempMax.y[2], checkResultsAccordingToASHRAEHeatingOrTempMax.upperLimit) annotation (Line(points={{72.7,-55},{86,-55},{86,-59.5},{97.95,-59.5}}, color={0,0,127}));
  connect(ReferenceCoolingLoadOrTempMin.y[1], checkResultsAccordingToASHRAECoolingOrTempMin.lowerLimit) annotation (Line(points={{72.7,-77},{86,-77},{86,-83.5},{97.95,-83.5}}, color={0,0,127}));
  connect(ReferenceCoolingLoadOrTempMin.y[2], checkResultsAccordingToASHRAECoolingOrTempMin.upperLimit) annotation (Line(points={{72.7,-77},{87,-77},{87,-80.5},{97.95,-80.5}}, color={0,0,127}));
  connect(to_degCRoomConvTemp.y, FreeFloatRoomTemperature) annotation (Line(points={{102.5,36},{140,36}}, color={0,0,127}));
  connect(temperatureSensor.T, to_degCRoomConvTemp.u) annotation (Line(points={{84,36},{91,36}}, color={0,0,127}));
  connect(temperatureSensor1.T, to_degCRoomConvTemp1.u) annotation (Line(points={{84,18},{91,18}}, color={0,0,127}));
  connect(to_degCRoomConvTemp1.y, FreeFloatRoomRadTemperature) annotation (Line(points={{102.5,18},{140,18}}, color={0,0,127}));
  connect(Room.thermRoom, temperatureSensor.port) annotation (Line(points={{-2.92,35},{-2.92,44},{67,44},{67,36},{72,36}}, color={191,0,0}));
  connect(Room.starRoom, temperatureSensor1.port) annotation (Line(points={{5.48,35},{5.48,42},{65,42},{65,18},{72,18}}, color={0,0,0}));

  annotation (Diagram(coordinateSystem(
        extent={{-150,-110},{130,90}},
        preserveAspectRatio=false,
        grid={1,1}), graphics={
        Rectangle(
          extent={{-47,-19},{42,-110}},
          lineColor={0,0,0},
          fillColor={255,235,236},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-150,-19},{-47,-110}},
          lineColor={0,0,0},
          fillColor={233,255,252},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-56,-2},{12,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Building physics"),
        Rectangle(
          extent={{-47,90},{42,-19}},
          lineColor={0,0,0},
          fillColor={242,255,238},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,90},{130,-19}},
          lineColor={0,0,0},
          fillColor={255,250,228},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-150,90},{-47,-19}},
          lineColor={0,0,0},
          fillColor={233,255,252},
          fillPattern=FillPattern.Solid),Text(
          extent={{-143,3},{-115,-13}},
          lineColor={0,0,255},
          textString="1 - Direct normal
     irradiance [W/m2]
2 - global horizontal 
     radiance in [W/m2]
",        fontSize=8),
        Text(
          extent={{-134,90},{-66,79}},
          lineColor={238,46,47},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Weather",
          fontSize=18),                  Text(
          extent={{-145,34},{-113,16}},
          lineColor={0,0,255},
          textString="1 - Air Temp [K]
2 - Wind Speed [m/s]
3- Dew Point Temp [K]
4- Cloud Cover",
          fontSize=8),
        Rectangle(
          extent={{42,-19},{130,-110}},
          lineColor={0,0,0},
          fillColor={255,250,228},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-35,90},{33,79}},
          lineColor={238,46,47},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=18,
          textString="Building"),
        Text(
          extent={{52,90},{120,79}},
          lineColor={238,46,47},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=18,
          textString="Outputs"),
        Text(
          extent={{-133,-19},{-65,-30}},
          lineColor={238,46,47},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=18,
          textString="Internal gains"),
        Text(
          extent={{-37,-19},{31,-30}},
          lineColor={238,46,47},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=18,
          textString="HVAC system"),
        Text(
          extent={{52,-19},{120,-30}},
          lineColor={238,46,47},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=18,
          textString="Results check")}),
                  Icon(coordinateSystem(
        extent={{-150,-110},{130,90}},
        preserveAspectRatio=false,
        grid={1,1})),
    experiment(Tolerance=1e-6, StopTime=31539600),
    __Dymola_experimentSetupOutput(events=true),
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
</html>"));
end PartialCase;
