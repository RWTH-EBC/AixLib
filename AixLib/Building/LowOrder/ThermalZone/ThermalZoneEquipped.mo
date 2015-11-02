within AixLib.Building.LowOrder.ThermalZone;
model ThermalZoneEquipped
  "Ready-to-use Low Order building model with AHU and heating"
  extends AixLib.Building.LowOrder.ThermalZone.partialThermalZone;
  AixLib.Building.Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    human_SensibleHeat_VDI2078(
    ActivityType=zoneParam.ActivityTypePeople,
    NrPeople=zoneParam.NrPeople,
    RatioConvectiveHeat=zoneParam.RatioConvectiveHeatPeople,
    T0=zoneParam.T0all) annotation (choicesAllMatching=true, Placement(
        transformation(extent={{40,0},{60,20}})));
  AixLib.Building.Components.Sources.InternalGains.Machines.Machines_DIN18599 machines_SensibleHeat_DIN18599(
    ActivityType=zoneParam.ActivityTypeMachines,
    NrPeople=zoneParam.NrPeopleMachines,
    ratioConv=zoneParam.RatioConvectiveHeatMachines,
    T0=zoneParam.T0all)
    annotation (Placement(transformation(extent={{40,-20},{60,-1}})));
  AixLib.Building.Components.Sources.InternalGains.Lights.Lights_relative lights(
    RoomArea=zoneParam.RoomArea,
    LightingPower=zoneParam.LightingPower,
    ratioConv=zoneParam.RatioConvectiveHeatLighting,
    T0=zoneParam.T0all)
    annotation (Placement(transformation(extent={{40,-40},{60,-21}})));
  Utilities.Control.VentilationController ventilationController(
    useConstantOutput=zoneParam.useConstantACHrate,
    baseACH=zoneParam.baseACH,
    maxUserACH=zoneParam.maxUserACH,
    maxOverheatingACH=zoneParam.maxOverheatingACH,
    maxSummerACH=zoneParam.maxSummerACH)
    annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tZone
    annotation (Placement(transformation(extent={{-24,-48},{-32,-40}})));
  Modelica.Blocks.Math.Add addInfiltrationVentilation(k1=+1, k2=1/zoneParam.Vair)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-8,-26})));
  Utilities.Psychrometrics.MixedTemperature
                             mixedTemperature(vAir=zoneParam.Vair)
    annotation (Placement(transformation(extent={{-64,-24},{-44,-4}})));
equation
  if zoneParam.withOuterwalls then
  end if;
  connect(ventilationController.y, mixedTemperature.infiltrationFlowIn)
    annotation (Line(
      points={{-45,-62},{-40,-62},{-40,-36},{-72,-36},{-72,-21},{-63.6,-21}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ventilationController.y, addInfiltrationVentilation.u1) annotation (
      Line(
      points={{-45,-62},{-11.6,-62},{-11.6,-33.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tZone.T, ventilationController.Tzone) annotation (Line(
      points={{-32,-44},{-72,-44},{-72,-56},{-64,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(human_SensibleHeat_VDI2078.ConvHeat, thermalZonePhysics.internalGainsConv)
    annotation (Line(points={{59,15},{78,15},{78,14},{78,-62},{8,-62},{8,2}},
        color={191,0,0}));
  connect(machines_SensibleHeat_DIN18599.ConvHeat, thermalZonePhysics.internalGainsConv)
    annotation (Line(points={{59,-4.8},{78,-4.8},{78,-62},{8,-62},{8,2}}, color=
         {191,0,0}));
  connect(lights.ConvHeat, thermalZonePhysics.internalGainsConv) annotation (
      Line(points={{59,-24.8},{78,-24.8},{78,-62},{8,-62},{8,2}}, color={191,0,
          0}));
  connect(internalGainsConv, thermalZonePhysics.internalGainsConv) annotation (
      Line(points={{0,-90},{2,-90},{2,-62},{8,-62},{8,2}}, color={191,0,0}));
  connect(tZone.port, thermalZonePhysics.internalGainsConv)
    annotation (Line(points={{-24,-44},{8,-44},{8,2}}, color={191,0,0}));
  connect(human_SensibleHeat_VDI2078.TRoom, thermalZonePhysics.internalGainsConv)
    annotation (Line(points={{41,19},{41,28},{78,28},{78,-62},{8,-62},{8,2}},
        color={191,0,0}));
  connect(internalGainsRad, thermalZonePhysics.internalGainsRad) annotation (
      Line(points={{40,-90},{42,-90},{42,-50},{16,-50},{16,2}}, color={95,95,95}));
  connect(lights.RadHeat, thermalZonePhysics.internalGainsRad) annotation (Line(
        points={{59,-36.01},{66,-36.01},{66,-50},{16,-50},{16,2}}, color={95,95,
          95}));
  connect(machines_SensibleHeat_DIN18599.RadHeat, thermalZonePhysics.internalGainsRad)
    annotation (Line(points={{59,-16.01},{66,-16.01},{66,-50},{16,-50},{16,2}},
        color={95,95,95}));
  connect(human_SensibleHeat_VDI2078.RadHeat, thermalZonePhysics.internalGainsRad)
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
  connect(mixedTemperature.mixedTemperatureOut, thermalZonePhysics.ventilationTemperature)
    annotation (Line(points={{-44,-14},{-30,-14},{-30,12},{-15.2,12}}, color={0,
          0,127}));
  connect(addInfiltrationVentilation.y, thermalZonePhysics.ventilationRate)
    annotation (Line(points={{-8,-19.4},{-8,2.8},{-8,2.8}}, color={0,0,127}));
  connect(weather, thermalZonePhysics.weather) annotation (Line(points={{-100,
          20},{-58,20},{-58,23.8},{-15,23.8}}, color={0,0,127}));
  connect(solarRad_in, thermalZonePhysics.solarRad_in) annotation (Line(points=
          {{-90,80},{-66,80},{-40,80},{-40,33},{-15.4,33}}, color={255,128,0}));
  connect(ventilationTemperature, mixedTemperature.ventilationTemperatureIn)
    annotation (Line(points={{-100,-40},{-88,-40},{-78,-40},{-78,-6.2},{-63.6,-6.2}},
                  color={0,0,127}));
  connect(ventilationRate, mixedTemperature.ventilationFlowIn) annotation (
      Line(points={{-40,-100},{-40,-78},{-76,-78},{-76,-11},{-63.6,-11}}, color=
         {0,0,127}));
  connect(ventilationController.Tambient, weather[1]) annotation (Line(points={{-64,-62},
          {-80,-62},{-80,20},{-100,20},{-100,6.66667}},           color={0,0,127}));
  connect(weather[1], mixedTemperature.infiltrationTemperatureIn) annotation (
      Line(points={{-100,6.66667},{-86,6.66667},{-70,6.66667},{-70,-16},{-63.6,
          -16}}, color={0,0,127}));
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>The ThermalZone reflects the VDI 6007 components (in ThermalZonePhysics) and adds some standards parts of the EBC library for easy simulation with persons, lights and maschines.</li>
 <li>Inputs: real weather vector, as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>; vectorial solarRad_in, the solar radiation (diffuse and direct) for all n directions; real infiltration/ventilation as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> and real inner loads input for profiles. </li>
 <li>Parameters: All parameters are collected in a ZoneRecord (see <a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\">ZoneBaseRecord</a>). </li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\" alt=\"stars: 5 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>ThermalZone is thought for easy computations to get information about air temperatures and heating profiles. Therefore, some simplifications have been implemented (one air node, one inner wall, one outer wall). </p>
 <p>All theory is documented in VDI 6007. How to gather the physical parameters for the thermal zone is documented in this standard. It is possible to get this information out of the normal information of a building. Various data can be used, depending on the abilities of the preprocessing tools. </p>
 <p><br/><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>See <a href=\"Examples\">Examples</a> for some results. </p>
 </html>", revisions="<html>
<ul>
<li><i>June, 2015&nbsp;</i> by Moritz Lauster:<br>Implemented </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})));
end ThermalZoneEquipped;
