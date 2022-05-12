within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation;
model ComparisonOfAHUCoolingHRS
  "Comparitive simulation with existing AHU model"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Vflow_in(k=100)
    annotation (Placement(transformation(extent={{-100,62},{-80,82}})));
  Modelica.Blocks.Sources.Constant desiredT_sup(k=293)
    annotation (Placement(transformation(extent={{62,12},{42,32}})));
  AHU                                 ahu(
    clockPeriodGeneric=30,
    heating=false,
    cooling=true,
    dehumidificationSet=false,
    humidificationSet=false,
    HRS=true,
    dp_sup(displayUnit="Pa"),
    dp_eta(displayUnit="Pa"))
              annotation (Placement(transformation(extent={{-68,20},{26,56}})));
  Modelica.Blocks.Sources.Constant phi_roomMin(k=0.47)
    annotation (Placement(transformation(extent={{68,-18},{48,2}})));
  Modelica.Blocks.Sources.Constant phi_roomMax(k=0.55)
    annotation (Placement(transformation(extent={{98,-18},{78,2}})));
  Modelica.Blocks.Sources.Constant phi_RoomExtractAir(k=0.6)
    annotation (Placement(transformation(extent={{98,14},{78,34}})));
  Modelica.Blocks.Math.Add addToExtractTemp
    annotation (Placement(transformation(extent={{46,50},{34,62}})));
  ModularAHU modularAHU(
    humidifying=false,
    cooling=true,
    dehumidifying=false,
    heating=false,
    heatRecovery=true,
    use_PhiSet=false,
    Twat=273.15,
    dp_sup(displayUnit="Pa"),
    dp_eta(displayUnit="Pa"),
    redeclare model humidifier = Components.SprayHumidifier)
    annotation (Placement(transformation(extent={{-54,-68},{16,-30}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false)
    annotation (Placement(transformation(extent={{60,-60},{48,-48}})));
  Modelica.Blocks.Sources.Constant TempOutside(k=298.15)
    annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
  Modelica.Blocks.Sources.Constant WaterLoadOutside(k=0.008)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Modelica.Blocks.Sources.Constant tempAddInRoom(k=2)
    annotation (Placement(transformation(extent={{94,60},{74,80}})));
  Utilities.Psychrometrics.ToTotalAir toTotAir
    annotation (Placement(transformation(extent={{-60,-12},{-48,0}})));
  Utilities.Psychrometrics.Phi_pTX phi
    annotation (Placement(transformation(extent={{-80,-60},{-68,-48}})));
protected
  Modelica.Blocks.Sources.Constant p_atm(k=101325)
    annotation (Placement(transformation(extent={{-100,-68},{-92,-60}})));
equation
  connect(desiredT_sup.y,ahu. T_supplyAir) annotation (Line(
      points={{41,22},{34,22},{34,31.7},{18.48,31.7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Vflow_in.y,ahu. Vflow_in) annotation (Line(
      points={{-79,72},{-76,72},{-76,33.5},{-66.12,33.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMin.y,ahu. phi_supplyAir[1]) annotation (Line(
      points={{47,-8},{32,-8},{32,28.1},{18.48,28.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_RoomExtractAir.y,ahu. phi_extractAir) annotation (Line(
      points={{77,24},{66,24},{66,38},{30,38},{30,43.4},{18.48,43.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMax.y,ahu. phi_supplyAir[2]) annotation (Line(points={{77,-8},
          {72,-8},{72,-28},{28,-28},{28,26.3},{18.48,26.3}},          color={0,0,
          127}));
  connect(ahu.T_extractAir,addToExtractTemp. y) annotation (Line(points={{18.48,
          47.9},{27.92,47.9},{27.92,56},{33.4,56}},       color={0,0,127}));
  connect(desiredT_sup.y,addToExtractTemp. u2) annotation (Line(points={{41,22},
          {38,22},{38,44},{56,44},{56,52.4},{47.2,52.4}},color={0,0,127}));
  connect(Vflow_in.y, modularAHU.VflowOda) annotation (Line(points={{-79,72},{
          -76,72},{-76,50},{-100,50},{-100,-37.6},{-54.875,-37.6}}, color={0,0,
          127}));
  connect(Vflow_in.y, modularAHU.VflowEta) annotation (Line(points={{-79,72},{
          -76,72},{-76,50},{-100,50},{-100,-26},{22,-26},{22,-38},{20,-38},{20,
          -37.6},{16.875,-37.6}}, color={0,0,127}));
  connect(addToExtractTemp.y, modularAHU.T_eta) annotation (Line(points={{33.4,
          56},{28,56},{28,86},{100,86},{100,-41.4},{16.875,-41.4}}, color={0,0,
          127}));
  connect(phi_roomMin.y, modularAHU.phi_supplyAir[1]) annotation (Line(points={
          {47,-8},{32,-8},{32,-80},{7.25,-80},{7.25,-69.14}}, color={0,0,127}));
  connect(phi_roomMax.y, modularAHU.phi_supplyAir[2]) annotation (Line(points={
          {77,-8},{72,-8},{72,-80},{7.25,-80},{7.25,-68.38}}, color={0,0,127}));
  connect(desiredT_sup.y, modularAHU.T_supplyAir) annotation (Line(points={{41,
          22},{38,22},{38,-74},{11.625,-74},{11.625,-68.76}}, color={0,0,127}));
  connect(phi_RoomExtractAir.y, x_pTphi.phi) annotation (Line(points={{77,24},{
          72,24},{72,-57.6},{61.2,-57.6}}, color={0,0,127}));
  connect(addToExtractTemp.y, x_pTphi.T) annotation (Line(points={{33.4,56},{28,
          56},{28,86},{100,86},{100,-54},{61.2,-54}}, color={0,0,127}));
  connect(x_pTphi.X[1], modularAHU.X_eta) annotation (Line(points={{47.4,-54},{
          32,-54},{32,-45.2},{16.875,-45.2}}, color={0,0,127}));
  connect(TempOutside.y, ahu.T_outdoorAir) annotation (Line(points={{-79,34},{
          -72,34},{-72,30.8},{-62.36,30.8}}, color={0,0,127}));
  connect(TempOutside.y, modularAHU.T_oda) annotation (Line(points={{-79,34},{
          -72,34},{-72,-41.4},{-54.875,-41.4}}, color={0,0,127}));
  connect(WaterLoadOutside.y, ahu.X_outdoorAir) annotation (Line(points={{-79,
          -2},{-72,-2},{-72,26.3},{-62.36,26.3}}, color={0,0,127}));
  connect(tempAddInRoom.y, addToExtractTemp.u1) annotation (Line(points={{73,70},
          {58,70},{58,59.6},{47.2,59.6}}, color={0,0,127}));
  connect(phi.phi, modularAHU.phi_oda) annotation (Line(points={{-67.4,-54},{
          -60,-54},{-60,-45.2},{-54.875,-45.2}}, color={0,0,127}));
  connect(p_atm.y, phi.p) annotation (Line(points={{-91.6,-64},{-84,-64},{-84,
          -58.8},{-80.6,-58.8}}, color={0,0,127}));
  connect(toTotAir.XiTotalAir, phi.X_w) annotation (Line(points={{-47.4,-6},{
          -42,-6},{-42,-28},{-74,-28},{-74,-44},{-84,-44},{-84,-54},{-80.6,-54}},
        color={0,0,127}));
  connect(TempOutside.y, phi.T) annotation (Line(points={{-79,34},{-72,34},{-72,
          -46},{-80.6,-46},{-80.6,-49.2}}, color={0,0,127}));
  connect(WaterLoadOutside.y, toTotAir.XiDry) annotation (Line(points={{-79,-2},
          {-66,-2},{-66,-6},{-60.6,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-60,84},{-22,58}},
          lineColor={28,108,200},
          fontSize=6,
          textString="Heat        Cool        Dehu        Hu        HRS
1        1        1        1        1
1        1        1        0        1
1        1        0        1        1
1        1        0        0        1
1        0        0        0        1
0        1        0        0        1
0        0        0        0        1
1        1        1        1        0
1        1        1        0        0
1        1        0        1        0
1        1        0        0        0
1        0        0        0        0
0        1        0        0        0
0        0        0        0        0
"),     Text(
          extent={{-60,100},{-16,90}},
          lineColor={28,108,200},
          textString="Use the following Table for investigation of all possible modes.
Check whether variable allCond is always 1.")}),
    experiment(
      StopTime=86400,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end ComparisonOfAHUCoolingHRS;
