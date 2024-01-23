within AixLib.ThermalZones.HighOrder.Components.Examples.Walls;
model OutsideWall
  extends Modelica.Icons.Example;
  AixLib.ThermalZones.HighOrder.Components.Walls.Wall outerWall(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_shortWaveRadOut=true,
    redeclare model WindowModel =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Window_ASHRAE140
        (                                                                                                 redeclare AixLib.DataBase.WindowsDoors.ASHRAE140WithPanes.Default winPaneRec),
    redeclare AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S wallPar,
    wall_length=5,
    wall_height=2,
    withWindow=true,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 WindowType,
    redeclare model CorrSolarGainWin =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    withSunblind=true,
    outside=true,
    calcMethodOut=2,
    Blinding=0.2,
    LimitSolIrr=100,
    TOutAirLimit=282.15,
    T0=289.15) annotation (Placement(transformation(
        extent={{-6,57},{6,-57}},
        rotation=180,
        origin={-24,25})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T = 293.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-90, 44})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside2(T = 293.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-90, 10})));
  Modelica.Blocks.Sources.RealExpression UValue(y = -Tinside2.port.Q_flow / (Tinside2.T - Toutside.T) / (outerWall.wall_length * outerWall.wall_height)) annotation(Placement(transformation(extent = {{-32, -78}, {24, -58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T = 283.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {30, 22})));
  Utilities.Sources.PrescribedSolarRad varRad            annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {50, 80})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb annotation (Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=180,
        origin={-58,26})));
  Modelica.Blocks.Sources.Constant       WindSpeed(k=4)   annotation(Placement(transformation(extent = {{30, 48}, {12, 64}})));
  Modelica.Blocks.Sources.Constant Solarradiation(k=0)
    annotation (Placement(transformation(extent={{96,70},{78,88}})));
equation
  connect(Tinside2.port, heatStarToComb.portRad) annotation (Line(points={{-80,10},{-72,10},{-72,21},{-68,21}}, color={191,0,0}));
  connect(Tinside1.port, heatStarToComb.portConv) annotation (Line(points={{-80,44},{-72,44},{-72,31},{-68,31}}, color={191,0,0}));
  connect(heatStarToComb.portConvRadComb, outerWall.thermStarComb_inside) annotation (Line(points={{-48,26},{-42,26},{-42,25},{-30,25}}, color={191,0,0}));
  connect(Toutside.port, outerWall.port_outside) annotation (Line(points={{20,22},{2,22},{2,25},{-17.7,25}}, color={191,0,0}));
  connect(WindSpeed.y, outerWall.WindSpeedPort) annotation (Line(points={{11.1,56},{-4,56},{-4,66.8},{-17.7,66.8}}, color={0,0,127}));
  connect(varRad.solarRad_out[1], outerWall.SolarRadiationPort) annotation (Line(points={{41,80},{12,80},{12,77.25},{-16.2,77.25}}, color={255,128,0}));
  connect(Solarradiation.y, varRad.AOI[1]) annotation (Line(points={{77.1,79},{68.55,79},{68.55,87},{59,87}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_gr[1]) annotation (Line(points={{77.1,79},{67.55,79},{67.55,83.1},{58.9,83.1}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_diff[1]) annotation (Line(points={{77.1,79},{68.55,79},{68.55,79},{59,79}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_dir[1]) annotation (Line(points={{77.1,79},{67.55,79},{67.55,75},{59,75}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I[1]) annotation (Line(points={{77.1,79},{68.55,79},{68.55,71.1},{58.9,71.1}}, color={0,0,127}));
  annotation (experiment(StopTime = 36000, Interval = 60, Algorithm = "Lsodar"),Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to test the <a href=
  \"AixLib.Building.Components.Walls.Wall\">Wall</a> model in case of an
  outside wall application.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Test case for calculation of U-value
</p>
<ul>
  <li>Area of Wall: 10 m2
  </li>
  <li>Area of Window: 2 m2
  </li>
  <li>Temperature difference: 10 K
  </li>
  <li>Test time: 10 h
  </li>
</ul>
<ul>
  <li>
    <i>April, 2012&#160;</i> by Mark Wesseling:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end OutsideWall;
