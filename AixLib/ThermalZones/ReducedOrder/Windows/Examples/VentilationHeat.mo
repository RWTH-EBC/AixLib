within AixLib.ThermalZones.ReducedOrder.Windows.Examples;
model VentilationHeat "Testmodel for VentilationHeat"
  extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.VentilationHeat ventilationHeat(
    d=0.1,
    screen=true,
    x_f=0.8,
    tau_e=0.1,
    rho_e=0.7125,
    til=1.5707963267949)
    "Heat input due to ventilation with closed sunblind"
    annotation (Placement(transformation(extent={{56,-10},{76,10}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data for Chicago"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil(
    azi=0,
    til=1.5707963267949,
    lat=0.86393797973719) "Diffuse irradiation on the window"
           annotation (Placement(transformation(extent={{-42,20},{-26,36}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
    azi=0,
    til=1.5707963267949,
    lat=0.86393797973719) "Direct solar irradiation on the window"
           annotation (Placement(transformation(extent={{-42,-8},{-26,8}})));
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Sunblind sunblind(lim=200) "Sunblind of the window"
    annotation (Placement(transformation(extent={{-16,8},{-2,22}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.AltitudeAngle altAng
    "Solar altitude angle"
    annotation (Placement(transformation(extent={{10,-20},{20,-10}})));
  AixLib.BoundaryConditions.SolarGeometry.ZenithAngle zen(lat=0.86393797973719)
    "Solar zenith angle"
    annotation (Placement(transformation(extent={{-2,-20},{8,-10}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
                                            annotation (Placement(
        transformation(extent={{-70,38},{-38,68}}), iconTransformation(extent={{
            -196,50},{-176,70}})));
  AixLib.ThermalZones.ReducedOrder.Windows.Window window(
    n=1,
    UWin=1.4,
    g={0.64},
    g_TotDir={0.08},
    g_TotDif={0.27},
    tau_vis={0.72},
    tau_visTotDir={0.08},
    tau_visTotDif={0.32},
    lim=200,
    azi={0},
    lat=0.86393797973719,
    til={1.5707963267949}) "Window facing south"
    annotation (Placement(transformation(extent={{56,-54},{76,-34}})));
  Modelica.Blocks.Math.Add add
    "Total solar energy entering the room through the window"
    annotation (Placement(transformation(extent={{92,-4},{100,4}})));
equation
  connect(altAng.zen, zen.y)
    annotation (Line(points={{9,-15},{9,-15},{8.5,-15}}, color={0,0,127}));
  connect(altAng.alt, ventilationHeat.alt) annotation (Line(points={{20.5,-15},{
          37.25,-15},{37.25,-8},{55,-8}}, color={0,0,127}));
  connect(HDifTil.H, ventilationHeat.HDifTil) annotation (Line(points={{-25.2,28},
          {14,28},{14,5},{55,5}}, color={0,0,127}));
  connect(weaDat.weaBus, HDifTil.weaBus) annotation (Line(
      points={{-80,0},{-62,0},{-62,28},{-42,28}},
      color={255,204,51},
      thickness=0.5));
  connect(HDirTil.H, ventilationHeat.HDirTil) annotation (Line(points={{-25.2,0},
          {16,0},{16,-2},{55,-2}}, color={0,0,127}));
  connect(HDifTil.H, sunblind.HDifTil) annotation (Line(points={{-25.2,28},
          {-22,28},{-22,19.06},{-16.7,19.06}}, color={0,0,127}));
  connect(HDirTil.H, sunblind.HDirTil) annotation (Line(points={{-25.2,0},{
          -22,0},{-22,10.8},{-16.7,10.8}}, color={0,0,127}));
  connect(sunblind.sunscreen, ventilationHeat.sunscreen) annotation (Line(
        points={{-1.3,15},{4,15},{4,16},{10,16},{10,2},{55,2}}, color={255,
          0,255}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,0},{-68,0},{-68,53},{-54,53}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.HDifHor, ventilationHeat.HDifHor) annotation (Line(
      points={{-54,53},{32,53},{32,8},{55,8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.HDirNor, ventilationHeat.HDirNor) annotation (Line(
      points={{-54,53},{32,53},{32,-5},{55,-5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaDat.weaBus, HDirTil.weaBus) annotation (Line(
      points={{-80,0},{-62,0},{-42,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, zen.weaBus) annotation (Line(
      points={{-80,0},{-56,0},{-56,-15},{-2,-15}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, window.weaBus) annotation (Line(
      points={{-80,0},{-68,0},{-68,-44},{56.2,-44}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilationHeat.HVen, add.u1) annotation (Line(points={{77.2,0},{86,0},
          {86,2.4},{91.2,2.4}}, color={0,0,127}));
  connect(window.HWin[1], add.u2) annotation (Line(points={{77,-48},{88,-48},{88,
          -2.4},{91.2,-2.4}}, color={0,0,127}));
  annotation (experiment(StartTime=0,StopTime=31536000),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This example shows the application of <a href=
  \"Windows.BaseClasses.VentilationHeat\">VentilationHeat</a>. For solar
  radiation, the example relies on the standard weather file in AixLib.
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
end VentilationHeat;
