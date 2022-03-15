within AixLib.ThermalZones.HighOrder.Validation.EmpiricalValidation;
model TwinHouseN2
   extends Modelica.Icons.Example;
  Rooms.RoomEmpiricalValidation.RoomTwinHouseN2 roomTwinHouseN2(
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=303.15,
    TWalls_start=303.15,
    calcMethodIn=1,
    redeclare model WindowModel = Components.WindowsDoors.Window_ASHRAE140,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_TwinHouses Type_Win,
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    solar_absorptance_OW=0.23,
    use_infiltEN12831=true,
    n50=1.62,
    room_V=212,
    room_height=2.6,
    room_width=10)
    annotation (Placement(transformation(extent={{36,-44},{96,26}})));
  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather weather(
    Latitude=47.874,
    Longitude=11.728,
    GroundReflection=0.23,
    tableName="weather",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TRY2013_03_TwinHouses.txt"),
    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true)
    annotation (Placement(transformation(extent={{-90,74},{-60,94}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp
    "ambient temperature"
    annotation (Placement(transformation(extent={{-52,73},{-41,84}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Temp
    annotation (Placement(transformation(extent={{40,-157},{51,-146}})));
  Modelica.Blocks.Sources.CombiTimeTable TempCellar(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TwinHouseN2.mat"),
    columns={4})
    annotation (Placement(transformation(extent={{-20,-160},{0,-140}})));
  Modelica.Blocks.Interfaces.RealOutput roomTemp
    annotation (Placement(transformation(extent={{168,80},{188,100}})));
  Modelica.Blocks.Interfaces.RealOutput ambientTemp
    annotation (Placement(transformation(extent={{168,62},{188,82}})));
  Modelica.Blocks.Sources.RealExpression room(y=roomTwinHouseN2.airload.T)
    annotation (Placement(transformation(extent={{114,82},{130,100}})));
  Modelica.Blocks.Sources.RealExpression ambTemp(y=roomTwinHouseN2.thermOutside.T)
    annotation (Placement(transformation(extent={{114,62},{130,80}})));
  Modelica.Blocks.Sources.CombiTimeTable TempAttic(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TwinHouseN2.mat"),
    columns={2,3})
    annotation (Placement(transformation(extent={{-96,26},{-76,46}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-62,32},{-48,46}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC1
    annotation (Placement(transformation(extent={{144,66},{154,76}})));
  Modelica.Blocks.Sources.CombiTimeTable HeatInput(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TwinHouseN2.mat"),
    columns={20,21,22,23,24,25,26}) "Heat input for every room"
    annotation (Placement(transformation(extent={{-94,-100},{-74,-80}})));
  Modelica.Blocks.Math.Sum sum1(nin=7)
    annotation (Placement(transformation(extent={{-64,-100},{-44,-80}})));
  Modelica.Blocks.Sources.CombiTimeTable VentilationRate(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TwinHouseN2.mat"),
    columns={31}) "Ventilation rate caused by mechanical ventilation system"
    annotation (Placement(transformation(extent={{-96,-12},{-80,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Temp3
    annotation (Placement(transformation(extent={{-46,-39},{-35,-28}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-18,6},{-2,22}})));
  Modelica.Blocks.Math.Gain gain(k=1/(roomTwinHouseN2.room_V))
    annotation (Placement(transformation(extent={{-58,-8},{-48,2}})));
  Modelica.Blocks.Math.Gain gain1(k=1/2)
    annotation (Placement(transformation(extent={{-34,34},{-24,44}})));
  Modelica.Blocks.Sources.CombiTimeTable VentTemp(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TwinHouseN2.mat"),
    columns={29}) "Temperature for mechanical ventilation rate"
    annotation (Placement(transformation(extent={{-96,-40},{-80,-24}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC annotation(Placement(transformation(extent={{-14,34},
            {-4,44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Temp2
    annotation (Placement(transformation(extent={{4,33},{15,44}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1  annotation(Placement(transformation(extent={{-66,-38},
            {-56,-28}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC2  annotation(Placement(transformation(extent={{20,-156},
            {30,-146}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatConv
    annotation (Placement(transformation(extent={{-13,-88},{7,-68}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatRad
    annotation (Placement(transformation(extent={{-13,-102},{7,-82}})));
  Modelica.Blocks.Math.Gain Conv(k=0.7)
    annotation (Placement(transformation(extent={{-30,-80},{-20,-70}})));
  Modelica.Blocks.Math.Gain Rad(k=0.3)
    annotation (Placement(transformation(extent={{-30,-96},{-20,-86}})));
  Modelica.Blocks.Sources.CombiTimeTable MeasuredTemperatures(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TwinHouseN2.mat"),
    columns={5,6,7,8,9,10,11,12,13})
    "Measured temperatures for every roo, on the ground floor"
    annotation (Placement(transformation(extent={{104,32},{124,52}})));
  Modelica.Blocks.Interfaces.RealOutput N2_living_AT_h67cm
    annotation (Placement(transformation(extent={{168,36},{188,56}})));
  Modelica.Blocks.Interfaces.RealOutput N2_living_AT_h125cm
    annotation (Placement(transformation(extent={{168,24},{188,44}})));
  Modelica.Blocks.Interfaces.RealOutput N2_living_AT_h187cm
    annotation (Placement(transformation(extent={{168,10},{188,30}})));
  Modelica.Blocks.Interfaces.RealOutput N2_corridor_AT
    annotation (Placement(transformation(extent={{168,-2},{188,18}})));
  Modelica.Blocks.Interfaces.RealOutput N2_bath_AT
    annotation (Placement(transformation(extent={{168,-14},{188,6}})));
  Modelica.Blocks.Interfaces.RealOutput N2_child_AT
    annotation (Placement(transformation(extent={{168,-28},{188,-8}})));
  Modelica.Blocks.Interfaces.RealOutput N2_kitchen_AT
    annotation (Placement(transformation(extent={{168,-42},{188,-22}})));
  Modelica.Blocks.Interfaces.RealOutput N2_doorway_AT
    annotation (Placement(transformation(extent={{168,-56},{188,-36}})));
  Modelica.Blocks.Interfaces.RealOutput N2_bedroom_AT
    annotation (Placement(transformation(extent={{168,-70},{188,-50}})));
  Modelica.Blocks.Interfaces.RealOutput meanMeasuredTemp
    annotation (Placement(transformation(extent={{168,-108},{188,-88}})));
  Modelica.Blocks.Math.Sum sum2(nin=9, k={0.137307708,0.137307708,0.137307708,
        0.066838046,0.084710491,0.136981271,0.091076019,0.071489778,0.136981271})
    "RoomVolume/TotalVolume for each room"
    annotation (Placement(transformation(extent={{122,-108},{142,-88}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC2
    annotation (Placement(transformation(extent={{144,84},{154,94}})));
equation
  connect(weather.WindSpeed, roomTwinHouseN2.WindSpeedPort) annotation (Line(
        points={{-59,90},{28,90},{28,2.2},{33,2.2}},      color={0,0,127}));
  connect(weather.AirTemp, outsideTemp.T) annotation (Line(points={{-59,87},{
          -56,87},{-56,78.5},{-53.1,78.5}}, color={0,0,127}));
  connect(Temp.port, roomTwinHouseN2.Therm_ground) annotation (Line(points={{51,
          -151.5},{56.4,-151.5},{56.4,-42.6}}, color={191,0,0}));
  connect(TempAttic.y[1], add.u1) annotation (Line(points={{-75,36},{-68,36},{-68,
          43.2},{-63.4,43.2}},color={0,0,127}));
  connect(TempAttic.y[2], add.u2) annotation (Line(points={{-75,36},{-68,36},{-68,
          34.8},{-63.4,34.8}},color={0,0,127}));
  connect(to_degC1.u, ambTemp.y) annotation (Line(points={{143,71},{130.8,71}}, color={0,0,127}));
  connect(to_degC1.y, ambientTemp) annotation (Line(points={{154.5,71},{164.25,71},{164.25,72},{178,72}}, color={0,0,127}));
  connect(roomTwinHouseN2.SolarRadiationPort, weather.SolarRadiation_OrientedSurfaces)
    annotation (Line(points={{33,10.6},{34,10.6},{34,8},{28,8},{28,60},{-82.8,
          60},{-82.8,73}}, color={255,128,0}));
  connect(outsideTemp.port, roomTwinHouseN2.thermOutside) annotation (Line(
        points={{-41,78.5},{28,78.5},{28,25.3},{36,25.3}},   color={191,0,0}));
  connect(Temp3.port, roomTwinHouseN2.thermSUA) annotation (Line(points={{-35,
          -33.5},{-22,-33.5},{-22,-28.6},{33,-28.6}}, color={191,0,0}));
  connect(gain.y, roomTwinHouseN2.AirExchangeSUA) annotation (Line(points={{-47.5,
          -3},{-26,-3},{-26,-22},{33,-22},{33,-20.375}},
        color={0,0,127}));
  connect(HeatInput.y, sum1.u)
    annotation (Line(points={{-73,-90},{-66,-90}}, color={0,0,127}));
  connect(add.y, gain1.u)
    annotation (Line(points={{-47.3,39},{-35,39}}, color={0,0,127}));
  connect(gain1.y, from_degC.u)
    annotation (Line(points={{-23.5,39},{-15,39}}, color={0,0,127}));
  connect(from_degC.y, Temp2.T) annotation (Line(points={{-3.5,39},{0,39},{0,
          38.5},{2.9,38.5}}, color={0,0,127}));
  connect(Temp2.port, roomTwinHouseN2.Therm_Ceiling1) annotation (Line(points={{15,38.5},
          {55.2,38.5},{55.2,25.3}},           color={191,0,0}));
  connect(Temp3.T, from_degC1.y) annotation (Line(points={{-47.1,-33.5},{-48,
          -33.5},{-48,-33},{-55.5,-33}},
                                  color={0,0,127}));
  connect(from_degC1.u, VentTemp.y[1]) annotation (Line(points={{-67,-33},{-76,
          -33},{-76,-32},{-79.2,-32}},color={0,0,127}));
  connect(Temp.T, from_degC2.y) annotation (Line(points={{38.9,-151.5},{40,
          -151.5},{40,-151},{30.5,-151}},
                                    color={0,0,127}));
  connect(TempCellar.y[1], from_degC2.u) annotation (Line(points={{1,-150},{20,
          -150},{20,-151},{19,-151}},   color={0,0,127}));
  connect(HeatConv.port, roomTwinHouseN2.thermRoom) annotation (Line(points={{7,-78},
          {38,-78},{38,-9},{61.8,-9}},        color={191,0,0}));
  connect(sum1.y, Conv.u) annotation (Line(points={{-43,-90},{-40,-90},{-40,-75},
          {-31,-75}}, color={0,0,127}));
  connect(Conv.y, HeatConv.Q_flow) annotation (Line(points={{-19.5,-75},{-17.75,
          -75},{-17.75,-78},{-13,-78}}, color={0,0,127}));
  connect(sum1.y, Rad.u) annotation (Line(points={{-43,-90},{-38,-90},{-38,-91},
          {-31,-91}}, color={0,0,127}));
  connect(Rad.y, HeatRad.Q_flow) annotation (Line(points={{-19.5,-91},{-17.75,
          -91},{-17.75,-92},{-13,-92}}, color={0,0,127}));
  connect(HeatRad.port, roomTwinHouseN2.starRoom)
    annotation (Line(points={{7,-92},{70.8,-92},{70.8,-9}},  color={191,0,0}));
  connect(const.y, roomTwinHouseN2.AirExchangePort) annotation (Line(points={{
          -1.2,14},{24,14},{24,15.325},{33,15.325}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[1], N2_living_AT_h67cm) annotation (Line(
        points={{125,42},{148,42},{148,46},{178,46}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[2], N2_living_AT_h125cm) annotation (Line(
        points={{125,42},{148,42},{148,34},{178,34}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[3], N2_living_AT_h187cm) annotation (Line(
        points={{125,42},{148,42},{148,20},{178,20}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[4], N2_corridor_AT) annotation (Line(points={{
          125,42},{148,42},{148,8},{178,8}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[5], N2_bath_AT) annotation (Line(points={{125,
          42},{148,42},{148,-4},{178,-4}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[6], N2_child_AT) annotation (Line(points={{125,
          42},{148,42},{148,-18},{178,-18}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[7],N2_kitchen_AT)  annotation (Line(points={{
          125,42},{148,42},{148,-32},{178,-32}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[8],N2_doorway_AT)  annotation (Line(points={{
          125,42},{148,42},{148,-46},{178,-46}}, color={0,0,127}));
  connect(MeasuredTemperatures.y, sum2.u) annotation (Line(points={{125,42},{
          130,42},{130,-64},{108,-64},{108,-100},{120,-100},{120,-98}}, color={
          0,0,127}));
  connect(room.y, to_degC2.u) annotation (Line(points={{130.8,91},{134,91},{134,
          89},{143,89}}, color={0,0,127}));
  connect(roomTemp, to_degC2.y) annotation (Line(points={{178,90},{164,90},{164,89},{154.5,89}}, color={0,0,127}));
  connect(MeasuredTemperatures.y[9], N2_bedroom_AT) annotation (Line(points={{
          125,42},{148,42},{148,-60},{178,-60}}, color={0,0,127}));
  connect(sum2.y, meanMeasuredTemp) annotation (Line(points={{143,-98},{158,-98},{158,-98},{178,-98}}, color={0,0,127}));
  connect(VentilationRate.y[1], gain.u) annotation (Line(points={{-79.2,-4},{
          -70,-4},{-70,-3},{-59,-3}}, color={0,0,127}));
  annotation (experiment(StopTime=3546000, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/EmpiricalValidation/TwinHouseN2.mos"
        "Simulate and plot"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -160},{180,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{180,
            100}})),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Twin House N2 is part of the empirical validation:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/TwinHouse_GroundFloor.png\"
  alt=\"Room layout\">
</p><br/>
The Frauenhofer Institute for Building Physics (IBP) created two
identical full scale buildings in Holzkirchen Germany in the course of
reproducing building energy performances based on measurement data.<br/>
<br/>
The Twin House N2 was implemented as part of the IEA EBC Annex 58.<br/>
<p>
  Air exchange rates:
</p>
<ul>
  <li>n50 = 1.62 1/h due to air leakage
  </li>
  <li>n = 120 m3/h caused by mechanical ventilation system
  </li>
</ul>
<p>
  <br/>
  Building specifications give information about experimental schedule
  (temperatures are maintained through specified heat inputs in every
  room):
</p>
<ul>
  <li>Day 1-7: Initialization: constant 30°C in each room
  </li>
  <li>Day 8-14: Constant 30°C in each room
  </li>
  <li>Day 15-28:ROLBS sequence in living roomand no other heat inputs
  </li>
  <li>Day 29-35: Re-initialization constant 25°C in each room
  </li>
  <li>Day 36-42: Free-float temperatures
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">Known Limitations</span></b>
</p>
<p>
  The experiment takes place on the ground floor of Twin House N2.
  Measured temperatures within the cellar and attic are used as
  boundary conditions for the ground floor.
</p>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<ul>
  <li>Empirical Whole Model Validation, Modelling Specification Test
  Case Twin_House_1, IEA ECB Annex 58, Validation of Building Energy
  Simulation ToolsSubtask 4 Version 6
  </li>
  <li>IEA ECB Annex 58
  </li>
</ul>
</html>

<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the bathroom.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bath.png\"
  alt=\"Room layout\">
</p>
</html>",
   revisions="<html><ul>
  <li>October 1, 2020 by Konstantina Xanthopoulou:<br/>
    First Implementation.
  </li>
  <li style=\"list-style: none\">This is for <a href=
  \"https://github.com/RWTH-EBC/AixLib/issues/967\">#967</a>.
  </li>
</ul>
</html>"));
end TwinHouseN2;
