within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneEquipped
  "Multizone model with ideal heater and cooler and AHU"
  extends AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;

  parameter Boolean heatAHU
    "Status of heating of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean coolAHU
    "Status of cooling of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean dehuAHU=if heatAHU and coolAHU then true
       else false
    "Status of dehumidification of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean huAHU=if heatAHU and coolAHU then true
       else false
    "Status of humidification of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
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
    max=1)
    "Efficiency of HRS when enabled"
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
  replaceable model AHUMod =
    AixLib.Airflow.AirHandlingUnit.AHU
    constrainedby AixLib.Airflow.AirHandlingUnit.BaseClasses.PartialAHU
    "Air handling unit model"
    annotation(Dialog(tab="AirHandlingUnit"),choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealInput AHU[4]
    "Input for AHU Conditions [1]: Desired Air Temperature in K [2]: Desired
    minimal relative humidity [3]: Desired maximal relative humidity [4]:
    Schedule Desired Ventilation Flow"
    annotation (Placement(transformation(
    extent={{20,20},{-20,-20}},
    rotation=180,
    origin={-100,-16}), iconTransformation(
    extent={{10,-10},{-10,10}},
    rotation=180,
    origin={-90,0})));
  Modelica.Blocks.Interfaces.RealOutput Pel(
    final quantity="Power",
    final unit="W") if ASurTot > 0 or VAir > 0
    "Electrical power of AHU"
    annotation (Placement(transformation(extent={{100,-14},{120,6}}),
    iconTransformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Interfaces.RealOutput PHeatAHU(final quantity="HeatFlowRate",
    final unit="W") if ASurTot > 0 or VAir > 0
    "Thermal power of AHU for heating"
    annotation (
    Placement(transformation(extent={{100,-28},{120,-8}}),
    iconTransformation(extent={{80,-40},{100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput PCoolAHU(final quantity="HeatFlowRate",
    final unit="W") if ASurTot > 0 or VAir > 0
    "Thermal power of AHU for cooling"
    annotation (
    Placement(transformation(extent={{100,-40},{120,-20}}),iconTransformation(
    extent={{80,-60},{100,-40}})));
  AHUMod AirHandlingUnit(
    final cooling=coolAHU,
    final dehumidificationSet=dehuAHU,
    final humidificationSet=huAHU,
    final BPF_DeHu=BPFDehuAHU,
    final heating=heatAHU,
    final efficiencyHRS_enabled=effHRSAHU_enabled,
    final efficiencyHRS_disabled=effHRSAHU_disabled,
    final HRS=HRS,
    final clockPeriodGeneric=sampleRateAHU,
    final dp_sup=dpAHU_sup,
    final dp_eta=dpAHU_eta,
    final eta_sup=effFanAHU_sup,
    final eta_eta=effFanAHU_eta) if
       ASurTot > 0 or VAir > 0
    "Air Handling Unit"
    annotation (
    Placement(transformation(extent={{-52,10},{18,40}})));

  Modelica.Blocks.Interfaces.RealOutput CO2Con[size(zone, 1)] if use_C_flow
    "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
protected
  parameter Real zoneFactor[numZones,1](fixed=false)
    "Calculated zone factors";
  parameter Real VAirRes(fixed=false)
    "Resulting air volume in zones supplied by the AHU";
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(
    final nout=numZones) if ASurTot > 0 or VAir > 0
    "Replicates scalar temperature of AHU into a vector[numZones] of identical
    temperatures"
    annotation (Placement(transformation(
    extent={{-5,-5},{5,5}},
    rotation=90,
    origin={23,53})));
  Modelica.Blocks.Nonlinear.Limiter minTemp(uMax=1000, uMin=1) if
       ASurTot > 0 or VAir > 0
    "Temperature limiter for measured indoor air temperature for AHU"
    annotation (Placement(transformation(extent={{30,-33},{20,-23}})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSplit airFlowRateSplit(
    final dimension=numZones,
    withProfile=true,
    final zoneParam=zoneParam) if ASurTot > 0 or VAir > 0
    "Post-processor for AHU outputs"
    annotation (Placement(transformation(
    extent={{-6,-6},{6,6}},
    rotation=90,
    origin={44,28})));
  BaseClasses.RelToAbsHum relToAbsHum
    "Converter from relative humidity to absolute humidity"
    annotation (Placement(transformation(extent={{-72,4},{-62,14}})));
  RC.BaseClasses.ThermSplitter splitterThermPercentAir(
    final splitFactor=zoneFactor,
    final nOut=numZones,
    final nIn=1) if        ASurTot > 0 or VAir > 0
    "Collector of indoor air temperatures of all zones"
    annotation (Placement(transformation(
    extent={{-4,-4},{4,4}},
    rotation=0,
    origin={50,-28})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAirAHUAvg if
       ASurTot > 0 or VAir > 0
    "Averaged air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{42,-32},{34,-24}})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSum airFlowRate(
    final dimension=numZones,
    withProfile=true,
    final zoneParam=zoneParam)
    "Pre-processor for AHU inputs"
    annotation (Placement(transformation(extent={{-72,22},{-60,34}})));

  BaseClasses.MoistSplitter moistSplitter(
    final nOut=1,
    final nIn=numZones,
    final splitFactor=zoneFactor) if (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Sums up a vector[numZones] of identical humidities to an average humidity"
    annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
  BaseClasses.AbsToRelHum absToRelHum if     (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Converter from absolute humidity to relative humidity"
    annotation (Placement(transformation(extent={{-36,76},{-26,86}})));
  BaseClasses.RelToAbsHum relToAbsHum1 if (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Converter from relative humidity to absolute humidity" annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={65,21})));
  Modelica.Blocks.Routing.Replicator replicatorHumidityVentilation(final nout=
        numZones) if (ASurTot > 0 or VAir > 0) and use_moisture_balance "Replicates scalar humidity of AHU into a vector[numZones] of identical
    humidities" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={65,37})));
  Modelica.Blocks.Interfaces.RealOutput X_w[numZones] if (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Absolute humidity in thermal zone"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{80,40},{100,60}})));

initial algorithm
  for i in 1:numZones loop
    if zoneParam[i].withAHU then
      VAirRes :=VAirRes + zoneParam[i].VAir;
    end if;
  end for;
  for i in 1:numZones loop
    if zoneParam[i].withAHU then
      if VAirRes > 0 then
        zoneFactor[i,1] :=zoneParam[i].VAir/VAirRes;
      else
        zoneFactor[i,1] :=0;
      end if;
    else
      zoneFactor[i,1] :=0;
    end if;
  end for;

equation
  for i in 1:numZones loop
    connect(intGains[(i*3) - 2], airFlowRate.relOccupation[i]) annotation (Line(
        points={{76,-100},{74,-100},{74,-42},{-78,-42},{-78,26},{-73.2,26},{
            -73.2,25.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 2], airFlowRateSplit.relOccupation[i]) annotation (
       Line(points={{76,-100},{74,-100},{74,0},{47.24,0},{47.24,20.8}},
                                                                     color={0,0,
            127}));

  end for;

  connect(AHU[1], AirHandlingUnit.T_supplyAir) annotation (Line(
      points={{-100,-31},{-100,-14},{-86,-14},{-86,2},{24,2},{24,19.75},{12.4,19.75}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(airFlowRate.airFlow, AirHandlingUnit.Vflow_in) annotation (Line(
      points={{-58.8,28},{-58,28},{-58,21.25},{-50.6,21.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[4], airFlowRate.profile) annotation (Line(
      points={{-100,-1},{-100,-16},{-86,-16},{-86,30},{-73.2,30},{-73.2,30.4}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(AHU[2], AirHandlingUnit.phi_supplyAir[1]) annotation (Line(
      points={{-100,-21},{-100,-16},{-86,-16},{-86,2},{24,2},{24,16},{12.4,16},{
          12.4,16.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AHU[3], AirHandlingUnit.phi_supplyAir[2]) annotation (Line(
      points={{-100,-11},{-100,-16},{-86,-16},{-86,2},{24,2},{24,16},{12.4,16},{
          12.4,15.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(AirHandlingUnit.Pel, Pel) annotation (Line(points={{0.15,11.875},{0.15,
          -4.125},{56,-4.125},{92,-4.125},{92,-4},{110,-4}}, color={0,0,127}));
  connect(AirHandlingUnit.QflowH, PHeatAHU) annotation (Line(points={{-6.85,11.875},
          {-6.85,-18},{-6,-18},{110,-18}}, color={0,0,127}));
  connect(AirHandlingUnit.QflowC, PCoolAHU) annotation (Line(points={{-20.85,11.875},
          {-20.85,-38},{-18,-38},{92,-38},{92,-30},{110,-30}}, color={0,0,127}));
  connect(replicatorTemperatureVentilation.y, zone.ventTemp) annotation (Line(
        points={{23,58.5},{23,66.22},{38.84,66.22}}, color={0,0,127}));
  connect(TAirAHUAvg.T, minTemp.u)
    annotation (Line(points={{34,-28},{34,-28},{31,-28}}, color={0,0,127}));
  connect(minTemp.y, AirHandlingUnit.T_extractAir) annotation (Line(points={{19.5,
          -28},{16,-28},{16,-16},{26,-16},{26,33.25},{12.4,33.25}}, color={0,0,127}));
  connect(zone.ventRate, airFlowRateSplit.airFlowOut) annotation (Line(points={{
          38.84,60.89},{44,60.89},{44,38},{44,38},{44,35.2}}, color={0,0,127}));
  connect(AHU[4], airFlowRateSplit.profile) annotation (Line(points={{-100,-1},{
          -100,-1},{-100,-18},{-86,-18},{-86,2},{40,2},{40,10},{40.4,10},{40.4,20.8}},
        color={0,0,127}));
  connect(AirHandlingUnit.T_supplyAirOut, replicatorTemperatureVentilation.u)
    annotation (Line(points={{12.4,23.5},{23,23.5},{23,47}}, color={0,0,127}));
  connect(AirHandlingUnit.T_outdoorAir, weaBus.TDryBul) annotation (Line(points=
         {{-47.8,19},{-100,19},{-100,69}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(splitterThermPercentAir.portIn[1], TAirAHUAvg.port)
    annotation (Line(points={{46,-28},{42,-28}}, color={191,0,0}));
  connect(splitterThermPercentAir.portOut, zone.intGainsConv) annotation (Line(
        points={{54,-28},{86,-28},{86,70.32},{80.42,70.32}}, color={191,0,0}));
  connect(relToAbsHum.relHum, weaBus.relHum) annotation (Line(points={{-73,11.6},
          {-100,11.6},{-100,69}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(relToAbsHum.TDryBul, weaBus.TDryBul) annotation (Line(points={{-73,6.2},
          {-100,6.2},{-100,69}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(relToAbsHum.absHum, AirHandlingUnit.X_outdoorAir) annotation (Line(
        points={{-61,9},{-56,9},{-56,15.25},{-47.8,15.25}}, color={0,0,127}));
  connect(airFlowRateSplit.airFlowIn, AirHandlingUnit.Vflow_out) annotation (
      Line(points={{44,20.8},{44,12},{28,12},{28,44},{-56,44},{-56,31},{-50.6,31}},
        color={0,0,127}));
  connect(zone.X_w, X_w) annotation (Line(points={{82.1,55.15},{94,55.15},{94,
          40},{110,40}},
                     color={0,0,127}));
  connect(minTemp.y, absToRelHum.TDryBul) annotation (Line(points={{19.5,-28},{-100,
          -28},{-100,72},{-42,72},{-42,78.2},{-37,78.2}}, color={0,0,127}));
  connect(AirHandlingUnit.T_supplyAirOut, relToAbsHum1.TDryBul) annotation (
      Line(points={{12.4,23.5},{28,23.5},{28,12},{67.8,12},{67.8,15}}, color={0,
          0,127}));
  connect(relToAbsHum1.absHum, replicatorHumidityVentilation.u)
    annotation (Line(points={{65,27},{65,31}}, color={0,0,127}));
  connect(replicatorHumidityVentilation.y, zone.ventHum) annotation (Line(
        points={{65,42.5},{65,44},{30,44},{30,54.945},{39.05,54.945}}, color={0,
          0,127}));
  connect(zone.X_w, moistSplitter.portIn) annotation (Line(points={{82.1,55.15},
          {94,55.15},{94,100},{-76,100},{-76,86},{-68,86}},
                                                          color={0,0,127}));
  connect(moistSplitter.portOut[1], absToRelHum.absHum) annotation (Line(points=
         {{-48,86},{-44,86},{-44,83.6},{-37,83.6}}, color={0,0,127}));
  connect(AirHandlingUnit.phi_supply, relToAbsHum1.relHum) annotation (Line(
        points={{12.4,12.25},{38,12.25},{38,12},{62,12},{62,15},{62.4,15}},
        color={0,0,127}));
  connect(absToRelHum.relHum, AirHandlingUnit.phi_extractAir) annotation (Line(
        points={{-25,81},{10,81},{10,44},{18,44},{18,29.5},{12.4,29.5}}, color={
          0,0,127}));
  connect(zone.CO2Con, CO2Con) annotation (Line(points={{82.1,51.05},{82.1,20},
          {110,20}},color={0,0,127}));
  if not use_moisture_balance then
  connect(AirHandlingUnit.phi_supply, AirHandlingUnit.phi_extractAir)
    annotation (Line(points={{12.4,12.25},{20,12.25},{20,29.5},{12.4,29.5}},
        color={0,0,127}));
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-62,-12},{-20,-26}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Polygon(
          points={{56,-44},{-80,-44},{-80,66},{32,66},{32,42},{56,42},{56,-44}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,58},{-20,52}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="AHU")}), Documentation(revisions="<html>
<ul>
<li>November 20, 2020, by Katharina Breuer:<br>Combine thermal zone models</li>
<li>August 27, 2020, by Katharina Breuer:<br>Add co2 balance </li>
<li>April, 2019, by Martin Kremer:<br>Add moisture balance</li>
<li>September 27, 2016, by Moritz Lauster:<br>Reimplementation based on Annex60 and AixLib models. </li>
<li>February 26, 2016, by Moritz Lauster:<br>Fixed bug in share of AHU volume flow. </li>
<li>April 25, 2015, by Ole Odendahl:<br>Implemented. </li>
</ul>
</html>", info="<html>
<p>This is a ready-to-use multizone model with a variable number of thermal zones. It adds heater/cooler devices and an air handling unit to <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.Multizone\">AixLib.ThermalZones.ReducedOrder.Multizone.Multizone</a>. It defines connectors and a replaceable vector of <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a> models. Most connectors are conditional to allow conditional modifications according to parameters or to pass-through conditional removements in <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a> and subsequently in <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.</p>
<p>Moisture and CO2 balances are conditional submodels which can be activated by setting use_moisture_balance or use_C_flow true.</p>
<h4>Typical use and important parameters </h4>
<p>The model needs parameters describing general properties of the building (indoor air volume, net floor area, overall surface area) and a vector with length of number of zones containing <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> records to define zone properties and heater/cooler properties. An additional tab allows configuring the air handling unit. The air handling unit facilitates heating, cooling, humidification, dehumidification and heat recovery modes. The user can redeclare the thermal zone model choosing from <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a simulation of a multizone building for district simulations. The multizone model calculates heat load and indoor air profiles. </p>
<h4>References </h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a> </p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples </h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.Multizone\">AixLib.ThermalZones.ReducedOrder.Examples.Multizone</a>. </p>
</html>"));
end MultizoneEquipped;
