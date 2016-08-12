within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneEquipped
  "Multizone model with ideal heater and cooler and AHU"
  extends AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;

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
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAirAHUAvg
    "Averaged air temperature of the zones which are supplied by the AHU" annotation (Placement(transformation(extent={{46,-36},
            {38,-28}})));
  RC.BaseClasses.ThermSplitter splitterThermPercentAir(
    splitFactor=
        AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.ZoneFactorsZero(numZones,
        zoneParam.withAHU,zoneParam.VAir),
    nOut=1,
    nIn=numZones)   annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={54,-32})));
  Modelica.Blocks.Interfaces.RealInput AHU[4]
    "Input for AHU Conditions [1]: Desired Air Temperature in K [2]: Desired minimal relative humidity [3]: Desired maximal relative humidity [4]: Schedule Desired Ventilation Flow"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-100,-16}), iconTransformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-99,1})));
  Utilities.Sources.HeaterCooler.HeaterCoolerPI heaterCooler[numZones](
    zoneParam=zoneParam,
    each recOrSep=true,
    each staOrDyn=true) "Heater Cooler with PI control"
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
  replaceable AixLib.Airflow.AirHandlingUnit.AHU AirHandlingUnit   constrainedby
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
    eta_eta=effFanAHU_eta) "Choose Air Handling Unit" annotation (
     Placement(transformation(extent={{-52,-6},{18,24}})), choices(choice(
          redeclare AixLib.Airflow.AirHandlingUnit.AHU AirHandlingUnit
          "with AHU"), choice(redeclare AixLib.Airflow.AirHandlingUnit.NoAHU
          AirHandlingUnit "AHU does not exist")),Dialog(
      tab="AirHandlingUnit"));

  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSum airFlowRate(
    zoneParam=zoneParam,
    dimension=numZones,
    withProfile=true)
    annotation (Placement(transformation(extent={{-72,2},{-60,18}})));
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
   final unit="W") "The consumed electrical power supplied from the mains"
                                                            annotation (
      Placement(transformation(extent={{94,0},{114,20}}), iconTransformation(
          extent={{100,6},{114,20}})));
  Modelica.Blocks.Interfaces.RealOutput PHeatAHU(final quantity="HeatFlowRate",
      final unit="W")
    "The absorbed heating power supplied from a heating circuit" annotation (
      Placement(transformation(extent={{94,-20},{114,0}}), iconTransformation(
          extent={{100,-14},{114,0}})));
  Modelica.Blocks.Interfaces.RealOutput PCoolAHU(final quantity="HeatFlowRate",
      final unit="W")
    "The absorbed cooling power supplied from a cooling circuit" annotation (
      Placement(transformation(extent={{94,-40},{114,-20}}), iconTransformation(
          extent={{100,-34},{114,-20}})));
  Modelica.Blocks.Interfaces.RealOutput PHeater[size(heaterCooler, 1)](final
      quantity="HeatFlowRate", final unit="W") "Power for heating" annotation (
      Placement(transformation(extent={{100,-54},{120,-34}}),
        iconTransformation(extent={{100,-52},{114,-38}})));
  Modelica.Blocks.Interfaces.RealOutput PCooler[size(heaterCooler, 1)](final
      quantity="HeatFlowRate", final unit="W") "Power for cooling" annotation (
      Placement(transformation(extent={{94,-76},{114,-56}}), iconTransformation(
          extent={{100,-70},{114,-56}})));
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(nout=
        numZones)
    "replicates scalar temperature of AHU into a vector[numZones] of identical temperatures"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={23,39})));
  Modelica.Blocks.Nonlinear.Limiter minTemp(uMax=1000, uMin=1)
    annotation (Placement(transformation(extent={{34,-37},{24,-27}})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSplit airFlowRateSplit(
    dimension=numZones,
    withProfile=true,
    zoneParam=zoneParam) annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={45,14})));
equation
  for i in 1:numZones loop
    connect(intGains[(i*3) - 2], airFlowRate.relOccupation[i]) annotation (Line(
        points={{76,-100},{74,-100},{74,-42},{-76,-42},{-76,6.8},{-72,6.8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 2], airFlowRateSplit.relOccupation[i]) annotation (
       Line(points={{76,-100},{74,-100},{74,0},{49.32,0},{49.32,7}}, color={0,0,
            127}));
  end for;

  connect(AHU[1], AirHandlingUnit.T_supplyAir) annotation (Line(
      points={{-100,-1},{-100,-12},{24,-12},{24,4},{18,4},{18,3.75},{12.4,3.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airFlowRate.airFlowRateOutput, AirHandlingUnit.Vflow_in) annotation (
      Line(
      points={{-60,10},{-58,10},{-58,5.25},{-50.6,5.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[4], airFlowRate.profile) annotation (Line(
      points={{-100,-31},{-100,18},{-72,18},{-72,13.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[2], AirHandlingUnit.phi_supplyAir[1]) annotation (Line(
      points={{-100,-11},{-100,-18},{22,-18},{22,0},{12.4,0},{12.4,0.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[3], AirHandlingUnit.phi_supplyAir[2]) annotation (Line(
      points={{-100,-21},{-100,-18},{22,-18},{22,0},{12.4,0},{12.4,-0.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSetCooler, heaterCooler.setPointCool) annotation (Line(points={{-86,
          -100},{-86,-72},{-48,-72},{-38.12,-72},{-38.12,-66.36}},
                                                   color={0,0,127}));
  connect(TSetHeater, heaterCooler.setPointHeat) annotation (Line(points={{-46,
          -100},{-46,-100},{-46,-74},{-32.14,-74},{-32.14,-66.36}},
                                                              color={0,0,127}));
  connect(AirHandlingUnit.Pel, Pel) annotation (Line(points={{0.15,-4.125},{
          0.15,-14.125},{56,-14.125},{92,-14.125},{92,10},{104,10}},
                                                 color={0,0,127}));
  connect(AirHandlingUnit.QflowH, PHeatAHU) annotation (Line(points={{-6.85,-4.125},
          {-6.85,-16},{-6,-16},{93,-16},{93,-10},{104,-10}},          color={0,0,
          127}));
  connect(AirHandlingUnit.QflowC, PCoolAHU) annotation (Line(points={{-20.85,
          -4.125},{-20.85,-40},{-18,-40},{92,-40},{92,-30},{104,-30}},   color={
          0,0,127}));
  connect(heaterCooler.heatingPower, PHeater) annotation (Line(points={{-22,
          -51.8},{38,-51.8},{92,-51.8},{92,-50},{92,-44},{110,-44}},
                                                              color={0,0,127}));
  connect(heaterCooler.coolingPower, PCooler) annotation (Line(points={{-22,
          -57.78},{12,-57.78},{12,-58},{92,-58},{92,-66},{104,-66}},
                                                             color={0,0,127}));
  connect(replicatorTemperatureVentilation.y, zone.ventTemp)
    annotation (Line(points={{23,44.5},{23,47.505},{43.25,47.505}},
                                                             color={0,0,127}));
  connect(AirHandlingUnit.phi_supply, AirHandlingUnit.phi_extractAir)
    annotation (Line(points={{12.4,-3.75},{20,-3.75},{20,15.75},{12.4,15.75}},
        color={0,0,127}));
  connect(TAirAHUAvg.T, minTemp.u)
    annotation (Line(points={{38,-32},{38,-32},{35,-32}},
                                               color={0,0,127}));
  connect(minTemp.y, AirHandlingUnit.T_extractAir) annotation (Line(points={{23.5,
          -32},{22,-32},{22,-20},{28,-20},{28,19.5},{12.4,19.5}},
        color={0,0,127}));
  connect(zone.ventRate, airFlowRateSplit.airFlowSplit) annotation (Line(
        points={{50.6,43.2},{50.6,43.2},{50.6,28},{44.36,28},{44.36,21}},
                                                                color={0,0,127}));
  connect(AHU[4], airFlowRateSplit.profile) annotation (Line(points={{-100,-31},
          {-100,-31},{-100,-20},{-60,-20},{-60,-22},{40.2,-22},{40.2,7}},
                                                                        color={0,
          0,127}));
  connect(AirHandlingUnit.Vflow_out, airFlowRateSplit.airFlow) annotation (Line(
        points={{-50.6,15},{-60,15},{-60,28},{36,28},{36,2},{45,2},{45,7}},
        color={0,0,127}));
  connect(AirHandlingUnit.T_supplyAirOut, replicatorTemperatureVentilation.u)
    annotation (Line(points={{12.4,7.5},{23,7.5},{23,33}},
                                                         color={0,0,127}));
  connect(AirHandlingUnit.X_outdoorAir, weaBus.relHum) annotation (Line(points={
          {-47.8,-0.75},{-100,-0.75},{-100,55}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heaterCooler.heatCoolRoom, zone.intGainsConv) annotation (Line(points={{-23.3,
          -62.2},{86,-62.2},{86,48.94},{80,48.94}},        color={191,0,0}));
  connect(AirHandlingUnit.T_outdoorAir, weaBus.TDryBul) annotation (Line(points=
         {{-47.8,3},{-100,3},{-100,55}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(splitterThermPercentAir.portIn[1], TAirAHUAvg.port)
    annotation (Line(points={{50,-32},{48,-32},{46,-32}}, color={191,0,0}));
  connect(splitterThermPercentAir.portOut, zone.intGainsConv) annotation (Line(
        points={{58,-32},{86,-32},{86,48.94},{80,48.94}}, color={191,0,0}));
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
    points={{60,-44},{-80,-44},{-80,52},{32,52},{32,30},{60,30},{60,-44}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,46},{-54,40}},
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
