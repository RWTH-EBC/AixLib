within AixLib.Systems.Benchmark.Model.Building.Floors;
model EastWing
  replaceable package Medium =
    AixLib.Media.Air "Medium in the component";
  Rooms.OpenPlanOffice_v2
                       openPlanOffice
    annotation (Placement(transformation(extent={{18,-16},{54,18}})));
  Rooms.MultiPersonOffice_v2
                          multiPersonOffice
    annotation (Placement(transformation(extent={{-52,14},{-16,48}})));
  Rooms.ConferenceRoom_v2
                       conferenceRoom
    annotation (Placement(transformation(extent={{-52,-50},{-16,-16}})));
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{80,0},{120,40}})));
  BusSystems.InternalBus internalBus
    annotation (Placement(transformation(extent={{80,40},{120,80}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out_Multipersonoffice(redeclare
      package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in_Multipersonoffice(redeclare
      package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out_Openplanoffice(redeclare
      package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in_Openplanoffice(redeclare package
      Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out_Conferenceroom(redeclare
      package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in_Conferenceroom(redeclare package
      Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
    Heatport_TBA_Openplanoffice
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
    Heatport_TBA_ConferenceRoom
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
    Heatport_TBA_Multipersonoffice
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_OpenPlanOffice
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_ConferenceRoom
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    AddPower_MultiPersonOffice
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={104,104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
    annotation (Placement(transformation(extent={{116,-96},{96,-76}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_South annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={66,-106})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp(T=286.65)
    annotation (Placement(transformation(extent={{-72,-72},{-60,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp1(
                                                                    T=286.65)
    annotation (Placement(transformation(extent={{-74,4},{-62,16}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp2(
                                                                    T=286.65)
    annotation (Placement(transformation(extent={{6,-42},{18,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToCanteen1
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
equation
  connect(openPlanOffice.measureBus, measureBus) annotation (Line(
      points={{18,-9.2},{0,-9.2},{0,-80},{80,-80},{80,20},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(conferenceRoom.measureBus, measureBus) annotation (Line(
      points={{-52,-43.2},{-80,-43.2},{-80,-80},{80,-80},{80,20},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(multiPersonOffice.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{-23.2,48},{-23.2,80},{80,80},{80,60},{90,60},{90,60.1},
          {100.1,60.1}},          color={0,0,127}));
  connect(multiPersonOffice.mFlow_Water, internalBus.InternalLoads_MFlow_Multipersonoffice)
    annotation (Line(points={{-52,46.3},{-80,46.3},{-80,80},{80,80},{80,60.1},{
          100.1,60.1}},        color={0,0,127}));
  connect(openPlanOffice.mFlow_Water, internalBus.InternalLoads_MFlow_Openplanoffice)
    annotation (Line(points={{18,16.3},{0,16.3},{0,80},{80,80},{80,60.1},{100.1,
          60.1}},       color={0,0,127}));
  connect(conferenceRoom.mFlow_Water, internalBus.InternalLoads_MFlow_Conferenceroom)
    annotation (Line(points={{-52,-17.7},{-80,-17.7},{-80,-80},{80,-80},{80,
          60.1},{100.1,60.1}},    color={0,0,127}));
  connect(conferenceRoom.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{-23.2,-16},{-23.2,0},{-80,0},{-80,80},{80,80},{80,
          60.1},{100.1,60.1}},     color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
    annotation (Line(points={{28.8,18},{28.8,80},{80,80},{80,60.1},{100.1,60.1}},
                  color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{46.8,18},{46.8,80},{80,80},{80,60.1},{100.1,60.1}},
                  color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_EastWall, internalBus.InternalLoads_Wind_Speed_East)
    annotation (Line(points={{54,-5.8},{80,-5.8},{80,60.1},{100.1,60.1}},
        color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
    annotation (Line(points={{28.8,-16},{28.8,-80},{80,-80},{80,60.1},{100.1,60.1}},
                        color={0,0,127}));
  connect(multiPersonOffice.measureBus, measureBus) annotation (Line(
      points={{-52,20.8},{-80,20.8},{-80,20},{-80,20},{-80,22},{-80,22},{-80,80},
          {80,80},{80,20},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(multiPersonOffice.Air_out, Air_out_Multipersonoffice) annotation (
      Line(points={{-16,37.8},{0,37.8},{0,36},{0,36},{0,0},{-80,0},{-80,-40},{-100,
          -40}},       color={0,127,255}));
  connect(multiPersonOffice.Air_in, Air_in_Multipersonoffice) annotation (Line(
        points={{-16,31},{-8,31},{-8,32},{0,32},{0,0},{-80,0},{-80,-60},{-100,-60}},
                      color={0,127,255}));
  connect(openPlanOffice.Air_out, Air_out_Openplanoffice) annotation (Line(
        points={{54,7.8},{80,7.8},{80,6},{80,6},{80,80},{-80,80},{-80,40},{-100,
          40}},      color={0,127,255}));
  connect(openPlanOffice.Air_in, Air_in_Openplanoffice) annotation (Line(points={{54,1},{
          68,1},{68,2},{80,2},{80,80},{-80,80},{-80,20},{-100,20}},
        color={0,127,255}));
  connect(conferenceRoom.Air_out, Air_out_Conferenceroom) annotation (Line(
        points={{-16,-26.2},{-14,-26.2},{-14,-28},{0,-28},{0,0},{-100,0}},
        color={0,127,255}));
  connect(conferenceRoom.Air_in, Air_in_Conferenceroom) annotation (Line(points={{-16,-33},
          {-12,-33},{-12,-32},{0,-32},{0,0},{-80,0},{-80,-20},{-100,-20}},
                      color={0,127,255}));
  connect(openPlanOffice.Heatport_TBA, Heatport_TBA_Openplanoffice) annotation (
     Line(points={{54,12.9},{80,12.9},{80,-20},{100,-20}}, color={191,0,0}));
  connect(multiPersonOffice.Heatport_TBA, Heatport_TBA_Multipersonoffice)
    annotation (Line(points={{-16,42.9},{0,42.9},{0,-80},{80,-80},{80,-60},{100,
          -60},{100,-60}},     color={191,0,0}));
  connect(multiPersonOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{-17.8,49.7},{-17.8,80},{-22,80},{-22,80},{104,80},
          {104,104}}, color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{34.2,19.7},{34.2,50},{38,50},{38,80},{70,80},{70,104}},
                 color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{52.2,19.7},{52.2,80},{48,80},{48,80},{104,80},{104,
          104}},     color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_EastWall, SolarRadiationPort_East)
    annotation (Line(points={{55.8,-10.9},{80,-10.9},{80,-86},{106,-86}},
                                                                        color={
          255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{34.2,-17.7},{34.2,-80},{66,-80},{66,-106}},
        color={255,128,0}));
  connect(conferenceRoom.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{-17.8,-14.3},{-17.8,0},{0,0},{0,80},{104,80},{104,
          104}}, color={255,128,0}));
  connect(multiPersonOffice.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
    annotation (Line(points={{-23.2,14},{-23.2,0},{0,0},{0,80},{80,80},{80,60.1},
          {100.1,60.1}},       color={0,0,127}));
  connect(conferenceRoom.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
    annotation (Line(points={{-39.76,-16},{-39.76,0},{0,0},{0,80},{80,80},{80,60.1},
          {100.1,60.1}},       color={0,0,127}));
  connect(SolarRadiationPort_North, conferenceRoom.SolarRadiationPort_NorthWall)
    annotation (Line(points={{70,104},{70,80},{0,80},{0,0},{-35.8,0},{-35.8,-14.3}},
                   color={255,128,0}));
  connect(SolarRadiationPort_South, multiPersonOffice.SolarRadiationPort_SouthWall)
    annotation (Line(points={{66,-106},{66,-80},{0,-80},{0,0},{-17.8,0},{-17.8,
          12.3}}, color={255,128,0}));
  connect(GroundTemp1.port, multiPersonOffice.HeatPort_ToGround) annotation (
      Line(points={{-62,10},{-43,10},{-43,14}},       color={191,0,0}));
  connect(GroundTemp.port, conferenceRoom.HeatPort_ToGround) annotation (Line(
        points={{-60,-66},{-52,-66},{-52,-50},{-43,-50}}, color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToConferenceRoom, conferenceRoom.HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{18,4.4},{-4,4.4},{-4,-50},{-25,-50}}, color={191,0,
          0}));
  connect(AddPower_ConferenceRoom, conferenceRoom.AddPower_System) annotation (
      Line(points={{-40,100},{-46,100},{-46,-22.8},{-52,-22.8}}, color={191,0,0}));
  connect(conferenceRoom.Heatport_TBA, Heatport_TBA_ConferenceRoom) annotation (
     Line(points={{-16,-21.1},{-16,-22},{-14,-22},{-14,-40},{100,-40}}, color={191,
          0,0}));
  connect(GroundTemp2.port, openPlanOffice.HeatPort_ToGround) annotation (Line(
        points={{18,-36},{28,-36},{28,-16},{38.52,-16}}, color={191,0,0}));
  connect(multiPersonOffice.HeatPort_ToOpenPlanOffice, openPlanOffice.HeatPort_ToMultiPersonOffice)
    annotation (Line(points={{-16,25.9},{16,25.9},{16,-16},{48.6,-16}}, color={191,
          0,0}));
  connect(HeatPort_ToCanteen1, openPlanOffice.HeatPort_ToCanteen) annotation (
      Line(points={{-100,80},{-42,80},{-42,-4.1},{18,-4.1}}, color={191,0,0}));
  connect(AddPower_OpenPlanOffice, openPlanOffice.AddPower_System) annotation (
      Line(points={{0,100},{10,100},{10,11.2},{18,11.2}}, color={191,0,0}));
  connect(AddPower_MultiPersonOffice, multiPersonOffice.AddPower_System)
    annotation (Line(points={{-80,100},{-66,100},{-66,41.2},{-52,41.2}}, color={
          191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EastWing;
