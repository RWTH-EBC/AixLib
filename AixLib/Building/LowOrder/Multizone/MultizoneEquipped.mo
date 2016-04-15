within AixLib.Building.LowOrder.Multizone;
model MultizoneEquipped
  "Multizone with basic heat supply system, air handling unit, an arbitrary number of thermal zones (vectorized), and ventilation"
  extends AixLib.Building.LowOrder.Multizone.PartialMultizone;
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAirAHUAvg
    "Averaged air temperature of the zones which are supplied by the AHU" annotation (Placement(transformation(extent={{16,-28},
            {8,-20}})));
  BaseClasses.ThermSplitter splitterThermPercentAir(dimension=buildingParam.numZones,
      splitFactor=AixLib.Building.LowOrder.BaseClasses.ZoneFactorsZero(buildingParam.numZones, zoneParam)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={26,-24})));
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
    annotation (Placement(transformation(extent={{-32,-66},{-6,-40}})));
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
  replaceable AixLib.Airflow.AirHandlingUnit.AHU AirHandlingUnit constrainedby
    AixLib.Airflow.AirHandlingUnit.BaseClasses.partialAHU(
    BPF_DeHu=buildingParam.BPF_DeHu,
    HRS=buildingParam.HRS,
    efficiencyHRS_enabled=buildingParam.efficiencyHRS_enabled,
    efficiencyHRS_disabled=buildingParam.efficiencyHRS_disabled,
    heating=buildingParam.heatingAHU,
    cooling=buildingParam.coolingAHU,
    dehumidificationSet=buildingParam.dehumidificationAHU,
    humidificationSet=buildingParam.humidificationAHU,
    clockPeriodGeneric=buildingParam.sampleRateAHU,
    dp_sup=buildingParam.dpAHU_sup,
    dp_eta=buildingParam.dpAHU_eta,
    eta_sup=buildingParam.effFanAHU_sup,
    eta_eta=buildingParam.effFanAHU_eta) "Choose Air Handling Unit" annotation (
     Placement(transformation(extent={{-52,-6},{18,24}})), choices(choice(
          redeclare AixLib.Airflow.AirHandlingUnit.AHU AirHandlingUnit
          "with AHU"), choice(redeclare AixLib.Airflow.AirHandlingUnit.NoAHU
          AirHandlingUnit "AHU does not exist")));

  BaseClasses.AirFlowRateSum airFlowRate(
    zoneParam=zoneParam,
    dimension=buildingParam.numZones,
    withProfile=true)
    annotation (Placement(transformation(extent={{-72,6},{-60,22}})));
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
        transformation(extent={{90,-54},{110,-34}}), iconTransformation(extent={{100,-52},
            {114,-38}})));
  Modelica.Blocks.Interfaces.RealOutput CoolingPowerCooler[size(
    heaterCooler, 1)](
   final quantity="HeatFlowRate",
   final unit="W") "Power for cooling" annotation (Placement(
        transformation(extent={{94,-76},{114,-56}}), iconTransformation(extent={{100,-70},
            {114,-56}})));
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(nout=
        buildingParam.numZones)
    "replicates scalar temperature of AHU into a vector[numZones] of identical temperatures"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={23,39})));
  Modelica.Blocks.Nonlinear.Limiter minTemp(uMax=1000, uMin=1)
    annotation (Placement(transformation(extent={{0,-29},{-10,-19}})));
  BaseClasses.AirFlowRateSplit airFlowRateSplit(
    dimension=buildingParam.numZones,
    withProfile=true,
    zoneParam=zoneParam) annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={45,14})));
equation
  for i in 1:buildingParam.numZones loop
    connect(internalGains[(i*3)-2], airFlowRate.relOccupation[i]) annotation (Line(
      points={{76,-100},{74,-100},{74,-36},{-76,-36},{-76,10.8},{-72,10.8}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)-2], airFlowRateSplit.relOccupation[i]) annotation (Line(
        points={{76,-100},{74,-100},{74,0},{49.32,0},{49.32,7}}, color={0,0,127}));
  end for;

  connect(AirHandlingUnit.T_outdoorAir, weather[1]) annotation (Line(
      points={{-47.8,3},{-56,3},{-56,115}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput, zone.internalGainsConv) annotation (Line(
      points={{30,-24},{60,-24},{60,43.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TAirAHUAvg.port, splitterThermPercentAir.signalInput) annotation (
      Line(
      points={{16,-24},{18,-24},{18,-26},{20,-26},{20,-24},{22,-24}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(weather[2], AirHandlingUnit.X_outdoorAir) annotation (Line(
      points={{-56,105},{-56,-0.75},{-47.8,-0.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[1], AirHandlingUnit.T_supplyAir) annotation (Line(
      points={{-100,-1},{-100,-8},{22,-8},{22,3.75},{12.4,3.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airFlowRate.airFlowRateOutput, AirHandlingUnit.Vflow_in) annotation (
      Line(
      points={{-60,14},{-58,14},{-58,5.25},{-50.6,5.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[4], airFlowRate.profile) annotation (Line(
      points={{-100,-31},{-100,18},{-72,18},{-72,17.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[2], AirHandlingUnit.phi_supplyAir[1]) annotation (Line(
      points={{-100,-11},{-100,-2},{18,-2},{18,0},{12.4,0},{12.4,0.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[3], AirHandlingUnit.phi_supplyAir[2]) annotation (Line(
      points={{-100,-21},{-100,-12},{16,-12},{16,0},{16,0},{12,0},{12.4,0},{
          12.4,-0.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSetCooler, heaterCooler.setPointCool) annotation (Line(points={{-48,
          -100},{-48,-66},{-22.12,-66},{-22.12,-62.36}},
                                                   color={0,0,127}));
  connect(TSetHeater, heaterCooler.setPointHeat) annotation (Line(points={{-20,
          -100},{-22,-100},{-22,-68},{-16.14,-68},{-16.14,-62.36}},
                                                              color={0,0,127}));
  connect(heaterCooler.heatCoolRoom, zone.internalGainsConv) annotation (Line(
        points={{-7.3,-58.2},{26,-58.2},{26,-52},{60,-52},{60,43.4}},
                                                  color={191,0,0}));
  connect(AirHandlingUnit.Pel, Pel) annotation (Line(points={{0.15,-4.125},{
          0.15,-6.125},{56,-6.125},{80,-6.125},{80,16},{104,16}},
                                                 color={0,0,127}));
  connect(AirHandlingUnit.QflowH, HeatingPowerAHU) annotation (Line(points={{-6.85,
          -4.125},{-6.85,-10},{-6,-10},{-6,-16},{82,-16},{82,-4},{104,-4}},
                                                         color={0,0,127}));
  connect(AirHandlingUnit.QflowC, CoolingPowerAHU) annotation (Line(points={{-20.85,
          -4.125},{-20.85,-14},{-17,-14},{-17,-32},{83,-32},{83,-22},{104,-22}},
                                                              color={0,0,127}));
  connect(heaterCooler.HeatingPower, HeatingPowerHeater) annotation (Line(
        points={{-6,-47.8},{38,-47.8},{38,-44},{100,-44}}, color={0,0,127}));
  connect(heaterCooler.CoolingPower, CoolingPowerCooler) annotation (Line(
        points={{-6,-53.78},{12,-53.78},{12,-54},{36,-54},{36,-66},{104,-66}},
        color={0,0,127}));
  connect(replicatorTemperatureVentilation.y, zone.ventilationTemperature)
    annotation (Line(points={{23,44.5},{23,47.2},{45,47.2}}, color={0,0,127}));
  connect(AirHandlingUnit.phi_supply, AirHandlingUnit.phi_extractAir)
    annotation (Line(points={{12.4,-3.75},{20,-3.75},{20,15.75},{12.4,15.75}},
        color={0,0,127}));
  connect(TAirAHUAvg.T, minTemp.u)
    annotation (Line(points={{8,-24},{1,-24}}, color={0,0,127}));
  connect(minTemp.y, AirHandlingUnit.T_extractAir) annotation (Line(points={{-10.5,
          -24},{-14,-24},{-14,-14},{26,-14},{26,19.5},{12.4,19.5}},
        color={0,0,127}));
  connect(zone.ventilationRate, airFlowRateSplit.airFlowSplit) annotation (Line(
        points={{52,43},{52,43},{52,28},{44.36,28},{44.36,21}}, color={0,0,127}));
  connect(AHU[4], airFlowRateSplit.profile) annotation (Line(points={{-100,-31},
          {-90,-31},{-90,-16},{-64,-16},{-64,-10},{40.2,-10},{40.2,7}}, color={0,
          0,127}));
  connect(AirHandlingUnit.Vflow_out, airFlowRateSplit.airFlow) annotation (Line(
        points={{-50.6,15},{-60,15},{-60,28},{36,28},{36,2},{45,2},{45,7}},
        color={0,0,127}));
  connect(AirHandlingUnit.T_supplyAirOut, replicatorTemperatureVentilation.u)
    annotation (Line(points={{12.4,7.5},{23,7.5},{23,33}},
                                                         color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics={
        Rectangle(
          extent={{-66,28},{32,-42}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={212,221,253}),
        Rectangle(
          extent={{-66,-42},{32,-70}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,-12},{-20,-26}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Text(
          extent={{-64,-48},{-36,-58}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Heating
Cooling")}),
    Documentation(revisions="<html>
<ul>
<li><i>February 26, 2016&nbsp;</i> by Moritz Lauster:<br/>Fixed bug in share of AHU volume flow</li>
<li><i>June 22, 2015&nbsp;</i> by Moritz Lauster:<br/>Changed building physics to AixLib</li>
<li><i>April 25, 2014&nbsp;</i> by Ole Odendahl:<br/>Implemented</li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is a multizone model with a variable number of thermal zones. It adds heater/cooler devices and an air handling unit. Outputs are the thermal demands of the zone heating as well as thermal and electrical demand of the air handling unit. This model is pre-configured and ready-to-use. The<a href=\"AixLib.Building.LowOrder.Multizone.partialMultizone\"> partial class</a> has a replaceable<a href=\"AixLib.Building.LowOrder.ThermalZone\"> thermal zone</a> model, due to the functionalities, <a href=\"AixLib.Building.LowOrder.ThermalZone.ThermalZoneEquipped\">ThermalZoneEquipped</a> is the most suitable recommendation.</span></p>
</html>"));
end MultizoneEquipped;
