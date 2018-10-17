within AixLib.ThermalZones.HighOrder.Components.Examples.Walls;
model OutsideWall
  extends Modelica.Icons.Example;
  ThermalZones.HighOrder.Components.Walls.Wall wall_simple(
    wall_length=5,
    wall_height=2,
    withWindow=true,
    WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    withSunblind=true,
    outside=true,
    WallType=AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S(),
    Model=2,
    Blinding=0.2,
    LimitSolIrr=100,
    TOutAirLimit=282.15,
    T0=289.15) annotation (Placement(transformation(
        extent={{-6,57},{6,-57}},
        rotation=180,
        origin={-30,25})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T = 293.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-90, 44})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside2(T = 293.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-90, 10})));
  Modelica.Blocks.Sources.RealExpression UValue(y = -Tinside2.port.Q_flow / (Tinside2.T - Toutside.T) / (wall_simple.wall_length * wall_simple.wall_height)) annotation(Placement(transformation(extent = {{-32, -78}, {24, -58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T = 283.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {30, 22})));
  Utilities.Sources.PrescribedSolarRad varRad            annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {50, 80})));
  Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb annotation(Placement(transformation(extent = {{-10, -8}, {10, 8}}, rotation = 180, origin = {-58, 26})));
  Modelica.Blocks.Sources.RealExpression WindSpeed(y = 4) annotation(Placement(transformation(extent = {{30, 48}, {12, 64}})));
  Modelica.Blocks.Sources.Constant Solarradiation(k=0)
    annotation (Placement(transformation(extent={{96,70},{78,88}})));
equation
  connect(Toutside.port, wall_simple.port_outside) annotation(Line(points = {{20, 22}, {4, 22}, {4, 25}, {-23.7, 25}}, color = {191, 0, 0}));
  connect(wall_simple.SolarRadiationPort, varRad.solarRad_out[1]) annotation(Line(points = {{-22.2, 77.25}, {9.9, 77.25}, {9.9, 80}, {41, 80}}, color = {255, 128, 0}));
  connect(heatStarToComb.thermStarComb, wall_simple.thermStarComb_inside) annotation(Line(points = {{-48.6, 26.1}, {-43.3, 26.1}, {-43.3, 25}, {-36, 25}}, color = {191, 0, 0}));
  connect(Tinside2.port, heatStarToComb.therm) annotation(Line(points = {{-80, 10}, {-74, 10}, {-74, 31.1}, {-68.1, 31.1}}, color = {191, 0, 0}));
  connect(Tinside1.port, heatStarToComb.star) annotation(Line(points = {{-80, 44}, {-74, 44}, {-74, 20.2}, {-68.4, 20.2}}, color = {191, 0, 0}));
  connect(varRad.AOI[1], Solarradiation.y) annotation (Line(
      points={{59,87},{64,87},{64,79},{77.1,79}},
      color={0,0,127}));
  connect(varRad.I_gr[1], Solarradiation.y) annotation (Line(
      points={{58.9,83.1},{77.1,83.1},{77.1,79}},
      color={0,0,127}));
  connect(Solarradiation.y, varRad.I_diff[1]) annotation (Line(
      points={{77.1,79},{59,79}},
      color={0,0,127}));
  connect(Solarradiation.y, varRad.I_dir[1]) annotation (Line(
      points={{77.1,79},{64.55,79},{64.55,75},{59,75}},
      color={0,0,127}));
  connect(varRad.I[1], Solarradiation.y) annotation (Line(
      points={{58.9,71.1},{77.1,71.1},{77.1,79}},
      color={0,0,127}));
  connect(wall_simple.WindSpeedPort, WindSpeed.y) annotation (Line(
      points={{-23.7,66.8},{-6,66.8},{-6,56},{11.1,56}},
      color={0,0,127}));
  annotation (experiment(StopTime = 36000, Interval = 60, Algorithm = "Lsodar"),Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Simulation to test the <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a> model in case of an outside wall application.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>Test case for calculation of U-value</p>
 <ul>
 <li>Area of Wall: 10 m2</li>
 <li>Area of Window: 2 m2</li>
 <li>Temperature difference: 10 K</li>
 <li>Test time: 10 h</li>
 </ul>
 </html>", revisions = "<html>
 <ul>
   <li><i>April, 2012&nbsp;</i>
          by Mark Wesseling:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end OutsideWall;
