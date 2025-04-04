within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneEquipped
  "Multizone model with ideal heater and cooler and AHU"
  extends
    AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;

  parameter Boolean heatAHU=true
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
  parameter Boolean heatRecoveryAHU=true
    "Status of Heat Recovery System of AHU"
    annotation (
    Dialog(tab="AirHandlingUnit", group="AHU Modes"), choices(checkBox=true));
  parameter Boolean relOrAbsHumAHU=true
    "Wether to control relative (true) or absolute humidity (false) in AHU"
    annotation (
    Dialog(tab="AirHandlingUnit", group="AHU Modes"), choices(checkBox=true));
  parameter Boolean dynamicVolumeFlowControlAHU=false
    "Status of dynamic AHU control depending on room temperature";
  parameter Boolean dynamicSetTempControlAHU=false
    "Status of dynamic set Temperature control in AHU control depending on temperature in AHU after HRS";
  parameter Modelica.Units.SI.Temperature T_Treshold_Heating_AHU=290.15
    "Temperature after HRS in AHU over which there should be no ahu heating
        for temperature reasons (humidifciation/dehumidifaction still possible)";
  parameter Modelica.Units.SI.Temperature T_Treshold_Cooling_AHU = 294.15
        "Temperature after HRS in AHU under which there should be no ahu cooling
        for temperature reasons (humidifciation/dehumidifaction still possible)";
  parameter Real effHRSAHU_enabled(
    min=0,
    max=1)
    "Efficiency of HRS when enabled"
    annotation (Dialog(
    tab="AirHandlingUnit",
    group="Settings AHU Value",
    enable=heatRecoveryAHU));
  parameter Real effHRSAHU_disabled(
    min=0,
    max=1)
    "Efficiency of HRS when disabled"
    annotation (Dialog(
    tab="AirHandlingUnit",
    group="Settings AHU Value",
    enable=not heatRecoveryAHU));

  parameter Modelica.Units.SI.Pressure dpAHU_sup
    "Pressure difference over supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.Units.SI.Pressure dpAHU_eta
    "Pressure difference over extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.Units.SI.Efficiency effFanAHU_sup
    "Efficiency of supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.Units.SI.Efficiency effFanAHU_eta
    "Efficiency of extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  Modelica.Blocks.Interfaces.RealInput AHU[4]
    "Input for AHU Conditions [1]: Desired Air Temperature in K [2]: Desired
    minimal relative humidity [3]: Desired maximal relative humidity [4]:
    Schedule Desired Ventilation Flow"
    annotation (Placement(transformation(
    extent={{16,18},{-16,-18}},
    rotation=180,
    origin={-100,10}),  iconTransformation(
    extent={{10,-10},{-10,10}},
    rotation=180,
    origin={-90,0})));
  Modelica.Blocks.Interfaces.RealOutput Pel(
    final quantity="Power",
    final unit="W") if ASurTot > 0 or VAir > 0
    "Electrical power of AHU"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
    iconTransformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Interfaces.RealOutput PHeatAHU(final quantity="HeatFlowRate",
    final unit="W") if ASurTot > 0 or VAir > 0
    "Thermal power of AHU for heating"
    annotation (
    Placement(transformation(extent={{100,-20},{120,0}}),
    iconTransformation(extent={{80,-40},{100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput PCoolAHU(final quantity="HeatFlowRate",
    final unit="W") if ASurTot > 0 or VAir > 0
    "Thermal power of AHU for cooling"
    annotation (
    Placement(transformation(extent={{100,-30},{120,-10}}),iconTransformation(
    extent={{80,-60},{100,-40}})));

  Modelica.Blocks.Interfaces.RealOutput CO2Con[numZones] if use_C_flow
    "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));

  replaceable model AHUMod =
      AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.ModularAHU
    constrainedby
    AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.BaseClasses.PartialModularAHU
    "Air handling unit model"
    annotation(choicesAllMatching=true, Dialog(tab="AirHandlingUnit"));


  AHUMod AirHandlingUnit(
    humidifying=huAHU,
    cooling=coolAHU,
    dehumidifying=dehuAHU,
    heating=heatAHU,
    heatRecovery=heatRecoveryAHU,
    usePhiSet=relOrAbsHumAHU,
    limPhiOda=false,
    m_flow_nominal=0.1,
    dpHrs_nominal(displayUnit="Pa") = 1,
    dpCoo_nominal(displayUnit="Pa") = 1,
    dpHea_nominal(displayUnit="Pa") = 1,
    dpHum_nominal(displayUnit="Pa") = 1,
    dpFanOda_nominal(displayUnit="Pa") = dpAHU_sup,
    dpFanEta_nominal(displayUnit="Pa") = dpAHU_eta,
    effHrsOn=effHRSAHU_enabled,
    effHrsOff=effHRSAHU_disabled,
    dpFanOda=dpAHU_sup,
    dpFanEta=dpAHU_eta,
    etaFanOda=effFanAHU_sup,
    etaFanEta=effFanAHU_eta)
    if ASurTot > 0 or VAir > 0
    annotation (Placement(transformation(extent={{-50,0},{10,40}})));


  Modelica.Blocks.Interfaces.RealOutput PHumAHU(final quantity="HeatFlowRate",
      final unit="W") if ASurTot > 0 or VAir > 0
    "Thermal power of AHU for humidification" annotation (Placement(
        transformation(extent={{100,-40},{120,-20}}), iconTransformation(extent=
           {{80,-60},{100,-40}})));


  BaseClasses.DynamicVolumeFlowControl dynamicVolumeFlowControl(
    final numZones=numZones,
    final zoneParam=zoneParam,
    final heatAHU=heatAHU,
    final coolAHU=coolAHU,
    maxAHU_PI_Heat=1,
    maxAHU_PI_Cool=1.5) if ASurTot > 0 or VAir > 0
    annotation (Placement(transformation(extent={{-24,-66},{-12,-54}})));
  BaseClasses.DynamicAHUTemperatureControl dynamicAHUTemperatureControl(
      dynamicSetTempControlAHU=dynamicSetTempControlAHU,
      T_Treshold_Heating=T_Treshold_Heating_AHU,
      T_Treshold_Cooling=T_Treshold_Cooling_AHU,
      phi_HRS = if heatRecoveryAHU then effHRSAHU_enabled else effHRSAHU_disabled)
      if ASurTot > 0 or VAir > 0
    annotation (Placement(transformation(extent={{-42,-46},{-54,-34}})));


protected
  parameter Real zoneFactor[numZones,1](each fixed=false)
    "Calculated zone factors";
  parameter Real VAirRes(fixed=false)
    "Resulting air volume in zones supplied by the AHU";
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(
    final nout=numZones) if ASurTot > 0 or VAir > 0
    "Replicates scalar temperature of AHU into a vector[numZones] of identical
    temperatures"
    annotation (Placement(transformation(
    extent={{-6,-6},{6,6}},
    rotation=90,
    origin={22,54})));
  Modelica.Blocks.Nonlinear.Limiter minTemp(uMax=1000, uMin=1)
    if ASurTot > 0 or VAir > 0
    "Temperature limiter for measured indoor air temperature for AHU"
    annotation (Placement(transformation(extent={{30,-33},{20,-23}})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSplit airFlowRateSplit(
    final dimension=numZones,
    withProfile=true,
    dynamicControl=dynamicVolumeFlowControlAHU,
    final zoneParam=zoneParam) if ASurTot > 0 or VAir > 0
    "Post-processor for AHU outputs"
    annotation (Placement(transformation(
    extent={{-6,-6},{6,6}},
    rotation=90,
    origin={44,28})));
  RC.BaseClasses.ThermSplitter splitterThermPercentAir(
    final splitFactor=zoneFactor,
    final nOut=numZones,
    final nIn=1)        if ASurTot > 0 or VAir > 0
    "Collector of indoor air temperatures of all zones"
    annotation (Placement(transformation(
    extent={{-4,-4},{4,4}},
    rotation=0,
    origin={50,-28})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAirAHUAvg
    if ASurTot > 0 or VAir > 0
    "Averaged air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{42,-32},{34,-24}})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.AirFlowRateSum airFlowRate(
    final dimension=numZones,
    withProfile=true,
    dynamicControl=dynamicVolumeFlowControlAHU,
    final zoneParam=zoneParam) if ASurTot > 0 or VAir > 0
    "Pre-processor for AHU inputs"
    annotation (Placement(transformation(extent={{-72,22},{-60,34}})));

  BaseClasses.MoistSplitter moistSplitter(
    final nOut=1,
    final nIn=numZones,
    final splitFactor=zoneFactor) if (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Sums up a vector[numZones] of identical humidities to an average humidity"
    annotation (Placement(transformation(extent={{-68,72},{-48,92}})));
  BaseClasses.AbsToRelHum absToRelHum if (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Converter from absolute humidity to relative humidity"
    annotation (Placement(transformation(extent={{-38,72},{-26,84}})));
  BaseClasses.RelToAbsHum relToAbsHum1 if (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Converter from relative humidity to absolute humidity" annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={65,21})));
  Modelica.Blocks.Routing.Replicator replicatorHumidityVentilation(final nout=
        numZones) if (ASurTot > 0 or VAir > 0) and use_moisture_balance
        "Replicates scalar humidity of AHU into a vector[numZones] of identical
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
        points={{76,-100},{74,-100},{74,-20},{-76,-20},{-76,26},{-73.2,26},{
            -73.2,25.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 2], airFlowRateSplit.relOccupation[i]) annotation (
       Line(points={{76,-100},{74,-100},{74,0},{47.24,0},{47.24,20.8}},
                                                                     color={0,0,
            127}));

  end for;

  connect(AHU[4], airFlowRate.profile) annotation (Line(
      points={{-100,16.75},{-100,10},{-82,10},{-82,30},{-73.2,30},{-73.2,30.4}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(AirHandlingUnit.Pel, Pel) annotation (Line(points={{-18.3125,-1},{-18.3125,
          -4.125},{56,-4.125},{92,-4.125},{92,0},{110,0}},   color={0,0,127}));
  connect(airFlowRate.airFlow, AirHandlingUnit.VOda_flow) annotation (Line(
        points={{-58.8,28},{-56,28},{-56,32},{-50.75,32}}, color={0,0,127}));
  connect(AirHandlingUnit.TOda, weaBus.TDryBul) annotation (Line(points={{-50.75,
          28},{-54,28},{-54,68},{-96,68},{-96,69.08},{-99.915,69.08}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(AirHandlingUnit.phiOda, weaBus.relHum) annotation (Line(points={{-50.75,
          24},{-54,24},{-54,68},{-98,68},{-98,69.08},{-99.915,69.08}},
                                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(AHU[2], AirHandlingUnit.phiSupSet[1]) annotation (Line(points={{-100,7.75},
          {-98,7.75},{-98,10},{-58,10},{-58,-4},{2.5,-4},{2.5,-1}}, color={0,0,127}));
  connect(AHU[3], AirHandlingUnit.phiSupSet[2]) annotation (Line(points={{-100,12.25},
          {-94,12.25},{-94,10},{-58,10},{-58,-4},{2.5,-4},{2.5,-0.6}}, color={0,
          0,127}));
  connect(AirHandlingUnit.TSup, replicatorTemperatureVentilation.u) annotation (Line(points={{10.75,
          16},{22,16},{22,46.8}},                                                                                           color={0,0,127}));
  connect(airFlowRate.airFlow, AirHandlingUnit.VEta_flow) annotation (Line(
        points={{-58.8,28},{-56,28},{-56,-8},{24,-8},{24,32},{10.75,32}}, color=
         {0,0,127}));
  connect(airFlowRate.airFlow, airFlowRateSplit.airFlowIn) annotation (Line(
        points={{-58.8,28},{-56,28},{-56,-12},{44,-12},{44,20.8}},
                                                                 color={0,0,127}));
  connect(AirHandlingUnit.TSupSet, AHU[1]) annotation (Line(points={{6.25,-0.8},
          {6.25,0},{8,0},{8,-4},{-58,-4},{-58,10},{-100,10},{-100,3.25}}, color=
         {0,0,127}));
  connect(airFlowRateSplit.profile, AHU[4]) annotation (Line(points={{40.4,20.8},
          {40.4,20},{40,20},{40,-4},{-64,-4},{-64,10},{-98,10},{-98,14},{-100,14},
          {-100,16.75}}, color={0,0,127}));
  connect(AirHandlingUnit.QHea_flow, PHeatAHU) annotation (Line(points={{-22.0625,
          -1},{-22.0625,-6},{-20,-6},{-20,-14},{94,-14},{94,-10},{110,-10}},
        color={0,0,127}));
  connect(AirHandlingUnit.QHum_flow, PHumAHU) annotation (Line(points={{-25.8125,
          -1},{-24,-1},{-24,-16},{94,-16},{94,-30},{110,-30}}, color={0,0,127}));
  connect(AirHandlingUnit.QCoo_flow, PCoolAHU) annotation (Line(points={{-29.5625,
          -1},{-28,-1},{-28,-18},{96,-18},{96,-20},{110,-20}}, color={0,0,127}));
  connect(AirHandlingUnit.TSup, relToAbsHum1.TDryBul) annotation (Line(points={{10.75,
          16},{22,16},{22,10},{67.8,10},{67.8,15}},       color={0,0,127}));
  connect(AirHandlingUnit.phiSup, relToAbsHum1.relHum) annotation (Line(points={{10.75,
          12},{62,12},{62,14},{62.4,14},{62.4,15}},        color={0,0,127}));
  connect(AirHandlingUnit.TEta, minTemp.y) annotation (Line(points={{10.75,28},{
          16,28},{16,-28},{19.5,-28}}, color={0,0,127}));
  connect(AirHandlingUnit.phiEta, absToRelHum.relHum) annotation (Line(points={{10.75,
          24},{18,24},{18,44},{12,44},{12,78},{-24.8,78}},       color={0,0,127}));


  connect(replicatorTemperatureVentilation.y, zone.ventTemp) annotation (Line(
        points={{22,60.6},{22,66.22},{38.84,66.22}}, color={0,0,127}));
  connect(TAirAHUAvg.T, minTemp.u)
    annotation (Line(points={{33.6,-28},{33.6,-28},{31,-28}},
                                                          color={0,0,127}));
  connect(zone.ventRate, airFlowRateSplit.airFlowOut) annotation (Line(points={{38.84,
          60.89},{36,60.89},{36,60},{34,60},{34,40},{44,40},{44,35.2}},
                                                              color={0,0,127}));
  connect(splitterThermPercentAir.portIn[1], TAirAHUAvg.port)
    annotation (Line(points={{46,-28},{42,-28}}, color={191,0,0}));
  connect(splitterThermPercentAir.portOut, zone.intGainsConv) annotation (Line(
        points={{54,-28},{86,-28},{86,70.32},{80.42,70.32}}, color={191,0,0}));
  connect(zone.X_w, X_w) annotation (Line(points={{82.1,55.15},{94,55.15},{94,
          40},{110,40}},
                     color={0,0,127}));
  connect(minTemp.y, absToRelHum.TDryBul) annotation (Line(points={{19.5,-28},{16,
          -28},{16,42},{-42,42},{-42,74.64},{-39.2,74.64}},
                                                          color={0,0,127}));
  connect(relToAbsHum1.absHum, replicatorHumidityVentilation.u)
    annotation (Line(points={{65,27},{65,31}}, color={0,0,127}));
  connect(replicatorHumidityVentilation.y, zone.ventHum) annotation (Line(
        points={{65,42.5},{65,44},{38,44},{38,54.535},{38.21,54.535}}, color={0,
          0,127}));
  connect(zone.X_w, moistSplitter.portIn) annotation (Line(points={{82.1,55.15},
          {94,55.15},{94,100},{-76,100},{-76,82},{-68,82}},
                                                          color={0,0,127}));
  connect(moistSplitter.portOut[1], absToRelHum.absHum) annotation (Line(points={{-48,82},
          {-40,82},{-40,81.12},{-39.2,81.12}},      color={0,0,127}));
  connect(zone.CO2Con, CO2Con) annotation (Line(points={{82.1,51.05},{82.1,20},
          {110,20}},color={0,0,127}));

  if not use_moisture_balance then
    connect(AirHandlingUnit.phiSup, AirHandlingUnit.phiEta) annotation (Line(
        points={{10.75,12},{18,12},{18,24},{10.75,24}}, color={0,0,127}));
  end if;


  connect(TSetCool, dynamicVolumeFlowControl.TSetCool) annotation (Line(points={{-80,
          -100},{-80,-72},{-20,-72},{-20,-70},{-20.4,-70},{-20.4,-67.2}},
                                                     color={0,0,127}));
  connect(dynamicVolumeFlowControl.setAHU, airFlowRate.setAHU) annotation (Line(
        points={{-25.2,-60},{-78,-60},{-78,22.6},{-73.2,22.6}},          color={
          0,0,127}));
  connect(dynamicVolumeFlowControl.setAHU, airFlowRateSplit.setAHU) annotation (
     Line(points={{-25.2,-60},{-28,-60},{-28,-50},{50,-50},{50,20.8}},
                                                                     color={0,0,
          127}));
  connect(AHU[4], dynamicVolumeFlowControl.AHUProfile) annotation (Line(points={{-100,
          16.75},{-100,10},{-80,10},{-80,-64.8},{-25.2,-64.8}},
        color={0,0,127}));
  connect(AHU[1], dynamicAHUTemperatureControl.TsetAHU_In) annotation (Line(
        points={{-100,3.25},{-100,10},{-80,10},{-80,-40},{-55.2,-40}},
        color={0,0,127}));
  connect(dynamicAHUTemperatureControl.T_Oda, weaBus.TDryBul) annotation (Line(
        points={{-52.8,-32.8},{-52.8,-32},{-54,-32},{-54,70},{-76,70},{-76,
          69.08},{-99.915,69.08}},                                   color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(dynamicAHUTemperatureControl.T_Eta, minTemp.y) annotation (Line(
        points={{-43.32,-32.8},{14,-32.8},{14,-28},{19.5,-28}},
        color={0,0,127}));
  connect(TSetHeat, dynamicVolumeFlowControl.TSetHeat) annotation (Line(points={
          {-40,-100},{-40,-74},{-15.6,-74},{-15.6,-67.2}}, color={0,0,127}));
  connect(dynamicVolumeFlowControl.roomHeatPort, zone.intGainsConv) annotation (
     Line(points={{-12,-60},{86,-60},{86,70},{80.42,70},{80.42,70.32}}, color={191,
          0,0}));
    annotation (Line(points={{33.6,-28},{31,-28}},        color={0,0,127}),
               Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,ERROR,
                    dynamicVolumeFlowControl.TSetHeat}},
                                                     color={0,0,127})),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-62,-12},{-20,-26}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Polygon(
          points={{58,-44},{-78,-44},{-78,66},{34,66},{34,42},{58,42},{58,-44}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,58},{-20,52}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="AHU")}), Documentation(revisions="<html><ul>
  <li>November 20, 2020, by Katharina Breuer:<br/>
    Combine thermal zone models
  </li>
  <li>August 27, 2020, by Katharina Breuer:<br/>
    Add co2 balance
  </li>
  <li>April, 2019, by Martin Kremer:<br/>
    Add moisture balance
  </li>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation based on Annex60 and AixLib models.
  </li>
  <li>February 26, 2016, by Moritz Lauster:<br/>
    Fixed bug in share of AHU volume flow.
  </li>
  <li>April 25, 2015, by Ole Odendahl:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  This is a ready-to-use multizone model with a variable number of
  thermal zones. It adds heater/cooler devices and an air handling unit
  to <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.Multizone\">AixLib.ThermalZones.ReducedOrder.Multizone.Multizone</a>.
  It defines connectors and a replaceable vector of <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  models. Most connectors are conditional to allow conditional
  modifications according to parameters or to pass-through conditional
  removements in <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  and subsequently in <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.
</p>
<p>
  Moisture and CO2 balances are conditional submodels which can be
  activated by setting use_moisture_balance or use_C_flow true.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  The model needs parameters describing general properties of the
  building (indoor air volume, net floor area, overall surface area)
  and a vector with length of number of zones containing <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  records to define zone properties and heater/cooler properties. An
  additional tab allows configuring the air handling unit. The air
  handling unit facilitates heating, cooling, humidification,
  dehumidification and heat recovery modes. The user can redeclare the
  thermal zone model choosing from <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>.
  Further parameters for medium, initialization and dynamics originate
  from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
  A typical use case is a simulation of a multizone building for
  district simulations. The multizone model calculates heat load and
  indoor air profiles.
</p>
<h4>
  References
</h4>
<p>
  For automatic generation of thermal zone and multizone models as well
  as for datasets, see <a href=
  \"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a>
</p>
<ul>
  <li>German Association of Engineers: Guideline VDI 6007-1, March
  2012: Calculation of transient thermal response of rooms and
  buildings - Modelling of rooms.
  </li>
  <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D.
  (2014): Low order thermal network models for dynamic simulations of
  buildings on city district scale. In: Building and Environment 73, p.
  223–231. DOI: <a href=
  \"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.
  </li>
</ul>
<h4>
  Examples
</h4>
<p>
  See <a href=
  \"AixLib.ThermalZones.ReducedOrder.Examples.Multizone\">AixLib.ThermalZones.ReducedOrder.Examples.Multizone</a>.
</p>
</html>"));
end MultizoneEquipped;
