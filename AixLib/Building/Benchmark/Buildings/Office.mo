within AixLib.Building.Benchmark.Buildings;
model Office
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Floors.FirstFloor firstFloor
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort[5]
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
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
        origin={8,80})));
  Floors.GroundFloor groundFloor
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=100,
    V=10,
    nPorts=6)  annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-67,-69})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA[5]
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower[5]
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  BusSystem.InternalBus internalBus
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
equation
  connect(prescribedTemperature.port, firstFloor.HeatPort_OutdoorTemp)
    annotation (Line(points={{8,74},{8,60}},
        color={191,0,0}));
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
  connect(vol1.ports[1],  Air_out) annotation (Line(points={{-60,-71.3333},{-60,
          -86},{-80,-86},{-80,-100}}, color={0,127,255}));
  connect(measureBus, groundFloor.measureBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,-80},{60,-80},{60,-36},{20.4,-36}},
      color={255,204,51},
      thickness=0.5));
  connect(measureBus, firstFloor.measureBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,-80},{60,-80},{60,44},{20,44}},
      color={255,204,51},
      thickness=0.5));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points=
          {{8,87.2},{8,92},{-26,92},{-26,68},{-80,68},{-80,0.1},{-99.9,0.1}},
        color={0,0,127}));
  connect(firstFloor.SolarRadiationPort, SolarRadiationPort) annotation (Line(
        points={{-18.4,54},{-40,54},{-40,80},{-100,80}}, color={255,128,0}));
  connect(firstFloor.Air_out_Openplanoffice, vol1.ports[2]) annotation (Line(
        points={{-20,48},{-60,48},{-60,-70.4}}, color={0,127,255}));
  connect(firstFloor.Air_out_Conferenceroom, vol1.ports[3]) annotation (Line(
        points={{-20,40},{-60,40},{-60,-69.4667}}, color={0,127,255}));
  connect(firstFloor.Air_out_Multipersonoffice, vol1.ports[4]) annotation (Line(
        points={{-20,32},{-60,32},{-60,-68.5333}}, color={0,127,255}));
  connect(firstFloor.Air_in_Openplanoffice, Air_in[1]) annotation (Line(points=
          {{-20,44},{-40,44},{-40,-108}}, color={0,127,255}));
  connect(firstFloor.Air_in_Conferenceroom, Air_in[2]) annotation (Line(points=
          {{-20,36},{-40,36},{-40,-104}}, color={0,127,255}));
  connect(firstFloor.Air_in_Multipersonoffice, Air_in[3]) annotation (Line(
        points={{-20,28},{-40,28},{-40,-100}}, color={0,127,255}));
  connect(firstFloor.Heatport_TBA_Openplanoffice, Heatport_TBA[1])
    annotation (Line(points={{20,36},{60,36},{60,-108}}, color={191,0,0}));
  connect(firstFloor.Heatport_TBA_ConferenceRoom, Heatport_TBA[2])
    annotation (Line(points={{20,32},{60,32},{60,-104}}, color={191,0,0}));
  connect(firstFloor.Heatport_TBA_Multipersonoffice, Heatport_TBA[3])
    annotation (Line(points={{20,28},{60,28},{60,-100}}, color={191,0,0}));
  connect(firstFloor.AddPower_MultiPersonOffice, AddPower[3]) annotation (Line(
        points={{-16,60},{-16,80},{-80,80},{-80,-40},{-100,-40}}, color={191,0,
          0}));
  connect(firstFloor.AddPower_ConferenceRoom, AddPower[2]) annotation (Line(
        points={{-8,60},{-8,80},{-80,80},{-80,-44},{-100,-44}}, color={191,0,0}));
  connect(firstFloor.AddPower_OpenPlanOffice, AddPower[1]) annotation (Line(
        points={{0,60},{0,80},{-80,80},{-80,-48},{-100,-48}}, color={191,0,0}));
  connect(groundFloor.AddPower_Workshop, AddPower[5]) annotation (Line(points={
          {-20,-52},{-40,-52},{-40,-80},{-80,-80},{-80,-32},{-100,-32}}, color=
          {191,0,0}));
  connect(groundFloor.AddPower_Canteen, AddPower[4]) annotation (Line(points={{
          -20,-60},{-40,-60},{-40,-80},{-80,-80},{-80,-36},{-100,-36}}, color={
          191,0,0}));
  connect(groundFloor.HeatPort_OutdoorTemp, firstFloor.HeatPort_OutdoorTemp)
    annotation (Line(points={{0,-60},{0,-80},{60,-80},{60,68},{8,68},{8,60}},
        color={191,0,0}));
  connect(groundFloor.Heatport_TBA_Canteen, Heatport_TBA[4])
    annotation (Line(points={{20,-48},{60,-48},{60,-96}}, color={191,0,0}));
  connect(groundFloor.Heatport_TBA_Workshop, Heatport_TBA[5])
    annotation (Line(points={{20,-56},{60,-56},{60,-92}}, color={191,0,0}));
  connect(groundFloor.internalBus, internalBus) annotation (Line(
      points={{20,-28},{60,-28},{60,-80},{-80,-80},{-80,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(firstFloor.internalBus, internalBus) annotation (Line(
      points={{20,52},{60,52},{60,-80},{-80,-80},{-80,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(groundFloor.Air_out_Canteen, vol1.ports[5]) annotation (Line(points={
          {-20,-32},{-60,-32},{-60,-67.6}}, color={0,127,255}));
  connect(groundFloor.Air_out_Workshop, vol1.ports[6]) annotation (Line(points={{-20,-40},
          {-60,-40},{-60,-66.6667}},            color={0,127,255}));
  connect(groundFloor.Air_in_Workshop, Air_in[5]) annotation (Line(points={{-20,
          -44},{-40,-44},{-40,-92}}, color={0,127,255}));
  connect(groundFloor.Air_in_Canteen, Air_in[4]) annotation (Line(points={{-20,
          -36},{-40,-36},{-40,-96}}, color={0,127,255}));
  connect(groundFloor.SolarRadiationPort, SolarRadiationPort) annotation (Line(
        points={{-18.4,-26},{-80,-26},{-80,80},{-100,80}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office;
