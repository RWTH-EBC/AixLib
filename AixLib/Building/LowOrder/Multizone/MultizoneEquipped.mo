within AixLib.Building.LowOrder.Multizone;
model MultizoneEquipped
  "Multizone with basic heat supply system, air handling unit, an arbitrary number of thermal zones (vectorized), and ventilation"
  extends AixLib.Building.LowOrder.Multizone.partialMultizone;
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAirAHUAvg
    "Averaged air temperature of the zones which are supplied by the AHU" annotation (Placement(transformation(extent={{16,-20},{8,-12}})));
  BaseClasses.ThermSplitter splitterThermPercentAir(dimension=buildingParam.numZones,
      splitFactor=AixLib.Building.LowOrder.BaseClasses.ZoneFactorsZero(buildingParam.numZones, zoneParam)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={26,-16})));
  Modelica.Blocks.Interfaces.RealInput AHU[4]
    "Input for AHU Conditions [1]: Desired Air Temperature in K [2]: Desired minimal relative humidity [3]: Desired maximal relative humidity [4]: Schedule Desired Ventilation Flow"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,-16}), iconTransformation(
        extent={{7,-7},{-7,7}},
        rotation=-90,
        origin={43,-93})));
  Utilities.Sources.HeaterCooler.HeaterCoolerPI heaterCooler[buildingParam.numZones](
    zoneParam=zoneParam,
    each recOrSep=true,
    each staOrDyn=true) "Heater Cooler with PI control"
    annotation (Placement(transformation(extent={{-32,-54},{-6,-28}})));
  Modelica.Blocks.Interfaces.RealInput TSetHeater[buildingParam.numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for heater"
                           annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-20,-100}), iconTransformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-94,6})));
  HVAC.AirHandlingUnit.AHU AirHandlingUnit(
    heating=buildingParam.heating,
    cooling=buildingParam.cooling,
    dehumidification=buildingParam.dehumidification,
    humidification=buildingParam.humidification,
    BPF_DeHu=buildingParam.BPF_DeHu,
    HRS=buildingParam.HRS,
    efficiencyHRS_enabled=buildingParam.efficiencyHRS_enabled,
    efficiencyHRS_disabled=buildingParam.efficiencyHRS_disabled)
    "Air Handling Unit"
    annotation (Placement(transformation(extent={{-54,-24},{22,46}})));
  BaseClasses.AirFlowRate airFlowRate(
    zoneParam=zoneParam,
    dimension=buildingParam.numZones,
    withProfile=true)                annotation (Placement(transformation(extent={{-72,6},{-60,22}})));
  Modelica.Blocks.Interfaces.RealInput TSetCooler[buildingParam.numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for cooler"
                           annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-48,-100}), iconTransformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-94,-22})));
  Modelica.Blocks.Interfaces.RealOutput Pel(
   final quantity="Power",
   final unit="W") "The consumed electrical power supplied from the mains"
                                                            annotation (
      Placement(transformation(extent={{94,6},{114,26}}), iconTransformation(
          extent={{100,12},{114,26}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingPowerAHU(
   final quantity="HeatFlowRate",
   final unit="W") "The absorbed heating power supplied from a heating circuit"
                                                                 annotation (Placement(transformation(extent={{94,-14},{114,6}}),
        iconTransformation(extent={{100,-8},{114,6}})));
  Modelica.Blocks.Interfaces.RealOutput CoolingPowerAHU(
   final quantity="HeatFlowRate",
   final unit="W") "The absorbed cooling power supplied from a cooling circuit"
                                                                 annotation (Placement(transformation(extent={{94,-32},{114,-12}}),
        iconTransformation(extent={{100,-26},{114,-12}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingPowerHeater[size(
    heaterCooler, 1)](
   final quantity="HeatFlowRate",
   final unit="W") "Power for heating" annotation (Placement(
        transformation(extent={{90,-52},{110,-32}}), iconTransformation(extent={{100,-52},
            {114,-38}})));
  Modelica.Blocks.Interfaces.RealOutput CoolingPowerCooler[size(
    heaterCooler, 1)](
   final quantity="HeatFlowRate",
   final unit="W") "Power for cooling" annotation (Placement(
        transformation(extent={{94,-76},{114,-56}}), iconTransformation(extent={{100,-70},
            {114,-56}})));
  BaseClasses.Split splitterVolumeFlowVentilation(nout=buildingParam.numZones,
      coefficients=AixLib.Building.LowOrder.BaseClasses.ZoneFactorsZero(
        buildingParam.numZones, zoneParam))
    "splits the volume flow rate from the AHU into parts for each zone (weighted with VAir/VAirTot)"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={48,24})));
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(nout=
        buildingParam.numZones)
    "replicates scalar temperature of AHU into a vector[numZones] of identical temperatures"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={23,39})));
  Modelica.Blocks.Math.Gain conversion(k=3600/buildingParam.Vair)
    "converts m3/s into 1/h" annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={48,10})));
equation
  AirHandlingUnit.phi_extractAir = hold(AirHandlingUnit.phi_sup);
  for i in 1:buildingParam.numZones loop
    connect(internalGains[(i*3)-2], airFlowRate.relOccupation[i]) annotation (Line(
      points={{76,-100},{74,-100},{74,-22},{-76,-22},{-76,10.8},{-72,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
  end for;
  connect(AHU[1], replicatorTemperatureVentilation.u) annotation (Line(
      points={{-100,-1},{-100,-8},{23,-8},{23,33}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput, zone.internalGainsConv) annotation (Line(
      points={{30,-16},{60,-16},{60,37}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TAirAHUAvg.port, splitterThermPercentAir.signalInput) annotation (
      Line(
      points={{16,-16},{22,-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(AirHandlingUnit.T_outdoorAir, weather[1]) annotation (Line(
      points={{-49.44,9.44444},{-56,9.44444},{-56,115}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weather[2], AirHandlingUnit.X_outdoorAir) annotation (Line(
      points={{-56,105},{-56,5.55556},{-49.44,5.55556}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TAirAHUAvg.T, AirHandlingUnit.T_extractAir) annotation (Line(
      points={{8,-16},{4,-16},{4,-4},{22,-4},{22,25.7778},{15.92,25.7778}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[1], AirHandlingUnit.T_supplyAir) annotation (Line(
      points={{-100,-1},{-100,-2},{20,-2},{20,11},{15.92,11}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airFlowRate.airFlowRateOutput, AirHandlingUnit.Vflow_in) annotation (
      Line(
      points={{-60,14},{-58,14},{-58,11.7778},{-52.48,11.7778}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[4], airFlowRate.profile) annotation (Line(
      points={{-100,-31},{-100,18},{-72,18},{-72,17.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[2], AirHandlingUnit.phi_supplyAir[1]) annotation (Line(
      points={{-100,-11},{-100,-2},{18,-2},{18,6},{15.92,6},{15.92,7.88889}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[3], AirHandlingUnit.phi_supplyAir[2]) annotation (Line(
      points={{-100,-21},{-100,-2},{18,-2},{18,6},{15.92,6},{15.92,6.33333}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSetCooler, heaterCooler.setPointCool) annotation (Line(points={{-48,-100},
          {-48,-66},{-22.12,-66},{-22.12,-50.36}}, color={0,0,127}));
  connect(TSetHeater, heaterCooler.setPointHeat) annotation (Line(points={{-20,-100},
          {-22,-100},{-22,-68},{-16.14,-68},{-16.14,-50.36}}, color={0,0,127}));
  connect(heaterCooler.heatCoolRoom, zone.internalGainsConv) annotation (Line(
        points={{-7.3,-46.2},{60,-46.2},{60,37}}, color={191,0,0}));
  connect(AirHandlingUnit.Pel, Pel) annotation (Line(points={{7.94,2.05556},{8,
          2.05556},{8,2},{56,2},{80,2},{80,16},{104,16}},
                                                 color={0,0,127}));
  connect(AirHandlingUnit.QflowH, HeatingPowerAHU) annotation (Line(points={{-0.42,
          2.05556},{-0.42,-6},{80,-6},{80,-4},{104,-4}}, color={0,0,127}));
  connect(AirHandlingUnit.QflowC, CoolingPowerAHU) annotation (Line(points={{-17.14,
          2.05556},{-17.14,-20},{80,-20},{80,-22},{104,-22}}, color={0,0,127}));
  connect(heaterCooler.HeatingPower, HeatingPowerHeater) annotation (Line(
        points={{-6,-35.8},{38,-35.8},{38,-42},{100,-42}}, color={0,0,127}));
  connect(heaterCooler.CoolingPower, CoolingPowerCooler) annotation (Line(
        points={{-6,-41.78},{12,-41.78},{12,-42},{36,-42},{36,-66},{104,-66}},
        color={0,0,127}));
  connect(splitterVolumeFlowVentilation.y, zone.ventilationRate) annotation (
      Line(
      points={{48,30.6},{48,37.4},{52,37.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(replicatorTemperatureVentilation.y, zone.ventilationTemperature)
    annotation (Line(points={{23,44.5},{23,47.2},{45,47.2}}, color={0,0,127}));
  connect(conversion.y, splitterVolumeFlowVentilation.u)
    annotation (Line(points={{48,14.4},{48,14.4},{48,16.8}}, color={0,0,127}));
  connect(conversion.u, AirHandlingUnit.Vflow_out) annotation (Line(points={{48,5.2},
          {48,4},{28,4},{28,28},{-60,28},{-60,21.8889},{-52.48,21.8889}},
        color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics={
        Rectangle(
          extent={{-66,30},{32,-24}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={212,221,253}),
        Rectangle(
          extent={{-66,-26},{32,-70}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,-8},{-20,-22}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Text(
          extent={{-60,-50},{-32,-60}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Heating
Cooling")}),
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
