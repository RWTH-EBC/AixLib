within AixLib.ThermalZones.HighOrder.Components.Shadow;
model ShadowLength
  "Calculate the shadow length on the vertical surface by a horizontal shield"
  parameter Modelica.Units.NonSI.Angle_deg aziDeg = -54
    "Surface azimuth, S=0°, W=90°, N=180°, E=-90°";
  parameter Modelica.Units.SI.Length lenShie = 0.3
    "Horizontal length of the sun shield";

  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.AltitudeAngle altAng
    "Altitude angle"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  AixLib.BoundaryConditions.SolarGeometry.IncidenceAngle incAng(
    azi = Modelica.Units.Conversions.from_deg(aziDeg),
    til = Modelica.Units.Conversions.from_deg(90)) "Solar incidence angle"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.WallSolarAzimuth wallSolAzi
    "Vertical wall solar azimuth angle"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng
    "Declination angle"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle solHouAng
    "Solar hour angle"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  AixLib.BoundaryConditions.SolarGeometry.BaseClasses.ZenithAngle zen "Zenith angle"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather bus" annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-110,
            -10},{-90,10}})));

  Modelica.Blocks.Interfaces.RealOutput heiSha
    "Height of shadow on vertical surface"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.BooleanOutput sha
    "= true, if the shadow is present on the surface"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

equation
  if tan(zen.zen)<0.001 or cos(wallSolAzi.verAzi)<0.001 then
    sha = false;
    heiSha = 0;
  else
    sha = true;
    heiSha = lenShie/(tan(zen.zen)*cos(wallSolAzi.verAzi));   //H_Shadow = lenShie * tan(VSA)
  end if;

  connect(weaBus.solZen, altAng.zen) annotation (Line(
      points={{-100,0},{-80,0},{-80,70},{-62,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, incAng.weaBus) annotation (Line(
      points={{-100,0},{-80,0},{-80,30},{-60,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.cloTim, decAng.nDay) annotation (Line(
      points={{-100,0},{-80,0},{-80,-30},{-62,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.solTim, solHouAng.solTim) annotation (Line(
      points={{-100,0},{-80,0},{-80,-70},{-62,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(altAng.alt, wallSolAzi.alt) annotation (Line(points={{-39,70},{-30,70},
          {-30,54.8},{-22,54.8}}, color={0,0,127}));
  connect(incAng.y, wallSolAzi.incAng) annotation (Line(points={{-39,30},{-30,30},
          {-30,45.2},{-22,45.2}}, color={0,0,127}));
  connect(decAng.decAng, zen.decAng) annotation (Line(points={{-39,-30},{-30,-30},
          {-30,-44.6},{-22,-44.6}}, color={0,0,127}));
  connect(solHouAng.solHouAng, zen.solHouAng) annotation (Line(points={{-39,-70},
          {-30,-70},{-30,-54.8},{-22,-54.8}}, color={0,0,127}));
  connect(weaBus.lat, zen.lat) annotation (Line(
      points={{-100,0},{-80,0},{-80,-50},{-22,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(
          extent={{-98,-98},{98,98}}, fileName="modelica://AixLib/Resources/Images/ThermalZones/HighOrder/Components/Shadow/Icon/ShadowLength.png"),
        Text(
          extent={{-100,140},{100,100}},
          textString="%name",
          textColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end ShadowLength;
