within AixLib.ThermalZones.HighOrder.Validation.EmpiricalValidation;
model Warehouse
  import ModelicaServices;
    extends Modelica.Icons.Example;
  Rooms.RoomEmpiricalValidation.RoomWarehouse room(
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=283.15,
    TWalls_start=283.15,
    redeclare model WindowModel = Components.WindowsDoors.WindowSimple,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_Warehouse Type_Win,
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple)
    annotation (Placement(transformation(extent={{2,-30},{68,42}})));

  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather weather(
    Latitude=52.37,
    Longitude=8.44,
    tableName="weather",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/TRY2010_03_Warehouse.txt"),
    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true)
    annotation (Placement(transformation(extent={{-90,78},{-60,98}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp
    "ambient temperature"
    annotation (Placement(transformation(extent={{-38,85},{-27,96}})));
  Modelica.Blocks.Sources.CombiTimeTable BuildingSpecifications(
    tableOnFile=true,
    tableName="Table",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/ThermalZones/HighOrder/Validation/EmpiricalValidation/Warehouse.mat"),
    columns={2,3,4,5},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "Air exchange due to windows in the roof area, {2} Temp in the Building (Top), {3} Temp in the Building (Center), {4} Temp in the Building (Bottom), {5} Air exchange due to windows in the roof"
    annotation (Placement(transformation(extent={{-96,-22},{-78,-4}})));
  Modelica.Blocks.Interfaces.RealOutput roomTemp
    annotation (Placement(transformation(extent={{148,82},{168,102}})));
  Modelica.Blocks.Interfaces.RealOutput roomTempTop
    annotation (Placement(transformation(extent={{148,50},{168,70}})));
  Modelica.Blocks.Interfaces.RealOutput roomTempCenter
    annotation (Placement(transformation(extent={{148,34},{168,54}})));
  Modelica.Blocks.Interfaces.RealOutput roomTempBottom
    annotation (Placement(transformation(extent={{148,18},{168,38}})));
  Modelica.Blocks.Interfaces.RealOutput ambientTemp
    annotation (Placement(transformation(extent={{148,66},{168,86}})));
  Modelica.Blocks.Sources.RealExpression roomTempExpression(y=room.airload.T)
    annotation (Placement(transformation(extent={{92,82},{106,98}})));
  Modelica.Blocks.Sources.RealExpression tempTop(y=BuildingSpecifications.y[1])
    annotation (Placement(transformation(extent={{92,52},{106,68}})));
  Modelica.Blocks.Sources.RealExpression tempCenter(y=BuildingSpecifications.y[2])
    annotation (Placement(transformation(extent={{92,36},{106,52}})));
  Modelica.Blocks.Sources.RealExpression tempBottom(y=BuildingSpecifications.y[3])
    annotation (Placement(transformation(extent={{92,20},{106,36}})));
  Modelica.Blocks.Sources.RealExpression ambientTempExpression(y=room.thermOutside.T)
    annotation (Placement(transformation(extent={{92,66},{106,82}})));

  Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler(
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000,
    recOrSep=false)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Modelica.Blocks.Sources.Constant Source_TsetC(k=273.15 + 25)
    annotation (Placement(transformation(extent={{2,-88},{15,-75}})));
  Modelica.Blocks.Sources.Constant Source_TsetH(k=273.15 + 4)
    annotation (Placement(transformation(extent={{80,-88},{67,-75}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    annotation (Placement(transformation(extent={{128,86},{138,96}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC1
    annotation (Placement(transformation(extent={{128,70},{138,80}})));

  parameter Real solar_absorptance_OW=0.4 "Solar absoptance outer walls ";

  Modelica.Blocks.Sources.RealExpression Cool(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{90,-24},{104,-8}})));
  Modelica.Blocks.Interfaces.RealOutput coolingPower
    annotation (Placement(transformation(extent={{128,-26},{148,-6}})));
  Modelica.Blocks.Sources.RealExpression Heat(y=idealHeaterCooler.heatingPower)
    annotation (Placement(transformation(extent={{90,-56},{104,-40}})));
  Modelica.Blocks.Interfaces.RealOutput heatingPower
    annotation (Placement(transformation(extent={{146,-58},{166,-38}})));
  Modelica.Blocks.Interfaces.RealOutput coolingEnergy
    annotation (Placement(transformation(extent={{146,-42},{166,-22}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingEnergy
    annotation (Placement(transformation(extent={{146,-74},{166,-54}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh
    annotation (Placement(transformation(extent={{130,-36},{140,-26}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh1
    annotation (Placement(transformation(extent={{130,-70},{140,-60}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{113,-35.5},{122,-26}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{115,-69.5},{124,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-52,-84},{-40,-72}})));
  Modelica.Blocks.Sources.CombiTimeTable Room(
    tableOnFile=false,
    table=[0,0; 25200,0; 25200,0.25; 57600,0.25; 57600,0; 86400,0],
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Air exchange due to open door in the room next to Warehouse main room, RoomTemp = 16.5 degC"
    annotation (Placement(transformation(extent={{-96,-46},{-78,-28}})));
  Modelica.Blocks.Sources.Constant Source_TsetC1(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-94,-86},{-78,-70}})));

  Modelica.Blocks.Sources.RealExpression MeasuredTemperatures(y=
        BuildingSpecifications.y[1] + BuildingSpecifications.y[2] +
        BuildingSpecifications.y[3])
    annotation (Placement(transformation(extent={{92,4},{106,20}})));
  Modelica.Blocks.Interfaces.RealOutput meanMeasuredTemp
    annotation (Placement(transformation(extent={{148,2},{168,22}})));
  Modelica.Blocks.Math.Gain gain(k=1/3)
    annotation (Placement(transformation(extent={{122,6},{134,18}})));
equation
  connect(weather.AirTemp, outsideTemp.T) annotation (Line(points={{-59,91},{
          -40,91},{-40,90.5},{-39.1,90.5}},
                                        color={0,0,127}));
  connect(tempTop.y, roomTempTop) annotation (Line(points={{106.7,60},{158,60}}, color={0,0,127}));
  connect(tempCenter.y, roomTempCenter) annotation (Line(points={{106.7,44},{158,44}}, color={0,0,127}));
  connect(tempBottom.y, roomTempBottom) annotation (Line(points={{106.7,28},{158,28}}, color={0,0,127}));

  connect(weather.WindSpeed, room.WindSpeedPort) annotation (Line(points={{-59,94},
          {-46,94},{-46,16},{-1.3,16},{-1.3,16.8}},color={0,0,127}));
  connect(idealHeaterCooler.heatCoolRoom, room.thermRoom) annotation (Line(
        points={{49,-64},{60,-64},{60,14},{30.38,14},{30.38,6}},
        color={191,0,0}));
  connect(room.SolarRadiationPort, weather.SolarRadiation_OrientedSurfaces)
    annotation (Line(points={{-1.3,26.88},{-82.8,26.88},{-82.8,77}},  color={255,
          128,0}));
  connect(Source_TsetC.y, idealHeaterCooler.setPointCool) annotation (Line(
        points={{15.65,-81.5},{37.6,-81.5},{37.6,-67.2}}, color={0,0,127}));
  connect(Source_TsetH.y, idealHeaterCooler.setPointHeat) annotation (Line(
        points={{66.35,-81.5},{42.2,-81.5},{42.2,-67.2}}, color={0,0,127}));
  connect(outsideTemp.port, room.thermOutside) annotation (Line(points={{-27,
          90.5},{2,90.5},{2,41.28}},     color={191,0,0}));
  connect(roomTempExpression.y, to_degC.u) annotation (Line(points={{106.7,90},{110,90},{110,91},{127,91}}, color={0,0,127}));
  connect(roomTemp, to_degC.y) annotation (Line(points={{158,92},{142,92},{142,91},{138.5,91}}, color={0,0,127}));
  connect(ambientTempExpression.y, to_degC1.u) annotation (Line(points={{106.7,74},{110,74},{110,75},{127,75}}, color={0,0,127}));
  connect(ambientTemp, to_degC1.y) annotation (Line(points={{158,76},{152,76},{152,75},{138.5,75}}, color={0,0,127}));
  connect(Cool.y, coolingPower)
    annotation (Line(points={{104.7,-16},{138,-16}},
                                                 color={0,0,127}));
  connect(Heat.y, heatingPower)
    annotation (Line(points={{104.7,-48},{156,-48}}, color={0,0,127}));
  connect(coolingEnergy, to_kWh.y) annotation (Line(points={{156,-32},{150,-32},
          {150,-31},{140.5,-31}},
                               color={0,0,127}));
  connect(HeatingEnergy, to_kWh1.y) annotation (Line(points={{156,-64},{150,-64},
          {150,-65},{140.5,-65}},
                             color={0,0,127}));
  connect(heatingPower, heatingPower)
    annotation (Line(points={{156,-48},{156,-48}},
                                               color={0,0,127}));
  connect(heatingPower, integrator2.u) annotation (Line(points={{156,-48},{112,
          -48},{112,-64.75},{114.1,-64.75}},
                                    color={0,0,127}));
  connect(to_kWh1.u, integrator2.y) annotation (Line(points={{129,-65},{128,-65},
          {128,-64.75},{124.45,-64.75}},
                                    color={0,0,127}));
  connect(coolingPower, integrator1.u) annotation (Line(points={{138,-16},{
          112.1,-16},{112.1,-30.75}},
                              color={0,0,127}));
  connect(integrator1.y, to_kWh.u) annotation (Line(points={{122.45,-30.75},{
          128.225,-30.75},{128.225,-31},{129,-31}},
                                                 color={0,0,127}));
  connect(room.AirExchangePort, BuildingSpecifications.y[4]) annotation (Line(
        points={{-1.3,31.02},{-72,31.02},{-72,-13},{-77.1,-13}}, color={0,0,127}));
  connect(Room.y[1], room.AirExchangePortRoom) annotation (Line(points={{-77.1,
          -37},{-56,-37},{-56,-18.66},{-1.3,-18.66}}, color={0,0,127}));
  connect(prescribedTemperature.port, room.thermRoomNextDoor) annotation (Line(
        points={{-40,-78},{-18,-78},{-18,-28.56},{0.68,-28.56}},   color={191,0,
          0}));
  connect(Source_TsetC1.y, prescribedTemperature.T) annotation (Line(points={{-77.2,
          -78},{-53.2,-78}},                                          color={0,
          0,127}));
  connect(roomTempBottom, roomTempBottom) annotation (Line(points={{158,28},{158,28}}, color={0,0,127}));
  connect(roomTemp, roomTemp) annotation (Line(points={{158,92},{158,92}}, color={0,0,127}));
  connect(MeasuredTemperatures.y, gain.u)
    annotation (Line(points={{106.7,12},{120.8,12}}, color={0,0,127}));
  connect(gain.y, meanMeasuredTemp) annotation (Line(points={{134.6,12},{158,12}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/EmpiricalValidation/Warehouse.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(extent={{-100,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{160,100}})),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Building 1 is part of an empirical validation according to an
  internal monitoring study with permission to use data anonymized.<br/>
  Specifications are:
</p>
<ul>
  <li>length = 72 m
  </li>
  <li>heigth = 22 m
  </li>
  <li>width = 22 m
  </li>
  <li>no windows, except for 60m² window area on the ceiling (smoke
  ventilation windows)
  </li>
</ul>
<p>
  <br/>
  Air exchange rates:
</p>
<ul>
  <li>n50 = 0.1 1/h, due to air leakage
  </li>
  <li>n = 1 1/h, due to air exchange caused by open ventilation windows
  (opening schedule in Building specifications{5})
  </li>
  <li>n = 0.25 1/h, due to air exchange caused by open door to room
  next to building 1 (schedule 7 am - 4 pm)
  </li>
</ul>
<p>
  <br/>
  Building specifications give information about:
</p>
<ul>
  <li>{2} measured room temperatur in the building: temperature sensor
  at the top
  </li>
  <li>{3} measured room temperatur in the building: temperature sensor
  at the center
  </li>
  <li>{4} measured room temperatur in the building: temperature sensor
  at the bottom
  </li>
  <li>{5} air exchange due to windows (smoke ventilation windows) in
  the ceiling
  </li>
</ul>
<p>
  <br/>
  Assumptions:
</p>
<ul>
  <li>30 &amp;percnt; of the volume is constantly filled with goods and
  shelves
  </li>
  <li>Internal capacity: 2100000 kg, specific heat capacity: 2000 J/kg
  </li>
</ul>
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
end Warehouse;
