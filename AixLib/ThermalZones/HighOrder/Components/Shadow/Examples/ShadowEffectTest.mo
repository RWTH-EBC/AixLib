within AixLib.ThermalZones.HighOrder.Components.Shadow.Examples;
model ShadowEffectTest "Test the modul ShadowEffect"
  extends Modelica.Icons.Example;
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  ShadowEffect shaEffDiffAll(calMod=AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.constRedDiffAllDir)
    "Shadow effect with constRedDiffAllDir"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  RadiationTransfer radiationTransfer
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  ShadowEffect shaEffDiffPerp(calMod=AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.constRedDiffPerpDir)
    "Shadow effect with constRedDiffPerpDir"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  ShadowEffect shaEffAsDir(calMod=AixLib.ThermalZones.HighOrder.Components.Shadow.Types.selectorShadowEffectMode.varRedDiffAsDirRad)
    "Shadow effect with varRedDiffAsDirRad"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
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
          annotation (Placement(transformation(extent={{80,-80},{112,-52}})));
  ReducedOrder.Windows.Validation.BaseClasses.IncidenceAngleVDI6007 incAng(azi=-0.94247779607694,
      til=1.5707963267949) "Incidence angle for the window"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  BoundaryConditions.SolarGeometry.BaseClasses.AltitudeAngle        altAng
    "Altitude angle"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  BoundaryConditions.WeatherData.Bus        weaBus "Weather bus" annotation (Placement(
        transformation(extent={{-80,-60},{-60,-40}}), iconTransformation(extent={{-110,
            -10},{-90,10}})));
  BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle
    solHouAng "Solar hour angle"
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));
  BoundaryConditions.SolarGeometry.BaseClasses.ZenithAngle        zen
    "Zenith angle"
    annotation (Placement(transformation(extent={{0,-120},{20,-100}})));
  BoundaryConditions.SolarGeometry.BaseClasses.Declination        decAng
    "Declination angle"
    annotation (Placement(transformation(extent={{-60,-120},{-40,-100}})));
  BoundaryConditions.SolarGeometry.BaseClasses.SolarAzimuth        solAzi
    "Solar azimuth"
    annotation (Placement(transformation(extent={{40,-160},{60,-140}})));
equation
  connect(weaDat.weaBus, shaEffDiffAll.weaBus) annotation (Line(
      points={{-80,30},{-20,30},{-20,58},{0,58}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, radiationTransfer.weaBus) annotation (Line(
      points={{-80,30},{-68,30},{-68,-2},{-60,-2}},
      color={255,204,51},
      thickness=0.5));
  connect(radiationTransfer.solRadOut, shaEffDiffAll.solRadIn) annotation (Line(
        points={{-39,-10},{-10,-10},{-10,50},{-1,50}}, color={255,128,0}));
  connect(weaDat.weaBus, shaEffDiffPerp.weaBus) annotation (Line(
      points={{-80,30},{-20,30},{-20,18},{0,18}},
      color={255,204,51},
      thickness=0.5));
  connect(radiationTransfer.solRadOut, shaEffDiffPerp.solRadIn) annotation (
      Line(points={{-39,-10},{-10,-10},{-10,10},{-1,10}}, color={255,128,0}));
  connect(weaDat.weaBus, shaEffAsDir.weaBus) annotation (Line(
      points={{-80,30},{-20,30},{-20,-22},{0,-22}},
      color={255,204,51},
      thickness=0.5));
  connect(radiationTransfer.solRadOut, shaEffAsDir.solRadIn) annotation (Line(
        points={{-39,-10},{-10,-10},{-10,-30},{-1,-30}}, color={255,128,0}));
  connect(altAng.zen, weaBus.solZen) annotation (Line(points={{-42,-50},{-70,
          -50}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,30},{-80,-50},{-70,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(incAng.incAng, selfShadowingAbove.incAng[1]) annotation (Line(points=
          {{21,-70},{60,-70},{60,-75.8},{78.4,-75.8}}, color={0,0,127}));
  connect(altAng.alt, incAng.alt) annotation (Line(points={{-19,-50},{-10,-50},
          {-10,-64.6},{-2.2,-64.6}}, color={0,0,127}));
  connect(altAng.alt, selfShadowingAbove.alt) annotation (Line(points={{-19,-50},
          {-10,-50},{-10,-54},{60,-54},{60,-66},{78.4,-66}}, color={0,0,127}));
  connect(zen.zen,solAzi. zen) annotation (Line(
      points={{21,-110},{28,-110},{28,-142},{38,-142}},
      color={0,0,127}));
  connect(decAng.decAng,solAzi. decAng) annotation (Line(
      points={{-39,-110},{-10,-110},{-10,-92},{32,-92},{32,-146},{38,-146},{38,
          -146.2}},
      color={0,0,127}));
  connect(decAng.decAng,zen. decAng) annotation (Line(
      points={{-39,-110},{-10,-110},{-10,-104.6},{-2,-104.6}},
      color={0,0,127}));
  connect(solHouAng.solHouAng, zen.solHouAng) annotation (Line(points={{-39,
          -150},{-2,-150},{-2,-114.8}}, color={0,0,127}));
  connect(weaBus.cloTim, decAng.nDay) annotation (Line(
      points={{-70,-50},{-70,-110},{-62,-110}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.solTim, solHouAng.solTim) annotation (Line(
      points={{-70,-50},{-70,-150},{-62,-150}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.lat, zen.lat) annotation (Line(
      points={{-70,-50},{-70,-80},{-30,-80},{-30,-110},{-2,-110}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.lat, solAzi.lat) annotation (Line(
      points={{-70,-50},{-70,-170},{38,-170},{38,-158}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.solTim, solAzi.solTim) annotation (Line(
      points={{-70,-50},{-70,-170},{20,-170},{20,-154},{38,-154}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(solAzi.solAzi, selfShadowingAbove.solAzi) annotation (Line(points={{
          61,-150},{70,-150},{70,-56.2},{78.4,-56.2}}, color={0,0,127}));
  connect(solAzi.solAzi, incAng.solAzi) annotation (Line(points={{61,-150},{70,
          -150},{70,-86},{-2,-86},{-2,-74.8}}, color={0,0,127}));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end ShadowEffectTest;
