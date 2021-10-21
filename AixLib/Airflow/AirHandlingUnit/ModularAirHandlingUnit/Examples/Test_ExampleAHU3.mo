within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_ExampleAHU3
  extends Modelica.Icons.Example;
  ExampleAHU2 exampleAHU2
    annotation (Placement(transformation(extent={{-56,8},{54,70}})));
  Modelica.Blocks.Sources.Constant T_WaterIn(k=273.15 + 10)
    annotation (Placement(transformation(extent={{36,-28},{24,-16}})));

  Modelica.Blocks.Sources.Constant m_flow_air(k=100*1.2)
    annotation (Placement(transformation(extent={{-96,74},{-84,86}})));
  Modelica.Blocks.Sources.Constant dp_etaVent(k=800)
    annotation (Placement(transformation(extent={{56,88},{44,100}})));
  Modelica.Blocks.Sources.Constant dp_supVent(k=800)
    annotation (Placement(transformation(extent={{66,-28},{54,-16}})));
  Modelica.Blocks.Sources.Constant T_setHRS(k=273.15 + 22)
    annotation (Placement(transformation(extent={{-74,-22},{-62,-10}})));
  Modelica.Blocks.Sources.Constant min_phi_supplyAir(k=0.4)
    annotation (Placement(transformation(extent={{100,-60},{88,-48}})));
  Modelica.Blocks.Sources.Constant max_phi_supplyAir(k=0.6)
    annotation (Placement(transformation(extent={{100,-92},{88,-80}})));
  Utilities.Psychrometrics.ToTotalAir toTotAir
    annotation (Placement(transformation(extent={{84,6},{96,18}})));
  Modelica.Blocks.Sources.Constant T_setPreheater(k=273.15 + 2)
    annotation (Placement(transformation(extent={{-74,-44},{-62,-32}})));
  Modelica.Blocks.Sources.Constant T_setCooler(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-50,-86},{-38,-74}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false, p(displayUnit="Pa")=
         101325)
    annotation (Placement(transformation(extent={{52,-60},{40,-48}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi1(use_p_in=false, p(displayUnit="Pa")=
         101325)
    annotation (Placement(transformation(extent={{52,-92},{40,-80}})));
  Modelica.Blocks.Continuous.LimPID PID_humidity_max(
    k=10,
    Ti=1000,
    Td=1000,
    yMin=0.005,
    yMax=0.01)
    annotation (Placement(transformation(extent={{28,-92},{16,-80}})));
  Modelica.Blocks.Continuous.LimPID PID_humidity_min(
    k=10,
    Ti=1000,
    Td=1000,
    yMin=0.005,
    yMax=0.01)
    annotation (Placement(transformation(extent={{28,-48},{16,-60}})));
  Modelica.Blocks.Sources.Sine     tempOutside(
    amplitude=10,
    freqHz=1/86400,
    phase=-3.1415/2,
    offset=292.15)
    annotation (Placement(transformation(extent={{-96,54},{-84,66}})));
  Modelica.Blocks.Sources.Sine waterLoadOutside(
    freqHz=1/86400,
    offset=0.008,
    amplitude=0.005,
    phase=-0.054829518451402)
    annotation (Placement(transformation(extent={{-96,14},{-84,26}})));
  Modelica.Blocks.Sources.Constant desiredT_sup1(k=273.15 + 20)
    annotation (Placement(transformation(extent={{162,42},{150,54}})));
  Modelica.Blocks.Math.Add addToExtractTemp
    annotation (Placement(transformation(extent={{134,58},{122,70}})));
  Modelica.Blocks.Sources.Sine tempAddInRoom1(
    freqHz=1/86400,
    amplitude=2,
    phase=-3.1415/4,
    offset=1.7)
              annotation (Placement(transformation(extent={{162,72},{150,84}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutSup(
    final unit= "K",
    displayUnit="degC")
    "temperature of outgoing supply air"
    annotation (Placement(transformation(extent={{136,12},{156,32}})));
  Modelica.Blocks.Interfaces.RealOutput T_airInOda(
    final unit= "K",
    displayUnit="degC")
    "temperature of incoming outdoor air"
    annotation (Placement(transformation(extent={{-94,32},{-114,52}})));
  Utilities.Psychrometrics.Phi_pTX phi
    annotation (Placement(transformation(extent={{154,-22},{166,-10}})));
  Modelica.Blocks.Sources.Constant airPressure(k=101325)
    annotation (Placement(transformation(extent={{134,-34},{146,-22}})));
  Modelica.Blocks.Interfaces.RealOutput phi_airOutSup
    "Relative humidity of supply air"
    annotation (Placement(transformation(extent={{174,-26},{194,-6}})));
  Modelica.Blocks.Sources.Constant T_setCooler1(k=293.15)
    annotation (Placement(transformation(extent={{-82,-68},{-70,-56}})));
equation
  connect(m_flow_air.y, exampleAHU2.m_flow_airInOda) annotation (Line(points={{-83.4,
          80},{-70,80},{-70,63.8},{-59.0556,63.8}}, color={0,0,127}));
  connect(exampleAHU2.T_waterIn, T_WaterIn.y) annotation (Line(points={{16.7222,
          8},{16.7222,-22},{23.4,-22}}, color={0,0,127}));
  connect(dp_supVent.y, exampleAHU2.dp_supVent) annotation (Line(points={{53.4,
          -22},{47.2778,-22},{47.2778,8}},
                                      color={0,0,127}));
  connect(dp_etaVent.y, exampleAHU2.dp_etaVent) annotation (Line(points={{43.4,94},
          {35.6667,94},{35.6667,73.1}}, color={0,0,127}));
  connect(m_flow_air.y, exampleAHU2.m_flow_airInEta) annotation (Line(points={{-83.4,
          80},{70,80},{70,63.8},{57.0556,63.8}}, color={0,0,127}));
  connect(T_setHRS.y, exampleAHU2.T_set_HRS) annotation (Line(points={{-61.4,
          -16},{-49.8889,-16},{-49.8889,8}},
                                        color={0,0,127}));
  connect(exampleAHU2.X_airOutSup, toTotAir.XiDry) annotation (Line(points={{57.0556,
          14.2},{80,14.2},{80,12},{83.4,12}}, color={0,0,127}));
  connect(exampleAHU2.X_airOutSup, exampleAHU2.X_airInEta) annotation (Line(
        points={{57.0556,14.2},{66,14.2},{66,45.2},{57.0556,45.2}}, color={0,0,127}));
  connect(T_setPreheater.y, exampleAHU2.T_set_preheater) annotation (Line(
        points={{-61.4,-38},{-37.6667,-38},{-37.6667,8}}, color={0,0,127}));
  connect(T_setCooler.y, exampleAHU2.T_set_cooler) annotation (Line(points={{-37.4,
          -80},{-7.11111,-80},{-7.11111,8}}, color={0,0,127}));
  connect(min_phi_supplyAir.y, x_pTphi.phi) annotation (Line(points={{87.4,-54},
          {70,-54},{70,-57.6},{53.2,-57.6}}, color={0,0,127}));
  connect(max_phi_supplyAir.y, x_pTphi1.phi) annotation (Line(points={{87.4,-86},
          {70,-86},{70,-89.6},{53.2,-89.6}}, color={0,0,127}));
  connect(x_pTphi1.X[1], PID_humidity_max.u_s)
    annotation (Line(points={{39.4,-86},{29.2,-86}}, color={0,0,127}));
  connect(toTotAir.XiTotalAir, PID_humidity_max.u_m) annotation (Line(points={{96.6,
          12},{108,12},{108,-104},{22,-104},{22,-93.2}}, color={0,0,127}));
  connect(x_pTphi.X[1], PID_humidity_min.u_s)
    annotation (Line(points={{39.4,-54},{29.2,-54}}, color={0,0,127}));
  connect(toTotAir.XiTotalAir, PID_humidity_min.u_m) annotation (Line(points={{96.6,
          12},{108,12},{108,-36},{22,-36},{22,-46.8}}, color={0,0,127}));
  connect(PID_humidity_min.y, exampleAHU2.X_set_Humidifier) annotation (Line(
        points={{15.4,-54},{8.16667,-54},{8.16667,8}}, color={0,0,127}));
  connect(tempOutside.y, exampleAHU2.T_airInOda) annotation (Line(points={{-83.4,
          60},{-72,60},{-72,54.5},{-59.0556,54.5}}, color={0,0,127}));
  connect(waterLoadOutside.y, exampleAHU2.X_airInOda) annotation (Line(points={{-83.4,
          20},{-72,20},{-72,45.2},{-59.0556,45.2}},       color={0,0,127}));
  connect(addToExtractTemp.y, exampleAHU2.T_airInEta) annotation (Line(points={{121.4,
          64},{90,64},{90,54.5},{57.0556,54.5}},       color={0,0,127}));
  connect(tempAddInRoom1.y, addToExtractTemp.u1) annotation (Line(points={{149.4,
          78},{142.7,78},{142.7,67.6},{135.2,67.6}}, color={0,0,127}));
  connect(desiredT_sup1.y, addToExtractTemp.u2) annotation (Line(points={{149.4,
          48},{142,48},{142,60.4},{135.2,60.4}}, color={0,0,127}));
  connect(exampleAHU2.T_airOutSup, T_airOutSup) annotation (Line(points={{57.0556,
          23.5},{138,23.5},{138,22},{146,22}}, color={0,0,127}));
  connect(T_airOutSup, T_airOutSup)
    annotation (Line(points={{146,22},{146,22}}, color={0,0,127}));
  connect(tempOutside.y, T_airInOda) annotation (Line(points={{-83.4,60},{-80,60},
          {-80,42},{-104,42}}, color={0,0,127}));
  connect(exampleAHU2.T_airOutSup, phi.T) annotation (Line(points={{57.0556,
          23.5},{130,23.5},{130,-11.2},{153.4,-11.2}}, color={0,0,127}));
  connect(toTotAir.XiTotalAir, phi.X_w) annotation (Line(points={{96.6,12},{114,
          12},{114,-16},{153.4,-16}}, color={0,0,127}));
  connect(phi.p, airPressure.y) annotation (Line(points={{153.4,-20.8},{150,
          -20.8},{150,-28},{146.6,-28}}, color={0,0,127}));
  connect(phi.phi, phi_airOutSup)
    annotation (Line(points={{166.6,-16},{184,-16}}, color={0,0,127}));
  connect(desiredT_sup1.y, exampleAHU2.T_set_reheater) annotation (Line(points={{149.4,
          48},{72,48},{72,-4},{38.7222,-4},{38.7222,8}},         color={0,0,127}));
  connect(PID_humidity_max.y, exampleAHU2.X_set_cooler) annotation (Line(points=
         {{15.4,-86},{0.833333,-86},{0.833333,8}}, color={0,0,127}));
  connect(desiredT_sup1.y, x_pTphi.T) annotation (Line(points={{149.4,48},{122,
          48},{122,-42},{60,-42},{60,-54},{53.2,-54}}, color={0,0,127}));
  connect(desiredT_sup1.y, x_pTphi1.T) annotation (Line(points={{149.4,48},{122,
          48},{122,-74},{64,-74},{64,-86},{53.2,-86}}, color={0,0,127}));
  connect(T_setCooler1.y, exampleAHU2.T_coolingSurf1) annotation (Line(points={{-69.4,
          -62},{-24.2222,-62},{-24.2222,8}},        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},
            {140,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{140,100}})),
    experiment(
      StopTime=86400,
      Interval=600.00012,
      __Dymola_Algorithm="Dassl"));
end Test_ExampleAHU3;
