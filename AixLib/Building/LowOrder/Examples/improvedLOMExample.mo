within AixLib.Building.LowOrder.Examples;
model improvedLOMExample
  extends Modelica.Icons.Example;
  import AixLib;
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();
  replaceable
    AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel.ReducedOrderModelEBCMod
    reducedOrderModel(
    R1i=0.001236773,
    C1i=9.32664e+05,
    Ai=48.0,
    splitfac=0.03,
    Aw=12,
    epsw=0.9,
    g=0.7,
    RRest=0.019534484,
    R1o=0.000233924,
    C1o=1.00258e+06,
    Ao=123.6,
    alphaiwi=3.16,
    epsi=0.9,
    outerwall(load1(der_T(fixed=true))),
    innerwall(load1(der_T(fixed=true))),
    airload(T(fixed=true)))
              constrainedby
    AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel.partialReducedOrderModel
    annotation (Placement(transformation(extent={{44,18},{78,52}})),
      choicesAllMatching=true);
  replaceable AixLib.Building.LowOrder.BaseClasses.EqAirTemp.EqAirTempEBCMod
    partialEqAirTemp(
    aowo=0.6,
    eowo=0.9,
    n=5,
    wf_wall={0.231653775,0.173740331,0.102957235,0.173740331,0.317908328},
    wf_win={0.000000000,0.000000000,1,0.000000000,0.000000000},
    wf_ground=0,
    T_ground=284.15,
    orientationswallshorizontal={90,90,90,90,0}) constrainedby
    AixLib.Building.LowOrder.BaseClasses.EqAirTemp.partialEqAirTemp
    annotation (Placement(transformation(extent={{-56,16},{-36,36}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k=1)   annotation(Placement(transformation(extent={{14,-7},
            {24,3}})));
  Utilities.HeatTransfer.HeatToStar HeatTorStar(A = 2) annotation(Placement(transformation(extent={{52,-88},
            {72,-68}})));
  AixLib.Building.Components.Weather.Sunblinds.Sunblind sunblind(n=5, gsunblind=
       {0,0,0.15,0.15,0})
    annotation (Placement(transformation(extent={{-42,59},{-22,79}})));
  AixLib.Building.LowOrder.BaseClasses.SolarRadWeightedSum solarRadWeightedSum(
      weightfactors={0,0,7,7,0}, n=5)
    annotation (Placement(transformation(extent={{4,55},{38,85}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent={{16,-40},
            {36,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective annotation(Placement(transformation(extent={{16,-60},
            {36,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative annotation(Placement(transformation(extent={{16,-88},
            {36,-68}})));
  AixLib.Building.Components.Weather.Weather
                             weather(                                                                                           Air_temp = true, Sky_rad = true, Ter_rad = true, Outopt = 1,
    fileName=
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",
    WeatherData(tableOnFile=false, table=weatherDataDay.weatherData))                                   annotation(Placement(transformation(extent={{-90,68},
            {-60,88}})));

  Modelica.Blocks.Sources.Constant const(k=200)
    annotation (Placement(transformation(extent={{-64,-58},{-44,-38}})));
  Modelica.Blocks.Math.Gain gain(k=0.4)
    annotation (Placement(transformation(extent={{-22,-34},{-12,-24}})));
  Modelica.Blocks.Math.Gain gain1(k=0.2)
    annotation (Placement(transformation(extent={{-20,-54},{-10,-44}})));
  Modelica.Blocks.Math.Gain gain2(k=0.4)
    annotation (Placement(transformation(extent={{-20,-82},{-12,-74}})));
  replaceable
    AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoCorG
    partialCorG(n=5) constrainedby
    Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
    annotation (Placement(transformation(extent={{-14,63},{0,77}})));
  AixLib.Building.LowOrder.BaseClasses.SolarRadAdapter
                  solarRadAdapter[5]
    annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
equation
  connect(personsRadiative.port,HeatTorStar. Therm) annotation(Line(points={{36,-78},
          {52.8,-78}},                                                                                 color = {191, 0, 0}, smooth = Smooth.None));
  connect(partialEqAirTemp.equalAirTemp, reducedOrderModel.equalAirTemp)
    annotation (Line(
      points={{-36.2,20.4},{-18,20.4},{-18,35.68},{47.4,35.68}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(HeatTorStar.Star, reducedOrderModel.internalGainsRad) annotation (
      Line(
      points={{71.1,-78},{86,-78},{86,-6},{73.75,-6},{73.75,19.7}},
      color={95,95,95},
      pattern=LinePattern.Solid,
      smooth=Smooth.None));
  connect(machinesConvective.port, reducedOrderModel.internalGainsConv)
    annotation (Line(
      points={{36,-30},{64.4,-30},{64.4,19.7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(personsConvective.port, reducedOrderModel.internalGainsConv)
    annotation (Line(
      points={{36,-50},{56,-50},{56,-48},{64.4,-48},{64.4,19.7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(infiltrationRate.y, reducedOrderModel.ventilationRate) annotation (
      Line(
      points={{24.5,-2},{54.54,-2},{54.54,19.7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solarRadWeightedSum.solarRad_out, reducedOrderModel.solarRad_in)
    annotation (Line(
      points={{36.3,70},{53.18,70},{53.18,50.98}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(sunblind.sunblindonoff, partialEqAirTemp.sunblindsig) annotation (
      Line(
      points={{-32,60},{-32,52},{-46,52},{-46,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weather.WeatherDataVector, partialEqAirTemp.weatherData) annotation (
      Line(
      points={{-75.1,67},{-75.1,26},{-54,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weather.WeatherDataVector[1], reducedOrderModel.ventilationTemperature)
    annotation (Line(
      points={{-75.1,67},{-75.1,0},{0,0},{0,26.84},{47.4,26.84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(machinesConvective.Q_flow, gain.y) annotation (Line(
      points={{16,-30},{4,-30},{4,-29},{-11.5,-29}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain2.y, personsRadiative.Q_flow) annotation (Line(
      points={{-11.6,-78},{16,-78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain1.y, personsConvective.Q_flow) annotation (Line(
      points={{-9.5,-49},{6,-49},{6,-50},{16,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, gain.u) annotation (Line(
      points={{-43,-48},{-32,-48},{-32,-29},{-23,-29}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, gain1.u) annotation (Line(
      points={{-43,-48},{-36,-48},{-36,-49},{-21,-49}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, gain2.u) annotation (Line(
      points={{-43,-48},{-36,-48},{-36,-78},{-20.8,-78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialEqAirTemp.equalAirTempWindow, reducedOrderModel.equalAirTempWindow)
    annotation (Line(
      points={{-36.2,28.6},{-34,28.6},{-34,28},{-28,28},{-28,44.18},{47.4,44.18}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(partialCorG.solarRadWinTrans, solarRadWeightedSum.solarRad_in)
    annotation (Line(
      points={{-0.7,70},{5.7,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weather.SolarRadiation_OrientedSurfaces, solarRadAdapter.solarRad_in)
    annotation (Line(
      points={{-82.8,67},{-82.8,50.5},{-97,50.5},{-97,32}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(solarRadAdapter.solarRad_out, partialEqAirTemp.solarRad_in)
    annotation (Line(
      points={{-78,32},{-80,32},{-80,31.6},{-54.5,31.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weather.SolarRadiation_OrientedSurfaces, sunblind.Rad_In) annotation (
     Line(
      points={{-82.8,67},{-82.8,60},{-46,60},{-46,70},{-41,70}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(sunblind.Rad_Out, partialCorG.SR_input) annotation (Line(
      points={{-23,70},{-18,70},{-18,69.93},{-13.86,69.93}},
      color={255,128,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=86400, Interval=3600),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html>
<ul>
<li><i>June 2015,&nbsp;</i> by Moritz Lauster:<br>Debugged due to name changes in partialReducedOrderModel</li>
</ul>
<ul>
<li>October 2014, Peter Remmen:</li>
</ul>
<p>implemented</p>
</html>"));
end improvedLOMExample;
