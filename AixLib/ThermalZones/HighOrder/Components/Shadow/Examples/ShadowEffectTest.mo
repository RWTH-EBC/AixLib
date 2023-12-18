within AixLib.ThermalZones.HighOrder.Components.Shadow.Examples;
model ShadowEffectTest "Test the modul ShadowEffect"
  extends Modelica.Icons.Example;
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  ShadowEffect shaEffDiffAll(calMod=AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.constRedDiffAllDir)
    "Shadow effect with constRedDiffAllDir"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  RadiationTransfer radiationTransfer
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  ShadowEffect shaEffDiffPerp(calMod=AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.constRedDiffPerpDir)
    "Shadow effect with constRedDiffPerpDir"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  ShadowEffect shaEffAsDir(calMod=AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.varRedDiffAsDirRad)
    "Shadow effect with varRedDiffAsDirRad"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  ReducedOrder.Windows.BaseClasses.SelfShadowing                     selfShadowingAbove(
    final bRig={0},
    final n=1,
    final b={1},
    final h={1},
    final bLef={0},
    final dLef={0},
    final dRig={0},
    final bAbo={0.3},
    final bBel={0},
    final dAbo={0.1},
    final dBel={0},
    final azi={-0.94247779607694},
    final til={1.5707963267949})
    "Shadowing due to a projection above the window"
          annotation (Placement(transformation(extent={{68,-20},{100,8}})));
  ReducedOrder.Windows.Validation.BaseClasses.IncidenceAngleVDI6007 incAng(azi=-0.94247779607694,
      til=1.5707963267949) "Incidence angle for the window"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  BoundaryConditions.SolarGeometry.BaseClasses.AltitudeAngle        altAng
    "Altitude angle"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  BoundaryConditions.WeatherData.Bus        weaBus "Weather bus" annotation (Placement(
        transformation(extent={{-80,0},{-60,20}}),    iconTransformation(extent={{-110,
            -10},{-90,10}})));
  BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle
    solHouAng "Solar hour angle"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  BoundaryConditions.SolarGeometry.BaseClasses.ZenithAngle        zen
    "Zenith angle"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  BoundaryConditions.SolarGeometry.BaseClasses.Declination        decAng
    "Declination angle"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  BoundaryConditions.SolarGeometry.BaseClasses.SolarAzimuth        solAzi
    "Solar azimuth"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Modelica.Blocks.Sources.RealExpression gShaDirEffDiffAll(y=shaEffDiffAll.gShaDir)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
equation
  connect(weaDat.weaBus, shaEffDiffAll.weaBus) annotation (Line(
      points={{-80,30},{-20,30},{-20,88},{0,88}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, radiationTransfer.weaBus) annotation (Line(
      points={{-80,30},{-68,30},{-68,58},{-60,58}},
      color={255,204,51},
      thickness=0.5));
  connect(radiationTransfer.solRadOut, shaEffDiffAll.solRadIn) annotation (Line(
        points={{-39,50},{-10,50},{-10,80},{-1,80}},   color={255,128,0}));
  connect(weaDat.weaBus, shaEffDiffPerp.weaBus) annotation (Line(
      points={{-80,30},{-20,30},{-20,58},{0,58}},
      color={255,204,51},
      thickness=0.5));
  connect(radiationTransfer.solRadOut, shaEffDiffPerp.solRadIn) annotation (
      Line(points={{-39,50},{-1,50}},                     color={255,128,0}));
  connect(weaDat.weaBus, shaEffAsDir.weaBus) annotation (Line(
      points={{-80,30},{-20,30},{-20,28},{0,28}},
      color={255,204,51},
      thickness=0.5));
  connect(radiationTransfer.solRadOut, shaEffAsDir.solRadIn) annotation (Line(
        points={{-39,50},{-10,50},{-10,20},{-1,20}},     color={255,128,0}));
  connect(altAng.zen, weaBus.solZen) annotation (Line(points={{-42,10},{-70,10}},
                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,30},{-80,10},{-70,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(incAng.incAng, selfShadowingAbove.incAng[1]) annotation (Line(points={{21,-10},
          {60,-10},{60,-15.8},{66.4,-15.8}},           color={0,0,127}));
  connect(altAng.alt, incAng.alt) annotation (Line(points={{-19,10},{-10,10},{-10,
          -4.6},{-2.2,-4.6}},        color={0,0,127}));
  connect(altAng.alt, selfShadowingAbove.alt) annotation (Line(points={{-19,10},{
          -10,10},{-10,6},{60,6},{60,-6},{66.4,-6}},         color={0,0,127}));
  connect(zen.zen,solAzi. zen) annotation (Line(
      points={{21,-50},{28,-50},{28,-82},{38,-82}},
      color={0,0,127}));
  connect(decAng.decAng,solAzi. decAng) annotation (Line(
      points={{-39,-40},{-10,-40},{-10,-32},{32,-32},{32,-86},{38,-86},{38,-86.2}},
      color={0,0,127}));
  connect(decAng.decAng,zen. decAng) annotation (Line(
      points={{-39,-40},{-10,-40},{-10,-44.6},{-2,-44.6}},
      color={0,0,127}));
  connect(solHouAng.solHouAng, zen.solHouAng) annotation (Line(points={{-39,-70},
          {-2,-70},{-2,-54.8}},         color={0,0,127}));
  connect(weaBus.cloTim, decAng.nDay) annotation (Line(
      points={{-70,10},{-70,-40},{-62,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.solTim, solHouAng.solTim) annotation (Line(
      points={{-70,10},{-70,-70},{-62,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.lat, zen.lat) annotation (Line(
      points={{-70,10},{-70,-20},{-30,-20},{-30,-50},{-2,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.lat, solAzi.lat) annotation (Line(
      points={{-70,10},{-70,-98},{38,-98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.solTim, solAzi.solTim) annotation (Line(
      points={{-70,10},{-70,-94},{38,-94}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(solAzi.solAzi, selfShadowingAbove.solAzi) annotation (Line(points={{61,-90},
          {64,-90},{64,3.8},{66.4,3.8}},               color={0,0,127}));
  connect(solAzi.solAzi, incAng.solAzi) annotation (Line(points={{61,-90},{64,-90},
          {64,-26},{-2,-26},{-2,-14.8}},       color={0,0,127}));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Simulation to test the <a href=\"AixLib.Building.Components.Shadow.ShadowEffect\">ShadowEffect</a> model with different diffuse radiation calculation modes. Comparison with shadow coefficient with the model <a href=\"AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SelfShadowing\">SelfShadowing</a>.</p>
<ul>
<li><i>November, 2023&nbsp;</i> by Jun Jiang:<br>Implemented. </li>
</ul>
</html>"));
end ShadowEffectTest;
