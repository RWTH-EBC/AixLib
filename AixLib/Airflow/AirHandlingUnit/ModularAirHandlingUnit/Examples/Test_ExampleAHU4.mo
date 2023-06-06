within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_ExampleAHU4
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Constant m_flow_air(k=100*1.2)
    annotation (Placement(transformation(extent={{-96,74},{-84,86}})));
  Modelica.Blocks.Sources.Constant dp_etaVent(k=800)
    annotation (Placement(transformation(extent={{56,88},{44,100}})));
  Modelica.Blocks.Sources.Constant dp_supVent(k=800)
    annotation (Placement(transformation(extent={{66,-28},{54,-16}})));
  Modelica.Blocks.Sources.Constant min_phi_supplyAir(k=0.4)
    annotation (Placement(transformation(extent={{100,-60},{88,-48}})));
  Modelica.Blocks.Sources.Constant max_phi_supplyAir(k=0.6)
    annotation (Placement(transformation(extent={{100,-92},{88,-80}})));
  Utilities.Psychrometrics.ToTotalAir toTotAir
    annotation (Placement(transformation(extent={{84,6},{96,18}})));
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
equation
  connect(m_flow_air.y, exampleAHU2.m_flow_airInOda) annotation (Line(points={{-83.4,
          80},{-70,80},{-70,63.8},{-59.0556,63.8}}, color={0,0,127}));
  connect(dp_supVent.y, exampleAHU2.dp_supVent) annotation (Line(points={{53.4,
          -22},{47.2778,-22},{47.2778,8}},
                                      color={0,0,127}));
  connect(dp_etaVent.y, exampleAHU2.dp_etaVent) annotation (Line(points={{43.4,94},
          {35.6667,94},{35.6667,73.1}}, color={0,0,127}));
  connect(m_flow_air.y, exampleAHU2.m_flow_airInEta) annotation (Line(points={{-83.4,
          80},{70,80},{70,63.8},{57.0556,63.8}}, color={0,0,127}));
  connect(exampleAHU2.X_airOutSup, toTotAir.XiDry) annotation (Line(points={{57.0556,
          14.2},{80,14.2},{80,12},{83.4,12}}, color={0,0,127}));
  connect(exampleAHU2.X_airOutSup, exampleAHU2.X_airInEta) annotation (Line(
        points={{57.0556,14.2},{66,14.2},{66,45.2},{57.0556,45.2}}, color={0,0,127}));
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
  connect(desiredT_sup1.y, exampleAHU2.TSupSet) annotation (Line(points={{149.4,
          48},{74,48},{74,-42},{-1,-42},{-1,4.9}}, color={0,0,127}));
  connect(min_phi_supplyAir.y, exampleAHU2.phiSet[1]) annotation (Line(points={{87.4,
          -54},{68,-54},{68,-56},{17.3333,-56},{17.3333,1.8}},       color={0,0,
          127}));
  connect(max_phi_supplyAir.y, exampleAHU2.phiSet[2]) annotation (Line(points={{87.4,
          -86},{17.3333,-86},{17.3333,8}},       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},
            {140,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{140,100}})),
    experiment(
      StopTime=86400,
      Interval=600.00012,
      __Dymola_Algorithm="Dassl"));
end Test_ExampleAHU4;
