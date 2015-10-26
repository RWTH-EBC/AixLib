within AixLib.Building.LowOrder.ThermalZone;
model ThermalZone "Ready-to-use Low Order building model"
  extends AixLib.Building.LowOrder.ThermalZone.partialThermalZone;
  Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078 human_SensibleHeat_VDI2078(ActivityType = zoneParam.ActivityTypePeople, NrPeople = zoneParam.NrPeople, RatioConvectiveHeat = zoneParam.RatioConvectiveHeatPeople, T0 = zoneParam.T0all) annotation(choicesAllMatching = true, Placement(transformation(extent = {{40, 0}, {60, 20}})));
  Components.Sources.InternalGains.Machines.Machines_DIN18599 machines_SensibleHeat_DIN18599(ActivityType = zoneParam.ActivityTypeMachines, NrPeople = zoneParam.NrPeopleMachines, ratioConv = zoneParam.RatioConvectiveHeatMachines, T0 = zoneParam.T0all) annotation(Placement(transformation(extent = {{40, -20}, {60, -1}})));
  Components.Sources.InternalGains.Lights.Lights_relative lights(RoomArea = zoneParam.RoomArea, LightingPower = zoneParam.LightingPower, ratioConv = zoneParam.RatioConvectiveHeatLighting, T0 = zoneParam.T0all) annotation(Placement(transformation(extent = {{40, -40}, {60, -21}})));
  replaceable BaseClasses.ThermalZonePhysics.ThermalZonePhysicsEBCMod thermalZonePhysics(RRest = zoneParam.RRest, R1o = zoneParam.R1o, C1o = zoneParam.C1o, Ao = zoneParam.Ao, T0all = zoneParam.T0all, alphaowi = zoneParam.alphaowi, alphaowo = zoneParam.alphaowo, epso = zoneParam.epso, R1i = zoneParam.R1i, C1i = zoneParam.C1i, Ai = zoneParam.Ai, Vair = zoneParam.Vair, alphaiwi = zoneParam.alphaiwi, rhoair = zoneParam.rhoair, cair = zoneParam.cair, epsi = zoneParam.epsi, aowo = zoneParam.aowo, epsw = zoneParam.epsw, g = zoneParam.g, Imax = zoneParam.Imax, n = zoneParam.n, weightfactorswall = zoneParam.weightfactorswall, weightfactorswindow = zoneParam.weightfactorswindow, weightfactorground = zoneParam.weightfactorground, temperatureground = zoneParam.temperatureground, Aw = zoneParam.Aw, gsunblind = zoneParam.gsunblind, withInnerwalls = zoneParam.withInnerwalls, withWindows = zoneParam.withWindows, withOuterwalls = zoneParam.withOuterwalls, splitfac = zoneParam.splitfac) constrainedby
    AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics.partialThermalZonePhysics
                                                                                      annotation(Placement(transformation(extent = {{-20, 0}, {20, 40}})),choicesAllMatching=true);
equation
  if zoneParam.withOuterwalls then
  end if;
  connect(human_SensibleHeat_VDI2078.TRoom, thermalZonePhysics.internalGainsConv) annotation(Line(points = {{41, 19}, {46, 19}, {46, 32}, {96, 32}, {96, -52}, {8, -52}, {8, 2}}, color = {191, 0, 0}));
  connect(human_SensibleHeat_VDI2078.ConvHeat, thermalZonePhysics.internalGainsConv) annotation(Line(points = {{59, 15}, {96, 15}, {96, -52}, {8, -52}, {8, 2}}, color = {191, 0, 0}));
  connect(machines_SensibleHeat_DIN18599.ConvHeat, thermalZonePhysics.internalGainsConv) annotation(Line(points = {{59, -4.8}, {96, -4.8}, {96, -52}, {8, -52}, {8, 2}}, color = {191, 0, 0}));
  connect(lights.ConvHeat, thermalZonePhysics.internalGainsConv) annotation(Line(points = {{59, -24.8}, {96, -24.8}, {96, -52}, {8, -52}, {8, 2}}, color = {191, 0, 0}));
  connect(human_SensibleHeat_VDI2078.RadHeat, thermalZonePhysics.internalGainsRad) annotation(Line(points = {{59, 9}, {92, 9}, {92, -48}, {16, -48}, {16, 2}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(machines_SensibleHeat_DIN18599.RadHeat, thermalZonePhysics.internalGainsRad) annotation(Line(points = {{59, -16.01}, {92, -16.01}, {92, -48}, {16, -48}, {16, 2}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(lights.RadHeat, thermalZonePhysics.internalGainsRad) annotation(Line(points = {{59, -36.01}, {92, -36.01}, {92, -48}, {16, -48}, {16, 2}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(internalGains[1], human_SensibleHeat_VDI2078.Schedule) annotation (
      Line(points={{80,-113.333},{80,-60},{32,-60},{32,8.9},{40.9,8.9}}, color={
          0,0,127}));
  connect(internalGains[2], machines_SensibleHeat_DIN18599.Schedule)
    annotation (Line(points={{80,-100},{80,-100},{80,-60},{32,-60},{32,-10.5},{41,
          -10.5}}, color={0,0,127}));
  connect(internalGains[3], lights.Schedule) annotation (Line(points={{80,
          -86.6667},{80,-60},{32,-60},{32,-30.5},{41,-30.5}},
                                                    color={0,0,127}));
  connect(internalGainsConv, thermalZonePhysics.internalGainsConv)
    annotation (Line(points={{0,-90},{0,-52},{8,-52},{8,2}}, color={191,0,0}));
  connect(solarRad_in, thermalZonePhysics.solarRad_in) annotation (Line(points={
          {-90,80},{-70,80},{-48,80},{-48,33},{-15.4,33}}, color={255,128,0}));
  connect(weather, thermalZonePhysics.weather) annotation (Line(points={{-100,20},
          {-58,20},{-58,23.8},{-15,23.8}}, color={0,0,127}));
  connect(infiltrationTemperature, thermalZonePhysics.ventilationTemperature)
    annotation (Line(points={{-80,-40},{-60,-40},{-40,-40},{-40,12},{-15.2,12}},
        color={0,0,127}));
  connect(infiltrationRate, thermalZonePhysics.ventilationRate) annotation (
      Line(points={{-40,-100},{-40,-100},{-40,-52},{-8,-52},{-8,2.8}}, color={0,
          0,127}));
  connect(internalGainsRad, thermalZonePhysics.internalGainsRad) annotation (
      Line(points={{40,-90},{40,-70},{16,-70},{16,2}}, color={95,95,95}));
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
 </html>", revisions = "<html>
 <ul>
   <li><i>March, 2012&nbsp;</i>
          by Moritz Lauster:<br/>
          Implemented</li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end ThermalZone;
