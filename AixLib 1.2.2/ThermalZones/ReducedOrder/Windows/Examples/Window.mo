within AixLib.ThermalZones.ReducedOrder.Windows.Examples;
model Window "Testmodel for Window"
    extends Modelica.Icons.Example;

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data for Chicago"
    annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
  AixLib.ThermalZones.ReducedOrder.Windows.Window window(
    n=2,
    UWin=1.4,
    g={0.64,0.64},
    g_TotDir={0.08,0.08},
    g_TotDif={0.27,0.27},
    tau_vis={0.72,0.72},
    tau_visTotDir={0.08,0.08},
    tau_visTotDif={0.32,0.32},
    lim=200,
    lat=0.86393797973719,
    til={1.5707963267949,1.5707963267949},
    azi={0,1.5707963267949})
    "Two windows: One facing south, one facing west"
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));
equation
  connect(weaDat.weaBus, window.weaBus) annotation (Line(
      points={{-22,0},{12.2,0}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StartTime=0,StopTime=31536000),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This example shows the application of <a href=
  \"AixLib.ThermalZones.ReducedOrder.Windows.Window\">Window</a>. For
  solar radiation, the example relies on the standard weather file in
  AixLib.
</p>
<p>
  The idea of the example is to show a typical application of all
  sub-models and to use the example in unit tests. The results are
  reasonable, but not related to any real use case or measurement data.
</p>
<h4>
  References
</h4>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  Modelling of solar radiation.
</p>
</html>",
      revisions="<html><ul>
  <li>July 13, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Window;
