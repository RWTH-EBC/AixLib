within AixLib.ThermalZones.ReducedOrder.Windows;
model ShadedWindow
  "Calculation of solar energy transmitted through windows considering shadowing."
  parameter Modelica.Units.SI.Angle lat "Latitude";
  parameter Integer n(min = 1) "Number of windows"
    annotation(dialog(group="window"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UWin
    "Thermal transmission coefficient of whole window"
    annotation (dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g[n]
    "Total energy transmittance of windows" annotation (Dialog(group="window"));
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
  parameter Modelica.Units.SI.Length b[n] "Width of window"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Height h[n] "Height of window"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length bLef[n] "Window projection left"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length bRig[n] "Window projection right"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length dLef[n]
    "Distance between projection (left) and window"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length dRig[n]
    "Distance between projection (right) and window"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length bAbo[n] "Window projection above"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length bBel[n] "Window projection below"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length dAbo[n]
    "Distance between projection (above) and window"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Length dBel[n]
    "Distance between projection (below) and window"
    annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.Angle azi[n](displayUnit="degree") "Surface azimuth. azi=-90 degree if surface outward unit normal points
    toward east; azi=0 if it points toward south"
    annotation (Dialog(group="window"));
  parameter Integer nCorPoi(min = 1) "Number of corner points"
      annotation(dialog(group="skyline"));
  parameter Modelica.Units.SI.Angle[nCorPoi] alpha(displayUnit="deg") "Azimuth of corner points, sorted from north to east to south to west,
     azi=-90 degree if surface outward unit normal points toward east;
     azi=0 if it points toward south" annotation (dialog(group="skyline"));
  parameter Modelica.Units.SI.Height[nCorPoi] deltaH
    "Difference between height of corner point and the window centre"
    annotation (dialog(group="skyline"));
  parameter Modelica.Units.SI.Distance[nCorPoi] s
    "Horizontal distance between corner point and window centre"
    annotation (dialog(group="skyline"));
  parameter Boolean[nCorPoi-1] gap
    "Corner points i and i+1 are gap between buildings: true, else: false"
    annotation(dialog(group="skyline"));
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDir[n] "Total energy transmittance of windows with closed sunscreen for direct
     radiation" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDif[n] "Total energy transmittance of windows with closed sunscreen for diffuse
     radiation" annotation (Dialog(group="window"));

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
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.ShadedWindow shadedWindow(
    final n=n,
    final UWin=UWin,
    final g=g,
    final tau_vis=tau_vis,
    final tau_visTotDir=tau_visTotDir,
    final tau_visTotDif=tau_visTotDif,
    final lim=lim,
    final til=til,
    final b=b,
    final h=h,
    final bLef=bLef,
    final bRig=bRig,
    final dLef=dLef,
    final dRig=dRig,
    final bAbo=bAbo,
    final bBel=bBel,
    final dAbo=dAbo,
    final dBel=dBel,
    final azi=azi,
    final nCorPoi=nCorPoi,
    final alpha=alpha,
    final deltaH=deltaH,
    final s=s,
    final gap=gap,
    final g_TotDir=g_TotDir,
    final g_TotDif=g_TotDif)
    "Base class of ShadedWindow"
    annotation (Placement(transformation(extent={{12,-34},{86,36}})));
  AixLib.BoundaryConditions.SolarGeometry.IncidenceAngle incAng[n](
    each lat=lat,
    final azi=azi,
    final til=til)
    "Calculates the incidence angle"
    annotation (
    Placement(transformation(extent={{-40,70},{-30,80}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.AltitudeAngle altAng
  "Calculates the altitude angle"
    annotation (Placement(transformation(extent={{-30,-8},{-22,0}})));
  AixLib.BoundaryConditions.SolarGeometry.ZenithAngle zen(each lat=lat)
  "Calculates the zenith angle"
    annotation (Placement(transformation(extent={{-62,-12},{-54,-4}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[n](
    final til=til,
    each lat=lat,
    final azi=azi)
    "Calculates the diffuse irradiation on a tilted surface after Perez"
    annotation (
    Placement(transformation(extent={{-38,-78},{-26,-66}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[n](
    final til=til,
    each lat=lat,
    final azi=azi)
    "Calculates the direct irradiation on a tilted surface"
    annotation (Placement(transformation(extent={{-66,40},{-52,54}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.SolarAzimuth solAzi(
  lat=lat)
  "Calculates the solar azimuth angle"
    annotation (Placement(transformation(extent={{-40,-34},{-32,-26}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng
  "Calculates the declination angle"
    annotation (Placement(transformation(extent={{-66,-36},{-60,-30}})));
equation
  connect(shadedWindow.HVis, HVis) annotation (Line(points={{89.7,15},{95.4,15},
          {95.4,40},{110,40}}, color={0,0,127}));
  connect(shadedWindow.HWin, HWin) annotation (Line(points={{89.7,-13},{95.4,-13},
          {95.4,-40},{110,-40}}, color={0,0,127}));
  connect(altAng.zen,zen. y)   annotation (
  Line(points={{-30.8,-4},{-30,-4},{-30,
          -4},{-36,-4},{-44,-4},{-44,-8},{-53.6,-8}},
          color={0,0,127}));
  connect(weaBus,zen. weaBus) annotation (Line(
      points={{-100,0},{-84,0},{-84,-6},{-68,-6},{-68,-8},{-62,-8},{-62,-8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(weaBus.HDifHor, shadedWindow.HDifHor) annotation (Line(
      points={{-100,0},{-84,0},{-84,-86},{0,-86},{0,-32.6},{8.3,-32.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTil.H, shadedWindow.HDifTil) annotation (Line(points={{-25.4,-72},
          {-20,-72},{-20,-24.9},{8.3,-24.9}}, color={0,0,127}));
  connect(altAng.alt, shadedWindow.alt) annotation (
  Line(points={{-21.6,-4},{-18,
          -4},{-18,-4.6},{8.3,-4.6}}, color={0,0,127}));
  connect(zen.y, solAzi.zen) annotation (
  Line(points={{-53.6,-8},{-50,-8},{-50,-27.6},
          {-40.8,-27.6}}, color={0,0,127}));
  connect(solAzi.solAzi, shadedWindow.solAzi) annotation (
  Line(points={{-31.6,-30},
          {-26,-30},{-26,-14.4},{8.3,-14.4}}, color={0,0,127}));
  connect(decAng.decAng, solAzi.decAng) annotation (
  Line(points={{-59.7,-33},{-45.85,
          -33},{-45.85,-30},{-40.8,-30}}, color={0,0,127}));
  connect(weaBus.cloTim, decAng.nDay) annotation (Line(
      points={{-100,0},{-84,0},{-84,-33},{-66.6,-33}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.solTim, solAzi.solTim) annotation (Line(
      points={{-100,0},{-84,0},{-84,-44},{-84,-72},{-56,-72},
      {-56,-44},{-48,-44},
          {-42,-44},{-42,-32.4},{-40.8,-32.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(incAng.y, shadedWindow.incAng) annotation (Line(points={{-29.5,75},
          {-11.75,75},{-11.75,35.3},{8.3,35.3}},
                                     color={0,0,127}));
  connect(weaBus.nTot, shadedWindow.nTot) annotation (Line(
      points={{-100,0},{-84,0},{-84,64},{-18,64},{-18,26.9},{8.3,26.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDirTil.H, shadedWindow.HDirTil) annotation (Line(points={{-51.3,47},{
          -20.65,47},{-20.65,16.4},{8.3,16.4}}, color={0,0,127}));
  for i in 1:n loop connect(weaBus,HDifTil [i].weaBus) annotation (Line(
      points={{-100,0},{-84,0},{-84,-72},{-38,-72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
          connect(incAng[i].weaBus,weaBus)  annotation (Line(
      points={{-40,75},{-84,75},{-84,0},{-100,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
          connect(weaBus,HDirTil [i].weaBus) annotation (Line(
      points={{-100,0},{-84,0},{-84,47},{-66,47}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  end for;
  connect(weaBus.HDirNor, shadedWindow.HDirNor) annotation (Line(
      points={{-100,0},{-48,0},{-48,5.9},{8.3,5.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (defaultComponentName="shadedWindow",Icon(
  coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-96,96},{96,-96}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-2,96},{2,-96}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-96,2},{96,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-34,122},{40,88}},
          lineColor={28,108,200},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name
")}),
Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model calculates the input of heat and visible light into the
  room due to solar irradiation. This model calculates the input of
  heat and visible light into the room due to solar irradiation.
  Therefore it uses the calculations of VDI 6007 part 3. It considers
  the correction values for non-vertical and non-parallel radiation
  incidence.
</p>
<p>
  Additionaly to the <a href=\"Windows.Window\">Window</a> model it
  includes the formation of shades because of the window itself and
  because of the surrounding skyline.
</p>
<p>
  An example on how this model should be used is <a href=
  \"Windows.Examples.ShadedWindow\">ShadedWindow</a>. To consider the
  additional heat input in case of ventilation with the solar
  protection the <a href=
  \"Windows.BaseClasses.VentilationHeat\">VentilationHeat</a> model can
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
end ShadedWindow;
