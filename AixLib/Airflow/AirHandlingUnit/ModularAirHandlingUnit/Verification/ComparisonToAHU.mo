within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Verification;
model ComparisonToAHU
  "Comparitive simulation with existing AHU model"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Sine     tempOutside(
    amplitude=10,
    f=1/86400,
    phase=-3.1415/2,
    offset=292)
    annotation (Placement(transformation(extent={{-100,22},{-80,42}})));
  Modelica.Blocks.Sources.Constant Vflow_in(k=100)
    annotation (Placement(transformation(extent={{-100,62},{-80,82}})));
  Modelica.Blocks.Sources.Constant desiredT_sup(k=293)
    annotation (Placement(transformation(extent={{64,12},{44,32}})));
  AHU                                 ahu(
    clockPeriodGeneric=1,
    heating=true,
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
  Modelica.Blocks.Sources.Sine waterLoadOutside(
    f=1/86400,
    offset=0.008,
    amplitude=0.002,
    phase=-0.054829518451402)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Modelica.Blocks.Sources.Constant phi_RoomExtractAir(k=0.6)
    annotation (Placement(transformation(extent={{98,14},{78,34}})));
  Modelica.Blocks.Sources.Sine tempAddInRoom(
    f=1/86400,
    amplitude=2,
    phase=-3.1415/4,
    offset=1.7)
              annotation (Placement(transformation(extent={{98,58},{78,78}})));
  Modelica.Blocks.Math.Add addToExtractTemp
    annotation (Placement(transformation(extent={{46,50},{34,62}})));
  ModularAHU modularAHU(
    humidifying=false,
    cooling=true,
    dehumidifying=false,
    heating=true,
    heatRecovery=true,
    usePhiSet=true,
    limPhiOda=false)
    annotation (Placement(transformation(extent={{-54,-68},{16,-30}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-46,-100},{-66,-80}})));
  ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum annotation (Placement(transformation(extent={{-82,-58},{-72,-48}})));
equation
  connect(desiredT_sup.y,ahu. T_supplyAir) annotation (Line(
      points={{43,22},{34,22},{34,31.7},{18.48,31.7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tempOutside.y,ahu. T_outdoorAir) annotation (Line(
      points={{-79,32},{-74,32},{-74,30.8},{-62.36,30.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Vflow_in.y,ahu. Vflow_in) annotation (Line(
      points={{-79,72},{-76,72},{-76,33.5},{-66.12,33.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMin.y,ahu. phi_supplyAir[1]) annotation (Line(
      points={{47,-8},{32,-8},{32,26.75},{18.48,26.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(waterLoadOutside.y,ahu. X_outdoorAir) annotation (Line(
      points={{-79,-2},{-72,-2},{-72,26.3},{-62.36,26.3}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_RoomExtractAir.y,ahu. phi_extractAir) annotation (Line(
      points={{77,24},{66,24},{66,38},{30,38},{30,43.4},{18.48,43.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMax.y,ahu. phi_supplyAir[2]) annotation (Line(points={{77,-8},
          {72,-8},{72,-28},{28,-28},{28,27.65},{18.48,27.65}},        color={0,0,
          127}));
  connect(ahu.T_extractAir,addToExtractTemp. y) annotation (Line(points={{18.48,
          47.9},{27.92,47.9},{27.92,56},{33.4,56}},       color={0,0,127}));
  connect(tempAddInRoom.y,addToExtractTemp. u1) annotation (Line(points={{77,68},
          {56,68},{56,59.6},{47.2,59.6}},         color={0,0,127}));
  connect(desiredT_sup.y,addToExtractTemp. u2) annotation (Line(points={{43,22},
          {38,22},{38,44},{56,44},{56,52.4},{47.2,52.4}},color={0,0,127}));
  connect(Vflow_in.y, modularAHU.VOda_flow) annotation (Line(points={{-79,72},{-76,
          72},{-76,50},{-100,50},{-100,-37.6},{-54.875,-37.6}}, color={0,0,127}));
  connect(tempOutside.y, modularAHU.TOda) annotation (Line(points={{-79,32},{-74,
          32},{-74,16},{-100,16},{-100,-42},{-78,-42},{-78,-41.4},{-54.875,-41.4}},
        color={0,0,127}));
  connect(Vflow_in.y, modularAHU.VEta_flow) annotation (Line(points={{-79,72},{-76,
          72},{-76,50},{-100,50},{-100,-26},{22,-26},{22,-38},{20,-38},{20,-37.6},
          {16.875,-37.6}}, color={0,0,127}));
  connect(addToExtractTemp.y, modularAHU.TEta) annotation (Line(points={{33.4,
          56},{28,56},{28,86},{100,86},{100,-41.4},{16.875,-41.4}}, color={0,0,
          127}));
  connect(phi_roomMin.y, modularAHU.phiSupSet[1]) annotation (Line(points={{47,-8},
          {32,-8},{32,-80},{7.25,-80},{7.25,-68.95}}, color={0,0,127}));
  connect(phi_roomMax.y, modularAHU.phiSupSet[2]) annotation (Line(points={{77,-8},
          {72,-8},{72,-80},{7.25,-80},{7.25,-68.57}}, color={0,0,127}));
  connect(desiredT_sup.y, modularAHU.TSupSet) annotation (Line(points={{43,22},
          {38,22},{38,-74},{11.625,-74},{11.625,-68.76}},color={0,0,127}));
  connect(modularAHU.QCoo_flow, abs1.u) annotation (Line(points={{-30.1562,
          -68.95},{-30.1562,-90},{-44,-90}},
                                     color={0,0,127}));
  connect(phi_RoomExtractAir.y, modularAHU.phiEta) annotation (Line(points={{77,
          24},{70,24},{70,-45.2},{16.875,-45.2}}, color={0,0,127}));
  connect(absToRelHum.relHum, modularAHU.phiOda) annotation (Line(points={{-71,-53},
          {-62.5,-53},{-62.5,-45.2},{-54.875,-45.2}}, color={0,0,127}));
  connect(absToRelHum.absHum, waterLoadOutside.y) annotation (Line(points={{-83,
          -50.4},{-83,-50},{-92,-50},{-92,-32},{-72,-32},{-72,-2},{-79,-2}},
        color={0,0,127}));
  connect(tempOutside.y, absToRelHum.TDryBul) annotation (Line(points={{-79,32},
          {-74,32},{-74,16},{-100,16},{-100,-56},{-92,-56},{-92,-55.8},{-83,
          -55.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=1,
      Tolerance=1e-04,
      __Dymola_Algorithm="Dassl"));
end ComparisonToAHU;
