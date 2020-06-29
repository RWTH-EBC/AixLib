within AixLib.Systems.Benchmark.Model.Building.Floors;
model WestWing
  replaceable package Medium =
    AixLib.Media.Air "Medium in the component";
  Rooms.Workshop_v2
                 workshop
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  Rooms.Canteen_v2
                canteen
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp(T=286.65)
    annotation (Placement(transformation(extent={{-64,-56},{-52,-44}})));
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{82,0},{122,40}})));
  BusSystems.InternalBus internalBus
    annotation (Placement(transformation(extent={{80,40},{120,80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA_Canteen
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA_Workshop
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_Canteen
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a AddPower_Workshop
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out_Canteen(redeclare package
      Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in_Canteen(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out_Workshop(redeclare package
      Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in_Workshop(redeclare package
      Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_South annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-104})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_West
    annotation (Placement(transformation(extent={{-114,70},{-94,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GroundTemp1(
                                                                    T=286.65)
    annotation (Placement(transformation(extent={{16,-56},{28,-44}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToOpenplanoffice1
    annotation (Placement(transformation(extent={{90,-18},{110,2}})));
equation
  connect(workshop.HeatPort_ToCanteen, canteen.HeatPort_ToWorkshop) annotation (
     Line(points={{-20,-6},{0,-6},{0,-6},{0,-6},{0,0},{20,0}},     color={191,0,
          0}));
  connect(canteen.measureBus, measureBus) annotation (Line(
      points={{20,-12},{0,-12},{0,-80},{80,-80},{80,20},{102,20}},
      color={255,204,51},
      thickness=0.5));
  connect(workshop.measureBus, measureBus) annotation (Line(
      points={{-60,-12},{-80,-12},{-80,-80},{80,-80},{80,20},{102,20}},
      color={255,204,51},
      thickness=0.5));
  connect(canteen.Heatport_TBA, Heatport_TBA_Canteen) annotation (Line(points={{60,14},
          {80,14},{80,10},{80,10},{80,-40},{100,-40}},           color={191,0,0}));
  connect(workshop.Heatport_TBA, Heatport_TBA_Workshop) annotation (Line(points={{-20,14},
          {0,14},{0,-80},{100,-80}},            color={191,0,0}));
  connect(canteen.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
    annotation (Line(points={{32,20},{32,80},{80,80},{80,60.1},{100.1,60.1}},
        color={0,0,127}));
  connect(canteen.mWat_Canteen, internalBus.InternalLoads_MFlow_Canteen)
    annotation (Line(points={{19.2,18.4},{0,18.4},{0,80},{80,80},{80,60.1},{
          100.1,60.1}}, color={0,0,127}));
  connect(canteen.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
    annotation (Line(points={{32,-20},{32,-30},{0,-30},{0,80},{80,80},{80,60.1},
          {100.1,60.1}},       color={0,0,127}));
  connect(workshop.WindSpeedPort_NorthWall, internalBus.InternalLoads_Wind_Speed_North)
    annotation (Line(points={{-48,20},{-48,80},{80,80},{80,60.1},{100.1,60.1}},
        color={0,0,127}));
  connect(workshop.mWat_Workshop, internalBus.InternalLoads_MFlow_Workshop)
    annotation (Line(points={{-60.8,18.4},{-80,18.4},{-80,80},{80,80},{80,60.1},
          {100.1,60.1}}, color={0,0,127}));
  connect(workshop.WindSpeedPort_WestWall, internalBus.InternalLoads_Wind_Speed_West)
    annotation (Line(points={{-60,0},{-80,0},{-80,80},{80,80},{80,60.1},{100.1,
          60.1}},       color={0,0,127}));
  connect(workshop.WindSpeedPort_SouthWall, internalBus.InternalLoads_Wind_Speed_South)
    annotation (Line(points={{-48,-20},{-48,-30},{0,-30},{0,80},{80,80},{80,
          60.1},{100.1,60.1}},    color={0,0,127}));
  connect(canteen.AddPower_Canteen, AddPower_Canteen) annotation (Line(points={
          {20,14},{0,14},{0,-80},{-60,-80},{-80,-80},{-80,-100},{-100,-100}},
        color={191,0,0}));
  connect(workshop.AddPower_Workshop, AddPower_Workshop) annotation (Line(
        points={{-60,14},{-80,14},{-80,-60},{-100,-60}}, color={191,0,0}));
  connect(canteen.Air_out, Air_out_Canteen) annotation (Line(points={{60,8},{80,
          8},{80,80},{-80,80},{-80,40},{-100,40}},      color={0,127,255}));
  connect(canteen.Air_in, Air_in_Canteen) annotation (Line(points={{60,0},{80,0},
          {80,80},{-80,80},{-80,20},{-100,20}},      color={0,127,255}));
  connect(workshop.Air_out, Air_out_Workshop) annotation (Line(points={{-20,8},
          {0,8},{0,80},{-80,80},{-80,0},{-100,0}},   color={0,127,255}));
  connect(workshop.Air_in, Air_in_Workshop) annotation (Line(points={{-20,0},{0,
          0},{0,80},{-80,80},{-80,-20},{-100,-20}},      color={0,127,255}));
  connect(workshop.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{-42,22},{-42,80},{0,80},{0,104}}, color={255,128,
          0}));
  connect(workshop.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{-42,-22},{-44,-22},{-44,-80},{60,-80},{60,-104}},
        color={255,128,0}));
  connect(workshop.SolarRadiationPort_WestWall, SolarRadiationPort_West)
    annotation (Line(points={{-62,-6},{-80,-6},{-80,-6},{-80,-6},{-80,80},{-104,
          80}},      color={255,128,0}));
  connect(canteen.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{38,22},{38,80},{0,80},{0,104}}, color={255,128,0}));
  connect(canteen.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{38,-22},{36,-22},{36,-80},{60,-80},{60,-104}},
        color={255,128,0}));
  connect(workshop.HeatPort_ToGround, GroundTemp.port) annotation (Line(points={{-30,-20},
          {-34,-20},{-34,-50},{-52,-50}},              color={191,0,0}));
  connect(GroundTemp1.port, canteen.HeatPort_ToGround) annotation (Line(points={{28,-50},
          {50,-50},{50,-20}},               color={191,0,0}));
  connect(workshop.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{-28,20},{-28,80},{80,80},{80,60.1},{100.1,60.1}},
        color={0,0,127}));
  connect(workshop.SolarRadiationPort_Roof, SolarRadiationPort_Hor) annotation (
     Line(points={{-26,22},{-26,80},{80,80},{80,104}}, color={255,128,0}));
  connect(canteen.SolarRadiationPort_Roof, SolarRadiationPort_Hor) annotation (
      Line(points={{58,22},{58,80},{80,80},{80,104}}, color={255,128,0}));
  connect(canteen.WindSpeedPort_Roof, internalBus.InternalLoads_Wind_Speed_Hor)
    annotation (Line(points={{52,20},{52,80},{80,80},{80,60.1},{100.1,60.1}},
        color={0,0,127}));
  connect(canteen.HeatPort_ToOpenplanoffice, HeatPort_ToOpenplanoffice1)
    annotation (Line(points={{60,-6},{80,-6},{80,-8},{100,-8}},
                                                color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WestWing;
