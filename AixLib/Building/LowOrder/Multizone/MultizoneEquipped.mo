within AixLib.Building.LowOrder.Multizone;
model MultizoneEquipped
  "house with basic heat supply system, air handling unit, an arbitrary number of thermal zones (vectorized), and ventilation"
  parameter Integer dimension = 6 "Dimension of the zone vector";
  parameter Boolean withSchedule = false "Air flow calculated by schedule";
protected
  parameter Integer orientations[:]=zoneParam.n "number cardinal directions";
  //inner parameter Real AirFactor = 3;
public
  parameter DataBase.Buildings.BuildingBaseRecord buildingParam=
      DataBase.Buildings.BuildingBaseRecord() "choose setup for the building"
                                    annotation (choicesAllMatching = false);
  parameter String filename="./Pictures/LCS/LCS_55.JPG"
    "Path to image file of the building";
protected
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam[:]=buildingParam.zoneSetup
    "choose setup for zones"
    annotation (choicesAllMatching=false, tab="Building Physics");
public
  replaceable AixLib.Building.LowOrder.ThermalZone.ThermalZoneEquipped zone[dimension](
      zoneParam=zoneParam)                                                             constrainedby
    AixLib.Building.LowOrder.ThermalZone.partialThermalZone                                                                                                  annotation (Placement(transformation(extent={{38,35},
            {78,75}})),choicesAllMatching=true);
  AixLib.Utilities.Interfaces.SolarRad_in radIn[max(orientations)] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,92}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-62,90})));

  Modelica.Blocks.Interfaces.RealInput internalGains[3*dimension]
    "Connect the input table for internal gains<br>Persons, machines, light"
    annotation (Placement(transformation(extent={{120,-62},{80,-22}}),
        iconTransformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,65})));
  Modelica.Blocks.Interfaces.RealInput weather[4]
    "Weather Input Vector<br>[1]: Air Temperature<br>[2]: Water mass fraction<br>[3]: Sky Radiation<br>[4]: Terrestrial Radiation"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-56,100}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-16,94})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tAirAHUavg
    "Averaged air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{16,-20},{8,-12}})));
  Utilities.SplitterThermPercentAir splitterThermPercentAir(dimension=dimension,
      ZoneFactor=Utilities.ZoneFactorsZero(dimension, zoneParam)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={26,-16})));
  Utilities.SplitterRealPercent splitterInfiltrationT(dimension=dimension,
      ZoneFactor=fill(1, dimension)) annotation (Placement(transformation(
        extent={{-7,-6},{7,6}},
        rotation=0,
        origin={-17,52})));
  Modelica.Blocks.Interfaces.RealInput AHU[4]
    "Input for AHU Conditions<br>[1]: Desired Air Temperature in K<br>[2]: Desired minimal relative humidity<br>[3]: Desired maximal relative humidity<br>[4]: Desired Ventilation Flow in m3/s"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,-16}), iconTransformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={93,-53})));
  Utilities.SplitterRealPercent splitterVentilationV(dimension=dimension,
      ZoneFactor=Utilities.ZoneFactorsZero(dimension, zoneParam)) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={46,24})));
  Utilities.SplitterRealPercent splitterVentilationT(dimension=dimension,
      ZoneFactor=fill(1, dimension)) annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={28,31})));
  Utilities.Sources.HeaterCooler.HeaterCoolerPI    idealHeaterCooler[dimension](
     zoneParam=zoneParam, each withMeter=false,
    recOrSep=true,
    staOrDyn=true)
    annotation (Placement(transformation(extent={{-32,-54},{-6,-28}})));
  Modelica.Blocks.Interfaces.RealInput TSetHeater[dimension]
    "Set point for heater" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-20,-100}), iconTransformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-94,6})));
  HVAC.AirHandlingUnit.AHU       aHUFull(
    heating=buildingParam.heating,
    cooling=buildingParam.cooling,
    dehumidification=buildingParam.dehumidification,
    humidification=buildingParam.humidification,
    BPF_DeHu=buildingParam.BPF_DeHu,
    HRS=buildingParam.HRS,
    efficiencyHRS_enabled=buildingParam.efficiencyHRS_enabled,
    efficiencyHRS_disabled=buildingParam.efficiencyHRS_disabled)
    annotation (Placement(transformation(extent={{-54,-24},{22,46}})));
  Utilities.AirFlowRate        airFlowRate(
    zoneParam=zoneParam,
    withSchedule=withSchedule,
    dimension=dimension)
    annotation (Placement(transformation(extent={{-72,6},{-60,22}})));
  Modelica.Blocks.Interfaces.RealInput TSetCooler[dimension]
    "Set point for cooler" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-48,-100}), iconTransformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-94,-22})));
equation
  for i in 1:dimension loop
    connect(internalGains[(i*3)-2], zone[i].internalGains[1]) annotation (Line(
      points={{100,-42},{74,-42},{74,35.8}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)-1], zone[i].internalGains[2]) annotation (Line(
      points={{100,-42},{74,-42},{74,37.4}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)], zone[i].internalGains[3]) annotation (Line(
      points={{100,-42},{74,-42},{74,39}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)-2], airFlowRate.relOccupation[i]) annotation (Line(
      points={{100,-42},{76,-42},{76,-20},{-80,-20},{-80,10.8},{-72,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
    if zone[i].zoneParam.withOuterwalls then
      //Connect Outside Temperature
      connect(weather[1], zone[i].weather[1]) annotation (Line(
          points={{-56,115},{-56,53.4},{43.2,53.4}},
          color={0,0,127},
          smooth=Smooth.None));
      for j in 3:4 loop
        //Connect Radiation Vectors. Index has shifted because the absolute humidity has been added at vector position 2.
        connect(weather[j], zone[i].weather[j - 1]) annotation (Line(
            points={{-56,100},{-56,55},{43.2,55}},
            color={0,0,127},
            smooth=Smooth.None));
      end for;
      for k in 1:orientations[i] loop
        //Connect the radiation Input according to the required orientations for the individual zone
        connect(radIn[k], zone[i].solarRad_in[k]) annotation (Line(
            points={{-20,92},{-20,67},{42,67}},
            color={255,128,0},
            smooth=Smooth.None));
      end for;
    end if;
  end for;

  connect(weather[1], splitterInfiltrationT.signalInput) annotation (Line(
      points={{-56,115},{-56,52},{-24,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[1], splitterVentilationT.signalInput) annotation (Line(
      points={{-100,-1},{-100,-22},{28,-22},{28,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterInfiltrationT.signalOutput, zone.infiltrationTemperature[1]) annotation (Line(
      points={{-10,52},{0,52},{0,45.9},{43,45.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterVentilationT.signalOutput, zone.infiltrationTemperature[2]) annotation (Line(
      points={{28,38},{28,48.5},{43,48.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput, zone.internalGainsConv) annotation (Line(
      points={{30,-16},{58,-16},{58,37}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(tAirAHUavg.port, splitterThermPercentAir.signalInput) annotation (
      Line(
      points={{16,-16},{22,-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(aHUFull.Vflow_out, splitterVentilationV.signalInput) annotation (Line(
      points={{-52.48,21.8889},{46,21.8889},{46,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(aHUFull.T_outdoorAir, weather[1]) annotation (Line(
      points={{-49.44,9.44444},{-56,9.44444},{-56,115}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weather[2], aHUFull.X_outdoorAir) annotation (Line(
      points={{-56,105},{-56,5.55556},{-49.44,5.55556}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tAirAHUavg.T, aHUFull.T_extractAir) annotation (Line(
      points={{8,-16},{4,-16},{4,-6},{22,-6},{22,25.7778},{15.92,25.7778}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[1], aHUFull.T_supplyAir) annotation (Line(
      points={{-100,-1},{-78,-1},{-78,-4},{20,-4},{20,11},{15.92,11}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airFlowRate.airFlowRateOutput, aHUFull.Vflow_in) annotation (Line(
      points={{-60,14},{-58,14},{-58,11.7778},{-52.48,11.7778}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[4], airFlowRate.schedule) annotation (Line(
      points={{-100,-31},{-100,0},{-72,0},{-72,17.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[2], aHUFull.phi_supplyAir[1]) annotation (Line(
      points={{-100,-11},{-42,-11},{-42,7.88889},{15.92,7.88889}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[3], aHUFull.phi_supplyAir[2]) annotation (Line(
      points={{-100,-21},{-42,-21},{-42,6.33333},{15.92,6.33333}},
      color={0,0,127},
      smooth=Smooth.None));

  aHUFull.phi_extractAir = hold(aHUFull.phi_sup);

  connect(splitterVentilationV.signalOutput, zone.infiltrationRate) annotation (
     Line(
      points={{46,30},{46,37.4},{50,37.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSetCooler, idealHeaterCooler.setPointCool) annotation (Line(points={
          {-48,-100},{-48,-66},{-25.24,-66},{-25.24,-47.24}}, color={0,0,127}));
  connect(TSetHeater, idealHeaterCooler.setPointHeat) annotation (Line(points={
          {-20,-100},{-22,-100},{-22,-66},{-15.1,-66},{-15.1,-47.24}}, color={0,
          0,127}));
  connect(idealHeaterCooler.heatCoolRoom, zone.internalGainsConv)
    annotation (Line(points={{-7.3,-41},{58,-41},{58,37}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics={
        Rectangle(
          extent={{34,78},{82,-70}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={213,255,170}),
        Rectangle(
          extent={{-66,-26},{32,-70}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-66,42},{32,-24}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={212,221,253}),
        Text(
          extent={{-38,44},{4,30}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Rectangle(
          extent={{32,78},{-66,44}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,-50},{-32,-60}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Heating
Cooling"),
        Text(
          extent={{-52,74},{-24,64}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Weather"),
        Text(
          extent={{42,-48},{70,-62}},
          lineColor={0,0,255},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Building")}),
    experiment(
      StopTime=3.1536e+007,
      Interval=3600,
      Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput(doublePrecision=true, events=false),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={                                                       Text(
          extent={{-80,-150},{100,-110}},
          lineColor={0,0,255},
          textString="%name%"),
        Rectangle(
          extent={{-60,-80},{60,40}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,40},{0,80},{80,40},{-80,40}},
          lineColor={95,95,95},
          smooth=Smooth.None,
          fillColor={217,72,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,20},{-8,-16}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,20},{40,-16}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,-44},{12,-80}},
          lineColor={95,95,95},
          fillColor={154,77,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,20},{-4,24}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,20},{44,24}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
                   Bitmap(extent={{-80,80},{80,-80}}, fileName=filename)}),
    Documentation(revisions="<html>
<ul>
<li><i>June 22, 2015&nbsp;</i> by Moritz Lauster:<br>Changed Building Physics to AixLib</li>
<li><i>April 25, 2014&nbsp;</i> by Ole Odendahl:<br>Implemented</li>
</ul>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>House&nbsp;with&nbsp;basic&nbsp;heat&nbsp;supply&nbsp;system,&nbsp;air&nbsp;handling&nbsp;unit,&nbsp;an&nbsp;arbitrary&nbsp;number&nbsp;of&nbsp;thermal&nbsp;zones&nbsp;(vectorized),&nbsp;and&nbsp;ventilation </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>. </p>
</html>"));
end MultizoneEquipped;
