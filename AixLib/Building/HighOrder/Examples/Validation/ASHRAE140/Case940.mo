within AixLib.Building.HighOrder.Examples.Validation.ASHRAE140;
model Case940
  extends Modelica.Icons.Example;

  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition SetTempProfile = AixLib.DataBase.Profiles.ASHRAE140.SetTemp_caseX40();
  Components.Weather.BaseClasses.Sun sun(
    TimeCorrection=0,
    Latitude=39.76,
    Longitude=-104.9,
    DiffWeatherDataTime=-7,
    Diff_localStandardTime_WeatherDataTime=0.5)
    annotation (Placement(transformation(extent={{-142,61},{-118,85}})));
  Components.Weather.RadiationOnTiltedSurface.RadOnTiltedSurf_Perez
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
    fileName=
        Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-114,0},{-94,20}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_Weather(
    tableOnFile=true,
    tableName="Table",
    columns={4,5,6,7},
    fileName=
        Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-114,30},{-94,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp
    "ambient temperature"
    annotation (Placement(transformation(extent={{-70,41},{-59,52}})));
  Rooms.ASHRAE140.SouthFacingWindows Room(TypOW=
        AixLib.DataBase.Walls.ASHRAE140.OW_Case900(), TypFL=
        AixLib.DataBase.Walls.ASHRAE140.FL_Case900())
    annotation (Placement(transformation(extent={{-9,17},{33,58}})));
  Utilities.Sources.HourOfDay hourOfDay
    annotation (Placement(transformation(extent={{80,69},{100,89}})));
  Modelica.Blocks.Interfaces.RealOutput AnnualHeatingLoad "in MWh"
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  Modelica.Blocks.Interfaces.RealOutput AnnualCoolingLoad "in MWh"
    annotation (Placement(transformation(extent={{90,22},{110,42}})));
  Modelica.Blocks.Interfaces.RealOutput PowerLoad "in kW"
    annotation (Placement(transformation(extent={{90,6},{110,26}})));
  Modelica.Blocks.Sources.Constant AirExchangeRate(k=0.41)
    annotation (Placement(transformation(extent={{-40,-50},{-27,-37}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains_convective(k=0.4*200)
    annotation (Placement(transformation(extent={{-112,-31},{-99,-18}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains_radiative(k=0.6*200)
    annotation (Placement(transformation(extent={{-112,-58},{-100,-46}})));
  Modelica.Blocks.Sources.Constant Source_TsetC(k=273.15 + 27)
    annotation (Placement(transformation(extent={{-10,-50},{3,-37}})));
  Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler(
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000)
    annotation (Placement(transformation(extent={{6,-34},{26,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow Ground(Q_flow=0)
    "adiabatic boundary"
    annotation (Placement(transformation(extent={{-75,0},{-55,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_convective
    annotation (Placement(transformation(extent={{-91,-34},{-71,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_radiative
    annotation (Placement(transformation(extent={{-92,-62},{-72,-42}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_TsetHeat(
    columns={2},
    tableOnFile=false,
    table=SetTempProfile.Profile,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{39,-50},{26,-37}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{71,44.5},{82,55.5}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{71,26.5},{82,37.5}})));
equation
    //Connections for input solar model
  for i in 1:5 loop
    connect(sun.OutDayAngleSun, radOnTiltedSurf_Perez[i].InDayAngleSun);
    connect(sun.OutHourAngleSun, radOnTiltedSurf_Perez[i].InHourAngleSun);
    connect(sun.OutDeclinationSun, radOnTiltedSurf_Perez[i].InDeclinationSun);
    connect(Solar_Radiation.y[1], radOnTiltedSurf_Perez[i].solarInput1);
    connect(Solar_Radiation.y[2], radOnTiltedSurf_Perez[i].solarInput2);
  end for;

  // Set outputs
    integrator1.u =idealHeaterCooler.heatingPower /(1000*1000); //in MWh
    integrator.u =idealHeaterCooler.coolingPower /(1000*1000); //in MWh

    PowerLoad =idealHeaterCooler.coolingPower  +idealHeaterCooler.heatingPower;

  connect(Source_Weather.y[1], outsideTemp.T) annotation (Line(
      points={{-93,40},{-80,40},{-80,46.5},{-71.1,46.5}},
      color={0,0,127}));
  connect(radOnTiltedSurf_Perez.OutTotalRadTilted, Room.SolarRadiationPort)
    annotation (Line(
      points={{-75.4,75.6},{-50,75.6},{-50,49.8},{-11.1,49.8}},
      color={255,128,0}));
  connect(outsideTemp.port, Room.Therm_outside) annotation (Line(
      points={{-59,46.5},{-55,46.5},{-55,47},{-50,47},{-50,57.385},{-10.05,
          57.385}},
      color={191,0,0}));

  connect(Source_Weather.y[2], Room.WindSpeedPort) annotation (Line(
      points={{-93,40},{-11.1,40},{-11.1,43.65}},
      color={0,0,127}));
  connect(Source_TsetC.y, idealHeaterCooler.setPointCool) annotation (Line(
        points={{3.65,-43.5},{13.6,-43.5},{13.6,-31.2}}, color={0,0,127}));
  connect(AirExchangeRate.y, Room.AER) annotation (Line(
      points={{-26.35,-43.5},{-20,-43.5},{-20,27.25},{-11.1,27.25}},
      color={0,0,127}));
  connect(Room.thermRoom,idealHeaterCooler.heatCoolRoom)  annotation (Line(
      points={{5.91,42.215},{5.91,19},{30,19},{30,-28},{25,-28}},
      color={191,0,0}));
  connect(Ground.port, Room.Therm_ground) annotation (Line(
      points={{-55,10},{5.28,10},{5.28,17.82}},
      color={191,0,0}));
  connect(Source_InternalGains_convective.y, InternalGains_convective.Q_flow)
    annotation (Line(
      points={{-98.35,-24.5},{-93,-24.5},{-93,-23},{-92,-23},{-92,-24},{-91,-24}},
      color={0,0,127}));

  connect(Source_InternalGains_radiative.y, InternalGains_radiative.Q_flow)
    annotation (Line(
      points={{-99.4,-52},{-92,-52}},
      color={0,0,127}));
  connect(InternalGains_convective.port, Room.thermRoom) annotation (Line(
      points={{-71,-24},{-50,-24},{-50,-14},{6,-14},{6,42.215},{5.91,42.215}},
      color={191,0,0}));
  connect(InternalGains_radiative.port, Room.starRoom) annotation (Line(
      points={{-72,-52},{-60,-52},{-60,-24},{-50,-24},{-50,-14},{13.89,-14},{
          13.89,42.83}},
      color={191,0,0}));
  connect(Source_TsetHeat.y[1], idealHeaterCooler.setPointHeat) annotation (
      Line(points={{25.35,-43.5},{18.2,-43.5},{18.2,-31.2}},
                                                         color={0,0,127}));
  connect(integrator1.y, AnnualHeatingLoad)
    annotation (Line(points={{82.55,50},{100,50},{100,50}}, color={0,0,127}));
  connect(integrator.y, AnnualCoolingLoad)
    annotation (Line(points={{82.55,32},{100,32},{100,32}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(
        extent={{-150,-100},{120,90}},
        preserveAspectRatio=false,
        grid={1,1}), graphics={
        Rectangle(
          extent={{-48,90},{48,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-116,-13},{-60,-70}},
          lineColor={0,0,127},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,90},{120,-100}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-150,90},{-50,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Text(
          extent={{-150,20},{-122,4}},
          lineColor={0,0,255},
          textString="1 - Direct normal irradiance in W/m2
2 - global horizontal
     radiance in W/m2
"),     Text(
          extent={{-147,-2},{-79,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Weather boundary conditions"),
                                         Text(
          extent={{-148,48},{-116,30}},
          lineColor={0,0,255},
          textString="1 - Air Temperature in K
2 - Wind Speed m/s
3- Dew Point Temperature in K
4- Cloud Cover"),
        Text(
          extent={{35,-91},{96,-99}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Outputs"),
        Rectangle(
          extent={{-50,-14},{47,-64}},
          lineColor={0,0,127},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,-55},{7,-63}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HVAC system"),
        Text(
          extent={{-125,-61},{-68,-68}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Internal gains"),
        Text(
          extent={{-57,-2},{11,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Building physics")}),
                  Icon(coordinateSystem(
        extent={{-150,-100},{120,90}},
        preserveAspectRatio=false,
        grid={1,1})),
    experiment(StopTime=3.1536e+007, Interval=3600),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",
         info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 900:</p>
<ul>
<li>From 2300 hours to 0700 hours, heat = ON if temperature &lt; 10 degC</li>
<li>From 0700 hours to 2300 hours, heat = ON if temperature &lt; 20 degC</li>
</ul>
</html>"));
end Case940;
