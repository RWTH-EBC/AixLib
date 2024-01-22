within AixLib.ThermalZones.HighOrder.Components.Examples.Walls;
model InsideWall
  extends Modelica.Icons.Example;
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside(T = 293.15) annotation(Placement(transformation(extent = {{92, 10}, {72, 30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T = 293.15) annotation(Placement(transformation(extent = {{92, 50}, {72, 70}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside2(T = 283.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-84, 62})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside3(T = 283.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-84, 22})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall wall_simple_new(
    outside=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half wallPar,
    wall_length=5,
    wall_height=2,
    withWindow=false,
    redeclare model WindowModel =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple,
    redeclare model CorrSolarGainWin =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    withDoor=true,
    T0=289.15,
    withSunblind=false,
    Blinding=0.2,
    LimitSolIrr=350,
    TOutAirLimit=273.15 + 17) annotation (Placement(transformation(extent={{28,-4},{40,68}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall wall_simple1_new(
    outside=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half wallPar,
    wall_length=5,
    wall_height=2,
    withWindow=false,
    redeclare model WindowModel =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple,
    redeclare model CorrSolarGainWin =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    withDoor=true,
    T0=287.15,
    withSunblind=false,
    Blinding=0.2,
    LimitSolIrr=350,
    TOutAirLimit=273.15 + 17) annotation (Placement(transformation(
        extent={{-6,36},{6,-36}},
        rotation=180,
        origin={-30,30})));
  Modelica.Blocks.Sources.RealExpression UValue_new(y = -Tinside3.port.Q_flow / (Tinside3.T - Tinside.T) / (wall_simple_new.wall_length * wall_simple_new.wall_height)) annotation(Placement(transformation(extent = {{-28, -100}, {28, -80}})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(extent={{-56,-50},{-72,-38}})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux1 annotation (Placement(transformation(extent={{56,-52},{70,-40}})));
equation
  connect(wall_simple1_new.port_outside, wall_simple_new.port_outside) annotation(Line(points = {{-23.7, 30}, {-23.7, 32}, {27.7, 32}}, color = {191, 0, 0}));
  connect(thermStar_Demux.portConvRadComb, wall_simple1_new.thermStarComb_inside) annotation (Line(points={{-56,-44},{-39.24,-44},{-39.24,30},{-36,30}},            color={191,0,0}));
  connect(thermStar_Demux1.portConvRadComb, wall_simple_new.thermStarComb_inside) annotation (Line(points={{56,-46},{49.21,-46},{49.21,32},{40,32}},            color={191,0,0}));
  connect(Tinside2.port, thermStar_Demux.portRad) annotation (Line(points={{-74,62},{-56,62},{-56,-22},{-88,-22},{-88,-40.25},{-72,-40.25}},    color={191,0,0}));
  connect(Tinside3.port, thermStar_Demux.portConv) annotation (Line(points={{-74,22},{-60,22},{-60,-18},{-92,-18},{-92,-47.75},{-72,-47.75}},      color={191,0,0}));
  connect(Tinside1.port, thermStar_Demux1.portRad) annotation (Line(points={{72,60},{56,60},{56,-22},{88,-22},{88,-42.25},{70,-42.25}},    color={191,0,0}));
  connect(Tinside.port, thermStar_Demux1.portConv) annotation (Line(points={{72,20},{60,20},{60,-18},{94,-18},{94,-50},{82,-50},{82,-49.75},{70,-49.75}},      color={191,0,0}));
  annotation (experiment(StopTime = 90000, Interval = 60, __Dymola_Algorithm = "Lsodar"),Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to test the <a href=
  \"AixLib.Building.Components.Walls.Wall\">Wall</a> model in case of an
  <b>inside wall</b> application.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Test case for calculation of U-value
</p>
<ul>
  <li>Area of Wall: 10 m²
  </li>
  <li>Area of Door: 2 m²
  </li>
  <li>Temperature difference: 10 K
  </li>
  <li>Test time: 25 h
  </li>
</ul>
<p>
  The u-values are calculated via calculation moduls and may be
  displayed easily.
</p>
<ul>
  <li>
    <i>April, 2012&#160;</i> by Mark Wesseling:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end InsideWall;
