within AixLib.Building.Benchmark.Floors;
model FirstFloor
  replaceable package Medium =
    AixLib.Media.Air "Medium in the component";
  Rooms.OpenPlanOffice openPlanOffice
    annotation (Placement(transformation(extent={{18,-16},{54,18}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_North
    annotation (Placement(transformation(extent={{112,68},{88,92}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North
    annotation (Placement(transformation(extent={{-102,74},{-90,86}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_East
    annotation (Placement(transformation(extent={{112,48},{88,72}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_South
    annotation (Placement(transformation(extent={{112,28},{88,52}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
    annotation (Placement(transformation(extent={{-102,54},{-90,66}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_South
    annotation (Placement(transformation(extent={{-102,34},{-90,46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToWorkshop_OpenPlanOffice
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToKitchen_OpenPlanOffice
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_West
    annotation (Placement(transformation(extent={{-102,14},{-90,26}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-80,96})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_West
    annotation (Placement(transformation(extent={{112,8},{88,32}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Hor annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA[5]
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[5](redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out[5](redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Rooms.MultiPersonOffice multiPersonOffice
    annotation (Placement(transformation(extent={{-52,14},{-16,48}})));
  Rooms.ConferenceRoom conferenceRoom
    annotation (Placement(transformation(extent={{-52,-50},{-16,-16}})));
  Modelica.Blocks.Interfaces.RealInput mWat[5]
    "Water flow rate added into the medium" annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={-40,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower[5]
    annotation (Placement(transformation(extent={{32,88},{52,108}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop_ConferenceRoom
    annotation (Placement(transformation(extent={{-42,-110},{-22,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_ToWorkshop_MultiPersonOffice
    annotation (Placement(transformation(extent={{-74,-110},{-54,-90}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{80,-40},{120,0}})));
equation
  connect(openPlanOffice.WindSpeedPort_NorthWall, WindSpeedPort_North)
    annotation (Line(points={{32.4,18.68},{32.4,80},{100,80}}, color={0,0,127}));
  connect(openPlanOffice.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{37.8,19.7},{37.8,80},{-96,80}}, color={255,128,0}));
  connect(openPlanOffice.WindSpeedPort_EastWall, WindSpeedPort_East)
    annotation (Line(points={{54.72,-2.06},{80,-2.06},{80,60},{100,60}}, color=
          {0,0,127}));
  connect(openPlanOffice.WindSpeedPort_SouthWall, WindSpeedPort_South)
    annotation (Line(points={{21.24,-17.02},{21.24,-30},{80,-30},{80,40},{100,
          40}}, color={0,0,127}));
  connect(openPlanOffice.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{31.68,-17.7},{31.68,-80},{-80,-80},{-80,40},{-96,
          40}},  color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_EastWall, SolarRadiationPort_East)
    annotation (Line(points={{55.8,-7.5},{80,-7.5},{80,-80},{-80,-80},{-80,60},
          {-96,60}}, color={255,128,0}));
  connect(openPlanOffice.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp)
    annotation (Line(points={{26.64,18},{26,18},{26,80},{0,80},{0,100}},
                                                           color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToWorkshop,
    HeatPort_ToWorkshop_OpenPlanOffice) annotation (Line(points={{38.52,-16},{
          39,-16},{39,-80},{0,-80},{0,-100}},     color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToKitchen, HeatPort_ToKitchen_OpenPlanOffice)
    annotation (Line(points={{48.6,-16},{48,-16},{48,-80},{40,-80},{40,-100}},
                                                             color={191,0,0}));
  connect(openPlanOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{48.6,19.7},{48.6,80},{-80,80},{-80,96}}, color={
          255,128,0}));
  connect(openPlanOffice.WindSpeedPort_Roof, WindSpeedPort_Hor) annotation (
      Line(points={{43.2,18.68},{43.2,28},{80,28},{80,100}}, color={0,0,127}));
  connect(HeatPort_ToKitchen_OpenPlanOffice, HeatPort_ToKitchen_OpenPlanOffice)
    annotation (Line(points={{40,-100},{40,-100}},                   color={191,
          0,0}));
  connect(multiPersonOffice.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp)
    annotation (Line(points={{-43.36,48},{-42,48},{-42,80},{0,80},{0,100}},
        color={191,0,0}));
  connect(multiPersonOffice.SolarRadiationPort_NorthWall,
    SolarRadiationPort_North) annotation (Line(points={{-32.2,49.7},{-32.2,80},
          {-96,80}}, color={255,128,0}));
  connect(multiPersonOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{-21.4,49.7},{-22,49.7},{-22,50},{-22,78},{-22,80},
          {-80,80},{-80,96},{-80,96}}, color={255,128,0}));
  connect(multiPersonOffice.SolarRadiationPort_WestWall,
    SolarRadiationPort_West) annotation (Line(points={{-53.8,25.56},{-80,25.56},
          {-80,20},{-96,20}}, color={255,128,0}));
  connect(multiPersonOffice.WindSpeedPort_WestWall, WindSpeedPort_West)
    annotation (Line(points={{-54.88,31},{-80,31},{-80,30},{-80,30},{-80,80},{
          80,80},{80,20},{100,20}}, color={0,0,127}));
  connect(conferenceRoom.WindSpeedPort_WestWall, WindSpeedPort_West)
    annotation (Line(points={{-54.88,-33},{-80,-33},{-80,-32},{-80,-32},{-80,
          -34},{-80,31},{-80,80},{80,80},{80,20},{100,20}}, color={0,0,127}));
  connect(conferenceRoom.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{-21.4,-14.3},{-21.4,0},{-80,0},{-80,96}}, color={
          255,128,0}));
  connect(conferenceRoom.SolarRadiationPort_WestWall, SolarRadiationPort_West)
    annotation (Line(points={{-53.8,-38.44},{-80,-38.44},{-80,-38},{-80,-38},{
          -80,20},{-96,20}}, color={255,128,0}));
  connect(conferenceRoom.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{-38.32,-51.7},{-38.32,-56},{-38.32,-80},{-38,-80},
          {-80,-80},{-80,40},{-96,40}}, color={255,128,0}));
  connect(conferenceRoom.WindSpeedPort_SouthWall, WindSpeedPort_West)
    annotation (Line(points={{-48.76,-51.02},{-48.76,-80},{80,-80},{80,20},{98,
          20},{98,20},{100,20},{100,20}}, color={0,0,127}));
  connect(conferenceRoom.WindSpeedPort_Roof, WindSpeedPort_Hor) annotation (
      Line(points={{-26.8,-15.32},{-26.8,0},{-26,0},{-26,0},{-80,0},{-80,80},{6,
          80},{6,80},{80,80},{80,100},{80,100}}, color={0,0,127}));
  connect(conferenceRoom.HeatPort_ToMultiPersonOffice, multiPersonOffice.HeatPort_ToConferenceRoom)
    annotation (Line(points={{-39.04,-16},{-38,-16},{-38,0},{-29.32,0},{-29.32,
          14}}, color={191,0,0}));
  connect(conferenceRoom.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp)
    annotation (Line(points={{-43.36,-16},{-44,-16},{-44,0},{-80,0},{-80,80},{0,
          80},{0,100}}, color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToConferenceRoom, conferenceRoom.HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{18,-3.76},{-4,-3.76},{-4,-4},{-4,-4},{-4,-36.4},{
          -16,-36.4}}, color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToMultiPersonOffice, multiPersonOffice.HeatPort_ToOpenPlanOffice)
    annotation (Line(points={{18,5.76},{-4,5.76},{-4,6},{-4,6},{-4,30},{-10,30},
          {-10,29.98},{-16,29.98}}, color={191,0,0}));
  connect(openPlanOffice.Heatport_TBA, Heatport_TBA[1]) annotation (Line(points=
         {{54,9.16},{80,9.16},{80,6},{80,6},{80,-68},{100,-68}}, color={191,0,0}));
  connect(conferenceRoom.Heatport_TBA, Heatport_TBA[2]) annotation (Line(points=
         {{-16,-24.84},{-4,-24.84},{-4,-26},{-4,-26},{-4,-80},{80,-80},{80,-64},
          {100,-64}}, color={191,0,0}));
  connect(multiPersonOffice.Heatport_TBA, Heatport_TBA[3]) annotation (Line(
        points={{-16,39.16},{-4,39.16},{-4,-80},{80,-80},{80,-60},{100,-60}},
        color={191,0,0}));
  connect(openPlanOffice.Air_out, Air_out[1]) annotation (Line(points={{54,5.76},
          {80,5.76},{80,6},{80,6},{80,-80},{-80,-80},{-80,-48},{-100,-48}},
        color={0,127,255}));
  connect(openPlanOffice.Air_in, Air_in[1]) annotation (Line(points={{54,2.02},
          {68,2.02},{68,2},{80,2},{80,-80},{-80,-80},{-80,-88},{-100,-88}},
        color={0,127,255}));
  connect(conferenceRoom.Air_in, Air_in[2]) annotation (Line(points={{-16,
          -31.98},{-10,-31.98},{-10,-32},{-4,-32},{-4,-80},{-80,-80},{-80,-84},
          {-100,-84}}, color={0,127,255}));
  connect(conferenceRoom.Air_out, Air_out[2]) annotation (Line(points={{-16,
          -28.24},{-4,-28.24},{-4,-28},{-4,-28},{-4,-80},{-80,-80},{-80,-44},{
          -100,-44}}, color={0,127,255}));
  connect(multiPersonOffice.Air_in, Air_in[3]) annotation (Line(points={{-16,
          32.02},{-10,32.02},{-10,32},{-4,32},{-4,-80},{-100,-80}}, color={0,
          127,255}));
  connect(multiPersonOffice.Air_out, Air_out[3]) annotation (Line(points={{-16,
          35.76},{-4,35.76},{-4,36},{-4,36},{-4,-80},{-80,-80},{-80,-40},{-100,
          -40}}, color={0,127,255}));
  connect(multiPersonOffice.mWat_MultiPersonOffice, mWat[3]) annotation (Line(
        points={{-52.72,46.64},{-66,46.64},{-80,46.64},{-80,46},{-80,46},{-80,
          48},{-80,46},{-80,46},{-80,80},{-40,80},{-40,100},{-40,100}}, color={
          0,0,127}));
  connect(conferenceRoom.mWat_ConferenceRoom, mWat[2]) annotation (Line(points=
          {{-52.72,-17.36},{-80,-17.36},{-80,80},{-40,80},{-40,105.6}}, color={
          0,0,127}));
  connect(openPlanOffice.mWat_OpenPlanOffice, mWat[1]) annotation (Line(points=
          {{17.28,16.64},{-4,16.64},{-4,80},{-40,80},{-40,111.2}}, color={0,0,
          127}));
  connect(multiPersonOffice.AddPower_MultiPersonOffice, AddPower[3])
    annotation (Line(points={{-52,42.9},{-80,42.9},{-80,56},{-80,56},{-80,80},{
          42,80},{42,98}}, color={191,0,0}));
  connect(openPlanOffice.AddPower_OpenPlanOffice, AddPower[1]) annotation (Line(
        points={{18,12.9},{-4,12.9},{-4,14},{-4,14},{-4,80},{42,80},{42,90}},
        color={191,0,0}));
  connect(conferenceRoom.AddPower_ConferenceRoom, AddPower[2]) annotation (Line(
        points={{-52,-21.1},{-80,-21.1},{-80,-24},{-80,-24},{-80,80},{42,80},{
          42,94}}, color={191,0,0}));
  connect(multiPersonOffice.WindSpeedPort_NorthWall, WindSpeedPort_North)
    annotation (Line(points={{-37.6,48.68},{-37.6,80},{100,80}}, color={0,0,127}));
  connect(multiPersonOffice.WindSpeedPort_Roof, WindSpeedPort_Hor) annotation (
      Line(points={{-26.8,48.68},{-26.8,80},{-28,80},{-28,80},{80,80},{80,100}},
        color={0,0,127}));
  connect(multiPersonOffice.HeatPort_ToWorkshop,
    HeatPort_ToWorkshop_MultiPersonOffice) annotation (Line(points={{-39.04,14},
          {-38,14},{-38,0},{-80,0},{-80,-80},{-64,-80},{-64,-100},{-64,-100}},
        color={191,0,0}));
  connect(conferenceRoom.HeatPort_ToWorkshop,
    HeatPort_ToWorkshop_ConferenceRoom) annotation (Line(points={{-31.48,-50},{
          -32,-50},{-32,-100}}, color={191,0,0}));
  connect(multiPersonOffice.measureBus, measureBus) annotation (Line(
      points={{-52,20.8},{-80,20.8},{-80,-80},{80,-80},{80,-20},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(openPlanOffice.measureBus, measureBus) annotation (Line(
      points={{18,-9.2},{-4,-9.2},{-4,-80},{80,-80},{80,-20},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(conferenceRoom.measureBus, measureBus) annotation (Line(
      points={{-52,-43.2},{-80,-43.2},{-80,-42},{-80,-42},{-80,-80},{80,-80},{
          80,-20},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FirstFloor;
