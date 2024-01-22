within AixLib.ThermalZones.HighOrder.Components.Examples.WindowsDoors;
model WindowSimple
  extends Modelica.Icons.Example;
  ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple windowSimple(
      windowarea=10,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002 WindowType,
    redeclare model CorrSolGain =
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple)
    annotation (Placement(transformation(extent={{-24,-4},{12,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T = 273.15) annotation(Placement(transformation(extent = {{-62, 0}, {-42, 20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside(T = 293.15) annotation(Placement(transformation(extent = {{58, 0}, {38, 20}})));
  Modelica.Blocks.Sources.RealExpression UValue(y=windowSimple.port_inside.Q_flow/(1 - windowSimple.WindowType.frameFraction)/windowSimple.windowarea/(windowSimple.port_inside.T - windowSimple.port_outside.T))
                                                                                                                                                                                                        annotation(Placement(transformation(extent = {{-20, -46}, {0, -26}})));
  Utilities.Sources.PrescribedSolarRad varRad(           n = 1) annotation(Placement(transformation(extent = {{-66, 40}, {-46, 60}})));
  Modelica.Blocks.Sources.Constant SolarRadiation(k = 100) annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T = 293.15) annotation(Placement(transformation(extent = {{58, 32}, {38, 52}})));
equation
  connect(Toutside.port, windowSimple.port_outside) annotation(Line(points = {{-42, 10}, {-34, 10}, {-34, 10.4}, {-22.2, 10.4}}, color = {191, 0, 0}));
  connect(windowSimple.port_inside, Tinside.port) annotation(Line(points = {{10.2, 10.4}, {24, 10.4}, {24, 10}, {38, 10}}, color = {191, 0, 0}));
  connect(varRad.solarRad_out[1], windowSimple.solarRad_in) annotation(Line(points = {{-47, 50}, {-32, 50}, {-32, 21.6}, {-22.2, 21.6}}, color = {255, 128, 0}));
  connect(SolarRadiation.y, varRad.I[1]) annotation (Line(
      points={{-79,50},{-74,50},{-74,58.9},{-64.9,58.9}},
      color={0,0,127}));
  connect(SolarRadiation.y, varRad.I_dir[1]) annotation (Line(
      points={{-79,50},{-74,50},{-74,55},{-65,55}},
      color={0,0,127}));
  connect(SolarRadiation.y, varRad.I_diff[1]) annotation (Line(
      points={{-79,50},{-76,50},{-76,48},{-74,48},{-74,51},{-65,51}},
      color={0,0,127}));
  connect(SolarRadiation.y, varRad.I_gr[1]) annotation (Line(
      points={{-79,50},{-74,50},{-74,46.9},{-64.9,46.9}},
      color={0,0,127}));
  connect(SolarRadiation.y, varRad.AOI[1]) annotation (Line(
      points={{-79,50},{-74,50},{-74,43},{-65,43}},
      color={0,0,127}));
  connect(Tinside1.port, windowSimple.radPort) annotation (Line(points={{38,42},{26,42},{26,21.6},{10.2,21.6}}, color={191,0,0}));
  annotation (experiment(StopTime = 3600, Interval = 60, Algorithm = "Lsodar"),Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to test the <a href=
  \"AixLib.Building.Components.WindowsDoors.WindowSimple\">WindowSimple</a>
  model.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Test case for calculation of U-value
</p>
<ul>
  <li>Area of component: 10 m2
  </li>
  <li>Temperature difference: 20 K
  </li>
  <li>Test time: 1 h
  </li>
</ul>
<ul>
  <li>
    <i>April 1, 2012&#160;</i> by Ana Constantin and Corinna
    Leonhard:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end WindowSimple;
