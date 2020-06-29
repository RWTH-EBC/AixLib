within AixLib.Systems.Benchmark.Model.Building;
model Office_v2
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[5](redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium_Air,
    V=10,
    nPorts=6,
    m_flow_nominal=3.375)
               annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-67,-69})));
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA[5]
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower[5]
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  BusSystems.InternalBus internalBus
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_South1
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_West1
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor1
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
  Floors.WestWing westWing
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  Floors.EastWing eastWing
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
equation
  connect(vol1.ports[1],  Air_out) annotation (Line(points={{-60,-71.3333},{-60,
          -86},{-80,-86},{-80,-100}}, color={0,127,255}));
  connect(eastWing.HeatPort_ToCanteen1, westWing.HeatPort_ToOpenplanoffice1)
    annotation (Line(points={{20,16},{0,16},{0,-1.6},{-20,-1.6}}, color={191,0,
          0}));
  connect(westWing.AddPower_Canteen, AddPower[4]) annotation (Line(points={{-60,
          -20},{-80,-20},{-80,-36},{-100,-36}}, color={191,0,0}));
  connect(westWing.AddPower_Workshop, AddPower[5]) annotation (Line(points={{
          -60,-12},{-80,-12},{-80,-32},{-100,-32}}, color={191,0,0}));
  connect(eastWing.AddPower_MultiPersonOffice, AddPower[3]) annotation (Line(
        points={{24,20},{24,40},{-80,40},{-80,-40},{-100,-40}}, color={191,0,0}));
  connect(eastWing.AddPower_ConferenceRoom, AddPower[2]) annotation (Line(
        points={{32,20},{32,40},{-80,40},{-80,-44},{-100,-44}}, color={191,0,0}));
  connect(eastWing.AddPower_OpenPlanOffice, AddPower[1]) annotation (Line(
        points={{40,20},{40,40},{-80,40},{-80,-48},{-100,-48}}, color={191,0,0}));
  connect(westWing.internalBus, internalBus) annotation (Line(
      points={{-20,12},{0,12},{0,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(westWing.measureBus, measureBus) annotation (Line(
      points={{-19.6,4},{0,4},{0,40},{-80,40},{-80,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(eastWing.internalBus, internalBus) annotation (Line(
      points={{60,12},{80,12},{80,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(eastWing.measureBus, measureBus) annotation (Line(
      points={{60,4},{80,4},{80,40},{-80,40},{-80,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(westWing.Heatport_TBA_Workshop, Heatport_TBA[5]) annotation (Line(
        points={{-20,-16},{0,-16},{0,-80},{60,-80},{60,-92}}, color={191,0,0}));
  connect(westWing.Heatport_TBA_Canteen, Heatport_TBA[4]) annotation (Line(
        points={{-20,-8},{0,-8},{0,-80},{60,-80},{60,-96}}, color={191,0,0}));
  connect(eastWing.Heatport_TBA_Openplanoffice, Heatport_TBA[1]) annotation (
      Line(points={{60,-4},{80,-4},{80,-80},{60,-80},{60,-108}}, color={191,0,0}));
  connect(eastWing.Heatport_TBA_ConferenceRoom, Heatport_TBA[2]) annotation (
      Line(points={{60,-8},{80,-8},{80,-80},{60,-80},{60,-104}}, color={191,0,0}));
  connect(eastWing.Heatport_TBA_Multipersonoffice, Heatport_TBA[3]) annotation (
     Line(points={{60,-12},{80,-12},{80,-80},{60,-80},{60,-100}}, color={191,0,
          0}));
  connect(eastWing.SolarRadiationPort_East, SolarRadiationPort_East)
    annotation (Line(points={{61.2,-17.2},{80,-17.2},{80,40},{90,40}}, color={
          255,128,0}));
  connect(eastWing.SolarRadiationPort_South, SolarRadiationPort_South1)
    annotation (Line(points={{53.2,-21.2},{53.2,-40},{80,-40},{80,0},{90,0}},
        color={255,128,0}));
  connect(eastWing.SolarRadiationPort_Hor, SolarRadiationPort_Hor1) annotation (
     Line(points={{60.8,20.8},{60.8,40},{80,40},{80,-80},{90,-80}}, color={255,
          128,0}));
  connect(eastWing.SolarRadiationPort_North, SolarRadiationPort_North)
    annotation (Line(points={{54,20.8},{54,40},{80,40},{80,80},{90,80}}, color=
          {255,128,0}));
  connect(westWing.SolarRadiationPort_Hor, SolarRadiationPort_Hor1) annotation (
     Line(points={{-24,20.8},{-24,40},{80,40},{80,-80},{90,-80}}, color={255,
          128,0}));
  connect(westWing.SolarRadiationPort_North, SolarRadiationPort_North)
    annotation (Line(points={{-40,20.8},{-40,40},{80,40},{80,80},{90,80}},
        color={255,128,0}));
  connect(westWing.SolarRadiationPort_West, SolarRadiationPort_West1)
    annotation (Line(points={{-60.8,16},{-80,16},{-80,40},{80,40},{80,-40},{90,
          -40}}, color={255,128,0}));
  connect(westWing.SolarRadiationPort_South, SolarRadiationPort_West1)
    annotation (Line(points={{-28,-20.8},{-28,-40},{74,-40},{74,-40},{90,-40}},
        color={255,128,0}));
  connect(westWing.Air_out_Canteen, vol1.ports[2]) annotation (Line(points={{
          -60,8},{-70,8},{-70,-40},{-60,-40},{-60,-70.4}}, color={0,127,255}));
  connect(westWing.Air_out_Workshop, vol1.ports[3]) annotation (Line(points={{-60,0},
          {-70,0},{-70,-40},{-60,-40},{-60,-69.4667}},        color={0,127,255}));
  connect(eastWing.Air_out_Openplanoffice, vol1.ports[4]) annotation (Line(
        points={{20,8},{0,8},{0,-40},{-60,-40},{-60,-68.5333}}, color={0,127,
          255}));
  connect(eastWing.Air_out_Conferenceroom, vol1.ports[5]) annotation (Line(
        points={{20,0},{0,0},{0,-40},{-60,-40},{-60,-67.6}}, color={0,127,255}));
  connect(eastWing.Air_out_Multipersonoffice, vol1.ports[6]) annotation (Line(
        points={{20,-8},{0,-8},{0,-40},{-60,-40},{-60,-66.6667}}, color={0,127,
          255}));
  connect(westWing.Air_in_Workshop, Air_in[5]) annotation (Line(points={{-60,-4},
          {-66,-4},{-66,-36},{-40,-36},{-40,-92}}, color={0,127,255}));
  connect(westWing.Air_in_Canteen, Air_in[4]) annotation (Line(points={{-60,4},
          {-66,4},{-66,-36},{-40,-36},{-40,-96}}, color={0,127,255}));
  connect(eastWing.Air_in_Multipersonoffice, Air_in[3]) annotation (Line(points=
         {{20,-12},{4,-12},{4,-36},{-40,-36},{-40,-100}}, color={0,127,255}));
  connect(eastWing.Air_in_Conferenceroom, Air_in[2]) annotation (Line(points={{
          20,-4},{4,-4},{4,-36},{-40,-36},{-40,-104}}, color={0,127,255}));
  connect(eastWing.Air_in_Openplanoffice, Air_in[1]) annotation (Line(points={{
          20,4},{4,4},{4,-36},{-40,-36},{-40,-108}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office_v2;
