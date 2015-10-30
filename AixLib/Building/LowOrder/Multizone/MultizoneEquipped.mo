within AixLib.Building.LowOrder.Multizone;
model MultizoneEquipped
  "house with basic heat supply system, air handling unit, an arbitrary number of thermal zones (vectorized), and ventilation"
  parameter Integer dimension = 6 "Dimension of the zone vector";
  parameter Boolean withSchedule = false "Air flow calculated by schedule";
  parameter AixLib.DataBase.Buildings.BuildingBaseRecord buildingParam
    "Choose setup for the building" annotation (choicesAllMatching = false);
  parameter String filename = "" "Path to image file of the building";
protected
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam[:]=buildingParam.zoneSetup
    "Choose setup for zones" annotation (choicesAllMatching=false);
  parameter Integer orientations[:]=zoneParam.n "Number cardinal directions";
public
  replaceable AixLib.Building.LowOrder.ThermalZone.ThermalZoneEquipped zone[dimension](
      zoneParam=zoneParam)                                                             constrainedby
    AixLib.Building.LowOrder.ThermalZone.partialThermalZone                                                                                                  annotation (Placement(transformation(extent={{40,35},
            {80,75}})),choicesAllMatching=true);
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
    annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={76,-100}),
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
  BaseClasses.ThermSplitter splitterThermPercentAir(dimension=dimension,
      splitFactor=AixLib.Building.LowOrder.BaseClasses.ZoneFactorsZero(dimension, zoneParam)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={26,-16})));
  BaseClasses.SplitterRealPercent
                                splitterInfiltrationT(dimension=dimension,
      splitFactor=fill(1, dimension)) annotation (Placement(transformation(
        extent={{-7,-6},{7,6}},
        rotation=0,
        origin={-17,60})));
  Modelica.Blocks.Interfaces.RealInput AHU[4]
    "Input for AHU Conditions<br>[1]: Desired Air Temperature in K<br>[2]: Desired minimal relative humidity<br>[3]: Desired maximal relative humidity<br>[4]: Desired Ventilation Flow in m3/s"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,-16}), iconTransformation(
        extent={{7,-7},{-7,7}},
        rotation=-90,
        origin={43,-93})));
  BaseClasses.SplitterRealPercent
                                splitterVentilationV(dimension=dimension,
      splitFactor=AixLib.Building.LowOrder.BaseClasses.ZoneFactorsZero(dimension, zoneParam)) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={48,24})));
  BaseClasses.SplitterRealPercent
                                splitterVentilationT(dimension=dimension,
      splitFactor=fill(1, dimension)) annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={24,39})));
  Utilities.Sources.HeaterCooler.HeaterCoolerPI    idealHeaterCooler[dimension](
     zoneParam=zoneParam,
    each recOrSep=true,
    each staOrDyn=true)
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
  BaseClasses.AirFlowRate      airFlowRate(
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
  Modelica.Blocks.Interfaces.RealOutput Pel
    "The consumed electrical power supplied from the mains [W]" annotation (
      Placement(transformation(extent={{90,6},{110,26}}), iconTransformation(
          extent={{96,12},{110,26}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingPowerAHU
    "The absorbed heating power supplied from a heating circuit [W]"
    annotation (Placement(transformation(extent={{90,-14},{110,6}}),
        iconTransformation(extent={{96,-8},{110,6}})));
  Modelica.Blocks.Interfaces.RealOutput CoolingPowerAHU
    "The absorbed cooling power supplied from a cooling circuit [W]"
    annotation (Placement(transformation(extent={{90,-32},{110,-12}}),
        iconTransformation(extent={{96,-26},{110,-12}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingPowerHeater[size(
    idealHeaterCooler, 1)] "Power for heating" annotation (Placement(
        transformation(extent={{90,-52},{110,-32}}), iconTransformation(extent=
            {{96,-52},{110,-38}})));
  Modelica.Blocks.Interfaces.RealOutput CoolingPowerCooler[size(
    idealHeaterCooler, 1)] "Power for cooling" annotation (Placement(
        transformation(extent={{90,-76},{110,-56}}), iconTransformation(extent=
            {{96,-70},{110,-56}})));
equation
  aHUFull.phi_extractAir = hold(aHUFull.phi_sup);
  for i in 1:dimension loop
    connect(internalGains[(i*3)-2], zone[i].internalGains[1]) annotation (Line(
      points={{76,-100},{76,35.8}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)-1], zone[i].internalGains[2]) annotation (Line(
      points={{76,-100},{76,37.4}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)], zone[i].internalGains[3]) annotation (Line(
      points={{76,-100},{76,39}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)-2], airFlowRate.relOccupation[i]) annotation (Line(
      points={{76,-100},{74,-100},{74,-22},{-76,-22},{-76,10.8},{-72,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
    if zone[i].zoneParam.withOuterwalls then
      //Connect Outside Temperature
      connect(weather[1], zone[i].weather[1]) annotation (Line(
          points={{-56,115},{-56,66},{40,66},{40,53.4},{45.2,53.4}},
          color={0,0,127},
          smooth=Smooth.None));
      for j in 3:4 loop
        //Connect Radiation Vectors. Index has shifted because the absolute humidity has been added at vector position 2.
        connect(weather[j], zone[i].weather[j - 1]) annotation (Line(
            points={{-56,100},{-56,66},{40,66},{40,55},{45.2,55}},
            color={0,0,127},
            smooth=Smooth.None));
      end for;
      for k in 1:orientations[i] loop
        //Connect the radiation Input according to the required orientations for the individual zone
        connect(radIn[k], zone[i].solarRad_in[k]) annotation (Line(
            points={{-20,92},{-20,72},{40,72},{40,67},{44,67}},
            color={255,128,0},
            smooth=Smooth.None));
      end for;
    end if;
  end for;
  connect(weather[1], splitterInfiltrationT.signalInput) annotation (Line(
      points={{-56,115},{-56,60},{-24,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[1], splitterVentilationT.signalInput) annotation (Line(
      points={{-100,-1},{-100,-8},{24,-8},{24,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterInfiltrationT.signalOutput, zone.infiltrationTemperature[1]) annotation (Line(
      points={{-10,60},{38,60},{38,45.9},{45,45.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterVentilationT.signalOutput, zone.infiltrationTemperature[2]) annotation (Line(
      points={{24,46},{24,48.5},{45,48.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput, zone.internalGainsConv) annotation (Line(
      points={{30,-16},{60,-16},{60,37}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(tAirAHUavg.port, splitterThermPercentAir.signalInput) annotation (
      Line(
      points={{16,-16},{22,-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(aHUFull.Vflow_out, splitterVentilationV.signalInput) annotation (Line(
      points={{-52.48,21.8889},{-56,21.8889},{-56,22},{-60,22},{-60,28},{38,28},
          {38,14},{48,14},{48,18}},
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
      points={{8,-16},{4,-16},{4,-4},{22,-4},{22,25.7778},{15.92,25.7778}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[1], aHUFull.T_supplyAir) annotation (Line(
      points={{-100,-1},{-100,-2},{20,-2},{20,11},{15.92,11}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airFlowRate.airFlowRateOutput, aHUFull.Vflow_in) annotation (Line(
      points={{-60,14},{-58,14},{-58,11.7778},{-52.48,11.7778}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[4], airFlowRate.schedule) annotation (Line(
      points={{-100,-31},{-100,18},{-72,18},{-72,17.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[2], aHUFull.phi_supplyAir[1]) annotation (Line(
      points={{-100,-11},{-100,-2},{18,-2},{18,6},{15.92,6},{15.92,7.88889}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[3], aHUFull.phi_supplyAir[2]) annotation (Line(
      points={{-100,-21},{-100,-2},{-42,-2},{-42,-2},{18,-2},{18,6},{15.92,6},{
          15.92,6.33333}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterVentilationV.signalOutput, zone.infiltrationRate) annotation (
     Line(
      points={{48,30},{48,37.4},{52,37.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSetCooler, idealHeaterCooler.setPointCool) annotation (Line(points={{-48,
          -100},{-48,-66},{-22.12,-66},{-22.12,-50.36}},      color={0,0,127}));
  connect(TSetHeater, idealHeaterCooler.setPointHeat) annotation (Line(points={{-20,
          -100},{-22,-100},{-22,-66},{-16.14,-66},{-16.14,-50.36}},    color={0,
          0,127}));
  connect(idealHeaterCooler.heatCoolRoom, zone.internalGainsConv)
    annotation (Line(points={{-7.3,-46.2},{60,-46.2},{60,37}},
                                                           color={191,0,0}));
  connect(aHUFull.Pel, Pel) annotation (Line(points={{7.94,2.05556},{7.94,16},{
          100,16}},
                color={0,0,127}));
  connect(aHUFull.QflowH, HeatingPowerAHU) annotation (Line(points={{-0.42,
          2.05556},{-0.42,-6},{80,-6},{80,-4},{100,-4}},
                                                 color={0,0,127}));
  connect(aHUFull.QflowC, CoolingPowerAHU) annotation (Line(points={{-17.14,
          2.05556},{-17.14,-20},{80,-20},{80,-22},{100,-22}},
                                                    color={0,0,127}));
  connect(idealHeaterCooler.HeatingPower, HeatingPowerHeater) annotation (Line(
        points={{-6,-35.8},{38,-35.8},{38,-42},{100,-42}}, color={0,0,127}));
  connect(idealHeaterCooler.CoolingPower, CoolingPowerCooler) annotation (Line(
        points={{-6,-41.78},{12,-41.78},{12,-42},{36,-42},{36,-66},{100,-66}},
        color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics={
        Rectangle(
          extent={{34,78},{86,-70}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={213,255,170}),
        Rectangle(
          extent={{-66,-26},{32,-70}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-66,50},{32,-24}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={212,221,253}),
        Text(
          extent={{-38,48},{4,34}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Rectangle(
          extent={{32,78},{-66,52}},
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
          extent={{42,-58},{70,-72}},
          lineColor={0,0,255},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Building")}),
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
          fillPattern=FillPattern.Solid)}),
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
