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
  connect(openPlanOffice.HeatPort_ToConferenceRoom, conferenceRoom.HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{18,5.42},{0,5.42},{0,-4},{0,-4},{0,-36},{0,-36},{
          0,-36},{0,-80},{-28,-80},{-28,-66},{-28.6,-66},{-28.6,-50}},
                       color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToMultiPersonOffice, multiPersonOffice.HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{48.6,-16},{48,-16},{48,-80},{0,-80},{0,6},{0,6},{
          0,24},{0,24},{0,24},{0,23.86},{-10,23.86},{-16,23.86}},
                                    color={191,0,0}));
  connect(openPlanOffice.measureBus, measureBus) annotation (Line(
      points={{18,-9.2},{0,-9.2},{0,-80},{80,-80},{80,20},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(conferenceRoom.measureBus, measureBus) annotation (Line(
      points={{-52,-43.2},{-80,-43.2},{-80,-80},{80,-80},{80,20},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(multiPersonOffice.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{-26.8,48.68},{-26.8,80},{80,80},{80,60},{90,60},{
          90,60.1},{100.1,60.1}}, color={0,0,127}));
  connect(multiPersonOffice.mWat_MultiPersonOffice, internalBus.InternalLoads_MFlow_Multipersonoffice)
    annotation (Line(points={{-52.72,46.64},{-80,46.64},{-80,80},{80,80},{80,
          60.1},{100.1,60.1}}, color={0,0,127}));
  connect(openPlanOffice.mWat_OpenPlanOffice, internalBus.InternalLoads_MFlow_Openplanoffice)
    annotation (Line(points={{17.28,16.64},{0,16.64},{0,80},{80,80},{80,60.1},{
          100.1,60.1}}, color={0,0,127}));
  connect(conferenceRoom.mWat_ConferenceRoom, internalBus.InternalLoads_MFlow_Conferenceroom)
    annotation (Line(points={{-52.72,-17.36},{-80,-17.36},{-80,-80},{80,-80},{
          80,60.1},{100.1,60.1}}, color={0,0,127}));
  connect(conferenceRoom.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{-26.8,-15.32},{-26.8,0},{-80,0},{-80,80},{80,80},
          {80,60.1},{100.1,60.1}}, color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
    annotation (Line(points={{32.4,18.68},{32.4,80},{80,80},{80,60.1},{100.1,
          60.1}}, color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{43.2,18.68},{43.2,80},{80,80},{80,60.1},{100.1,
          60.1}}, color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_EastWall, internalBus.InternalLoads_Wind_Speed_East)
    annotation (Line(points={{54.72,-2.06},{80,-2.06},{80,60.1},{100.1,60.1}},
        color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
    annotation (Line(points={{21.24,-17.02},{21.24,-80},{80,-80},{80,60.1},{
          100.1,60.1}}, color={0,0,127}));
  connect(multiPersonOffice.measureBus, measureBus) annotation (Line(
      points={{-52,20.8},{-80,20.8},{-80,20},{-80,20},{-80,22},{-80,22},{-80,80},
          {80,80},{80,20},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(multiPersonOffice.Air_out, Air_out_Multipersonoffice) annotation (
      Line(points={{-16,35.76},{0,35.76},{0,36},{0,36},{0,0},{-80,0},{-80,-40},
          {-100,-40}}, color={0,127,255}));
  connect(multiPersonOffice.Air_in, Air_in_Multipersonoffice) annotation (Line(
        points={{-16,32.02},{-8,32.02},{-8,32},{0,32},{0,0},{-80,0},{-80,-60},{
          -100,-60}}, color={0,127,255}));
  connect(openPlanOffice.Air_out, Air_out_Openplanoffice) annotation (Line(
        points={{54,5.76},{80,5.76},{80,6},{80,6},{80,80},{-80,80},{-80,40},{
          -100,40}}, color={0,127,255}));
  connect(openPlanOffice.Air_in, Air_in_Openplanoffice) annotation (Line(points=
         {{54,2.02},{68,2.02},{68,2},{80,2},{80,80},{-80,80},{-80,20},{-100,20}},
        color={0,127,255}));
  connect(conferenceRoom.Air_out, Air_out_Conferenceroom) annotation (Line(
        points={{-16,-28.24},{-14,-28.24},{-14,-28},{0,-28},{0,0},{-100,0}},
        color={0,127,255}));
  connect(conferenceRoom.Air_in, Air_in_Conferenceroom) annotation (Line(points=
         {{-16,-31.98},{-12,-31.98},{-12,-32},{0,-32},{0,0},{-80,0},{-80,-20},{
          -100,-20}}, color={0,127,255}));
  connect(openPlanOffice.Heatport_TBA, Heatport_TBA_Openplanoffice) annotation (
     Line(points={{54,9.16},{80,9.16},{80,-20},{100,-20}}, color={191,0,0}));
  connect(conferenceRoom.Heatport_TBA, Heatport_TBA_ConferenceRoom) annotation (
     Line(points={{-16,-24.84},{0,-24.84},{0,-26},{0,-26},{0,-80},{80,-80},{80,
          -40},{100,-40}}, color={191,0,0}));
  connect(multiPersonOffice.Heatport_TBA, Heatport_TBA_Multipersonoffice)
    annotation (Line(points={{-16.36,42.9},{0,42.9},{0,-80},{80,-80},{80,-60},{
          100,-60},{100,-60}}, color={191,0,0}));
  connect(openPlanOffice.AddPower_OpenPlanOffice, AddPower_OpenPlanOffice)
    annotation (Line(points={{18,12.9},{0,12.9},{0,100}}, color={191,0,0}));
  connect(conferenceRoom.AddPower_ConferenceRoom, AddPower_ConferenceRoom)
    annotation (Line(points={{-52,-21.1},{-80,-21.1},{-80,-22},{-80,-22},{-80,
          80},{-40,80},{-40,100}}, color={191,0,0}));
  connect(multiPersonOffice.AddPower_MultiPersonOffice,
    AddPower_MultiPersonOffice) annotation (Line(points={{-52,42.9},{-80,42.9},
          {-80,42},{-80,42},{-80,100},{-80,100}}, color={191,0,0}));
  connect(multiPersonOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{-21.4,49.7},{-21.4,80},{-22,80},{-22,80},{104,80},
          {104,104}}, color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{37.8,19.7},{37.8,50},{38,50},{38,80},{70,80},{70,
          104}}, color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{48.6,19.7},{48.6,80},{48,80},{48,80},{104,80},{
          104,104}}, color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_EastWall, SolarRadiationPort_East)
    annotation (Line(points={{55.8,-7.5},{80,-7.5},{80,-86},{106,-86}}, color={
          255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{31.68,-17.7},{31.68,-80},{66,-80},{66,-106}},
        color={255,128,0}));
  connect(conferenceRoom.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{-21.4,-14.3},{-21.4,0},{0,0},{0,80},{104,80},{104,
          104}}, color={255,128,0}));
  connect(multiPersonOffice.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
    annotation (Line(points={{-26.8,13.32},{-26.8,0},{0,0},{0,80},{80,80},{80,
          60.1},{100.1,60.1}}, color={0,0,127}));
  connect(conferenceRoom.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
    annotation (Line(points={{-41.2,-14.98},{-41.2,0},{0,0},{0,80},{80,80},{80,
          60.1},{100.1,60.1}}, color={0,0,127}));
  connect(SolarRadiationPort_North, conferenceRoom.SolarRadiationPort_NorthWall)
    annotation (Line(points={{70,104},{70,80},{0,80},{0,0},{-32.2,0},{-32.2,
          -14.3}}, color={255,128,0}));
  connect(SolarRadiationPort_South, multiPersonOffice.SolarRadiationPort_SouthWall)
    annotation (Line(points={{66,-106},{66,-80},{0,-80},{0,0},{-17.8,0},{-17.8,
          12.3}}, color={255,128,0}));
  connect(GroundTemp.port, conferenceRoom.HeatPort_ToGround) annotation (Line(
        points={{-60,-66},{-39.76,-66},{-39.76,-50}}, color={191,0,0}));
  connect(GroundTemp1.port, multiPersonOffice.HeatPort_ToGround) annotation (
      Line(points={{-62,10},{-39.04,10},{-39.04,14}}, color={191,0,0}));
  connect(GroundTemp2.port, openPlanOffice.HeatPort_ToGround) annotation (Line(
        points={{18,-36},{38.52,-36},{38.52,-16}}, color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToCanteen, HeatPort_ToCanteen1) annotation (
      Line(points={{18,-3.42},{12,-3.42},{12,-4},{0,-4},{0,80},{-100,80}},
        color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EastWing;
