within AixLib.ThermalZones.HighOrder.Validation.EmpiricalValidation;
model Building1
    extends Modelica.Icons.Example;
  Rooms.RoomEmpiricalValidation.RoomBuilding1 room(
    TWalls_start=T0,
    roof(
      redeclare model Window = Components.WindowsDoors.WindowSimple (WindowType=
             AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple(),
            redeclare model correctionSolarGain =
              AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoCorG
              (WindowType=
                  AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple(
                  Uw=1.5,
                  g=0.8,
                  frameFraction=0.1))),
      WindowType=
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple(
          Uw=1.5,
          g=0.8,
          frameFraction=0.1),
      T0=T0),
    floor(T0=T0),
    redeclare DataBase.Walls.Collections.EmpricalValidation.Building1 wallTypes,
    T0_air=283.15,
    calcMethodIn=3,
    solar_absorptance_OW=solar_absorptance_OW,
    calcMethodOut=1,
    use_infiltEN12831=true,
    n50=0.1,
    eps=1.2,
    wallWest(T0=T0),
    wallNorth(T0=T0),
    wallEast(T0=T0),
    wallSouth(T0=T0),
    heatCapacitor(T(start=T0)))
    annotation (Placement(transformation(extent={{2,-30},{68,42}})));

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
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "Air exchange due to windows in the roof area, {2} Temp in the Building (Top), {3} Temp in the Building (Center), {4} Temp in the Building (Bottom), {5} Air exchange due to windows in the roof"
    annotation (Placement(transformation(extent={{-96,-58},{-76,-38}})));
  Modelica.Blocks.Interfaces.RealOutput roomTemperature
    annotation (Placement(transformation(extent={{168,82},{188,102}})));
  Modelica.Blocks.Interfaces.RealOutput TemperatureTopRoom
    annotation (Placement(transformation(extent={{168,50},{188,70}})));
  Modelica.Blocks.Interfaces.RealOutput outsideTemperature
    annotation (Placement(transformation(extent={{168,66},{188,86}})));
  Modelica.Blocks.Interfaces.RealOutput RoomTemperatureBottom
    annotation (Placement(transformation(extent={{168,18},{188,38}})));
  Modelica.Blocks.Interfaces.RealOutput RoomTemperatureCenter
    annotation (Placement(transformation(extent={{168,34},{188,54}})));
  Modelica.Blocks.Sources.RealExpression roomTemp(y=room.airload.T)
    annotation (Placement(transformation(extent={{112,82},{126,98}})));
  Modelica.Blocks.Sources.RealExpression ambientTemp(y=room.thermOutside.T)
    annotation (Placement(transformation(extent={{112,66},{126,82}})));
  Modelica.Blocks.Sources.RealExpression tempTop(y=RWD.y[1])
    annotation (Placement(transformation(extent={{112,52},{126,68}})));
  Modelica.Blocks.Sources.RealExpression tempCenter(y=RWD.y[2])
    annotation (Placement(transformation(extent={{112,36},{126,52}})));
  Modelica.Blocks.Sources.RealExpression tempBottom(y=RWD.y[3])
    annotation (Placement(transformation(extent={{112,20},{126,36}})));

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
    annotation (Placement(transformation(extent={{110,-88},{97,-75}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    annotation (Placement(transformation(extent={{148,86},{158,96}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC1
    annotation (Placement(transformation(extent={{148,70},{158,80}})));

  parameter Real solar_absorptance_OW=0.3 "Solar absoptance outer walls ";
  parameter Modelica.SIunits.Temperature T0=284.15 "Initial temperature";

  Modelica.Blocks.Sources.RealExpression Cool(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{112,0},{126,16}})));
  Modelica.Blocks.Interfaces.RealOutput coolingPower
    annotation (Placement(transformation(extent={{150,-2},{170,18}})));
  Modelica.Blocks.Sources.RealExpression Heat(y=idealHeaterCooler.heatingPower)
    annotation (Placement(transformation(extent={{112,-32},{126,-16}})));
  Modelica.Blocks.Interfaces.RealOutput heatingPower
    annotation (Placement(transformation(extent={{168,-34},{188,-14}})));
  Modelica.Blocks.Interfaces.RealOutput coolingEnergy
    annotation (Placement(transformation(extent={{168,-18},{188,2}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingEnergy
    annotation (Placement(transformation(extent={{168,-50},{188,-30}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh
    annotation (Placement(transformation(extent={{152,-12},{162,-2}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh1
    annotation (Placement(transformation(extent={{152,-46},{162,-36}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{135,-11.5},{144,-2}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{137,-45.5},{146,-36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}})));
  Modelica.Blocks.Sources.CombiTimeTable Room(
    tableOnFile=false,
    table=[0,0,0; 25200,0,0; 25200,0.25,16.5; 57600,0.25,16.5; 57600,0,0; 86400,
        0,0],
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Air exchange due to open Door in the Room next to Building1, RoomTemp=16.5°C"
    annotation (Placement(transformation(extent={{-96,-90},{-76,-70}})));
  Modelica.Blocks.Sources.Constant Source_TsetC1(k=273.15 + 16.5)
    annotation (Placement(transformation(extent={{-68,-108},{-55,-95}})));

equation
  connect(weather.AirTemp, outsideTemp.T) annotation (Line(points={{-55,79},{
          -40,79},{-40,80.5},{-31.1,80.5}},
                                        color={0,0,127}));
  connect(tempTop.y, TemperatureTopRoom)
    annotation (Line(points={{126.7,60},{178,60}}, color={0,0,127}));
  connect(tempCenter.y, RoomTemperatureCenter)
    annotation (Line(points={{126.7,44},{178,44}}, color={0,0,127}));
  connect(tempBottom.y, RoomTemperatureBottom)
    annotation (Line(points={{126.7,28},{178,28}}, color={0,0,127}));

  connect(weather.WindSpeed, room.WindSpeedPort) annotation (Line(points={{-55,82},
          {-46,82},{-46,4},{-1.3,4},{-1.3,16.8}},  color={0,0,127}));
  connect(idealHeaterCooler.heatCoolRoom, room.thermRoom) annotation (Line(
        points={{79,-64},{90,-64},{90,-54},{74,-54},{74,12},{30.38,12},{30.38,6}},
        color={191,0,0}));
  connect(room.SolarRadiationPort, weather.SolarRadiation_OrientedSurfaces)
    annotation (Line(points={{-1.3,26.88},{-78.8,26.88},{-78.8,65}},  color={255,
          128,0}));
  connect(Source_TsetC.y, idealHeaterCooler.setPointCool) annotation (Line(
        points={{45.65,-81.5},{67.6,-81.5},{67.6,-67.2}}, color={0,0,127}));
  connect(Source_TsetH.y, idealHeaterCooler.setPointHeat) annotation (Line(
        points={{96.35,-81.5},{72.2,-81.5},{72.2,-67.2}}, color={0,0,127}));
  connect(outsideTemp.port, room.thermOutside) annotation (Line(points={{-19,
          80.5},{2,80.5},{2,41.28}},     color={191,0,0}));
  connect(roomTemp.y, to_degC.u) annotation (Line(points={{126.7,90},{130,90},{
          130,91},{147,91}}, color={0,0,127}));
  connect(roomTemperature, to_degC.y) annotation (Line(points={{178,92},{162,92},
          {162,91},{158.5,91}}, color={0,0,127}));
  connect(ambientTemp.y, to_degC1.u) annotation (Line(points={{126.7,74},{130,
          74},{130,75},{147,75}}, color={0,0,127}));
  connect(outsideTemperature, to_degC1.y) annotation (Line(points={{178,76},{
          172,76},{172,75},{158.5,75}}, color={0,0,127}));
  connect(Cool.y, coolingPower)
    annotation (Line(points={{126.7,8},{160,8}}, color={0,0,127}));
  connect(Heat.y, heatingPower)
    annotation (Line(points={{126.7,-24},{178,-24}}, color={0,0,127}));
  connect(coolingEnergy, to_kWh.y) annotation (Line(points={{178,-8},{172,-8},{
          172,-7},{162.5,-7}}, color={0,0,127}));
  connect(HeatingEnergy, to_kWh1.y) annotation (Line(points={{178,-40},{172,-40},
          {172,-41},{162.5,-41}},
                             color={0,0,127}));
  connect(heatingPower, heatingPower)
    annotation (Line(points={{178,-24},{178,-24}},
                                               color={0,0,127}));
  connect(heatingPower, integrator2.u) annotation (Line(points={{178,-24},{134,
          -24},{134,-40.75},{136.1,-40.75}},
                                    color={0,0,127}));
  connect(to_kWh1.u, integrator2.y) annotation (Line(points={{151,-41},{150,-41},
          {150,-40.75},{146.45,-40.75}},
                                    color={0,0,127}));
  connect(coolingPower, integrator1.u) annotation (Line(points={{160,8},{134.1,
          8},{134.1,-6.75}},  color={0,0,127}));
  connect(integrator1.y, to_kWh.u) annotation (Line(points={{144.45,-6.75},{
          150.225,-6.75},{150.225,-7},{151,-7}}, color={0,0,127}));
  connect(room.AirExchangePort, RWD.y[4]) annotation (Line(points={{-1.3,31.02},
          {-72,31.02},{-72,-50},{-75,-50},{-75,-48}}, color={0,0,127}));
  connect(Room.y[1], room.AirExchangePortRoom) annotation (Line(points={{-75,
          -80},{-56,-80},{-56,-18.66},{-1.3,-18.66}}, color={0,0,127}));
  connect(prescribedTemperature.port, room.thermRoomNextDoor) annotation (Line(
        points={{-20,-100},{-18,-100},{-18,-28.56},{0.68,-28.56}}, color={191,0,
          0}));
  connect(Source_TsetC1.y, prescribedTemperature.T) annotation (Line(points={{
          -54.35,-101.5},{-49.175,-101.5},{-49.175,-100},{-42,-100}}, color={0,
          0,127}));
  connect(RoomTemperatureBottom, RoomTemperatureBottom)
    annotation (Line(points={{178,28},{178,28}}, color={0,0,127}));
  connect(roomTemperature, roomTemperature)
    annotation (Line(points={{178,92},{178,92}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-120},{180,100}})),
    Icon(coordinateSystem(extent={{-100,-120},{180,100}})));
end Building1;
