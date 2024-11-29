within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_ExampleAHU
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant T_setCooler(k=273.15 + 26)
    annotation (Placement(transformation(extent={{20,-100},{0,-80}})));
  Modelica.Blocks.Sources.Constant X_set_Cooler(k=0.0115)
    annotation (Placement(transformation(extent={{-100,-112},{-80,-92}})));
  Modelica.Blocks.Sources.Constant T_SteamIn(k=273.15 + 100)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Modelica.Blocks.Sources.Constant T_setReheater(k=273.15 + 20)
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  Modelica.Blocks.Sources.Constant T_setPreheater(k=273.15)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Continuous.LimPID PID(yMax=0.8, yMin=0)
    annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
  Modelica.Blocks.Sources.Constant X_set_Humidifier(k=0.006)
    annotation (Placement(transformation(extent={{100,-94},{80,-74}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-54,80},{-74,100}})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-102,50},{-88,66}}),iconTransformation(extent={
            {-160,22},{-140,42}})));
  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-94,26},{-74,46}})));
  Modelica.Blocks.Sources.Constant m_flow_air(k=1.0*simpleRoom.V_room/3600*1.18)
    annotation (Placement(transformation(extent={{20,80},{0,100}})));
  Modelica.Blocks.Sources.CombiTimeTable SchedulePeople(
    tableOnFile=true,
    tableName="Schedule",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://SimpleAHU/Resources/SchedulePeopleOffice.txt"),
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Room.SimpleRoom simpleRoom
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Continuous.LimPID PID1(
    k=10,
    yMin=277.15,
    yMax=287.15)
    annotation (Placement(transformation(extent={{-42,-100},{-22,-80}})));
equation
  connect(T_SteamIn.y, exampleAHU.T_steamIn) annotation (Line(points={{79,-50},
          {24,-50},{24,8},{23.4444,8}},       color={0,0,127}));
  connect(T_setCooler.y, exampleAHU.T_set_cooler) annotation (Line(points={{-1,
          -90},{-8,-90},{-8,-16},{-7.11111,-16},{-7.11111,8}}, color={0,0,127}));
  connect(T_setReheater.y, exampleAHU.T_set_reheater) annotation (Line(points={{79,-10},
          {38.7222,-10},{38.7222,8}},          color={0,0,127}));
  connect(T_setPreheater.y, exampleAHU.T_set_preheater) annotation (Line(points={{-59,-70},
          {-37.6667,-70},{-37.6667,8}},           color={0,0,127}));
  connect(T_setReheater.y, exampleAHU.T_set_HRS) annotation (Line(points={{79,-10},
          {-50,-10},{-50,8},{-49.8889,8}},      color={0,0,127}));
  connect(PID.y, exampleAHU.m_flow_steam) annotation (Line(points={{39,-70},{
          8.16667,-70},{8.16667,8}}, color={0,0,127}));
  connect(exampleAHU.X_airOutSup, PID.u_m) annotation (Line(points={{57.0556,
          14.2},{100,14.2},{100,-100},{50,-100},{50,-82}}, color={0,0,127}));
  connect(X_set_Humidifier.y, PID.u_s) annotation (Line(points={{79,-84},{68,
          -84},{68,-70},{62,-70}}, color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-74,90},{-95,90},{-95,58}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, exampleAHU.T_airInOda) annotation (Line(
      points={{-95,58},{-82,58},{-82,54.5},{-59.0556,54.5}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.pAtm, x_pTphi.p_in) annotation (Line(
      points={{-95,58},{-100,58},{-100,42},{-96,42}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, x_pTphi.T) annotation (Line(
      points={{-95,58},{-100,58},{-100,36},{-96,36}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum, x_pTphi.phi) annotation (Line(
      points={{-95,58},{-100,58},{-100,30},{-96,30}},
      color={255,204,51},
      thickness=0.5));
  connect(x_pTphi.X[1], exampleAHU.X_airInOda) annotation (Line(points={{-73,36},
          {-68,36},{-68,45.2},{-59.0556,45.2}}, color={0,0,127}));
  connect(m_flow_air.y, exampleAHU.m_flow_airInOda) annotation (Line(points={{-1,90},
          {-20,90},{-20,72},{-68,72},{-68,64},{-60,64},{-60,63.8},{-59.0556,
          63.8}},          color={0,0,127}));
  connect(exampleAHU.X_airOutSup, simpleRoom.HumIn) annotation (Line(points={{57.0556,
          14.2},{72,14.2},{72,45},{79,45}},         color={0,0,127}));
  connect(exampleAHU.T_airOutSup, simpleRoom.TempIn) annotation (Line(points={{57.0556,
          23.5},{72,23.5},{72,48},{79,48}},         color={0,0,127}));
  connect(exampleAHU.m_flow_airOutSup, simpleRoom.m_flow_in) annotation (Line(
        points={{57.0556,32.8},{72,32.8},{72,42},{79,42}}, color={0,0,127}));
  connect(simpleRoom.TempOut, exampleAHU.T_airInEta) annotation (Line(points={{79,52},
          {72,52},{72,54.5},{57.0556,54.5}},        color={0,0,127}));
  connect(simpleRoom.HumOut, exampleAHU.X_airInEta) annotation (Line(points={{79,55},
          {72,55},{72,45.2},{57.0556,45.2}},        color={0,0,127}));
  connect(simpleRoom.m_flow_out, exampleAHU.m_flow_airInEta) annotation (Line(
        points={{79,58},{72,58},{72,63.8},{57.0556,63.8}}, color={0,0,127}));
  connect(SchedulePeople.y[1], simpleRoom.Schedule) annotation (Line(points={{
          79,90},{74,90},{74,72},{100,72},{100,32},{90,32},{90,39}}, color={0,0,
          127}));
  connect(PID1.y, exampleAHU.T_coolingSurf) annotation (Line(points={{-21,-90},
          {-14,-90},{-14,-44},{-22.3889,-44},{-22.3889,8}}, color={0,0,127}));
  connect(exampleAHU.X_airOutSup, PID1.u_m) annotation (Line(points={{57.0556,
          14.2},{100,14.2},{100,-116},{-32,-116},{-32,-102}}, color={0,0,127}));
  connect(X_set_Cooler.y, PID1.u_s) annotation (Line(points={{-79,-102},{-62,
          -102},{-62,-90},{-44,-90}}, color={0,0,127}));
  connect(exampleAHU.X_set_Cooler, X_set_Cooler.y) annotation (Line(points={{
          0.222222,8},{0.222222,-74},{-50,-74},{-50,-102},{-79,-102}}, color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=31536000, Interval=1800));
end Test_ExampleAHU;
