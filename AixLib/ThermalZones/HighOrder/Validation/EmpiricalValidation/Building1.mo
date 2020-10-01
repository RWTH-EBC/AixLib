within AixLib.ThermalZones.HighOrder.Validation.EmpiricalValidation;
model Building1
  import ModelicaServices;
    extends Modelica.Icons.Example;
  Rooms.RoomEmpiricalValidation.RoomBuilding1 room(T0_air=283.15, TWalls_start=283.15)
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
  Modelica.Blocks.Interfaces.RealOutput RoomTemperatureTop
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

  parameter Real solar_absorptance_OW=0.4 "Solar absoptance outer walls ";

  Modelica.Blocks.Sources.RealExpression Cool(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{110,-24},{124,-8}})));
  Modelica.Blocks.Interfaces.RealOutput coolingPower
    annotation (Placement(transformation(extent={{148,-26},{168,-6}})));
  Modelica.Blocks.Sources.RealExpression Heat(y=idealHeaterCooler.heatingPower)
    annotation (Placement(transformation(extent={{110,-56},{124,-40}})));
  Modelica.Blocks.Interfaces.RealOutput heatingPower
    annotation (Placement(transformation(extent={{166,-58},{186,-38}})));
  Modelica.Blocks.Interfaces.RealOutput coolingEnergy
    annotation (Placement(transformation(extent={{166,-42},{186,-22}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingEnergy
    annotation (Placement(transformation(extent={{166,-74},{186,-54}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh
    annotation (Placement(transformation(extent={{150,-36},{160,-26}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh to_kWh1
    annotation (Placement(transformation(extent={{150,-70},{160,-60}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{133,-35.5},{142,-26}})));
  Modelica.Blocks.Continuous.Integrator integrator2
    annotation (Placement(transformation(extent={{135,-69.5},{144,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}})));
  Modelica.Blocks.Sources.CombiTimeTable Room(
    tableOnFile=false,
    table=[0,0; 25200,0; 25200,0.25; 57600,0.25; 57600,0; 86400,0],
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Air exchange due to open Door in the Room next to Building1, RoomTemp=16.5°C"
    annotation (Placement(transformation(extent={{-98,-88},{-78,-68}})));
  Modelica.Blocks.Sources.Constant Source_TsetC1(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-68,-108},{-55,-95}})));

  Modelica.Blocks.Sources.RealExpression MeanMeasuredTemp(y=RWD.y[1] + RWD.y[2]
         + RWD.y[3])
    annotation (Placement(transformation(extent={{112,4},{126,20}})));
  Modelica.Blocks.Interfaces.RealOutput MeanMeasuredTemperature
    annotation (Placement(transformation(extent={{168,2},{188,22}})));
  Modelica.Blocks.Math.Gain gain(k=1/3)
    annotation (Placement(transformation(extent={{142,6},{154,18}})));
equation
  connect(weather.AirTemp, outsideTemp.T) annotation (Line(points={{-55,79},{
          -40,79},{-40,80.5},{-31.1,80.5}},
                                        color={0,0,127}));
  connect(tempTop.y,RoomTemperatureTop)
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
    annotation (Line(points={{124.7,-16},{158,-16}},
                                                 color={0,0,127}));
  connect(Heat.y, heatingPower)
    annotation (Line(points={{124.7,-48},{176,-48}}, color={0,0,127}));
  connect(coolingEnergy, to_kWh.y) annotation (Line(points={{176,-32},{170,-32},
          {170,-31},{160.5,-31}},
                               color={0,0,127}));
  connect(HeatingEnergy, to_kWh1.y) annotation (Line(points={{176,-64},{170,-64},
          {170,-65},{160.5,-65}},
                             color={0,0,127}));
  connect(heatingPower, heatingPower)
    annotation (Line(points={{176,-48},{176,-48}},
                                               color={0,0,127}));
  connect(heatingPower, integrator2.u) annotation (Line(points={{176,-48},{132,
          -48},{132,-64.75},{134.1,-64.75}},
                                    color={0,0,127}));
  connect(to_kWh1.u, integrator2.y) annotation (Line(points={{149,-65},{148,-65},
          {148,-64.75},{144.45,-64.75}},
                                    color={0,0,127}));
  connect(coolingPower, integrator1.u) annotation (Line(points={{158,-16},{
          132.1,-16},{132.1,-30.75}},
                              color={0,0,127}));
  connect(integrator1.y, to_kWh.u) annotation (Line(points={{142.45,-30.75},{
          148.225,-30.75},{148.225,-31},{149,-31}},
                                                 color={0,0,127}));
  connect(room.AirExchangePort, RWD.y[4]) annotation (Line(points={{-1.3,31.02},
          {-72,31.02},{-72,-50},{-75,-50},{-75,-48}}, color={0,0,127}));
  connect(Room.y[1], room.AirExchangePortRoom) annotation (Line(points={{-77,-78},
          {-56,-78},{-56,-18.66},{-1.3,-18.66}},      color={0,0,127}));
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
  connect(MeanMeasuredTemp.y, gain.u)
    annotation (Line(points={{126.7,12},{140.8,12}}, color={0,0,127}));
  connect(gain.y, MeanMeasuredTemperature)
    annotation (Line(points={{154.6,12},{178,12}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-100,-120},{180,100}})),
    Icon(coordinateSystem(extent={{-100,-120},{180,100}})));
end Building1;
