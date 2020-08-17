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
    each Latitude= 39.76,
    each h= 1609,
    each WeatherFormat=2) "N,E,S,W, Horz"
    annotation (Placement(transformation(extent={{-102,41},{-74,69}})));

  Modelica.Blocks.Sources.CombiTimeTable Solar_Radiation(
    tableOnFile=true,
    tableName="Table",
    columns={2,3},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-102,-14},{-85,3}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_Weather(
    tableOnFile=true,
    tableName="Table",
    columns={4,5,6,7},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-103,13},{-86,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp
    "ambient temperature"
    annotation (Placement(transformation(extent={{-66,31},{-55,42}})));
  Rooms.ASHRAE140.SouthFacingWindows Room(
    wallTypes=wallTypes,
    calcMethodIn=4,
    Type_Win=windowParam,
    redeclare final model CorrSolarGainWin = CorrSolarGainWin,
    solar_absorptance_OW=solar_absorptance_OW,
    calcMethodOut=2,
    Win_Area=Win_Area,
    absInnerWallSurf=absInnerWallSurf) annotation (Placement(transformation(extent={{-26,9},{30,65}})));

  Modelica.Blocks.Interfaces.RealOutput AnnualHeatingLoad "in kWh"
    annotation (Placement(transformation(extent={{130,58},{150,78}})));
  Modelica.Blocks.Interfaces.RealOutput AnnualCoolingLoad "in kWh"
    annotation (Placement(transformation(extent={{130,42},{150,62}})));
  Modelica.Blocks.Interfaces.RealOutput PowerLoad "in kW"
    annotation (Placement(transformation(extent={{130,25},{150,45}})));
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
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{72,62.5},{83,73.5}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{72,46.5},{83,57.5}})));
  Modelica.Blocks.Sources.RealExpression HeatingPower(y=idealHeaterCooler.heatingPower)
    annotation (Placement(transformation(extent={{45,58},{65,78}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh
    annotation (Placement(transformation(extent={{92,63},{102,73}})));
  Modelica.Blocks.Sources.RealExpression CoolingPower(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{45,41},{65,61}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh1
    annotation (Placement(transformation(extent={{92,47},{102,57}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2)
    "Sum of heating and cooling power"
    annotation (Placement(transformation(extent={{85,30},{95,40}})));
  Modelica.Blocks.Math.Gain convectiveInternalGains(k=0.4) "Convective part"
    annotation (Placement(transformation(extent={{-120,-72},{-110,-62}})));
  Modelica.Blocks.Math.Gain radiativeInternalGains(k=0.6) "Radiative part"
    annotation (Placement(transformation(extent={{-120,-92},{-110,-82}})));
  Modelica.Blocks.Sources.RealExpression TransmittedRad(y=Room.outerWall_South.solarRadWinTrans)
    annotation (Placement(transformation(extent={{46,-10},{64,8}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{75,-6},{85,4.5}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh2
    annotation (Placement(transformation(extent={{92,-6},{102,4}})));
  Modelica.Blocks.Math.Gain gainIntHea(k=1/(Room.Win_Area))
    "Converts to MWh"
    annotation (Placement(transformation(extent={{116,-4},{122,2}})));
  Modelica.Blocks.Math.Gain gain(k=1/1000) "Converts to kW"
    annotation (Placement(transformation(extent={{102,32},{108,38}})));

  BaseClasses.CheckResultsAccordingToASHRAE checkResultsAccordingToASHRAEHeating(checkTime=31536000) annotation (Placement(transformation(extent={{100,-89},{115,-74}})));
  Modelica.Blocks.Sources.CombiTimeTable ReferenceHeatingLoad(tableOnFile=false,
      table=[600,4296,5709])
    "AnnualHeatingLoad according to ASHRAE140 at t=31536000s,  {2}=lowerLimit AnnualHeatingLoad, {3}=upperLimit AnnualHeatingLoad"
    annotation (Placement(transformation(extent={{61,-87},{75,-73}})));
  BaseClasses.CheckResultsAccordingToASHRAE checkResultsAccordingToASHRAECooling(checkTime=31536000) annotation (Placement(transformation(extent={{100,-67},{115,-52}})));
  Modelica.Blocks.Sources.CombiTimeTable ReferenceCoolingLoad(tableOnFile=false,
      table=[600,-7964,-6137])
    "AnnualCoolingLoad according to ASHRAE140 at t=31536000s,  {2}=lowerLimit AnnualCoolingLoad, {3}=upperLimit AnnualCoolingLoad"
    annotation (Placement(transformation(extent={{59,-66},{73,-52}})));
  parameter Real airExchange=0.41 "Constant Air Exchange Rate";
  parameter Real TsetCooler=27 "Constant Set Temperature for Cooler";
  parameter Real TsetHeater=20 "Constant Set Temperature for Heater";
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
  Modelica.Blocks.Sources.RealExpression RoomTemp(y=Room.airload.T)
    annotation (Placement(transformation(extent={{46,6},{64,26}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    annotation (Placement(transformation(extent={{92,11},{102,21}})));
  Modelica.Blocks.Interfaces.RealOutput FreeFloatRoomTemperature "in degC"
    annotation (Placement(transformation(extent={{130,6},{150,26}})));
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
      points={{-75.4,60.6},{-61,60.6},{-61,61},{-51,61},{-51,53.8},{-28.8,53.8}},
      color={255,128,0}));

  connect(Source_Weather.y[2], Room.WindSpeedPort) annotation (Line(
      points={{-85.15,21.5},{-68,21.5},{-68,22},{-48,22},{-48,47},{-28.8,47},{-28.8,45.4}},
      color={0,0,127}));
  connect(Ground.port, Room.Therm_ground) annotation (Line(
      points={{-78,-43},{-48,-43},{-48,-19},{-6.96,-19},{-6.96,10.12}},
      color={191,0,0}));

  connect(InternalGains_convective.port, Room.thermRoom) annotation (Line(
      points={{-78,-67},{-48,-67},{-48,-19},{-2,-19},{-2,37},{-1.92,37}},
      color={191,0,0}));
  connect(InternalGains_radiative.port, Room.starRoom) annotation (Line(
      points={{-77,-87},{-48,-87},{-48,-19},{6.48,-19},{6.48,37}},
      color={191,0,0}));
  connect(outsideTemp.port, Room.thermOutside) annotation (Line(points={{-55,36.5},{-49,36.5},{-49,64},{-27,64},{-27,64.44},{-26,64.44}},
                                              color={191,0,0}));
  connect(HeatingPower.y, integrator1.u)
    annotation (Line(points={{66,68},{70.9,68}}, color={0,0,127}));
  connect(integrator1.y, to_kWh.u)
    annotation (Line(points={{83.55,68},{91,68}},   color={0,0,127}));
  connect(to_kWh.y, AnnualHeatingLoad)
    annotation (Line(points={{102.5,68},{140,68}},color={0,0,127}));
  connect(integrator.u, CoolingPower.y)
    annotation (Line(points={{70.9,52},{68,52},{68,51},{66,51}},
                                                 color={0,0,127}));
  connect(integrator.y, to_kWh1.u) annotation (Line(points={{83.55,52},{91,52}},
                                 color={0,0,127}));
  connect(HeatingPower.y, multiSum.u[1]) annotation (Line(points={{66,68},{66,36.75},{85,36.75}},
                                      color={0,0,127}));
  connect(PowerLoad, PowerLoad)
    annotation (Line(points={{140,35},{140,35}}, color={0,0,127}));
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
  connect(TransmittedRad.y, integrator2.u) annotation (Line(points={{64.9,-1},{71,-1},{71,-0.75},{74,-0.75}},
                                              color={0,0,127}));
  connect(CoolingPower.y, multiSum.u[2]) annotation (Line(points={{66,51},{67,51},{67,33.25},{85,33.25}},
                                      color={0,0,127}));
  connect(to_kWh2.y, gainIntHea.u) annotation (Line(points={{102.5,-1},{115.4,-1}},
                                                              color={0,0,127}));
  connect(to_kWh1.y, AnnualCoolingLoad) annotation (Line(points={{102.5,52},{140,52}},
                                color={0,0,127}));
  connect(integrator2.y, to_kWh2.u) annotation (Line(points={{85.5,-0.75},{91,-0.75},{91,-1}},
                                      color={0,0,127}));
  connect(gainIntHea.y, TransmittedSolarRadiation_room) annotation (Line(points={{122.3,-1},{140,-1}},
                                                color={0,0,127}));
  connect(multiSum.y, gain.u) annotation (Line(points={{95.85,35},{101.4,35}},
                              color={0,0,127}));
  connect(gain.y, PowerLoad) annotation (Line(points={{108.3,35},{140,35}},
                                        color={0,0,127}));
  connect(AnnualHeatingLoad, checkResultsAccordingToASHRAEHeating.modelResults)
    annotation (Line(points={{140,68},{130,68},{130,-36},{49,-36},{49,-90},{77,-90},{77,-85.85},{98.95,-85.85}},
                   color={0,0,127}));
  connect(ReferenceHeatingLoad.y[1], checkResultsAccordingToASHRAEHeating.lowerLimit)
    annotation (Line(points={{75.7,-80},{84,-80},{84,-76},{93,-76},{93,-75.5},{98.95,-75.5}},
                                                                    color={0,0,
          127}));
  connect(ReferenceHeatingLoad.y[2], checkResultsAccordingToASHRAEHeating.upperLimit)
    annotation (Line(points={{75.7,-80},{80,-80},{80,-81},{86,-81},{86,-78.5},{98.95,-78.5}},
                                                                    color={0,0,
          127}));
  connect(AnnualCoolingLoad, checkResultsAccordingToASHRAECooling.modelResults)
    annotation (Line(points={{140,52},{130,52},{130,-39},{52,-39},{52,-68},{76,-68},{76,-63.85},{98.95,-63.85}},
                       color={0,0,127}));
  connect(ReferenceCoolingLoad.y[1], checkResultsAccordingToASHRAECooling.lowerLimit)
    annotation (Line(points={{73.7,-59},{86,-59},{86,-53.5},{98.95,-53.5}},
                                                                    color={0,0,
          127}));
  connect(ReferenceCoolingLoad.y[2], checkResultsAccordingToASHRAECooling.upperLimit)
    annotation (Line(points={{73.7,-59},{88,-59},{88,-56.5},{98.95,-56.5}},
                                                                    color={0,0,
          127}));
  connect(RoomTemp.y,to_degC. u) annotation (Line(points={{64.9,16},{91,16}},
                              color={0,0,127}));
  connect(to_degC.y, FreeFloatRoomTemperature) annotation (Line(points={{102.5,16},{140,16}}, color={0,0,127}));
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
    experiment(Tolerance=1e-6, StopTime=31536000),
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
