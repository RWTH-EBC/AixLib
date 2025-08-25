within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model ShadedWindow
  "Calculation of solar energy transmitted through windows considering
  shadowing."
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
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDir[n] "Total energy transmittance of windows with closed sunscreen for
    direct radiation" annotation (Dialog(group="window"));
  parameter Modelica.Units.SI.TransmissionCoefficient g_TotDif[n] "Total energy transmittance of windows with closed sunscreen for
     diffuse radiation" annotation (Dialog(group="window"));
  Modelica.Blocks.Interfaces.RealInput incAng[n](
    final quantity="Angle",
    final unit="rad",
    displayUnit="degree")
    "Incidence angles of the sun beam on a tilted surface"
    annotation (Placement(transformation(extent={{-124,84},{-100,108}}),
    iconTransformation(extent={{-120,88},{-100,108}})));
  Modelica.Blocks.Interfaces.RealInput solAzi(
    final quantity="Angle",
    final unit="rad")
    "Solar azimuth angle"
    annotation (Placement(transformation(extent={{-124,-58},{-100,-34}}),
        iconTransformation(extent={{-120,-54},{-100,-34}})));
   Modelica.Blocks.Interfaces.RealInput alt(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar altitude angle"
    annotation (Placement(transformation(extent={{-124,-30},{-100,-6}}),
        iconTransformation(extent={{-120,-26},{-100,-6}})));

   Modelica.Blocks.Interfaces.RealInput nTot(min=0,max=1,
    final unit="1") "Total sky Cover"
    annotation (Placement(transformation(extent={{-124,60},{-100,84}}),
        iconTransformation(extent={{-120,64},{-100,84}})));
   Modelica.Blocks.Interfaces.RealInput HDirTil[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Direct irradition on tilted surface"
    annotation (Placement(transformation(extent={{-124,30},{-100,54}}),
        iconTransformation(extent={{-120,34},{-100,54}})));

    Modelica.Blocks.Interfaces.RealInput HDirNor(
      final quantity="RadiantEnergyFluenceRate",
      final unit="W/m2") "Direct normal radiation."
    annotation (Placement(transformation(extent={{-124,0},{-100,24}}),
        iconTransformation(extent={{-120,4},{-100,24}})));

   Modelica.Blocks.Interfaces.RealInput HDifHor(
      final quantity="RadiantEnergyFluenceRate",
      final unit="W/m2")
    "Horizontal diffuse solar radiation."
    annotation (Placement(transformation(extent={{-124,-110},{-100,-86}}),
        iconTransformation(extent={{-120,-106},{-100,-86}})));

    Modelica.Blocks.Interfaces.RealInput HDifTil[n](
      final quantity="RadiantEnergyFluenceRate",
      final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface from the sky"
    annotation (Placement(transformation(extent={{-124,-88},{-100,-64}}),
        iconTransformation(extent={{-120,-84},{-100,-64}})));
   Modelica.Blocks.Interfaces.RealOutput HVis[n](
    final quantity="RadiantEnergyFluenceRate",
    final unit="W/m2")
    "Solar energy entering the room in the visible area"
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
    final tau_vis=tau_vis,
    final tau_visTotDir=tau_visTotDir,
    final tau_visTotDif=tau_visTotDif,
    final lim=lim,
    final til=til,
    final g_TotDir=g_TotDir,
    final g_TotDif=g_TotDif)
    annotation (Placement(transformation(extent={{40,-2},{88,58}})));
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SelfShadowing selfShadowing(
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
    final til=til,
    final n=n) annotation (Placement(transformation(
    extent={{-34,-62},{-14,-42}})));
  Modelica.Blocks.Math.Product productSelfShadowing[n]
    annotation (Placement(transformation(extent={{4,-6},{18,8}})));
  SkylineShadowing skylineShadow(
    final alpha=alpha,
    final deltaH=deltaH,
    final s=s,
    final gap=gap,
    final n=nCorPoi)
    annotation (Placement(transformation(extent={{-88,-40},{-68,-20}})));
  Modelica.Blocks.Math.Product productSkylineShadowing[n]
    annotation (Placement(transformation(extent={{-30,-6},{-16,8}})));
  Modelica.Blocks.Math.BooleanToReal boolToReal
    annotation (Placement(transformation(extent={{-48,-18},{-38,-8}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-60,-18},{-50,-8}})));
equation
  for i in 1:n loop

    connect(boolToReal.y, productSkylineShadowing[i].u2) annotation (Line(
          points={{-37.5,-13},{-37.5,-12},{-34,-12},{-34,-4},{-31.4,-4},{
            -31.4,-3.2}}, color={0,0,127}));
  end for;
  connect(solAzi, selfShadowing.solAzi) annotation (Line(points={{-112,-46},
          {-92,-46},{-92,-45},{-35,-45}},color={0,0,127}));
  connect(alt, selfShadowing.alt) annotation (Line(points={{-112,-18},{-92,
          -18},{-92,-52},{-35,-52}},
                                color={0,0,127}));
  connect(window.HVis, HVis)
    annotation (Line(points={{90.4,40},{90.4,40},{110,40}}, color={0,0,127}));
  connect(window.HWin, HWin) annotation (Line(points={{90.4,16},{96,16},{96,
          -40},{110,-40}},
                      color={0,0,127}));
  connect(productSkylineShadowing.y, productSelfShadowing.u1) annotation (
      Line(points={{-15.3,1},{-9.75,1},{-9.75,5.2},{2.6,5.2}}, color={0,0,
          127}));
  connect(productSelfShadowing.y, window.HDirTil) annotation (Line(points={
          {18.7,1},{24,1},{24,4},{36,4},{36,4.6},{37.6,4.6}}, color={0,0,
          127}));
  connect(HDirTil, productSkylineShadowing.u1) annotation (Line(points={{
          -112,42},{-68,42},{-68,5.2},{-31.4,5.2}}, color={0,0,127}));
  connect(alt, greater.u1) annotation (Line(points={{-112,-18},{-92,-18},{
          -92,-14},{-76,-14},{-76,-13},{-61,-13}},
                      color={0,0,127}));
  connect(skylineShadow.altLim, greater.u2) annotation (Line(points={{-67,-30},
          {-66,-30},{-66,-18},{-64,-18},{-64,-17},{-61,-17}},
                                          color={0,0,127}));
  connect(greater.y, boolToReal.u)
    annotation (Line(points={{-49.5,-13},{-49,-13}}, color={255,0,255}));
  connect(incAng, window.incAng) annotation (Line(points={{-112,96},{-44,96},
          {-44,52.6},{37.6,52.6}},
                              color={0,0,127}));
  connect(incAng, selfShadowing.incAng) annotation (Line(points={{-112,96},
          {-94,96},{-94,-59},{-35,-59}},
                                    color={0,0,127}));
  connect(HDirNor, window.HDirNor) annotation (Line(points={{-112,12},{-46,
          12},{-46,13},{37.6,13}},
                              color={0,0,127}));
  connect(HDifHor, window.HDifHor) annotation (Line(points={{-112,-98},{32,
          -98},{32,21.4},{37.6,21.4}},
                                  color={0,0,127}));
  connect(HDifTil, window.HDifTil) annotation (Line(points={{-112,-76},{-76,
          -76},{-76,-72},{28,-72},{28,28.6},{37.6,28.6}},
                                                     color={0,0,127}));
  connect(nTot, window.nTot) annotation (Line(points={{-112,72},{-48,72},{
          -48,44.8},{37.6,44.8}},
                        color={0,0,127}));
  connect(alt, window.alt) annotation (Line(points={{-112,-18},{-92,-18},{
          -92,35.8},{37.6,35.8}},
                        color={0,0,127}));
  connect(solAzi, skylineShadow.solAzi) annotation (Line(points={{-112,-46},
          {-96,-46},{-96,-30},{-89,-30}},
                                       color={0,0,127}));

  connect(selfShadowing.x_As, productSelfShadowing.u2) annotation (Line(
        points={{-13.1,-51.9},{-9.1,-51.9},{-9.1,-12},{-6,-12},{-6,-8},{2.6,
          -8},{2.6,-3.2}}, color={0,0,127}));
  annotation (defaultComponentName="shadedWindow",Icon(coordinateSystem(
  preserveAspectRatio=false),
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
          extent={{-34,116},{40,82}},
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
  Additionaly to the <a href=\"vdi6007.Window\">Window</a> model it
  includes the formation of shades because of the window itself and
  because of the surrounding skyline.
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
