within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZone
  "Ready-to-use reduced order building model with internal gains"
  extends AixLib.ThermalZones.ReducedOrder.ThermalZone.PartialThermalZone;
  Building.Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078 human_SensibleHeat_VDI2078(
    ActivityType=zoneParam.ActivityTypePeople,
    NrPeople=zoneParam.NrPeople,
    RatioConvectiveHeat=zoneParam.RatioConvectiveHeatPeople,
    T0=zoneParam.T0all) "Internal gains from persons" annotation (
      choicesAllMatching=true, Placement(transformation(extent={{40,0},{60,20}})));
  Building.Components.Sources.InternalGains.Machines.Machines_DIN18599 machines_SensibleHeat_DIN18599(
    ActivityType=zoneParam.ActivityTypeMachines,
    NrPeople=zoneParam.NrPeopleMachines,
    ratioConv=zoneParam.RatioConvectiveHeatMachines,
    T0=zoneParam.T0all) "Internal gains from machines"
    annotation (Placement(transformation(extent={{40,-20},{60,-1}})));
  Building.Components.Sources.InternalGains.Lights.Lights_relative lights(
    RoomArea=zoneParam.RoomArea,
    LightingPower=zoneParam.LightingPower,
    ratioConv=zoneParam.RatioConvectiveHeatLighting,
    T0=zoneParam.T0all) "Internal gains from light"
    annotation (Placement(transformation(extent={{40,-40},{60,-21}})));
equation
  connect(internalGains[1], human_SensibleHeat_VDI2078.Schedule) annotation (
      Line(points={{80,-113.333},{80,-60},{32,-60},{32,8.9},{40.9,8.9}}, color={
          0,0,127}));
  connect(internalGains[2], machines_SensibleHeat_DIN18599.Schedule)
    annotation (Line(points={{80,-100},{80,-100},{80,-60},{32,-60},{32,-10.5},{41,
          -10.5}}, color={0,0,127}));
  connect(internalGains[3], lights.Schedule) annotation (Line(points={{80,
          -86.6667},{80,-60},{32,-60},{32,-30.5},{41,-30.5}},
                                                    color={0,0,127}));
  connect(lights.ConvHeat, buildingPhysics.internalGainsConv) annotation (
      Line(points={{59,-24.8},{80,-24.8},{80,-52},{8,-52},{8,2}}, color={191,0,
          0}));
  connect(machines_SensibleHeat_DIN18599.ConvHeat, buildingPhysics.internalGainsConv)
    annotation (Line(points={{59,-4.8},{80,-4.8},{80,-52},{8,-52},{8,2}}, color=
         {191,0,0}));
  connect(human_SensibleHeat_VDI2078.ConvHeat, buildingPhysics.internalGainsConv)
    annotation (Line(points={{59,15},{80,15},{80,-52},{8,-52},{8,2}}, color={
          191,0,0}));
  connect(human_SensibleHeat_VDI2078.TRoom, buildingPhysics.internalGainsConv)
    annotation (Line(points={{41,19},{41,26},{80,26},{80,-52},{8,-52},{8,2}},
        color={191,0,0}));
  connect(internalGainsRad, buildingPhysics.internalGainsRad) annotation (
      Line(points={{40,-58},{40,-58},{40,-70},{40,-66},{16,-66},{16,2}}, color=
          {95,95,95}));
  connect(lights.RadHeat, buildingPhysics.internalGainsRad) annotation (Line(
        points={{59,-36.01},{68,-36.01},{68,-46},{16,-46},{16,2}}, color={95,95,
          95}));
  connect(machines_SensibleHeat_DIN18599.RadHeat, buildingPhysics.internalGainsRad)
    annotation (Line(points={{59,-16.01},{68,-16.01},{68,-46},{16,-46},{16,2}},
        color={95,95,95}));
  connect(human_SensibleHeat_VDI2078.RadHeat, buildingPhysics.internalGainsRad)
    annotation (Line(points={{59,9},{68,9},{68,-46},{16,-46},{16,2}}, color={95,
          95,95}));
  annotation(Documentation(info="<html>
<p>This model combines building physics and models for internal gains. It is thought as a ready-to-use thermal zone model. For convenience, all parameters are collected in a record (see<a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\"> ZoneBaseRecord</a>). </p>
<p><br/><b>References</b> </p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<p><b>Example Results</b> </p>
<p>See <a href=\"Examples\">Examples</a>.</p>
</html>",  revisions = "<html>
 <ul>
   <li><i>March, 2012&nbsp;</i>
          by Moritz Lauster:<br/>
          Implemented</li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end ThermalZone;
