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
  Modelica.Blocks.Interfaces.RealInput infiltrationTemperature[2] annotation (
      Placement(transformation(extent={{-148,-60},{-108,-20}}),
        iconTransformation(extent={{-88,-52},{-62,-26}})));
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
  Cities.Utilities.MixedTemperature
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
  connect(infiltrationTemperature[2], mixedTemperature.ventilationTemperatureIn)
    annotation (Line(
      points={{-128,-30},{-74,-30},{-74,-6.2},{-63.6,-6.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(infiltrationTemperature[1], mixedTemperature.infiltrationTemperatureIn)
    annotation (Line(
      points={{-128,-50},{-128,-30},{-74,-30},{-74,-16},{-63.6,-16}},
      color={0,0,127},
      smooth=Smooth.None));
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
