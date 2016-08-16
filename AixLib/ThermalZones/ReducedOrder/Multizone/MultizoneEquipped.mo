within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneEquipped
  "Multizone model with ideal heater and cooler and AHU"
  extends
    AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;

  parameter Boolean heatAHU "Status of heating of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean coolAHU "Status of cooling of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean dehuAHU=if heatAHU and coolAHU then true
       else false
    "Status of dehumidification of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"), enable=(heating and cooling));
  parameter Boolean huAHU=if heatAHU and coolAHU then true
       else false
    "Status of humidification of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"), enable=(heating and cooling));
  parameter Real BPFDehuAHU(
    min=0,
    max=1)
    "By-pass factor of cooling coil during dehumidification"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value"));
  parameter Boolean HRS=true
    "Status of Heat Recovery System of AHU"
    annotation (
      Dialog(tab="AirHandlingUnit", group="AHU Modes"), choices(checkBox=true));
  parameter Real effHRSAHU_enabled(
    min=0,
    max=1) "Efficiency of HRS when enabled"
    annotation (Dialog(
      tab="AirHandlingUnit",
      group="Settings AHU Value",
      enable=HRS));
  parameter Real effHRSAHU_disabled(
    min=0,
    max=1)
    "Efficiency of HRS when disabled"
    annotation (Dialog(
      tab="AirHandlingUnit",
      group="Settings AHU Value",
      enable=HRS));
  parameter Modelica.SIunits.Time sampleRateAHU(min=0) = 1800
    "Time period for sampling"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings for State Machines"));
  parameter Modelica.SIunits.Pressure dpAHU_sup
    "Pressure difference over supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Pressure dpAHU_eta
    "Pressure difference over extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Efficiency effFanAHU_sup
    "Efficiency of supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Efficiency effFanAHU_eta
    "Efficiency of extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAirAHUAvg if ASurTot > 0 or VAir > 0
    "Averaged air temperature of the zones which are supplied by the AHU" annotation (Placement(transformation(extent={{46,-32},
            {38,-24}})));
  RC.BaseClasses.ThermSplitter splitterThermPercentAir(
    splitFactor=zoneFactor,
    nOut=1,
    nIn=numZones) if ASurTot > 0 or VAir > 0
    "Collector of indoor air temperatures of all zones"
                                             annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={54,-28})));
  Modelica.Blocks.Interfaces.RealInput AHU[4]
    "Input for AHU Conditions [1]: Desired Air Temperature in K [2]: Desired minimal relative humidity [3]: Desired maximal relative humidity [4]: Schedule Desired Ventilation Flow"
    annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-100,-16}), iconTransformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-99,1})));
  Utilities.Sources.HeaterCooler.HeaterCoolerPI heaterCooler[numZones](
    zoneParam=zoneParam,
    each recOrSep=true,
    each staOrDyn=true) if ASurTot > 0 or VAir > 0 "Heater Cooler with PI control"
    annotation (Placement(transformation(extent={{-48,-70},{-22,-44}})));
  Modelica.Blocks.Interfaces.RealInput TSetHeater[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for heater"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-46,-100}), iconTransformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={-56,-98})));
  replaceable AixLib.Airflow.AirHandlingUnit.AHU AirHandlingUnit if ASurTot > 0 or VAir > 0  constrainedby
    AixLib.Airflow.AirHandlingUnit.BaseClasses.PartialAHU(
    cooling=coolAHU,
    dehumidificationSet=dehuAHU,
    humidificationSet=huAHU,
    BPF_DeHu=BPFDehuAHU,
    heating=heatAHU,
    efficiencyHRS_enabled=effHRSAHU_enabled,
    efficiencyHRS_disabled=effHRSAHU_disabled,
    HRS=HRS,
    clockPeriodGeneric=sampleRateAHU,
    dp_sup=dpAHU_sup,
    dp_eta=dpAHU_eta,
    eta_sup=effFanAHU_sup,
    eta_eta=effFanAHU_eta) "Air Handling Unit"        annotation (
     Placement(transformation(extent={{-52,10},{18,40}})), choices(choice(
          redeclare AixLib.Airflow.AirHandlingUnit.AHU AirHandlingUnit
          "with AHU"), choice(redeclare AixLib.Airflow.AirHandlingUnit.NoAHU
          AirHandlingUnit "AHU does not exist")),Dialog(
      tab="AirHandlingUnit"));

  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSum airFlowRate(
    dimension=numZones,
    withProfile=true,
    zoneParam=zoneParam) "Pre-processor for AHU inputs"
    annotation (Placement(transformation(extent={{-72,22},{-60,34}})));
  Modelica.Blocks.Interfaces.RealInput TSetCooler[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for cooler"
                           annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-86,-100}), iconTransformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={-38,-98})));
  Modelica.Blocks.Interfaces.RealOutput Pel(
   final quantity="Power",
   final unit="W") if ASurTot > 0 or VAir > 0 "Electrical power of AHU"
                                                            annotation (
      Placement(transformation(extent={{94,0},{114,20}}), iconTransformation(
          extent={{100,6},{114,20}})));
  Modelica.Blocks.Interfaces.RealOutput PHeatAHU(final quantity="HeatFlowRate",
      final unit="W") if ASurTot > 0 or VAir > 0
    "Thermal power of AHU for heating"                           annotation (
      Placement(transformation(extent={{94,-20},{114,0}}), iconTransformation(
          extent={{100,-14},{114,0}})));
  Modelica.Blocks.Interfaces.RealOutput PCoolAHU(final quantity="HeatFlowRate",
      final unit="W") if ASurTot > 0 or VAir > 0
    "Thermal power of AHU for cooling"                           annotation (
      Placement(transformation(extent={{94,-40},{114,-20}}), iconTransformation(
          extent={{100,-34},{114,-20}})));
  Modelica.Blocks.Interfaces.RealOutput PHeater[size(heaterCooler, 1)](final
      quantity="HeatFlowRate", final unit="W") if ASurTot > 0 or VAir > 0 "Power for heating" annotation (
      Placement(transformation(extent={{100,-54},{120,-34}}),
        iconTransformation(extent={{100,-52},{114,-38}})));
  Modelica.Blocks.Interfaces.RealOutput PCooler[size(heaterCooler, 1)](final
      quantity="HeatFlowRate", final unit="W") if ASurTot > 0 or VAir > 0 "Power for cooling" annotation (
      Placement(transformation(extent={{94,-76},{114,-56}}), iconTransformation(
          extent={{100,-70},{114,-56}})));
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(nout=
        numZones) if ASurTot > 0 or VAir > 0
    "replicates scalar temperature of AHU into a vector[numZones] of identical temperatures"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={23,53})));
  Modelica.Blocks.Nonlinear.Limiter minTemp(uMax=1000, uMin=1) if ASurTot > 0 or VAir > 0
    "Temperature limiter for measured indoor air temperature for AHU"
    annotation (Placement(transformation(extent={{34,-33},{24,-23}})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSplit airFlowRateSplit(
    dimension=numZones,
    withProfile=true,
    zoneParam=zoneParam) if ASurTot > 0 or VAir > 0
    "Post-processor for AHU outputs"                annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={44,28})));
protected
  parameter Real zoneFactor[numZones,1](fixed=false) "Calculated zone factors";
  parameter Real VAirRes(fixed=false) "Resulting air volume in zones supplied by the AHU";

public
  BaseClasses.RelToAbsHum relToAbsHum
    "Converter from relative humidity to absolute humidity"
    annotation (Placement(transformation(extent={{-72,4},{-62,14}})));
initial algorithm
  for i in 1:numZones loop
    if zoneParam.withAHU[i] then
      VAirRes :=VAirRes + zoneParam.VAir[i];
    end if;
  end for;
  for i in 1:numZones loop
    if zoneParam.withAHU[i] then
      zoneFactor[i,1] :=zoneParam.VAir[i]/VAirRes;
    else
      zoneFactor[i,1] :=0;
    end if;
  end for;

equation
  for i in 1:numZones loop
    connect(intGains[(i*3) - 2], airFlowRate.relOccupation[i]) annotation (Line(
        points={{76,-100},{74,-100},{74,-42},{-78,-42},{-78,26},{-72,26},{-72,
            25.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 2], airFlowRateSplit.relOccupation[i]) annotation (
       Line(points={{76,-100},{74,-100},{74,0},{47.24,0},{47.24,22}},color={0,0,
            127}));
  end for;

  connect(AHU[1], AirHandlingUnit.T_supplyAir) annotation (Line(
      points={{-100,-31},{-100,-14},{-86,-14},{-86,2},{24,2},{24,19.75},{12.4,
          19.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airFlowRate.airFlow, AirHandlingUnit.Vflow_in) annotation (Line(
      points={{-60,28},{-58,28},{-58,21.25},{-50.6,21.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[4], airFlowRate.profile) annotation (Line(
      points={{-100,-1},{-100,-16},{-86,-16},{-86,30},{-72,30},{-72,30.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[2], AirHandlingUnit.phi_supplyAir[1]) annotation (Line(
      points={{-100,-21},{-100,-16},{-86,-16},{-86,2},{24,2},{24,16},{12.4,16},
          {12.4,16.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[3], AirHandlingUnit.phi_supplyAir[2]) annotation (Line(
      points={{-100,-11},{-100,-16},{-86,-16},{-86,2},{24,2},{24,16},{12.4,16},
          {12.4,15.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSetCooler, heaterCooler.setPointCool) annotation (Line(points={{-86,
          -100},{-86,-72},{-48,-72},{-38.12,-72},{-38.12,-66.36}},
                                                   color={0,0,127}));
  connect(TSetHeater, heaterCooler.setPointHeat) annotation (Line(points={{-46,
          -100},{-46,-100},{-46,-74},{-32.14,-74},{-32.14,-66.36}},
                                                              color={0,0,127}));
  connect(AirHandlingUnit.Pel, Pel) annotation (Line(points={{0.15,11.875},{
          0.15,-4.125},{56,-4.125},{92,-4.125},{92,10},{104,10}},
                                                 color={0,0,127}));
  connect(AirHandlingUnit.QflowH, PHeatAHU) annotation (Line(points={{-6.85,
          11.875},{-6.85,-10},{-6,-10},{93,-10},{104,-10}},           color={0,0,
          127}));
  connect(AirHandlingUnit.QflowC, PCoolAHU) annotation (Line(points={{-20.85,
          11.875},{-20.85,-38},{-18,-38},{92,-38},{92,-30},{104,-30}},   color={
          0,0,127}));
  connect(heaterCooler.heatingPower, PHeater) annotation (Line(points={{-22,
          -51.8},{38,-51.8},{92,-51.8},{92,-50},{92,-44},{110,-44}},
                                                              color={0,0,127}));
  connect(heaterCooler.coolingPower, PCooler) annotation (Line(points={{-22,
          -57.78},{12,-57.78},{12,-58},{92,-58},{92,-66},{104,-66}},
                                                             color={0,0,127}));
  connect(replicatorTemperatureVentilation.y, zone.ventTemp)
    annotation (Line(points={{23,58.5},{23,61.505},{43.25,61.505}},
                                                             color={0,0,127}));
  connect(AirHandlingUnit.phi_supply, AirHandlingUnit.phi_extractAir)
    annotation (Line(points={{12.4,12.25},{20,12.25},{20,31.75},{12.4,31.75}},
        color={0,0,127}));
  connect(TAirAHUAvg.T, minTemp.u)
    annotation (Line(points={{38,-28},{38,-28},{35,-28}},
                                               color={0,0,127}));
  connect(minTemp.y, AirHandlingUnit.T_extractAir) annotation (Line(points={{23.5,
          -28},{20,-28},{20,-16},{26,-16},{26,35.5},{12.4,35.5}},
        color={0,0,127}));
  connect(zone.ventRate, airFlowRateSplit.airFlowOut) annotation (Line(points={
          {50.6,57.2},{50,57.2},{50,38},{43.52,38},{43.52,34}}, color={0,0,127}));
  connect(AHU[4], airFlowRateSplit.profile) annotation (Line(points={{-100,-1},
          {-100,-1},{-100,-18},{-86,-18},{-86,2},{40,2},{40,10},{40.4,10},{40.4,
          22}},                                                         color={0,
          0,127}));
  connect(AirHandlingUnit.T_supplyAirOut, replicatorTemperatureVentilation.u)
    annotation (Line(points={{12.4,23.5},{23,23.5},{23,47}},
                                                         color={0,0,127}));
  connect(heaterCooler.heatCoolRoom, zone.intGainsConv) annotation (Line(points={{-23.3,
          -62.2},{86,-62.2},{86,62.94},{80,62.94}},        color={191,0,0}));
  connect(AirHandlingUnit.T_outdoorAir, weaBus.TDryBul) annotation (Line(points={{-47.8,
          19},{-100,19},{-100,69}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(splitterThermPercentAir.portIn[1], TAirAHUAvg.port)
    annotation (Line(points={{50,-28},{46,-28}},          color={191,0,0}));
  connect(splitterThermPercentAir.portOut, zone.intGainsConv) annotation (Line(
        points={{58,-28},{86,-28},{86,62.94},{80,62.94}}, color={191,0,0}));
  connect(relToAbsHum.relHum, weaBus.relHum) annotation (Line(points={{-73,11.6},
          {-100,11.6},{-100,69}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(relToAbsHum.TDryBul, weaBus.TDryBul) annotation (Line(points={{-73,
          6.2},{-100,6.2},{-100,69}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(relToAbsHum.absHum, AirHandlingUnit.X_outdoorAir) annotation (Line(
        points={{-61,9},{-56,9},{-56,15.25},{-47.8,15.25}}, color={0,0,127}));
  connect(airFlowRateSplit.airFlowIn, AirHandlingUnit.Vflow_out) annotation (
      Line(points={{44,22},{44,12},{28,12},{28,44},{-56,44},{-56,31},{-50.6,31}},
        color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics={
        Rectangle(
          extent={{-80,-46},{-2,-70}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-62,-12},{-20,-26}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Text(
          extent={{-80,-50},{-56,-56}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Heating
Cooling"),
  Polygon(
    points={{60,-44},{-80,-44},{-80,66},{32,66},{32,42},{60,42},{60,-44}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,58},{-20,52}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="AHU")}),
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
