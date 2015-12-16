within AixLib.Building.LowOrder.ThermalZone;
model ThermalZoneEquipped
  "Ready-to-use reduced order building model with ventilation, infiltration and internal gains"
  extends AixLib.Building.LowOrder.ThermalZone.partialThermalZone;
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
  Utilities.Control.VentilationController ventilationController(
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
  connect(human_SensibleHeat_VDI2078.ConvHeat, buildingPhysics.internalGainsConv)
    annotation (Line(points={{59,15},{78,15},{78,14},{78,-62},{8,-62},{8,2}},
        color={191,0,0}));
  connect(machines_SensibleHeat_DIN18599.ConvHeat, buildingPhysics.internalGainsConv)
    annotation (Line(points={{59,-4.8},{78,-4.8},{78,-62},{8,-62},{8,2}}, color=
         {191,0,0}));
  connect(lights.ConvHeat, buildingPhysics.internalGainsConv) annotation (
      Line(points={{59,-24.8},{78,-24.8},{78,-62},{8,-62},{8,2}}, color={191,0,
          0}));
  connect(internalGainsConv, buildingPhysics.internalGainsConv) annotation (
      Line(points={{0,-58},{2,-58},{2,-62},{8,-62},{8,2}}, color={191,0,0}));
  connect(tZone.port, buildingPhysics.internalGainsConv)
    annotation (Line(points={{-24,-44},{8,-44},{8,2}}, color={191,0,0}));
  connect(human_SensibleHeat_VDI2078.TRoom, buildingPhysics.internalGainsConv)
    annotation (Line(points={{41,19},{41,28},{78,28},{78,-62},{8,-62},{8,2}},
        color={191,0,0}));
  connect(internalGainsRad, buildingPhysics.internalGainsRad) annotation (
      Line(points={{40,-58},{42,-58},{42,-50},{16,-50},{16,2}}, color={95,95,95}));
  connect(lights.RadHeat, buildingPhysics.internalGainsRad) annotation (Line(
        points={{59,-36.01},{66,-36.01},{66,-50},{16,-50},{16,2}}, color={95,95,
          95}));
  connect(machines_SensibleHeat_DIN18599.RadHeat, buildingPhysics.internalGainsRad)
    annotation (Line(points={{59,-16.01},{66,-16.01},{66,-50},{16,-50},{16,2}},
        color={95,95,95}));
  connect(human_SensibleHeat_VDI2078.RadHeat, buildingPhysics.internalGainsRad)
    annotation (Line(points={{59,9},{66,9},{66,-50},{16,-50},{16,2}}, color={95,
          95,95}));
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
  connect(mixedTemperature.mixedTemperatureOut, buildingPhysics.ventilationTemperature)
    annotation (Line(points={{-44,-14},{-30,-14},{-30,12},{-19.6,12}}, color={0,
          0,127}));
  connect(addInfiltrationVentilation.y, buildingPhysics.ventilationRate)
    annotation (Line(points={{-8,-19.4},{-8,2.8}},          color={0,0,127}));
  connect(weather, buildingPhysics.weather) annotation (Line(points={{-100,20},{
          -58,20},{-58,23.8},{-20.2,23.8}},    color={0,0,127}));
  connect(solarRad_in, buildingPhysics.solarRad_in) annotation (Line(points={{-90,80},
          {-66,80},{-40,80},{-40,33},{-21,33}},             color={255,128,0}));
  connect(ventilationController.Tambient, weather[1]) annotation (Line(points={{-64,-62},
          {-80,-62},{-80,20},{-100,20},{-100,6.66667}},           color={0,0,127}));
  connect(weather[1], mixedTemperature.temperature_flow2) annotation (Line(
        points={{-100,6.66667},{-100,-16},{-63.6,-16}}, color={0,0,127}));
  connect(ventilationController.y, mixedTemperature.flowRate_flow2) annotation (
     Line(points={{-45,-62},{-40,-62},{-40,-30},{-70,-30},{-70,-21},{-63.6,-21}},
        color={0,0,127}));
  connect(ventilationRate, mixedTemperature.flowRate_flow1) annotation (Line(
        points={{-40,-100},{-40,-76},{-74,-76},{-74,-11},{-63.6,-11}}, color={0,
          0,127}));
  connect(ventilationTemperature, mixedTemperature.temperature_flow1)
    annotation (Line(points={{-100,-40},{-76,-40},{-76,-6.2},{-63.6,-6.2}},
        color={0,0,127}));
  annotation(Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model combines building physics, models for internal gains and the calculation of natural ventilation (window opening) and infiltration. It is thought as a ready-to-use thermal zone model. For convenience, all parameters are collected in a record (see<a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\"> ZoneBaseRecord</a>). </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p><b>References</b> </span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </span></li>
</ul>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Example Results</b> </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">See <a href=\"Examples\">Examples</a>.</span></p>
</html>",  revisions="<html>
<ul>
<li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br>Implemented </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end ThermalZoneEquipped;
