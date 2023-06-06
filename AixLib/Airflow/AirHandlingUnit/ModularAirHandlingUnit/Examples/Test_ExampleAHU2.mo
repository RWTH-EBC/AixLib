within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_ExampleAHU2
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant T_WaterIn(k=273.15 + 10)
    annotation (Placement(transformation(extent={{36,-28},{24,-16}})));
  Modelica.Blocks.Sources.Constant T_setReheater(k=273.15 + 20)
    annotation (Placement(transformation(extent={{90,-16},{78,-4}})));

  Modelica.Blocks.Sources.Constant m_flow_air(k=100*1.2)
    annotation (Placement(transformation(extent={{-96,74},{-84,86}})));
  Modelica.Blocks.Sources.Constant dp_etaVent(k=800)
    annotation (Placement(transformation(extent={{56,88},{44,100}})));
  Modelica.Blocks.Sources.Constant dp_supVent(k=800)
    annotation (Placement(transformation(extent={{66,-28},{54,-16}})));
  Modelica.Blocks.Sources.Ramp T_air(
    height=11,
    duration(displayUnit="h") = 86400,
    offset=273.15 + 11)
    annotation (Placement(transformation(extent={{-96,54},{-84,66}})));
  Modelica.Blocks.Sources.Constant X_air(k=0.008)
    annotation (Placement(transformation(extent={{-96,34},{-84,46}})));
  Modelica.Blocks.Sources.Constant T_setHRS(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-74,-22},{-62,-10}})));
  Controls.Continuous.LimPID conPID(
    k=5,
    Ti=0.1,
    Td=1,
    yMin=0.4,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{26,-50},{14,-62}})));
  Modelica.Blocks.Sources.Constant min_phi_supplyAir(k=0.4)
    annotation (Placement(transformation(extent={{66,-62},{54,-50}})));
  Modelica.Blocks.Sources.Constant max_phi_supplyAir(k=0.6)
    annotation (Placement(transformation(extent={{66,-94},{54,-82}})));
  Utilities.Psychrometrics.ToTotalAir toTotAir
    annotation (Placement(transformation(extent={{84,6},{96,18}})));
  Controls.Continuous.LimPID conPID1(
    k=5,
    Ti=0.1,
    Td=1,
    yMax=0.6,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{26,-94},{14,-82}})));
  Modelica.Blocks.Sources.Constant T_room(k=273.15 + 24)
    annotation (Placement(transformation(extent={{98,46},{86,58}})));
  Modelica.Blocks.Sources.Constant X_set_Cooler(k=0.01)
    annotation (Placement(transformation(extent={{-100,-66},{-88,-54}})));
  Modelica.Blocks.Continuous.LimPID PID_T_setCoolingSurf(
    k=10,
    yMin=277.15,
    yMax=287.15)
    annotation (Placement(transformation(extent={{-74,-66},{-62,-54}})));
  Modelica.Blocks.Sources.Constant T_setPreheater(k=273.15 + 2)
    annotation (Placement(transformation(extent={{-74,-44},{-62,-32}})));
  Modelica.Blocks.Sources.Constant T_setCooler(k=273.15 + 22)
    annotation (Placement(transformation(extent={{-50,-86},{-38,-74}})));
  Utilities.Psychrometrics.Phi_pTX phi
    annotation (Placement(transformation(extent={{102,-124},{90,-112}})));
  Modelica.Blocks.Sources.Constant airPressure(k=101325)
    annotation (Placement(transformation(extent={{142,-138},{130,-126}})));
equation
  connect(T_setReheater.y, exampleAHU_SprayHumidifier.T_set_reheater) annotation (Line(points={{77.4,
          -10},{38.7222,-10},{38.7222,8}},     color={0,0,127}));
  connect(m_flow_air.y, exampleAHU_SprayHumidifier.m_flow_airInOda) annotation (Line(points={{-83.4,
          80},{-70,80},{-70,63.8},{-59.0556,63.8}},
                           color={0,0,127}));
  connect(exampleAHU_SprayHumidifier.T_waterIn, T_WaterIn.y) annotation (Line(
        points={{16.7222,8},{16.7222,-22},{23.4,-22}},
                                                     color={0,0,127}));
  connect(dp_supVent.y, exampleAHU_SprayHumidifier.dp_supVent) annotation (Line(
        points={{53.4,-22},{47.2778,-22},{47.2778,8}},
                                                     color={0,0,127}));
  connect(dp_etaVent.y, exampleAHU_SprayHumidifier.dp_etaVent) annotation (Line(
        points={{43.4,94},{35.6667,94},{35.6667,73.1}},
                                                      color={0,0,127}));
  connect(T_air.y, exampleAHU_SprayHumidifier.T_airInOda) annotation (Line(
        points={{-83.4,60},{-78,60},{-78,54.5},{-59.0556,54.5}}, color={0,0,127}));
  connect(exampleAHU_SprayHumidifier.X_airInOda, X_air.y) annotation (Line(
        points={{-59.0556,45.2},{-72,45.2},{-72,40},{-83.4,40}}, color={0,0,127}));
  connect(m_flow_air.y, exampleAHU_SprayHumidifier.m_flow_airInEta) annotation (
     Line(points={{-83.4,80},{70,80},{70,63.8},{57.0556,63.8}}, color={0,0,127}));
  connect(T_setHRS.y, exampleAHU_SprayHumidifier.T_set_HRS) annotation (Line(
        points={{-61.4,-16},{-49.8889,-16},{-49.8889,8}}, color={0,0,127}));
  connect(exampleAHU_SprayHumidifier.X_set_Cooler, conPID1.y) annotation (Line(
        points={{0.222222,8},{0,8},{0,-88},{13.4,-88}}, color={0,0,127}));
  connect(exampleAHU_SprayHumidifier.X_airOutSup, toTotAir.XiDry) annotation (
      Line(points={{57.0556,14.2},{80,14.2},{80,12},{83.4,12}}, color={0,0,127}));
  connect(exampleAHU_SprayHumidifier.X_airOutSup, exampleAHU_SprayHumidifier.X_airInEta)
    annotation (Line(points={{57.0556,14.2},{66,14.2},{66,45.2},{57.0556,45.2}},
        color={0,0,127}));
  connect(T_room.y, exampleAHU_SprayHumidifier.T_airInEta) annotation (Line(
        points={{85.4,52},{72,52},{72,54.5},{57.0556,54.5}}, color={0,0,127}));
  connect(exampleAHU_SprayHumidifier.X_set_Humidifier, conPID.y) annotation (
      Line(points={{8.16667,8},{8,8},{8,-56},{13.4,-56}}, color={0,0,127}));
  connect(X_set_Cooler.y, PID_T_setCoolingSurf.u_s)
    annotation (Line(points={{-87.4,-60},{-75.2,-60}}, color={0,0,127}));
  connect(PID_T_setCoolingSurf.y, exampleAHU_SprayHumidifier.T_coolingSurf)
    annotation (Line(points={{-61.4,-60},{-22.3889,-60},{-22.3889,8}}, color={0,
          0,127}));
  connect(T_setPreheater.y, exampleAHU_SprayHumidifier.T_set_preheater)
    annotation (Line(points={{-61.4,-38},{-37.6667,-38},{-37.6667,8}}, color={0,
          0,127}));
  connect(toTotAir.XiTotalAir, PID_T_setCoolingSurf.u_m) annotation (Line(
        points={{96.6,12},{118,12},{118,-104},{-68,-104},{-68,-67.2}}, color={0,
          0,127}));
  connect(T_setCooler.y, exampleAHU_SprayHumidifier.T_set_cooler) annotation (
      Line(points={{-37.4,-80},{-7.11111,-80},{-7.11111,8}}, color={0,0,127}));
  connect(exampleAHU_SprayHumidifier.T_airOutSup, phi.T) annotation (Line(
        points={{57.0556,23.5},{138,23.5},{138,-113.2},{102.6,-113.2}}, color={
          0,0,127}));
  connect(toTotAir.XiTotalAir, phi.X_w) annotation (Line(points={{96.6,12},{156,
          12},{156,-118},{102.6,-118}}, color={0,0,127}));
  connect(phi.p, airPressure.y) annotation (Line(points={{102.6,-122.8},{120,
          -122.8},{120,-132},{129.4,-132}}, color={0,0,127}));
  connect(conPID1.u_s, max_phi_supplyAir.y)
    annotation (Line(points={{27.2,-88},{53.4,-88}}, color={0,0,127}));
  connect(phi.phi, conPID1.u_m) annotation (Line(points={{89.4,-118},{20,-118},
          {20,-95.2}}, color={0,0,127}));
  connect(phi.phi, conPID.u_m) annotation (Line(points={{89.4,-118},{78,-118},{
          78,-38},{20,-38},{20,-48.8}}, color={0,0,127}));
  connect(conPID.u_s, min_phi_supplyAir.y)
    annotation (Line(points={{27.2,-56},{53.4,-56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=1800,
      __Dymola_Algorithm="Dassl"));
end Test_ExampleAHU2;
