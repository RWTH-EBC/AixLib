within AixLib.Building.LowOrder.Examples.Validation.ASHRAE140;
model Case620
  import AixLib;
  extends Modelica.Icons.Example;
  AixLib.Building.Components.Weather.BaseClasses.Sun sun(
    TimeCorrection=0,
    Longitude=-104.9,
    DiffWeatherDataTime=-7,
    Diff_localStandardTime_WeatherDataTime=0.5,
    Latitude=39.78)
    annotation (Placement(transformation(extent={{-142,61},{-118,85}})));
  AixLib.Building.Components.Weather.RadiationOnTiltedSurface.RadOnTiltedSurf_Perez
    radOnTiltedSurf_Perez[5](
    each WeatherFormat=2,
    Azimut={180,-90,0,90,0},
    Tilt={90,90,90,90,0},
    GroundReflection=fill(0.2, 5),
    Latitude=fill(39.78, 5),
    each h=1609) "N,E,S,W, Horz"
    annotation (Placement(transformation(extent={{-104,56},{-76,84}})));

  Modelica.Blocks.Sources.CombiTimeTable Solar_Radiation(
    tableOnFile=true,
    tableName="Table",
    columns={2,3},
    fileName=
        Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_Weather(
    tableOnFile=true,
    columns={2,3,4},
    tableName="Table",
    fileName=
        Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/WeatherData_Ashrae140_LOM.mat"))
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));

    Utilities.Sources.HourOfDay hourOfDay
      annotation (Placement(transformation(extent={{80,69},{100,89}})));
    Modelica.Blocks.Interfaces.RealOutput AnnualHeatingLoad "in MWh"
      annotation (Placement(transformation(extent={{90,40},{110,60}})));
    Modelica.Blocks.Interfaces.RealOutput AnnualCoolingLoad "in MWh"
      annotation (Placement(transformation(extent={{90,22},{110,42}})));
    Modelica.Blocks.Interfaces.RealOutput PowerLoad "in kW"
      annotation (Placement(transformation(extent={{90,6},{110,26}})));
//     Utilities.Sensors.EnergyMeter SolarMeter[6]
//      annotation (Placement(transformation(extent={{86,-86},{106,-66}})));
//     Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationN "in kWh/m2"
//       annotation (Placement(transformation(extent={{73,-14},{93,6}})));
//     Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationE "in kWh/m2"
//       annotation (Placement(transformation(extent={{95,-18},{115,2}})));
//     Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationW "in kWh/m2"
//       annotation (Placement(transformation(extent={{72,-31},{92,-11}})));
//     Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationS "in kWh/m2"
//       annotation (Placement(transformation(extent={{95,-34},{115,-14}})));
//     Modelica.Blocks.Interfaces.RealOutput IncidentSolarRadiationHor "in kWh/m2"
//       annotation (Placement(transformation(extent={{73,-56},{93,-36}})));
//     Modelica.Blocks.Interfaces.RealOutput TransmittedSolarRadiation_room
//     "in kWh/m2"
//       annotation (Placement(transformation(extent={{73,-72},{99,-52}})));
  Modelica.Blocks.Sources.Constant AirExchangeRate(k=0.41)
    annotation (Placement(transformation(extent={{-40,-50},{-27,-37}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains_convective(k=0.4*200)
    annotation (Placement(transformation(extent={{-112,-31},{-99,-18}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains_radiative(k=0.6*200)
    annotation (Placement(transformation(extent={{-112,-58},{-100,-46}})));
  Modelica.Blocks.Sources.Constant Source_TsetC(k=273.15 + 27)
    annotation (Placement(transformation(extent={{-10,-50},{3,-37}})));
  Modelica.Blocks.Sources.Constant Source_TsetH(k=273.15 + 20)
    annotation (Placement(transformation(extent={{40,-50},{27,-37}})));
  AixLib.Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler(
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000)
    annotation (Placement(transformation(extent={{6,-34},{26,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_convective
    annotation (Placement(transformation(extent={{-91,-34},{-71,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_radiative
    annotation (Placement(transformation(extent={{-92,-62},{-72,-42}})));
  AixLib.Building.LowOrder.BaseClasses.SolarRadWeightedSum SolarRadWeightedSum(
      n=5, weightfactors={0.00,6.00,0.00,6.00,0.00})
    annotation (Placement(transformation(extent={{-2,54},{18,74}})));
  AixLib.Building.LowOrder.BaseClasses.EqAirTemp.EqAirTempEBCMod
                                        eqAirTemp(
    n=5,
    orientationswallshorizontal={90,90,90,90,0},
    wf_ground=0,
    wf_wall={0.232639073,0.174479305,0.103395145,0.174479305,0.315007171},
    wf_win={0.000000000,0.5,0.000000000,0.5,0.000000000},
    T_ground=283.15)
    annotation (Placement(transformation(extent={{-19,24.5},{3,46.5}})));
  AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel.ReducedOrderModelEBCMod
                                                        reducedOrderModel(
    withWindows=true,
    Aw=12,
    Vair=129.60,
    epso=0.9,
    epsw=0.9,
    g=0.789,
    splitfac=0.03,
    withInnerwalls=true,
    R1i=0.001236773,
    C1i=9.32664e+05,
    Ai=48.0,
    C1o=1.00258e+06,
    Ao=123.6,
    epsi=0.9,
    withOuterwalls=true,
    R1o=0.000233924,
    cair=1005,
    alphaiwi=4.13,
    alphaowi=2.23,
    alphaWin=3.16,
    RRest=0.019486743,
    rhoair=1.19,
    T0all=293.15)
    annotation (Placement(transformation(extent={{13,10.5},{45,46.5}})));
  AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_VDI6007
    corG_VDI6007_1(          n=5, Uw=3.0)
    annotation (Placement(transformation(extent={{-48,54},{-28,74}})));
  Modelica.Blocks.Sources.Constant sunblind[5](each k=0)
    annotation (Placement(transformation(extent={{-24,69},{-11,82}})));
  AixLib.Building.LowOrder.BaseClasses.SolarRadAdapter solarRadAdapter[5]
    annotation (Placement(transformation(extent={{-45,31.5},{-25,51.5}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{72,44.5},{83,55.5}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{72,26.5},{83,37.5}})));
equation

    //Connections for input solar model
  for i in 1:5 loop
    connect(sun.OutDayAngleSun, radOnTiltedSurf_Perez[i].InDayAngleSun);
    connect(sun.OutHourAngleSun, radOnTiltedSurf_Perez[i].InHourAngleSun);
    connect(sun.OutDeclinationSun, radOnTiltedSurf_Perez[i].InDeclinationSun);
    connect(Solar_Radiation.y[1], radOnTiltedSurf_Perez[i].solarInput1);
    connect(Solar_Radiation.y[2], radOnTiltedSurf_Perez[i].solarInput2);
  end for;

//     //Connections for output solar model to meters
//     for i in 1:5 loop
//         SolarMeter[i].p = radOnTiltedSurf_Perez[i].OutTotalRadTilted.I;
//     end for;
//     //Transmitted radiation through window
//     SolarMeter[6].p = reducedOrderModel.solarRadToHeatRad.port.Q_flow;

    // Set outputs
    integrator1.u =idealHeaterCooler.heatingPower /(1000*1000); //in MWh
    integrator.u =idealHeaterCooler.coolingPower /(1000*1000); //in MWh

//     //solar radiation
//     IncidentSolarRadiationN = SolarMeter[1].q_kwh;
//     IncidentSolarRadiationE = SolarMeter[2].q_kwh;
//     IncidentSolarRadiationS = SolarMeter[3].q_kwh;
//     IncidentSolarRadiationW = SolarMeter[4].q_kwh;
//     IncidentSolarRadiationHor = SolarMeter[5].q_kwh;
//
//     TransmittedSolarRadiation_room = SolarMeter[6].q_kwh / reducedOrderModel.Aw;

    PowerLoad =idealHeaterCooler.coolingPower  +idealHeaterCooler.heatingPower;

  connect(Source_TsetC.y, idealHeaterCooler.setPointCool) annotation (Line(
        points={{3.65,-43.5},{13.6,-43.5},{13.6,-31.2}}, color={0,0,127}));
  connect(Source_TsetH.y, idealHeaterCooler.setPointHeat) annotation (Line(
        points={{26.35,-43.5},{18.2,-43.5},{18.2,-31.2}}, color={0,0,127}));
  connect(Source_InternalGains_convective.y, InternalGains_convective.Q_flow)
    annotation (Line(
      points={{-98.35,-24.5},{-93,-24.5},{-93,-23},{-92,-23},{-92,-24},{-91,-24}},
      color={0,0,127}));

  connect(Source_InternalGains_radiative.y, InternalGains_radiative.Q_flow)
    annotation (Line(
      points={{-99.4,-52},{-92,-52}},
      color={0,0,127}));
  connect(eqAirTemp.equalAirTempWindow, reducedOrderModel.equalAirTempWindow)
    annotation (Line(
      points={{2.78,38.36},{3.9,38.36},{3.9,38.22},{16.2,38.22}},
      color={191,0,0}));
  connect(eqAirTemp.equalAirTemp, reducedOrderModel.equalAirTemp) annotation (
      Line(
      points={{2.78,29.34},{4.4,29.34},{4.4,29.22},{16.2,29.22}},
      color={191,0,0}));
  connect(Source_Weather.y, eqAirTemp.weatherData) annotation (Line(
      points={{-79,40},{-57,40},{-57,35.5},{-16.8,35.5}},
      color={0,0,127}));
  connect(Source_Weather.y[1], reducedOrderModel.ventilationTemperature)
    annotation (Line(
      points={{-79,40},{-57,40},{-57,19.86},{16.2,19.86}},
      color={0,0,127}));
  connect(InternalGains_convective.port, reducedOrderModel.internalGainsConv)
    annotation (Line(
      points={{-71,-24},{-11,-24},{-11,-12},{32.2,-12},{32.2,12.3}},
      color={191,0,0}));
  connect(InternalGains_radiative.port, reducedOrderModel.internalGainsRad)
    annotation (Line(
      points={{-72,-52},{-52,-52},{-52,-31},{-7,-31},{-7,-13},{41,-13},{41,12.3}},
      color={191,0,0}));
  connect(idealHeaterCooler.heatCoolRoom, reducedOrderModel.internalGainsConv)
    annotation (Line(
      points={{25,-28},{32,-28},{32,12.3},{32.2,12.3}},
      color={191,0,0}));
  connect(AirExchangeRate.y, reducedOrderModel.ventilationRate) annotation (
      Line(
      points={{-26.35,-43.5},{-19,-43.5},{-19,-11},{24,-11},{24,12.3},{22.92,
          12.3}},
      color={0,0,127}));

  connect(radOnTiltedSurf_Perez.OutTotalRadTilted, corG_VDI6007_1.SR_input)
    annotation (Line(
      points={{-77.4,75.6},{-53,75.6},{-53,63.9},{-47.8,63.9}},
      color={255,128,0}));
  connect(sunblind.y, eqAirTemp.sunblindsig) annotation (Line(
      points={{-10.35,75.5},{-8,75.5},{-8,44.3}},
      color={0,0,127}));
  connect(solarRadAdapter.solarRad_out, eqAirTemp.solarRad_in) annotation (Line(
      points={{-25,41.5},{-25,41.66},{-17.35,41.66}},
      color={0,0,127}));
  connect(solarRadAdapter.solarRad_in, radOnTiltedSurf_Perez.OutTotalRadTilted)
    annotation (Line(
      points={{-44,41.5},{-66,41.5},{-66,75.6},{-77.4,75.6}},
      color={255,128,0}));
  connect(corG_VDI6007_1.solarRadWinTrans, SolarRadWeightedSum.solarRad_in)
    annotation (Line(
      points={{-29,64},{-1,64}},
      color={0,0,127}));
  connect(SolarRadWeightedSum.solarRad_out, reducedOrderModel.solarRad_in)
    annotation (Line(
      points={{17,64},{21.64,64},{21.64,45.42}},
      color={0,0,127}));
  connect(integrator.y, AnnualCoolingLoad) annotation (Line(points={{83.55,32},
          {87,32},{100,32}},        color={0,0,127}));
  connect(integrator1.y, AnnualHeatingLoad) annotation (Line(points={{83.55,50},
          {88.775,50},{100,50}},             color={0,0,127}));
  annotation (Diagram(coordinateSystem(
        extent={{-150,-100},{120,90}},
        preserveAspectRatio=false,
        grid={1,1}), graphics={
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
          extent={{-150,91},{-50,-9}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
Rectangle(extent={{-150,91},{-50,-9}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Text(
          extent={{-139,16},{-111,0}},
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
          extent={{-141,48},{-109,30}},
          lineColor={0,0,255},
          textString="1 - Air Temperature in K
2 - extraterrestrial longwave radiation in W/m2
3 - terrestrial longwave radiation in W/m2"),
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
        Rectangle(
          extent={{-48,90},{48,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-125,-61},{-68,-68}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Internal gains"),
        Text(
          extent={{-56,-2},{12,-10}},
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
    Documentation(info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 600: </p>
<ul>
<li>no windows on south side. two windows, one facing east, one facing west, each with a surface of 6m2.</li>
</ul>
</html>", revisions="<html>
 <ul>
 <li><i>March 19, 2015</i> by Peter Remmen:<br/>Implemented</li>
 </ul>
 </html>"));
end Case620;
