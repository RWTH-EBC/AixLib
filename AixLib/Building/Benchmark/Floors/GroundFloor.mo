within AixLib.Building.Benchmark.Floors;
model GroundFloor
  replaceable package Medium =
    AixLib.Media.Air "Medium in the component";
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
    annotation (Placement(transformation(extent={{-10,-90},{10,-110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_FromWorkshop
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_FromCanteen
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_West
    annotation (Placement(transformation(extent={{-102,14},{-90,26}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_West
    annotation (Placement(transformation(extent={{112,8},{88,32}})));
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
  Modelica.Blocks.Interfaces.RealInput mWat[5]
    "Water flow rate added into the medium" annotation (Placement(
        transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={-40,-100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower[5]
    annotation (Placement(transformation(extent={{32,-90},{52,-110}})));
  Rooms.Workshop workshop
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  Rooms.Canteen canteen
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp(T=286.65)
    annotation (Placement(transformation(extent={{-36,-56},{-24,-44}})));
equation
  connect(HeatPort_FromCanteen, HeatPort_FromCanteen)
    annotation (Line(points={{40,100},{40,100}}, color={191,0,0}));
  connect(workshop.HeatPort_ToCanteen, canteen.HeatPort_ToWorkshop) annotation (
     Line(points={{-20,-6.4},{0,-6.4},{0,-6},{0,-6},{0,0},{20,0}}, color={191,0,
          0}));
  connect(canteen.HeatPort_Canteen, HeatPort_FromCanteen) annotation (Line(
        points={{52,20},{52,80},{40,80},{40,100}}, color={191,0,0}));
  connect(workshop.HeatPort_Workshop, HeatPort_FromWorkshop) annotation (Line(
        points={{-28,20},{-28,80},{-40,80},{-40,100}}, color={191,0,0}));
  connect(workshop.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{-38,22},{-38,80},{-96,80}}, color={255,128,0}));
  connect(canteen.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{42,22},{40,22},{40,80},{-96,80}}, color={255,128,0}));
  connect(workshop.SolarRadiationPort_WestWall, SolarRadiationPort_West)
    annotation (Line(points={{-62,-6.4},{-80,-6.4},{-80,-6},{-80,-6},{-80,20},{-96,
          20}}, color={255,128,0}));
  connect(workshop.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{-44.8,-22},{-44,-22},{-44,-80},{-80,-80},{-80,40},
          {-96,40}}, color={255,128,0}));
  connect(canteen.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{35.2,-22},{36,-22},{36,-80},{-80,-80},{-80,40},{-96,
          40}}, color={255,128,0}));
  connect(canteen.SolarRadiationPort_EastWall, SolarRadiationPort_East)
    annotation (Line(points={{62,-10},{80,-10},{80,80},{-80,80},{-80,60},{-96,60}},
        color={255,128,0}));
  connect(workshop.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp) annotation (Line(
        points={{-50.4,20},{-52,20},{-52,80},{-80,80},{-80,-80},{0,-80},{0,-100}},
        color={191,0,0}));
  connect(canteen.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp) annotation (Line(
        points={{29.6,20},{28,20},{28,80},{-80,80},{-80,-80},{0,-80},{0,-100}},
        color={191,0,0}));
  connect(canteen.AddPower_Canteen, AddPower[4]) annotation (Line(points={{20,14},
          {0,14},{0,-80},{42,-80},{42,-104}}, color={191,0,0}));
  connect(workshop.AddPower_Workshop, AddPower[5]) annotation (Line(points={{-60,
          14},{-80,14},{-80,-80},{42,-80},{42,-108}}, color={191,0,0}));
  connect(workshop.Heatport_TBA, Heatport_TBA[5]) annotation (Line(points={{-20,
          9.6},{0,9.6},{0,-80},{80,-80},{80,-52},{100,-52}}, color={191,0,0}));
  connect(canteen.Heatport_TBA, Heatport_TBA[4]) annotation (Line(points={{60,9.6},
          {80,9.6},{80,10},{80,10},{80,-56},{100,-56}}, color={191,0,0}));
  connect(canteen.WindSpeedPort_NorthWall, WindSpeedPort_North)
    annotation (Line(points={{36,20.8},{36,80},{100,80}}, color={0,0,127}));
  connect(workshop.WindSpeedPort_NorthWall, WindSpeedPort_North)
    annotation (Line(points={{-44,20.8},{-44,80},{100,80}}, color={0,0,127}));
  connect(workshop.WindSpeedPort_WestWall, WindSpeedPort_West) annotation (Line(
        points={{-63.2,0},{-80,0},{-80,80},{80,80},{80,20},{100,20},{100,20}},
        color={0,0,127}));
  connect(canteen.WindSpeedPort_EastWall, WindSpeedPort_East) annotation (Line(
        points={{60.8,-3.6},{80,-3.6},{80,-4},{80,-4},{80,60},{100,60}}, color={
          0,0,127}));
  connect(canteen.WindSpeedPort_SouthWall, WindSpeedPort_South) annotation (
      Line(points={{23.6,-21.2},{23.6,-80},{80,-80},{80,40},{100,40}}, color={0,
          0,127}));
  connect(workshop.WindSpeedPort_SouthWall, WindSpeedPort_South) annotation (
      Line(points={{-56.4,-21.2},{-56.4,-80},{80,-80},{80,40},{100,40}}, color={
          0,0,127}));
  connect(workshop.mWat_Workshop, mWat[5]) annotation (Line(points={{-60.8,18.4},
          {-80,18.4},{-80,-80},{-40,-80},{-40,-88.8}}, color={0,0,127}));
  connect(canteen.mWat_Canteen, mWat[4]) annotation (Line(points={{19.2,18.4},{0,
          18.4},{0,-80},{-40,-80},{-40,-94.4}}, color={0,0,127}));
  connect(workshop.HeatPort_ToGround, GroundTemp.port) annotation (Line(points={
          {-34.4,-20},{-34.4,-30},{-10,-30},{-10,-50},{-24,-50}}, color={191,0,0}));
  connect(canteen.HeatPort_ToGround, GroundTemp.port) annotation (Line(points={{
          42.8,-20},{44,-20},{44,-30},{-10,-30},{-10,-50},{-24,-50}}, color={191,
          0,0}));
  connect(workshop.Air_out, Air_out[5]) annotation (Line(points={{-20,5.6},{0,5.6},
          {0,-80},{-80,-80},{-80,-32},{-100,-32}}, color={0,127,255}));
  connect(canteen.Air_out, Air_out[4]) annotation (Line(points={{60,5.6},{80,5.6},
          {80,-80},{-80,-80},{-80,-36},{-100,-36}}, color={0,127,255}));
  connect(workshop.Air_in, Air_in[5]) annotation (Line(points={{-20,1.2},{0,1.2},
          {0,0},{0,0},{0,-80},{-80,-80},{-80,-72},{-100,-72}}, color={0,127,255}));
  connect(canteen.Air_in, Air_in[4]) annotation (Line(points={{60,1.2},{80,1.2},
          {80,-2},{80,-2},{80,-80},{-80,-80},{-80,-76},{-100,-76}}, color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GroundFloor;
