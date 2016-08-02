within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneEquipped
  "Ready-to-use reduced order building model with ventilation, infiltration and internal gains"
  extends AixLib.ThermalZones.ReducedOrder.ThermalZone.PartialThermalZone;
  AixLib.Building.Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    human_SensibleHeat_VDI2078(
    ActivityType=zoneParam.ActivityTypePeople,
    NrPeople=zoneParam.NrPeople,
    RatioConvectiveHeat=zoneParam.RatioConvectiveHeatPeople,
    T0=zoneParam.T0all) "Internal gains from persons"
                        annotation (choicesAllMatching=true, Placement(
        transformation(extent={{40,0},{60,20}})));
  AixLib.Building.Components.Sources.InternalGains.Machines.Machines_DIN18599 machines_SensibleHeat_DIN18599(
    ActivityType=zoneParam.ActivityTypeMachines,
    NrPeople=zoneParam.NrPeopleMachines,
    ratioConv=zoneParam.RatioConvectiveHeatMachines,
    T0=zoneParam.T0all) "Internal gains from machines"
    annotation (Placement(transformation(extent={{40,-20},{60,-1}})));
  AixLib.Building.Components.Sources.InternalGains.Lights.Lights_relative lights(
    RoomArea=zoneParam.RoomArea,
    LightingPower=zoneParam.LightingPower,
    ratioConv=zoneParam.RatioConvectiveHeatLighting,
    T0=zoneParam.T0all) "Internal gains from light"
    annotation (Placement(transformation(extent={{40,-40},{60,-21}})));
  Controls.VentilationController.VentilationController
                                          ventilationController(
    useConstantOutput=zoneParam.useConstantACHrate,
    baseACH=zoneParam.baseACH,
    maxUserACH=zoneParam.maxUserACH,
    maxOverheatingACH=zoneParam.maxOverheatingACH,
    maxSummerACH=zoneParam.maxSummerACH,
    winterReduction=zoneParam.winterReduction,
    Tmean_start=zoneParam.T0all)
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tZone
    "Temperature sensor for zone temperature"
    annotation (Placement(transformation(extent={{-24,-48},{-32,-40}})));
  Modelica.Blocks.Math.Add addInfiltrationVentilation
    "Combines infiltration and ventilation"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-8,-26})));
  Utilities.Psychrometrics.MixedTemperature mixedTemperature
    "mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-64,-24},{-44,-4}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam="modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
    "Weather data reader"
    annotation (Placement(transformation(extent={{-178,72},{-158,92}})));
  BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[2](
    each outSkyCon=true,
    each outGroCon=true,
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-148,40},{-128,60}})));
  BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[2](
    each til(displayUnit="deg") = 1.5707963267949,
    each lat=0.87266462599716,
    azi={3.1415926535898,4.7123889803847})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{-148,72},{-128,92}})));
  SolarGain.CorrectionGDoublePane corGDouPan(n=2, UWin=2.1)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{-74,74},{-54,94}})));
  EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(
    n=2,
    wfGro=0,
    wfWall={0.3043478260869566,0.6956521739130435},
    wfWin={0.5,0.5},
    withLongwave=true,
    aExt=0.7,
    alphaWallOut=20,
    alphaRadWall=5,
    alphaWinOut=20,
    alphaRadWin=5,
    aWin=0.03,
    eExt=0.9,
    TGro=285.15,
    eWin=0.9) "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{-104,6},{-84,26}})));
  Modelica.Blocks.Math.Add solRad[2]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{-118,26},{-108,36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{-72,14},{-60,26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem1
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{-72,34},{-60,46}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{-42,36},{-52,46}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{-44,26},{-54,16}})));
  Modelica.Blocks.Sources.Constant const[2](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{-100,34},{-94,40}})));
  Modelica.Blocks.Sources.Constant alphaWall(k=25*11.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={-50,4})));
  Modelica.Blocks.Sources.Constant alphaWin(k=20*14)
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(
    transformation(
    extent={{4,-4},{-4,4}},
    rotation=90,
    origin={-48,58})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(
    transformation(extent={{-180,10},{-146,42}}),iconTransformation(
    extent={{-70,-12},{-50,8}})));
  Building.Components.Weather.Sunblinds.Sunblind
                                        sunblind(
    Imax=Imax,
    n=n,
    gsunblind=gsunblind) "Sunblind model" annotation (Placement(transformation(extent={{36,67},
            {56,87}})));
equation
  connect(ventilationController.y, addInfiltrationVentilation.u1) annotation (
      Line(
      points={{-45,-62},{-11.6,-62},{-11.6,-33.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tZone.T, ventilationController.Tzone) annotation (Line(
      points={{-32,-44},{-72,-44},{-72,-56},{-64,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(internalGains[1], human_SensibleHeat_VDI2078.Schedule) annotation (
      Line(points={{80,-113.333},{80,-113.333},{80,-68},{30,-68},{30,8.9},{40.9,
          8.9}}, color={0,0,127}));
  connect(internalGains[2], machines_SensibleHeat_DIN18599.Schedule)
    annotation (Line(points={{80,-100},{80,-100},{80,-70},{80,-68},{30,-68},{30,
          -10.5},{41,-10.5}}, color={0,0,127}));
  connect(internalGains[3], lights.Schedule) annotation (Line(points={{80,
          -86.6667},{80,-86.6667},{80,-68},{30,-68},{30,-30.5},{41,-30.5}},
        color={0,0,127}));
  connect(internalGains[1], ventilationController.relOccupation) annotation (
      Line(points={{80,-113.333},{80,-113.333},{80,-68},{-34,-68},{-34,-74},{
          -72,-74},{-72,-68},{-64,-68}}, color={0,0,127}));
  connect(ventilationRate, addInfiltrationVentilation.u2) annotation (Line(
        points={{-40,-100},{-40,-66},{-4.4,-66},{-4.4,-33.2}}, color={0,0,127}));
  connect(ventilationController.Tambient, weather[1]) annotation (Line(points={{-64,-62},
          {-80,-62},{-80,-14},{-90,-14},{-90,-8},{-100,-8},{-100,-3.33333}},
                                                                  color={0,0,127}));
  connect(weather[1], mixedTemperature.temperature_flow2) annotation (Line(
        points={{-100,-3.33333},{-100,-14},{-112,-14},{-112,-16},{-63.6,-16}},
                                                        color={0,0,127}));
  connect(ventilationController.y, mixedTemperature.flowRate_flow2) annotation (
     Line(points={{-45,-62},{-40,-62},{-40,-30},{-70,-30},{-70,-21},{-63.6,-21}},
        color={0,0,127}));
  connect(ventilationRate, mixedTemperature.flowRate_flow1) annotation (Line(
        points={{-40,-100},{-40,-76},{-74,-76},{-74,-11},{-63.6,-11}}, color={0,
          0,127}));
  connect(ventilationTemperature, mixedTemperature.temperature_flow1)
    annotation (Line(points={{-100,-40},{-76,-40},{-76,-6.2},{-63.6,-6.2}},
        color={0,0,127}));
  connect(eqAirTemp.TEqAirWin,preTem1. T)
    annotation (Line(
    points={{-83,19.8},{-80,19.8},{-80,40},{-73.2,40}},
                                                   color={0,0,127}));
  connect(eqAirTemp.TEqAir,preTem. T)
    annotation (Line(points={{-83,16},{-73.2,16},{-73.2,20}},
    color={0,0,127}));
  connect(weaDat.weaBus,weaBus)
    annotation (Line(
    points={{-158,82},{-154,82},{-154,38},{-164,38},{-164,32},{-163,32},{-163,
          26}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%second",
    index=1,
    extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul,eqAirTemp. TDryBul)
    annotation (Line(
    points={{-163,26},{-163,18},{-118,18},{-118,10},{-106,10}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(const.y,eqAirTemp. sunblind)
    annotation (Line(points={{-93.7,37},{-92,37},{-92,28},{-94,28}},
    color={0,0,127}));
  connect(HDifTil.HSkyDifTil,corGDouPan. HSkyDifTil)
    annotation (Line(
    points={{-127,56},{-108,56},{-86,56},{-86,86},{-76,86}},
                                                       color={0,0,127}));
  connect(HDirTil.H,corGDouPan. HDirTil)
    annotation (Line(points={{-127,82},{-90,82},{-90,90},{-76,90}},
    color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{-127,82},{-122,82},{-122,34},{-119,34}},
                   color={0,0,127}));
  connect(HDirTil.inc,corGDouPan. inc)
    annotation (Line(points={{-127,78},{-76,78}},     color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{-127,50},{-124,50},{-124,28},{-119,28}},
                 color={0,0,127}));
  connect(HDifTil.HGroDifTil,corGDouPan. HGroDifTil)
    annotation (Line(
    points={{-127,44},{-84,44},{-84,82},{-76,82}},
                                              color={0,0,127}));
  connect(solRad.y,eqAirTemp. HSol)
    annotation (Line(points={{-107.5,31},{-106,31},{-106,22}},
    color={0,0,127}));
  connect(weaDat.weaBus,HDifTil [1].weaBus)
    annotation (Line(
    points={{-158,82},{-154,82},{-154,50},{-148,50}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDifTil [2].weaBus)
    annotation (Line(
    points={{-158,82},{-154,82},{-154,50},{-148,50}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [1].weaBus)
    annotation (Line(
    points={{-158,82},{-153,82},{-148,82}},
    color={255,204,51},
    thickness=0.5));
  connect(weaDat.weaBus,HDirTil [2].weaBus)
    annotation (Line(
    points={{-158,82},{-153,82},{-148,82}},
    color={255,204,51},
    thickness=0.5));
  connect(theConWin.solid, thermalZoneTwoElements.window)
    annotation (
     Line(points={{-42,41},{-40,41},{-40,40},{-36.2,40}},
                                                      color={191,0,0}));
  connect(preTem1.port,theConWin. fluid)
    annotation (Line(points={{-60,40},{-52,40},{-52,41}},
                                                       color={191,0,0}));
  connect(thermalZoneTwoElements.extWall,theConWall. solid)
    annotation (Line(points={{-36.2,32},{-40,32},{-40,21},{-44,21}},
    color={191,0,0}));
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{-54,21},{-56,21},{-56,20},{-60,20}},
                                                           color={191,0,0}));
  connect(alphaWall.y,theConWall. Gc)
    annotation (Line(points={{-50,8.4},{-50,16},{-49,16}},color={0,0,127}));
  connect(alphaWin.y,theConWin. Gc)
    annotation (Line(points={{-48,53.6},{-48,46},{-47,46}},
                                                         color={0,0,127}));
  connect(weaBus.TBlaSky,eqAirTemp. TBlaSky)
    annotation (Line(
    points={{-163,26},{-138,26},{-138,22},{-112,22},{-112,16},{-106,16}},
    color={255,204,51},
    thickness=0.5), Text(
    string="%first",
    index=-1,
    extent={{-6,3},{-6,3}}));
  connect(corGDouPan.solarRadWinTrans, thermalZoneTwoElements.solRad)
    annotation (Line(points={{-53,84},{-46,84},{-40,84},{-40,51},{-37,51}},
                                                                       color={0,
    0,127}));
  annotation(Documentation(info="<html>
<p>This model combines building physics, models for internal gains and the
calculation of natural ventilation (window opening) and infiltration. It is
thought as a ready-to-use thermal zone model. For convenience, all parameters
are collected in a record (see
<a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\"> ZoneBaseRecord</a>). </p>
<p><b>References</b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012:
Calculation of transient thermal response of rooms and buildings -
Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014):
Low order thermal network models for dynamic simulations of buildings on city
district scale. In: Building and Environment 73, p. 223&ndash;231. DOI:
<a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">
10.1016/j.buildenv.2013.12.016</a>.</li>
</ul>
<p><b>Example Results</b></p>
<p>See <a href=\"Examples\">Examples</a>.</p>
</html>",  revisions="<html>
<ul>
<li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end ThermalZoneEquipped;
