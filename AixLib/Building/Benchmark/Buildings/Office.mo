within AixLib.Building.Benchmark.Buildings;
model Office
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Floors.FirstFloor firstFloor
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_North
    annotation (Placement(transformation(extent={{110,70},{90,90}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_East
    annotation (Placement(transformation(extent={{110,40},{90,60}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_South
    annotation (Placement(transformation(extent={{110,10},{90,30}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_West
    annotation (Placement(transformation(extent={{110,-20},{90,0}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North[5]
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Hor annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA[5]
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[5](redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={0,78})));
  Modelica.Blocks.Interfaces.RealInput AirTemp annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,100}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-2,98})));
  Floors.GroundFloor groundFloor
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower[5]
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Blocks.Interfaces.RealInput mWat[5]
    "Water flow rate added into the medium"
    annotation (Placement(transformation(extent={{-114,26},{-86,54}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=100,
    V=10,
    nPorts=11) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-67,-53})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  connect(firstFloor.WindSpeedPort_North, WindSpeedPort_North) annotation (Line(
        points={{20,56},{80,56},{80,80},{100,80}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_East, WindSpeedPort_East) annotation (Line(
        points={{20,52},{80,52},{80,50},{100,50}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_South, WindSpeedPort_South) annotation (Line(
        points={{20,48},{80,48},{80,20},{100,20}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_Hor, WindSpeedPort_Hor) annotation (Line(
        points={{16,60},{16,80},{80,80},{80,100}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_West, WindSpeedPort_West) annotation (Line(
        points={{20,44},{80,44},{80,-10},{100,-10}}, color={0,0,127}));
  connect(firstFloor.SolarRadiationPort_Hor, SolarRadiationPort_North[5])
    annotation (Line(points={{-16,59.2},{-16,88},{-100,88}}, color={255,128,0}));
  connect(firstFloor.SolarRadiationPort_North, SolarRadiationPort_North[1])
    annotation (Line(points={{-19.2,56},{-40,56},{-40,72},{-100,72}}, color={
          255,128,0}));
  connect(firstFloor.SolarRadiationPort_East, SolarRadiationPort_North[2])
    annotation (Line(points={{-19.2,52},{-40,52},{-40,76},{-100,76}}, color={
          255,128,0}));
  connect(firstFloor.SolarRadiationPort_South, SolarRadiationPort_North[3])
    annotation (Line(points={{-19.2,48},{-40,48},{-40,80},{-100,80}}, color={
          255,128,0}));
  connect(firstFloor.SolarRadiationPort_West, SolarRadiationPort_North[4])
    annotation (Line(points={{-19.2,44},{-40,44},{-40,84},{-100,84}}, color={
          255,128,0}));
  connect(prescribedTemperature.port, firstFloor.HeatPort_OutdoorTemp)
    annotation (Line(points={{-1.11022e-015,72},{-1.11022e-015,64},{0,64},{0,60}},
        color={191,0,0}));
  connect(AirTemp, prescribedTemperature.T)
    annotation (Line(points={{0,100},{0,85.2}}, color={0,0,127}));
  connect(firstFloor.HeatPort_ToWorkshop_MultiPersonOffice, groundFloor.HeatPort_FromWorkshop)
    annotation (Line(points={{-12.8,20},{-12,20},{-12,0},{-8,0},{-8,-20}},
        color={191,0,0}));
  connect(firstFloor.HeatPort_ToWorkshop_ConferenceRoom, groundFloor.HeatPort_FromWorkshop)
    annotation (Line(points={{-6.4,20},{-6.4,0},{-8,0},{-8,-20}}, color={191,0,
          0}));
  connect(firstFloor.HeatPort_ToWorkshop_OpenPlanOffice, groundFloor.HeatPort_FromWorkshop)
    annotation (Line(points={{0,20},{0,20},{0,0},{-8,0},{-8,-20}}, color={191,0,
          0}));
  connect(firstFloor.HeatPort_ToKitchen_OpenPlanOffice, groundFloor.HeatPort_FromCanteen)
    annotation (Line(points={{8,20},{8,-20}}, color={191,0,0}));
  connect(firstFloor.Heatport_TBA, Heatport_TBA)
    annotation (Line(points={{20,28},{60,28},{60,-100}}, color={191,0,0}));
  connect(groundFloor.Heatport_TBA, Heatport_TBA)
    annotation (Line(points={{20,-52},{60,-52},{60,-100}}, color={191,0,0}));
  connect(groundFloor.Air_in, Air_in) annotation (Line(points={{-20,-56},{-40,
          -56},{-40,-100}}, color={0,127,255}));
  connect(firstFloor.Air_in, Air_in) annotation (Line(points={{-20,24},{-40,24},
          {-40,-100}}, color={0,127,255}));
  connect(groundFloor.WindSpeedPort_North, WindSpeedPort_North) annotation (
      Line(points={{20,-24},{80,-24},{80,80},{100,80}}, color={0,0,127}));
  connect(groundFloor.WindSpeedPort_East, WindSpeedPort_East) annotation (Line(
        points={{20,-28},{80,-28},{80,50},{100,50},{100,50}}, color={0,0,127}));
  connect(groundFloor.WindSpeedPort_South, WindSpeedPort_South) annotation (
      Line(points={{20,-32},{80,-32},{80,20},{100,20},{100,20}}, color={0,0,127}));
  connect(groundFloor.WindSpeedPort_West, WindSpeedPort_West) annotation (Line(
        points={{20,-36},{80,-36},{80,-10},{100,-10}}, color={0,0,127}));
  connect(groundFloor.SolarRadiationPort_North, SolarRadiationPort_North[1])
    annotation (Line(points={{-19.2,-24},{-40,-24},{-40,72},{-100,72}}, color={
          255,128,0}));
  connect(groundFloor.SolarRadiationPort_East, SolarRadiationPort_North[2])
    annotation (Line(points={{-19.2,-28},{-40,-28},{-40,76},{-100,76}}, color={
          255,128,0}));
  connect(groundFloor.SolarRadiationPort_South, SolarRadiationPort_North[3])
    annotation (Line(points={{-19.2,-32},{-40,-32},{-40,80},{-100,80}}, color={
          255,128,0}));
  connect(groundFloor.SolarRadiationPort_West, SolarRadiationPort_North[4])
    annotation (Line(points={{-19.2,-36},{-40,-36},{-40,84},{-100,84}}, color={
          255,128,0}));
  connect(groundFloor.HeatPort_OutdoorTemp, firstFloor.HeatPort_OutdoorTemp)
    annotation (Line(points={{0,-60},{0,-80},{60,-80},{60,68},{0,68},{0,66},{0,
          66},{0,60}}, color={191,0,0}));
  connect(groundFloor.AddPower, AddPower) annotation (Line(points={{8.4,-60},{8,
          -60},{8,-80},{-80,-80},{-80,-40},{-100,-40}}, color={191,0,0}));
  connect(firstFloor.AddPower, AddPower) annotation (Line(points={{8.4,59.6},{
          8.4,68},{-80,68},{-80,-40},{-100,-40}}, color={191,0,0}));
  connect(firstFloor.mWat, mWat) annotation (Line(points={{-8,60},{-8,68},{-80,
          68},{-80,40},{-100,40}}, color={0,0,127}));
  connect(groundFloor.mWat, mWat) annotation (Line(points={{-8,-60},{-8,-80},{
          -80,-80},{-80,40},{-100,40}}, color={0,0,127}));
  connect(groundFloor.Air_out, vol1.ports[1:5]) annotation (Line(points={{-20,
          -48},{-60,-48},{-60,-53.5091}}, color={0,127,255}));
  connect(firstFloor.Air_out, vol1.ports[6:10]) annotation (Line(points={{-20,32},
          {-40,32},{-40,32},{-60,32},{-60,-50.9636}},     color={0,127,255}));
  connect(vol1.ports[11], Air_out) annotation (Line(points={{-60,-50.4545},{-60,
          -86},{-80,-86},{-80,-100}}, color={0,127,255}));
  connect(measureBus, groundFloor.measureBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,-80},{60,-80},{60,-44},{20,-44}},
      color={255,204,51},
      thickness=0.5));
  connect(measureBus, firstFloor.measureBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,-80},{60,-80},{60,36},{20,36}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office;
