within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Validation;
model ComparisonToAHUHeatingCoolingHumDehumHRS
  "Comparitive simulation with existing AHU model"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Sine     tempOutside(
    amplitude=10,
    freqHz=1/86400,
    phase=-3.1415/2,
    offset=292)
    annotation (Placement(transformation(extent={{-100,22},{-80,42}})));
  Modelica.Blocks.Sources.Constant Vflow_in(k=100)
    annotation (Placement(transformation(extent={{-100,62},{-80,82}})));
  Modelica.Blocks.Sources.Constant desiredT_sup(k=293)
    annotation (Placement(transformation(extent={{62,12},{42,32}})));
  AHU                                 ahu(
    clockPeriodGeneric=1,
    heating=true,
    cooling=true,
    dehumidificationSet=true,
    humidificationSet=true,
    HRS=true,
    efficiencyHRS_enabled=0.8,
    efficiencyHRS_disabled=0.2,
    dp_sup(displayUnit="Pa"),
    dp_eta(displayUnit="Pa"))
              annotation (Placement(transformation(extent={{-68,22},{26,58}})));
  Modelica.Blocks.Sources.Constant phi_roomMin(k=0.47)
    annotation (Placement(transformation(extent={{68,-18},{48,2}})));
  Modelica.Blocks.Sources.Constant phi_roomMax(k=0.55)
    annotation (Placement(transformation(extent={{98,-18},{78,2}})));
  Modelica.Blocks.Sources.Sine waterLoadOutside(
    freqHz=1/86400,
    offset=0.006,
    amplitude=0.002,
    phase=3.1415926535898)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Modelica.Blocks.Sources.Constant phi_RoomExtractAir(k=0.6)
    annotation (Placement(transformation(extent={{98,14},{78,34}})));
  Modelica.Blocks.Sources.Sine tempAddInRoom(
    freqHz=1/86400,
    amplitude=2,
    phase=-3.1415/4,
    offset=1.7)
              annotation (Placement(transformation(extent={{98,58},{78,78}})));
  Modelica.Blocks.Math.Add addToExtractTemp
    annotation (Placement(transformation(extent={{46,50},{34,62}})));
  ModularAHU modularAHU(
    humidifying=true,
    cooling=true,
    dehumidifying=true,
    heating=true,
    heatRecovery=true,
    use_PhiSet=false,
    Twat=284.15,
    efficiencyHRS_enabled=0.8,
    efficiencyHRS_disabled=0.2,
    dp_sup(displayUnit="Pa"),
    dp_eta(displayUnit="Pa"),
    redeclare model humidifier = Components.SprayHumidifier)
    annotation (Placement(transformation(extent={{-54,-68},{16,-30}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-46,-100},{-66,-80}})));
  ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum annotation (Placement(transformation(extent={{-82,-58},{-72,-48}})));
equation
  connect(desiredT_sup.y,ahu. T_supplyAir) annotation (Line(
      points={{41,22},{34,22},{34,33.7},{18.48,33.7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tempOutside.y,ahu. T_outdoorAir) annotation (Line(
      points={{-79,32},{-74,32},{-74,32.8},{-62.36,32.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Vflow_in.y,ahu. Vflow_in) annotation (Line(
      points={{-79,72},{-76,72},{-76,35.5},{-66.12,35.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMin.y,ahu. phi_supplyAir[1]) annotation (Line(
      points={{47,-8},{32,-8},{32,30.1},{18.48,30.1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(waterLoadOutside.y,ahu. X_outdoorAir) annotation (Line(
      points={{-79,-2},{-72,-2},{-72,28.3},{-62.36,28.3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_RoomExtractAir.y,ahu. phi_extractAir) annotation (Line(
      points={{77,24},{66,24},{66,38},{30,38},{30,45.4},{18.48,45.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMax.y,ahu. phi_supplyAir[2]) annotation (Line(points={{77,-8},
          {72,-8},{72,-28},{28,-28},{28,28.3},{18.48,28.3}},          color={0,0,
          127}));
  connect(ahu.T_extractAir,addToExtractTemp. y) annotation (Line(points={{18.48,
          49.9},{27.92,49.9},{27.92,56},{33.4,56}},       color={0,0,127}));
  connect(tempAddInRoom.y,addToExtractTemp. u1) annotation (Line(points={{77,68},
          {56,68},{56,59.6},{47.2,59.6}},         color={0,0,127}));
  connect(desiredT_sup.y,addToExtractTemp. u2) annotation (Line(points={{41,22},
          {38,22},{38,44},{56,44},{56,52.4},{47.2,52.4}},color={0,0,127}));
  connect(Vflow_in.y, modularAHU.VflowOda) annotation (Line(points={{-79,72},{
          -76,72},{-76,50},{-100,50},{-100,-37.6},{-54.875,-37.6}}, color={0,0,
          127}));
  connect(tempOutside.y, modularAHU.T_oda) annotation (Line(points={{-79,32},{
          -74,32},{-74,16},{-100,16},{-100,-42},{-78,-42},{-78,-41.4},{-54.875,
          -41.4}}, color={0,0,127}));
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
  connect(modularAHU.QflowC, abs1.u) annotation (Line(points={{-30.1563,-68.95},
          {-30.1563,-90},{-44,-90}}, color={0,0,127}));
  connect(phi_RoomExtractAir.y, modularAHU.phi_eta) annotation (Line(points={{
          77,24},{70,24},{70,-45.2},{16.875,-45.2}}, color={0,0,127}));
  connect(absToRelHum.relHum, modularAHU.phi_oda) annotation (Line(points={{-71,
          -53},{-63.5,-53},{-63.5,-45.2},{-54.875,-45.2}}, color={0,0,127}));
  connect(waterLoadOutside.y, absToRelHum.absHum) annotation (Line(points={{-79,
          -2},{-72,-2},{-72,-34},{-92,-34},{-92,-50.4},{-83,-50.4}}, color={0,0,
          127}));
  connect(tempOutside.y, absToRelHum.TDryBul) annotation (Line(points={{-79,32},
          {-74,32},{-74,-44},{-96,-44},{-96,-55.8},{-83,-55.8}}, color={0,0,127}));
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
end ComparisonToAHUHeatingCoolingHumDehumHRS;
