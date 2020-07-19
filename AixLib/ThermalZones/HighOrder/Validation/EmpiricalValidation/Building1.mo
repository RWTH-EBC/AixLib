within AixLib.ThermalZones.HighOrder.Validation.EmpiricalValidation;
model Building1
  EmpiricalValidation.RoomEmpiricalValidation.Room room(
    roof(T0=283.15),
    floor(T0=283.15),
    redeclare DataBase.Walls.Collections.EmpricalValidation.Building1 wallTypes,

    T0_air=283.15,
    TWalls_start=283.15,
    calcMethodIn=3,
    solar_absorptance_OW=solar_absorptance_OW,
    calcMethodOut=3,
    use_infiltEN12831=false,
    n50=0.1,
    eps=1.2,
    wallWest(T0=283.15),
    wallNorth(T0=283.15),
    wallEast(T0=283.15),
    wallSouth(T0=283.15))
    annotation (Placement(transformation(extent={{-10,-44},{56,28}})));

  BoundaryConditions.WeatherData.Old.WeatherTRY.Weather weather(
    Latitude=52.37,
    Longitude=8.44,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2010_03_Building1.txt"),
    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true)
    annotation (Placement(transformation(extent={{-86,66},{-56,86}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp
    "ambient temperature"
    annotation (Placement(transformation(extent={{-30,75},{-19,86}})));
  Modelica.Blocks.Sources.CombiTimeTable RWD(
    tableOnFile=true,
    tableName="Table",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/Building1.mat"),
    columns={2,3,4,5},
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-92,-58},{-72,-38}})));
  Modelica.Blocks.Interfaces.RealOutput roomTemp
    annotation (Placement(transformation(extent={{88,82},{108,102}})));
  Modelica.Blocks.Interfaces.RealOutput hallenTempOben
    annotation (Placement(transformation(extent={{90,54},{110,74}})));
  Modelica.Blocks.Interfaces.RealOutput ousideTemp
    annotation (Placement(transformation(extent={{88,68},{108,88}})));
  Modelica.Blocks.Interfaces.RealOutput hallenTempUnten
    annotation (Placement(transformation(extent={{88,26},{108,46}})));
  Modelica.Blocks.Interfaces.RealOutput hallenTempMitte
    annotation (Placement(transformation(extent={{88,38},{108,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=room.airload.T)
    annotation (Placement(transformation(extent={{54,84},{68,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=room.thermOutside.T)
    annotation (Placement(transformation(extent={{54,72},{68,88}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=RWD.y[1])
    annotation (Placement(transformation(extent={{54,58},{68,74}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=RWD.y[2])
    annotation (Placement(transformation(extent={{54,46},{68,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=RWD.y[3])
    annotation (Placement(transformation(extent={{54,30},{68,46}})));

  Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler(
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000,
    recOrSep=false)
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Sources.Constant Source_TsetC(k=273.15 + 25)
    annotation (Placement(transformation(extent={{32,-88},{45,-75}})));
  Modelica.Blocks.Sources.Constant Source_TsetH(k=273.15 + 4)
    annotation (Placement(transformation(extent={{102,-90},{89,-77}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    annotation (Placement(transformation(extent={{74,88},{82,96}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC1
    annotation (Placement(transformation(extent={{74,76},{82,84}})));
  Modelica.Blocks.Sources.Constant n50(k=0.1)
    annotation (Placement(transformation(extent={{-92,-26},{-72,-6}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-56,-34},{-36,-14}})));
  parameter Real solar_absorptance_OW=0.3 "Solar absoptance outer walls ";
  Modelica.Blocks.Sources.RealExpression realExpression4(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{92,16},{106,32}})));
  Modelica.Blocks.Interfaces.RealOutput coolingPower
    annotation (Placement(transformation(extent={{120,14},{140,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=idealHeaterCooler.heatingPower)
    annotation (Placement(transformation(extent={{92,0},{106,16}})));
  Modelica.Blocks.Interfaces.RealOutput heatingPower
    annotation (Placement(transformation(extent={{120,-2},{140,18}})));
  Modelica.Blocks.Interfaces.RealOutput coolingEnergy
    annotation (Placement(transformation(extent={{166,14},{186,34}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingEnergy
    annotation (Placement(transformation(extent={{168,-4},{188,16}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh
    annotation (Placement(transformation(extent={{152,18},{162,28}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh1
    annotation (Placement(transformation(extent={{152,0},{162,10}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{135,18.5},{144,28}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{135,0.5},{144,10}})));
equation
  connect(weather.AirTemp, outsideTemp.T) annotation (Line(points={{-55,79},{
          -40,79},{-40,80.5},{-31.1,80.5}},
                                        color={0,0,127}));
  connect(realExpression2.y, hallenTempOben) annotation (Line(points={{68.7,66},
          {84,66},{84,64},{100,64}}, color={0,0,127}));
  connect(realExpression3.y, hallenTempMitte) annotation (Line(points={{68.7,54},
          {80,54},{80,48},{98,48}}, color={0,0,127}));
  connect(realExpression5.y, hallenTempUnten)
    annotation (Line(points={{68.7,38},{98,38},{98,36}}, color={0,0,127}));

  connect(weather.WindSpeed, room.WindSpeedPort) annotation (Line(points={{-55,82},
          {-46,82},{-46,4},{-13.3,4},{-13.3,2.8}}, color={0,0,127}));
  connect(idealHeaterCooler.heatCoolRoom, room.thermRoom) annotation (Line(
        points={{79,-64},{90,-64},{90,-54},{74,-54},{74,12},{18.38,12},{18.38,
          -8}},
        color={191,0,0}));
  connect(room.SolarRadiationPort, weather.SolarRadiation_OrientedSurfaces)
    annotation (Line(points={{-13.3,12.88},{-78.8,12.88},{-78.8,65}}, color={255,
          128,0}));
  connect(Source_TsetC.y, idealHeaterCooler.setPointCool) annotation (Line(
        points={{45.65,-81.5},{67.6,-81.5},{67.6,-67.2}}, color={0,0,127}));
  connect(Source_TsetH.y, idealHeaterCooler.setPointHeat) annotation (Line(
        points={{88.35,-83.5},{72.2,-83.5},{72.2,-67.2}}, color={0,0,127}));
  connect(outsideTemp.port, room.thermOutside) annotation (Line(points={{-19,
          80.5},{-10,80.5},{-10,27.28}}, color={191,0,0}));
  connect(realExpression.y, to_degC.u)
    annotation (Line(points={{68.7,92},{73.2,92}}, color={0,0,127}));
  connect(roomTemp, to_degC.y)
    annotation (Line(points={{98,92},{82.4,92}}, color={0,0,127}));
  connect(realExpression1.y, to_degC1.u)
    annotation (Line(points={{68.7,80},{73.2,80}}, color={0,0,127}));
  connect(ousideTemp, to_degC1.y) annotation (Line(points={{98,78},{90,78},{90,
          80},{82.4,80}}, color={0,0,127}));
  connect(n50.y, add.u1) annotation (Line(points={{-71,-16},{-64,-16},{-64,-18},
          {-58,-18}}, color={0,0,127}));
  connect(RWD.y[4], add.u2) annotation (Line(points={{-71,-48},{-64,-48},{-64,
          -30},{-58,-30}}, color={0,0,127}));
  connect(add.y, room.AirExchangePort) annotation (Line(points={{-35,-24},{-26,
          -24},{-26,17.02},{-13.3,17.02}}, color={0,0,127}));
  connect(realExpression4.y, coolingPower)
    annotation (Line(points={{106.7,24},{130,24}}, color={0,0,127}));
  connect(realExpression6.y, heatingPower)
    annotation (Line(points={{106.7,8},{130,8}}, color={0,0,127}));
  connect(coolingEnergy, to_kWh.y) annotation (Line(points={{176,24},{170,24},{
          170,23},{162.5,23}}, color={0,0,127}));
  connect(HeatingEnergy, to_kWh1.y) annotation (Line(points={{178,6},{170,6},{
          170,5},{162.5,5}}, color={0,0,127}));
  connect(heatingPower, heatingPower)
    annotation (Line(points={{130,8},{130,8}}, color={0,0,127}));
  connect(heatingPower, integrator2.u) annotation (Line(points={{130,8},{132,8},
          {132,5.25},{134.1,5.25}}, color={0,0,127}));
  connect(to_kWh1.u, integrator2.y) annotation (Line(points={{151,5},{148,5},{
          148,5.25},{144.45,5.25}}, color={0,0,127}));
  connect(coolingPower, integrator1.u) annotation (Line(points={{130,24},{134.1,
          24},{134.1,23.25}}, color={0,0,127}));
  connect(integrator1.y, to_kWh.u) annotation (Line(points={{144.45,23.25},{
          148.225,23.25},{148.225,23},{151,23}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-120},{180,100}})),
    Icon(coordinateSystem(extent={{-100,-120},{180,100}})));
end Building1;
