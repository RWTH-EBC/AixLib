within AixLib.ThermalZones.ReducedOrder.Windows;
model Window "Calculation of solar energy transmitted through windows"
  parameter Modelica.Units.SI.Angle lat "Latitude";
  parameter Integer n(min = 1) "Number of windows"
    annotation(dialog(group="window"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UWin
    "Thermal transmission coefficient of whole window"
    annotation (dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g[n]
    "Total energy transmittance of windows" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDir[n] "Total energy transmittance of windows with closed sunscreen for direct
     radiation" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDif[n] "Total energy transmittance of windows with closed sunscreen for diffuse
     radiation" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient tau_vis[n]
    "Degree of light transmission for direct irradiation"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient tau_visTotDir[n]
    "Degree of light transmission for direct irradiation, with sunscreen"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient tau_visTotDif[n]
    "Degree of light transmission for diffuse irradiation, with sunscreen"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.RadiantEnergyFluenceRate lim
    "Limit for the sunscreen to become active"
    annotation (dialog(group="sunscreen"));
  parameter Modelica.Units.SI.Angle xi(displayUnit="degree") = 0
    "Elevation angle";
  parameter Modelica.Units.SI.Angle til[n](displayUnit="deg") "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
    roof" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Angle azi[n] "Surface azimuth"
    annotation (Dialog(group="window"));
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealOutput HVis[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2") "Solar energy entering the room in the visible area"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,30},{120,50}})));

  Modelica.Blocks.Interfaces.RealOutput HWin[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Solar radiation transmitted through aggregated window"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}}),
        iconTransformation(extent={{100,-50},{120,-30}})));

  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Window window(
    final n=n,
    final UWin=UWin,
    final g=g,
    final g_TotDir=g_TotDir,
    final g_TotDif=g_TotDif,
    final tau_vis=tau_vis,
    final tau_visTotDir=tau_visTotDir,
    final tau_visTotDif=tau_visTotDif,
    final lim=lim,
    final til=til)
    "Base class of window"
    annotation (
    Placement(transformation(extent={{20,-32},{86,30}})));
  AixLib.BoundaryConditions.SolarGeometry.IncidenceAngle incAng[n](
    each lat=lat,
    final azi=azi,
    final til=til)
    "Calculates the incidence angle" annotation (
    Placement(transformation(extent={{-40,74},{-30,84}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}}),
        iconTransformation(extent={{-108,-10},{-88,10}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.AltitudeAngle altAng
    "Calculates the altitude angle"
    annotation (Placement(transformation(extent={{-18,56},{-10,64}})));
  AixLib.BoundaryConditions.SolarGeometry.ZenithAngle zen(each lat=lat)
    "Calculates the zenith angle"
    annotation (Placement(transformation(extent={{-28,56},{-20,64}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[n](
    final til=til,
    each lat=lat,
    final azi=azi)
    "Calculates the diffuse irradiation on a tilted surface after Perez"
    annotation (
    Placement(transformation(extent={{-32,-6},{-20,6}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[n](
    final til=til,
    each lat=lat,
    final azi=azi)
    "Calculates the direct irradiation on a tilted surfcae"
    annotation (Placement(transformation(extent={{-60,-54},{-40,-34}})));
equation
  connect(window.HVis, HVis) annotation (
  Line(points={{89.3,11.4},{94,11.4},{94,
          40},{110,40}}, color={0,0,127}));
  connect(window.HWin, HWin) annotation (
  Line(points={{89.3,-13.4},{96,-13.4},{96,
          -40},{110,-40}}, color={0,0,127}));
  connect(incAng.y, window.incAng) annotation (Line(points={{-29.5,79},{-10,79},
          {-10,80},{8,80},{8,24.42},{16.7,24.42}}, color={0,0,127}));
  connect(weaBus.nTot, window.nTot) annotation (Line(
      points={{-98,0},{-90,0},{-90,72},{2,72},{2,18},{10,18},{10,16.36},{16.7,
          16.36}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(altAng.alt, window.alt) annotation (
  Line(points={{-9.6,60},{-8,60},{-8,
          7.06},{16.7,7.06}}, color={0,0,127}));
  connect(altAng.zen, zen.y)   annotation (Line(points={{-18.8,60},{-19.6,60}},
   color={0,0,127}));
  connect(weaBus, zen.weaBus) annotation (Line(
      points={{-98,0},{-64,0},{-64,60},{-28,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTil.H, window.HDifTil) annotation (Line(points={{-19.4,0},{-16,0},
          {-16,-0.38},{16.7,-0.38}}, color={0,0,127}));
  connect(weaBus.HDifHor, window.HDifHor) annotation (Line(
      points={{-98,0},{-42,0},{-42,-7.82},{16.7,-7.82}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.HDirNor, window.HDirNor) annotation (Line(
      points={{-98,0},{-42,0},{-42,-16.5},{16.7,-16.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDirTil.H, window.HDirTil) annotation (
  Line(points={{-39,-44},{-12,-44},
          {-12,-25.18},{16.7,-25.18}}, color={0,0,127}));
      for i in 1:n loop
          connect(weaBus, HDifTil[i].weaBus) annotation (Line(
      points={{-98,0},{-66,0},{-66,0},{-32,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
          connect(incAng[i].weaBus, weaBus) annotation (Line(
      points={{-40,79},{-90,79},{-90,0},{-98,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
          connect(weaBus, HDirTil[i].weaBus) annotation (Line(
      points={{-98,0},{-80,0},{-80,-44},{-60,-44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
      end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-96,96},{96,-96}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={156,232,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,96},{2,-96}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-96,2},{96,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<html><p>
  This model calculates the input of heat and visible light into the
  room due to solar irradiation. Therefore it uses the calculations of
  VDI 6007 part 3. It considers the correction values for non-vertical
  and non-parallel radiation incidence.
</p>
<p>
  To calculate the solar irradiation and the solar geometry it uses the
  models of the <a href=
  \"AixLib.BoundaryConditions\">BoundaryConditions</a> package.
</p>
<p>
  An example on how this model should be used is <a href=
  \"vdi6007.Examples.Window\">Window</a>. To consider the additional heat
  input in case of ventilation with the solar protection the <a href=
  \"vdi6007.BaseClasses.VentilationHeat\">VentilationHeat</a> model can
  be used.
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
  <li>June 30, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Window;
